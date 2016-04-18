Return-Path: <rtc-linux+bncBCQJP74GSUDRBREQ2K4AKGQEACDN4DI@googlegroups.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com. [2607:f8b0:4001:c05::244])
        by gmr-mx.google.com with ESMTPS id r5si229599igp.0.2016.04.18.00.09.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 00:09:56 -0700 (PDT)
Received: by mail-ig0-x244.google.com with SMTP id kb1so9831314igb.3
        for <rtc-linux@googlegroups.com>; Mon, 18 Apr 2016 00:09:56 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4192558.Mh1hb3LCLb@wuerfel>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
	<CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
	<4192558.Mh1hb3LCLb@wuerfel>
Date: Mon, 18 Apr 2016 09:09:55 +0200
Message-ID: <CAMuHMdWQiqNq7-fgn5NONovLQxhOoGD5s-TAYVYZOVRfEs52Zg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

cc linux-m68k

On Sun, Apr 17, 2016 at 11:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 March 2016 11:22:04 Geert Uytterhoeven wrote:
>> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Every new architecture has to add itself to the growing list of those
>> > that do not support the legacy PC RTC driver.
>> >
>> > This replaces the long list of architectures that don't support it
>> > with a shorter list of those that do.
>> >
>> > The list is taken from those architectures that have a non-empty
>> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
>>
>> M68K was blacklisted...
>
> I never got back to you on this topic, sorry about that. I've fixed
> up the patch to leave out m68k now.
>
> On a semi-related note, I see that m68k is one of the few architectures
> still using the (other) genrtc driver. It would be nice to reduce that
> list and change m68k to use its own rtc driver (ideally one per

We do have hp_sdc_rtc (HP9000/300; why is that under drivers/input/misc/?),
and rtc-msm6242 and rtc-rp5c01 (both for Amiga).

> platform), but the q40 platform is the only one providing
> get_rtc_pll()/set_rtc_pll() for the RTC_PLL_GET/RTC_PLL_SET ioctl
> commands.

Do you mean this is a problem?

> If we do this change on top of the other m68k patch I have, the
> rtc-generic driver should be usable as a full replacement for
> genrtc.c on m68k and we can remove all the set_rtc_pll/get_rtc_pll
> handling from genrtc.
>
> diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
> index 773b2187210d..f4781d612c37 100644
> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -100,7 +100,32 @@ static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
>         return 0;
>  }
>
> +static int rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +       struct rtc_pll_info pll;
> +       struct rtc_pll_info __user *argp = (void __user *)arg;
> +
> +       switch (cmd) {
> +       case RTC_PLL_GET:
> +               if (!mach_get_rtc_pll || mach_get_rtc_pll(&pll))
> +                       return -EINVAL;
> +               return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
> +
> +       case RTC_PLL_SET:
> +               if (!mach_set_rtc_pll)
> +                       return -EINVAL;
> +               if (!capable(CAP_SYS_TIME))
> +                       return -EACCES;
> +               if (copy_from_user(&pll, argp, sizeof(pll)))
> +                       return -EFAULT;
> +               return mach_set_rtc_pll(&pll);
> +       }
> +
> +       return -ENOIOCTLCMD;
> +}
> +
>  static const struct rtc_class_ops generic_rtc_ops = {
> +       .ioctl = rtc_ioctl,
>         .read_time = rtc_generic_get_time,
>         .set_time = rtc_generic_set_time,
>  };

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
