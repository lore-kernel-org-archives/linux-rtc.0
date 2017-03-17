Return-Path: <rtc-linux+bncBDXOFUXT2UGBB36DV7DAKGQENA3BEXA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relmlie3.idc.renesas.com (relmlor4.renesas.com. [210.160.252.174])
        by gmr-mx.google.com with ESMTP id u12si1402571pfd.3.2017.03.17.06.17.34
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Mar 2017 06:17:35 -0700 (PDT)
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman
	<horms+renesas@verge.net.au>, RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH 1/5] rtc: rtc-sh: add support for rza series
Date: Fri, 17 Mar 2017 13:17:31 +0000
Message-ID: <SG2PR06MB116511BA2DB66097980C97548A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-2-chris.brandt@renesas.com>
 <CAMuHMdXXRiUTJJRsrpyFNEwjvjPO2s5Rthn2r+UipaQgVHHMcQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXXRiUTJJRsrpyFNEwjvjPO2s5Rthn2r+UipaQgVHHMcQ@mail.gmail.com>
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
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1303,10 +1303,10 @@ config RTC_DRV_SA1100
> >
> >  config RTC_DRV_SH
> >         tristate "SuperH On-Chip RTC"
> > -       depends on SUPERH && HAVE_CLK
> > +       depends on (SUPERH || ARCH_RENESAS) && HAVE_CLK
> 
> I believe the dependency on HAVE_CLK is not needed.
> SuperH selects CLKDEV_LOOKUP, which selects HAVE_CLK.
> ARM (and ARM64) selects COMMON_CLK, which selects HAVE_CLK.
> 
> interestingly, SuperH already did so at the time the dependency was
> added...

OK, I'll take it out.
I just didn't want to break any SH stuff.



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
