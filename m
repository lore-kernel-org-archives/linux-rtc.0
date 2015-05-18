Return-Path: <rtc-linux+bncBDS7HNEFSALRB3WJ5GVAKGQEYH4O2YQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u10si443279wif.1.2015.05.18.15.17.18
        for <rtc-linux@googlegroups.com>;
        Mon, 18 May 2015 15:17:18 -0700 (PDT)
Date: Tue, 19 May 2015 00:17:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Zhi Li <lznuaa@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	"Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
	sachin.kamat@linaro.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-input@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-pm@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon
 access register
Message-ID: <20150518221717.GX3338@piout.net>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
 <1431938725.3209.15.camel@pengutronix.de>
 <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 18/05/2015 at 14:30:50 -0500, Zhi Li wrote :
> On Mon, May 18, 2015 at 3:45 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Frank,
> >
> > Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> snvs is MFP device. Change dts to use syscon to allocate register resource.
> >>
> >> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> >> ---
> >>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
> >>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
> >>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
> >>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
> >>  4 files changed, 15 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> >> index 0482a66..6d8161d 100644
> >> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> >> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> >> @@ -687,21 +687,17 @@
> >>                       };
> >>
> >>                       snvs@020cc000 {
> >> -                             compatible = "fsl,sec-v4.0-mon", "simple-bus";
> >> -                             #address-cells = <1>;
> >> -                             #size-cells = <1>;
> >> -                             ranges = <0 0x020cc000 0x4000>;
> >> +                             compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";
> >
> > The compatible should change from "simple-bus" to "simple-mfd", then.
> 
> After change to simple-mfd,  driver can't been probed. Anything missed?

The pull request is there:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342131.html

It has landed in linux-next


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
