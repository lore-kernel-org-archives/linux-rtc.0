Return-Path: <rtc-linux+bncBDS7HNEFSALRBZU4Q6XAKGQEH4WMVSQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si213188wib.3.2015.08.05.01.50.45
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Aug 2015 01:50:45 -0700 (PDT)
Date: Wed, 5 Aug 2015 10:50:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Matt Porter <mporter@konsulko.com>
Cc: Joachim Eastwood <manabian@gmail.com>, a.zummo@towertech.it,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com, joshc@ni.com
Subject: [rtc-linux] Re: [PATCH v3 2/2] doc: dt: add documentation for nxp,lpc1788-rtc
Message-ID: <20150805085044.GC3486@piout.net>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <1436635730-15617-3-git-send-email-manabian@gmail.com>
 <20150727133720.GA15004@beef>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150727133720.GA15004@beef>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/07/2015 at 09:37:20 -0400, Matt Porter wrote :
> > +Required properties:
> > +- compatible	: must contain "nxp,lpc1788-rtc"
> > +- reg		: Specifies base physical address and size of the registers.
> > +- interrupts	: A single interrupt specifier.
> > +- clocks	: Must contain entries for rtc and register clock
> 
> "Must contain clock specifiers for rtc and register clock" ?
> 

I fixed it up in the patch.

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
