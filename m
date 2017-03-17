Return-Path: <rtc-linux+bncBCQJP74GSUDRBDF4V3DAKGQEERWOUBI@googlegroups.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com. [2607:f8b0:4001:c0b::244])
        by gmr-mx.google.com with ESMTPS id g205si142668ita.2.2017.03.17.01.27.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 01:27:56 -0700 (PDT)
Received: by mail-it0-x244.google.com with SMTP id y18so2719278itc.2
        for <rtc-linux@googlegroups.com>; Fri, 17 Mar 2017 01:27:56 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170316175112.27913-4-chris.brandt@renesas.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com> <20170316175112.27913-4-chris.brandt@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Mar 2017 09:27:54 +0100
Message-ID: <CAMuHMdXAvMoLu5azcBfX5pH_KYApcYSipBktpbfLybvnCG+bwg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/5] ARM: dts: r7s72100: add rtc clock to
 device tree
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

On Thu, Mar 16, 2017 at 6:51 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -117,6 +117,15 @@
>                         clock-output-names = "ostm0", "ostm1";
>                 };
>
> +               mstp6_clks: mstp6_clks@fcfe042c {
> +                       #clock-cells = <1>;
> +                       compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xfcfe042c 4>;
> +                       clocks = <&p0_clk>;
> +                       clock-indices = <R7S72100_CLK_RTC>;
> +                       clock-output-names = "rtc0";

"rtc"? There's only one.

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
