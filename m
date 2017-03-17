Return-Path: <rtc-linux+bncBDXOFUXT2UGBBDOFV7DAKGQEDCEFICA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relmlie4.idc.renesas.com (relmlor1.renesas.com. [210.160.252.171])
        by gmr-mx.google.com with ESMTP id c123si1370764pfa.4.2017.03.17.06.20.12
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 06:20:13 -0700 (PDT)
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman
	<horms+renesas@verge.net.au>, RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH 3/5] ARM: dts: r7s72100: add rtc clock to
 device tree
Date: Fri, 17 Mar 2017 13:20:09 +0000
Message-ID: <SG2PR06MB1165ECF439A79E31978ACF228A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-4-chris.brandt@renesas.com>
 <CAMuHMdXAvMoLu5azcBfX5pH_KYApcYSipBktpbfLybvnCG+bwg@mail.gmail.com>
In-Reply-To: <CAMuHMdXAvMoLu5azcBfX5pH_KYApcYSipBktpbfLybvnCG+bwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Geert,

On Friday, March 17, 2017, Geert Uytterhoeven wrote:
> > --- a/arch/arm/boot/dts/r7s72100.dtsi
> > +++ b/arch/arm/boot/dts/r7s72100.dtsi
> > @@ -117,6 +117,15 @@
> >                         clock-output-names = "ostm0", "ostm1";
> >                 };
> >
> > +               mstp6_clks: mstp6_clks@fcfe042c {
> > +                       #clock-cells = <1>;
> > +                       compatible = "renesas,r7s72100-mstp-clocks",
> "renesas,cpg-mstp-clocks";
> > +                       reg = <0xfcfe042c 4>;
> > +                       clocks = <&p0_clk>;
> > +                       clock-indices = <R7S72100_CLK_RTC>;
> > +                       clock-output-names = "rtc0";
> 
> "rtc"? There's only one.

The rtc-sh.c code wants to have a number at the end. So if I just put "rtc" as the clock name, it does not find it. Again, I didn't want to break any SH builds, so I just changed the DT to match the driver.


[ from the rtc-sh.c code ]

	clk_id = pdev->id;
	/* With a single device, the clock id is still "rtc0" */
	if (clk_id < 0)
		clk_id = 0;

	snprintf(clk_name, sizeof(clk_name), "rtc%d", clk_id);

	rtc->clk = devm_clk_get(&pdev->dev, clk_name);
	if (IS_ERR(rtc->clk)) {
		/*
		 * No error handling for rtc->clk intentionally, not all
		 * platforms will have a unique clock for the RTC, and
		 * the clk API can handle the struct clk pointer being
		 * NULL.
		 */
		rtc->clk = NULL;
	}

	clk_enable(rtc->clk);


Cheers

Chris

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
