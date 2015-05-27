Return-Path: <rtc-linux+bncBDS7HNEFSALRBQ5FTCVQKGQEB5KSZUI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si746381wiz.0.2015.05.27.11.53.53
        for <rtc-linux@googlegroups.com>;
        Wed, 27 May 2015 11:53:53 -0700 (PDT)
Date: Wed, 27 May 2015 20:53:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jan Kardell <jan.kardell@telliq.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, oen@telliq.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf8563 fix: return -EINVAL if we
 read an invalid time.
Message-ID: <20150527185352.GJ2185@piout.net>
References: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
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

On 27/05/2015 at 14:48:16 +0200, Jan Kardell wrote :
> @@ -204,6 +204,7 @@ static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  		pcf8563->voltage_low = 1;
>  		dev_info(&client->dev,

Aren't dev_err or dev_warn more appropriate? You used dev_err in your
first patch, what made you change your mind?

>  			"low voltage detected, date/time is not reliable.\n");
> +		return -EINVAL;
>  	}
>  
>  	dev_dbg(&client->dev,

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
