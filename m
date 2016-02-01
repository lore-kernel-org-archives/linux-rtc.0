Return-Path: <rtc-linux+bncBDS7HNEFSALRB4H7XW2QKGQE7U7JRVI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 5si352561wmm.2.2016.02.01.07.55.28
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Feb 2016 07:55:28 -0800 (PST)
Date: Mon, 1 Feb 2016 16:55:27 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>, devicetree@vger.kernel.org,
	a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] doc: dt: add documentation for alphascale,asm9260-rtc
Message-ID: <20160201155527.GR20165@piout.net>
References: <1454056802-23386-1-git-send-email-linux@rempel-privat.de>
 <1454056802-23386-3-git-send-email-linux@rempel-privat.de>
 <20160201152750.GA17595@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160201152750.GA17595@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/02/2016 at 09:27:50 -0600, Rob Herring wrote :
> On Fri, Jan 29, 2016 at 09:40:02AM +0100, Oleksij Rempel wrote:
> > Document Alphascale asm9260 RTC bindings
> > 
> > Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> > ---
> >  .../bindings/rtc/alphascale,asm9260-rtc.txt        | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
> > new file mode 100644
> > index 0000000..2c0ff3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
> > @@ -0,0 +1,25 @@
> > +* Alphascale asm9260 SoC Real Time Clock
> > +
> > +Required properties:
> > +- compatible: Should be "alphascale,asm9260-rtc"
> > +- reg: Physical base address of the controller and length
> > +       of memory mapped region.
> > +- interrupts: IRQ line for the RTC.
> > +- clocks: Reference to the clock entry.
> > +- clock-names: should contain:
> > +  * "ahb" for the SoC RTC clock
> > +
> > +Optional:
> > +- calibration: calibration value for 1 sec period.
> > +		Max value for forward calibration is 0x1ffff (131071),
> > +		Min value for backward calibration is 0xfffe0001 (-131071).
> 
> This should be prefixed with 'alphascale,'
> 
> How is this value determined?
> 

I think this should stay in userspace, see that series:
https://groups.google.com/forum/#!topic/rtc-linux/HGQqiHnMiuw

It quite often depends on environmental things like temperature so it may be updated at runtime.

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
