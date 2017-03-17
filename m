Return-Path: <rtc-linux+bncBCQJP74GSUDRBX5ZV3DAKGQEZGLH3VA@googlegroups.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com. [2607:f8b0:4001:c0b::241])
        by gmr-mx.google.com with ESMTPS id b188si127702ite.3.2017.03.17.01.22.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 01:22:54 -0700 (PDT)
Received: by mail-it0-x241.google.com with SMTP id r141so2701325ita.1
        for <rtc-linux@googlegroups.com>; Fri, 17 Mar 2017 01:22:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170316175112.27913-2-chris.brandt@renesas.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com> <20170316175112.27913-2-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Mar 2017 09:22:53 +0100
Message-ID: <CAMuHMdXXRiUTJJRsrpyFNEwjvjPO2s5Rthn2r+UipaQgVHHMcQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/5] rtc: rtc-sh: add support for rza series
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Chris,

On Thu, Mar 16, 2017 at 6:51 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> This same RTC is used in RZ/A series MPUs, therefore with some slight
> changes, this driver can be reused. Additionally, since ARM architectures
> require Device Tree configurations, device tree support has been added.

Thanks for your patch!

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1303,10 +1303,10 @@ config RTC_DRV_SA1100
>
>  config RTC_DRV_SH
>         tristate "SuperH On-Chip RTC"
> -       depends on SUPERH && HAVE_CLK
> +       depends on (SUPERH || ARCH_RENESAS) && HAVE_CLK

I believe the dependency on HAVE_CLK is not needed.
SuperH selects CLKDEV_LOOKUP, which selects HAVE_CLK.
ARM (and ARM64) selects COMMON_CLK, which selects HAVE_CLK.

interestingly, SuperH already did so at the time the dependency was added...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
