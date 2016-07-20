Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBB5WX26AKGQEJAUDONI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si184957wmg.1.2016.07.20.08.38.46
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jul 2016 08:38:46 -0700 (PDT)
Date: Wed, 20 Jul 2016 17:38:36 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 03/13] RTC: ds1307: Add DS1341 specific
 power-saving options
Message-ID: <20160720153836.GS7132@piout.net>
References: <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
 <20160619142934.GA8522@rob-hp-laptop>
 <CAHQ1cqFfFpLmMMr9itinha9rotG7Btr9UmWbO2_0VWxX_HeG1g@mail.gmail.com>
 <20160621204904.GA9779@rob-hp-laptop>
 <20160621210739.GY5809@piout.net>
 <CAHQ1cqGRqhOAqfJZEixkxAHZ4Y8dd-hD__T1ci0LS28Orphs3Q@mail.gmail.com>
 <20160719224728.GP7132@piout.net>
 <CAHQ1cqF+Z5sKhtxgFiTGJdaOtkQRtQmXU=DzG0qxnDDwfAMp_g@mail.gmail.com>
 <20160720090220.GQ7132@piout.net>
 <CAHQ1cqEoN7PEQApHBo-FOqumtLJWoURHOPZfrzL=6h2p4S0Fdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHQ1cqEoN7PEQApHBo-FOqumtLJWoURHOPZfrzL=6h2p4S0Fdg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/07/2016 at 07:36:55 -0700, Andrey Smirnov wrote :
> On Wed, Jul 20, 2016 at 2:02 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 19/07/2016 at 16:56:56 -0700, Andrey Smirnov wrote :
> >> >> I don't see any value in doing that, could you give me a realistic
> >> >> example of a scenario in which a user would want to spend some of
> >> >> uptime with RTC oscillator fault detection/glitch filtering disabled
> >> >> and then enable it?
> >> >>
> >> >
> >> > Well, the issue is not being dynamic, it is differentiating between
> >> > hardware description and user configuration. Configuration must not be in
> >> > DT.
> >>
> >> Why? And I don't mean in a generic sense, but in this particular case.
> >> What is gained by not having this bit of configuration, whose only
> >> consumer is the driver, in the device tree file?
> >>
> >
> > Because configuration doesn't belong to DT. DT is about hardware
> > description, not configuration.
> 
> That doesn't really answer my question. You just re-iterating some
> maxim without explaining what is the point behind applying it.
> 

Well, that is from the device tree specification and how the device tree
maintainers want it...

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
