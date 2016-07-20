Return-Path: <rtc-linux+bncBDKOBWPM5ABRBCEZX26AKGQEF46M2KI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com. [2607:f8b0:4002:c05::233])
        by gmr-mx.google.com with ESMTPS id v70si199409ywc.2.2016.07.20.07.36.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 07:36:56 -0700 (PDT)
Received: by mail-yw0-x233.google.com with SMTP id r9so47156075ywg.0
        for <rtc-linux@googlegroups.com>; Wed, 20 Jul 2016 07:36:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160720090220.GQ7132@piout.net>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
 <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
 <20160619142934.GA8522@rob-hp-laptop> <CAHQ1cqFfFpLmMMr9itinha9rotG7Btr9UmWbO2_0VWxX_HeG1g@mail.gmail.com>
 <20160621204904.GA9779@rob-hp-laptop> <20160621210739.GY5809@piout.net>
 <CAHQ1cqGRqhOAqfJZEixkxAHZ4Y8dd-hD__T1ci0LS28Orphs3Q@mail.gmail.com>
 <20160719224728.GP7132@piout.net> <CAHQ1cqF+Z5sKhtxgFiTGJdaOtkQRtQmXU=DzG0qxnDDwfAMp_g@mail.gmail.com>
 <20160720090220.GQ7132@piout.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 20 Jul 2016 07:36:55 -0700
Message-ID: <CAHQ1cqEoN7PEQApHBo-FOqumtLJWoURHOPZfrzL=6h2p4S0Fdg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 03/13] RTC: ds1307: Add DS1341 specific
 power-saving options
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jul 20, 2016 at 2:02 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 19/07/2016 at 16:56:56 -0700, Andrey Smirnov wrote :
>> >> I don't see any value in doing that, could you give me a realistic
>> >> example of a scenario in which a user would want to spend some of
>> >> uptime with RTC oscillator fault detection/glitch filtering disabled
>> >> and then enable it?
>> >>
>> >
>> > Well, the issue is not being dynamic, it is differentiating between
>> > hardware description and user configuration. Configuration must not be in
>> > DT.
>>
>> Why? And I don't mean in a generic sense, but in this particular case.
>> What is gained by not having this bit of configuration, whose only
>> consumer is the driver, in the device tree file?
>>
>
> Because configuration doesn't belong to DT. DT is about hardware
> description, not configuration.

That doesn't really answer my question. You just re-iterating some
maxim without explaining what is the point behind applying it.

>
>
>> > And this choice is definitively not hardware related (as opposed to
>> > the trickle charging that depends on the battery that is used on the
>> > board).
>>
>> There's most certainly plenty of precedents of non hardware-related in
>> device tree, first two that come to mind are "chosen" node and
>> "local-mac-address" property and, granted, those might be
>> exceptions/legacy bindings that are just there to stay, but even if
>> you look at RTC subsystem rtc-cmos.txt, atmel,at91sam-rtc.txt and
>> possibly rtc-st-lpc.txt are providing bindings that are not exactly
>> hardware related.
>>
>> Rtc-cmos.txt is especially noticeable example since it literally does
>> what I am trying to do -- allows the user to specify initial values to
>> certain registers that would be initialized by the driver.
>>
>
> Well, the RTC subsystem has been left unmaintained for a while and it is
> not because we made mistakes in the past that we have to make them
> again.
>
> rtc-st-lpc is only hardware related. The mode it is used in is board
> dependant. And I have a plan to change how the gpbr register is
> allocated for the at91 RTT. I agree that rtc-cmos is an example of what
> not to do.
>
>> > Well, it doesn't leak abstraction as long as all the RTC that are able
>> > to disable the oscillator failure detection use the same ABI.
>>
>> Correct me if I am wrong, but no such, at least semi-standardized, ABI
>> exist as of today, correct? If that is so, then what you are saying is
>> that the abstraction doesn't leak as long as you put it inside of a
>> new abstraction that doesn't leak. I am not arguing that it is
>> impossible to create a new one that would allow to hide hardware
>> differences, I am positive it is, what I am arguing is that to do so
>> is a lot of work for as far as I can see for no gain.
>>
>
> You are correct, that ABI doesn't exist and I'm asking to create it.
> That is how kernel development happens.

OK, I don't think this is going anywhere. I am sure by now you know
very well, that I am not going to agree to that. I'll just drop this
part, gut the patchset to it's bare minimum and re-submit it.

Andrey

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
