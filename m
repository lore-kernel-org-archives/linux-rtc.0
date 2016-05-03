Return-Path: <rtc-linux+bncBDS7HNEFSALRBZV3UG4QKGQEKXVXZEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v130si269072wmv.1.2016.05.03.01.14.29
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 01:14:29 -0700 (PDT)
Date: Tue, 3 May 2016 10:14:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Cc: Rob Herring <robh@kernel.org>, lee.jones@linaro.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: add Cypress FM33256B Processor
 Companion driver
Message-ID: <20160503081418.GC2335@piout.net>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-2-git-send-email-jlp@gomspace.com>
 <20160422193232.GA9737@rob-hp-laptop>
 <20160422201153.GB17051@piout.net>
 <571F7BD2.60201@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <571F7BD2.60201@gomspace.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/04/2016 at 16:31:46 +0200, Jeppe Ledet-Pedersen wrote :
> > Good catch, I didn't look at this patch but it includes a lot of code
> > that should be going to the RTC driver.
> > If trickle charging is not enabled, I guess the RTC will not charge its
> > backup battery.
> 
> Thank you for the comments.
> 
> Alexandre is correct. If the "cypress,charge-enabled" property is
> present, the internal 80 uA trickle charger is enabled to charge a
> backup capacitor on the VBAK pin.
> 
> Do you want more code than the trickle charger setup moved to the RTC
> driver?
> 

I guess the 32k oscillator could go in the rtc driver too.

> >>> +- cypress,charge-fast: enable fast (1 mA) charging
> >>
> >> What does fast mean?
> >>
> 
> Fast charging means charging with 1 mA instead of 80 uA. The wording is
> from the datasheet, but I agree it should be renamed to something that
> better explains what the difference is.
> 
> >> I think it is time for a common binding here. There's all sorts of 
> >> variations on setting the charge current in bindings. Add something like 
> >> "charge-current-microamp" in power_supply.txt and use it here. Then 
> >> 1000uA implies "fast charge".
> > 
> > Well, this is not a power supply, it is an RTC.
> > 
> > I think both properties should got to the RTC subdevice and be parsed in
> > the RTC driver.
> 
> The backup capacitor is primarily used to supply current to the RTC, but
> a couple of other registers are also battery-backed (watchdog reset
> cause, event counter), so I put the charger setup in the main MFD file.
> 
> If you prefer, I can move them both to the RTC driver?

I would prefer unless you think that many people are not using the RTC
while still using the watchdog (I'd say that is not the case).

> 
> > Note that for trickle charging, we currently have the following
> > properties:
> >  - trickle-resistor-ohms
> >  - trickle-diode-disable
> >  - abracon,tc-diode
> >  - abracon,tc-resistor
> > 
> > abracon,tc-resistor can be replaced by trickle-resistor-ohms, I'll make
> > a patch but abracon,tc-diode allows to select a diode type (and in
> > particular a voltage drop).
> > 
> > I think we could add a trickle-current-microamp like you suggested and
> > trickle-diode-disable can be reused.
> 
> So replace "cypress,charge-enabled/charge-fast" with
> "trickle-current-microamp" and a check for 0/80/1000 uA?
> 

Yeah, seems fine.

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
