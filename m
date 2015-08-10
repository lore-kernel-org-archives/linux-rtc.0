Return-Path: <rtc-linux+bncBDS7HNEFSALRBC65UKXAKGQE3VDD6CA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c3si340843wiz.2.2015.08.10.07.00.43
        for <rtc-linux@googlegroups.com>;
        Mon, 10 Aug 2015 07:00:43 -0700 (PDT)
Date: Mon, 10 Aug 2015 16:00:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Cc: festevam@gmail.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: rtc-ds1374: Remove unused variable
Message-ID: <20150810140042.GF3411@piout.net>
References: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
 <1439210865-8611-2-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439210865-8611-2-git-send-email-fabio.estevam@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Greg,

Can you take this one or squash it in your misc_deregister patch?

Original is at: http://patchwork.ozlabs.org/patch/505614/

On 10/08/2015 at 09:47:45 -0300, Fabio Estevam wrote :
> Remove unused variable 'res' and fix the following build warning:
> 
> drivers/rtc/rtc-ds1374.c:667:6: warning: unused variable 'res' [-Wunused-variable]
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/rtc/rtc-ds1374.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 7067232..3b3049c 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -664,8 +664,6 @@ static int ds1374_remove(struct i2c_client *client)
>  {
>  	struct ds1374 *ds1374 = i2c_get_clientdata(client);
>  #ifdef CONFIG_RTC_DRV_DS1374_WDT
> -	int res;
> -
>  	misc_deregister(&ds1374_miscdev);
>  	ds1374_miscdev.parent = NULL;
>  	unregister_reboot_notifier(&ds1374_wdt_notifier);
> -- 
> 1.9.1
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
