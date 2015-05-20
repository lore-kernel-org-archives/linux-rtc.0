Return-Path: <rtc-linux+bncBCUYRNXYZECRBZVF6OVAKGQEZNUC5EQ@googlegroups.com>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id u10si171825wif.1.2015.05.20.11.31.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 11:31:01 -0700 (PDT)
Date: Wed, 20 May 2015 19:30:50 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: a.zummo@towertech.it, Frank.Li@freescale.com,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	dmitry.torokhov@gmail.com, devicetree@vger.kernel.org,
	robh+dt@kernel.org, alexandre.belloni@free-electrons.com,
	p.zabel@pengutronix.de, linux-input@vger.kernel.org,
	lznuaa@gmail.com, shawn.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150520183050.GR2067@n2100.arm.linux.org.uk>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <20150520182540.GQ2067@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150520182540.GQ2067@n2100.arm.linux.org.uk>
Sender: rtc-linux@googlegroups.com
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 20, 2015 at 07:25:41PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 20, 2015 at 09:58:51AM +0800, Shawn Guo wrote:
> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
> > > Frank Li (6):
> > >   arm: imx: power-off: change to syscon to access register
> > >   rtc: arm: imx: snvs: change use syscon to access register
> > >   Document: dt: fsl: snvs: change support syscon
> > >   arm: dts: imx: update snvs to use syscon access register
> > >   document: devicetree: input: imx: i.mx snvs power device tree bindings
> > >   arm: dts: imx6sx: enable snvs power key
> > 
> > So, the series will break existing DTBs for RTC and poweroff, right?
> > If this is unavoidable, should we at least have some warning messages
> > telling users about his breakage?
> 
> What's the justification for breaking existing DTBs?  Really, this is
> something we should strive to avoid, _and_ actually avoid by providing
> backwards compatibility.

Looking at the RTC code, it would be pretty trivial to do.

Rather than passing around struct regmap, pass around the private data
structure.

Rename the regmap_* function calls to be private accessors.  Implement
a set of new accessors - if the private data has the regmap, use the
regmap API.  Otherwise, use the old method, and print a warning that an
old DT is being used.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

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
