Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBMXFVTCQKGQELF5VSEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id p185si899050wme.1.2017.02.20.10.17.22
        for <rtc-linux@googlegroups.com>;
        Mon, 20 Feb 2017 10:17:22 -0800 (PST)
Date: Mon, 20 Feb 2017 19:17:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com,
	Andrew Lunn <andrew@lunn.ch>, Haim Boot <hayim@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/3] Extend rtc-armada38x support for
 Armada 7K/8K
Message-ID: <20170220181712.yejnobmj3dhm5ev6@piout.net>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
 <20170220173633.d4ke4eohaacgsw3h@piout.net>
 <20170220175054.GP21222@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170220175054.GP21222@n2100.armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/02/2017 at 17:50:54 +0000, Russell King - ARM Linux wrote:
> > The question being what does that do and whether it could be done in the
> > driver instead.
> 
> It's not specific to the Armada 8040, the same problem exists with
> Armada 38x, so holding this up for that reason does not make sense.
> 

I agree, I will not delay the patch for that.

> I suspect that the errata is "RTC is not reset at power up" for the RTC
> power domain.
> 
> I don't know where the value of 0x2000 comes from for the correction
> value, all I know is that's the value uboot uses with "date reset".
> We probably do _not_ want the driver writing that each time the
> kernel boots, since that's a tuning parameter.
> 

It is probably a calibration offset. It may be worth exposing to
userspace but without more information, I doubt we can make something
useful out of it.



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
