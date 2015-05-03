Return-Path: <rtc-linux+bncBDS7HNEFSALRBIMBTGVAKGQEBMWZWNY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m3si228803wia.1.2015.05.03.08.37.04
        for <rtc-linux@googlegroups.com>;
        Sun, 03 May 2015 08:37:04 -0700 (PDT)
Date: Sun, 3 May 2015 17:37:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: rtc: update author email for rtc-at32ap700x
Message-ID: <20150503153703.GZ12076@piout.net>
References: <1309273417-8884-1-git-send-email-hans-christian.egtvedt@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1309273417-8884-1-git-send-email-hans-christian.egtvedt@atmel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/06/2011 at 17:03:37 +0200, Hans-Christian Egtvedt wrote :
> This patch updates the email address of the rtc-at32ap700x driver supported by
> me to an email account I will use on a more regular basis in the future.
> 
> Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> ---
>  drivers/rtc/rtc-at32ap700x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Better late than never, applied for 4.2.

> 
> diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
> index e725d51..402e52f 100644
> --- a/drivers/rtc/rtc-at32ap700x.c
> +++ b/drivers/rtc/rtc-at32ap700x.c
> @@ -314,6 +314,6 @@ static void __exit at32_rtc_exit(void)
>  }
>  module_exit(at32_rtc_exit);
>  
> -MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
> +MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
>  MODULE_DESCRIPTION("Real time clock for AVR32 AT32AP700x");
>  MODULE_LICENSE("GPL");

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
