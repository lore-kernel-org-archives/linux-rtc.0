Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZVDX66AKGQEIZ46DMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o85si1633155wme.0.2016.07.20.12.32.54
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jul 2016 12:32:54 -0700 (PDT)
Date: Wed, 20 Jul 2016 21:32:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>, Rob Herring <robh+dt@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/3] Documentation: dt: Intersil isl12057 is
 not a trivial device
Message-ID: <20160720193253.GB4446@piout.net>
References: <1468371571-22641-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468371571-22641-2-git-send-email-alexandre.belloni@free-electrons.com>
 <87zipkgeuv.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87zipkgeuv.fsf@natisbad.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

+robh

On 14/07/2016 at 22:10:48 +0200, Arnaud Ebalard wrote :
> Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:
> 
> > The ISL12057 has a documentation file, remove it from trivial-devices.txt
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index 539874490492..a397d39ea741 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -50,7 +50,6 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
> >  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> >  infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
> >  infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> > -isil,isl12057		Intersil ISL12057 I2C RTC Chip
> >  isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
> >  maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
> >  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
> 
> No strong advice on this but I thought it qualified as a trivial device
> because it did not *need* anything else except a compatible, an address
> and possibly an interrupt. The additional boolean property documented in
> Documentation/devicetree/bindings/rtc/isil,isl12057.txt is optional.
> 

Well, my thinking is that trivial devices are in trivial-devices.txt
because they are not documented anywhere else. This is mostly the case.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
