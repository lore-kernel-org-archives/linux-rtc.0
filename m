Return-Path: <rtc-linux+bncBDS7HNEFSALRBJ465CYQKGQEQDRHFPA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l1si114570wmb.3.2015.11.04.05.59.02
        for <rtc-linux@googlegroups.com>;
        Wed, 04 Nov 2015 05:59:02 -0800 (PST)
Date: Wed, 4 Nov 2015 14:59:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [patch] rtc: rtc-rv8803: Fix a couple locking bugs
Message-ID: <20151104135901.GY22331@piout.net>
References: <20151104134045.GJ20966@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151104134045.GJ20966@mwanda>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 04/11/2015 at 16:40:45 +0300, Dan Carpenter wrote :
> There was one missing unlock on error in rv8803_set_alarm() and one
> unlock in rv8803_ioctl() which was missing altogether.
> 
> Fixes: 2f370c4a1a44 ('rtc: Add a driver for Micro Crystal RV8803')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Presumably the IOCTL issue was a last minute change after the driver had
> been tested...
> 

Yeah, I already fixed the first one and the lock in rv8803_ioctl is
actually unnecessary.

Thanks for the info.

> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index 63244eb..9508de4 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -240,8 +240,10 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
>  
>  	ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
> -	if (ret != 2)
> +	if (ret != 2) {
> +		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
>  		return ret < 0 ? ret : -EIO;
> +	}
>  
>  	alarmvals[0] = bin2bcd(alrm->time.tm_min);
>  	alarmvals[1] = bin2bcd(alrm->time.tm_hour);
> @@ -338,6 +340,7 @@ static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  	case RTC_VL_READ:
>  		spin_lock_irqsave(&rv8803->flags_lock, irqflags);
>  		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
> +		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
>  		if (flags < 0)
>  			return flags;
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
