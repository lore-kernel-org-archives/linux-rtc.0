Return-Path: <rtc-linux+bncBDS7HNEFSALRBQ5ES2WQKGQECWVWH5Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id eo3si631721wib.0.2015.07.14.15.50.42
        for <rtc-linux@googlegroups.com>;
        Tue, 14 Jul 2015 15:50:42 -0700 (PDT)
Date: Wed, 15 Jul 2015 00:50:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc/ds3232: fix ds3232 get a WARNING trace in
 resume function
Message-ID: <20150714225041.GH20482@piout.net>
References: <1436249576-23233-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436249576-23233-1-git-send-email-dongsheng.wang@freescale.com>
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

This seems ok, one small nitpick:

On 07/07/2015 at 14:12:56 +0800, Dongsheng Wang wrote :
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 7e48e53..2081155 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -463,7 +463,10 @@ static int ds3232_suspend(struct device *dev)
>  
>  	if (device_can_wakeup(dev)) {
>  		ds3232->suspended = true;
> -		irq_set_irq_wake(client->irq, 1);
> +		if (irq_set_irq_wake(client->irq, 1)) {
> +			dev_info(dev, "Cannot serve as a wakeup source\n");

I would use dev_warn_once or dev_info_once here to avoid spamming the
log each time the machine is suspended.

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
