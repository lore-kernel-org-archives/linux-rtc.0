Return-Path: <rtc-linux+bncBAABBBUIYSWAKGQELHX42AY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id f17si610341igt.0.2015.06.29.01.38.30
        for <rtc-linux@googlegroups.com>;
        Mon, 29 Jun 2015 01:38:30 -0700 (PDT)
Date: Mon, 29 Jun 2015 16:38:14 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Frank.Li@freescale.com, shawn.guo@linaro.org,
	devicetree@vger.kernel.org, rtc-linux@googlegroups.com,
	dmitry.torokhov@gmail.com, robh+dt@kernel.org,
	linux-input@vger.kernel.org, lznuaa@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [rtc-linux] [PATCH v5 1/6] rtc: arm: imx: snvs: change use syscon
 to access register
Message-ID: <20150629083814.GH10332@tiger>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
 <20150601202507.GP4710@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150601202507.GP4710@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jun 01, 2015 at 10:25:07PM +0200, Alexandre Belloni wrote:
> On 27/05/2015 at 00:25:57 +0800, Frank.Li@freescale.com wrote :
> > From: Frank Li <Frank.Li@freescale.com>
> > 
> > snvs included rtc, on/off key, power-off module
> > change to syscon to access register
> > 
> > Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Shawn, when applying could you please change the subject to:
> rtc: snvs: use syscon to access registers

Okay, will do.

Shawn

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
