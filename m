Return-Path: <rtc-linux+bncBCQJP74GSUDRBRGES6XQKGQEDWF3K3Y@googlegroups.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com. [2607:f8b0:4003:c06::233])
        by gmr-mx.google.com with ESMTPS id d20si119994igo.3.2015.09.01.10.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2015 10:37:07 -0700 (PDT)
Received: by mail-oi0-x233.google.com with SMTP id x17so4092005oix.0
        for <rtc-linux@googlegroups.com>; Tue, 01 Sep 2015 10:37:07 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1440271591-5640-1-git-send-email-paul.gortmaker@windriver.com>
References: <1440271591-5640-1-git-send-email-paul.gortmaker@windriver.com>
Date: Tue, 1 Sep 2015 19:37:07 +0200
Message-ID: <CAMuHMdXMHg-HR10WQavREmnva6u5-i0ekFeGM5za5UUHgiN0dA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH -next] rtc: drop unused ret variable orphaned
 by misc_deregister becoming void
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, Aug 22, 2015 at 9:26 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> In commit f368ed6088ae9c1fbe1c897bb5f215ce5e63fa1e ("char: make
> misc_deregister a void function") this ret variable became unused
> which now generates a compile warning.  Get rid of it.
>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

It's funny how these things end up in mainline, despite at least two
people providing a patch.

> ---
>  drivers/rtc/rtc-ds1374.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 7067232ba507..742ac67eb702 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -663,9 +663,8 @@ static int ds1374_probe(struct i2c_client *client,
>  static int ds1374_remove(struct i2c_client *client)
>  {
>         struct ds1374 *ds1374 = i2c_get_clientdata(client);
> -#ifdef CONFIG_RTC_DRV_DS1374_WDT
> -       int res;
>
> +#ifdef CONFIG_RTC_DRV_DS1374_WDT
>         misc_deregister(&ds1374_miscdev);
>         ds1374_miscdev.parent = NULL;
>         unregister_reboot_notifier(&ds1374_wdt_notifier);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
