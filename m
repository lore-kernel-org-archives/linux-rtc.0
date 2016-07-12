Return-Path: <rtc-linux+bncBDKOBWPM5ABRB7FRSS6AKGQECZOTKBQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com. [2607:f8b0:4002:c05::22f])
        by gmr-mx.google.com with ESMTPS id i4si220098ywf.6.2016.07.12.09.21.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 09:21:15 -0700 (PDT)
Received: by mail-yw0-x22f.google.com with SMTP id w127so18264451ywf.3
        for <rtc-linux@googlegroups.com>; Tue, 12 Jul 2016 09:21:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGRqhOAqfJZEixkxAHZ4Y8dd-hD__T1ci0LS28Orphs3Q@mail.gmail.com>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
 <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
 <20160619142934.GA8522@rob-hp-laptop> <CAHQ1cqFfFpLmMMr9itinha9rotG7Btr9UmWbO2_0VWxX_HeG1g@mail.gmail.com>
 <20160621204904.GA9779@rob-hp-laptop> <20160621210739.GY5809@piout.net> <CAHQ1cqGRqhOAqfJZEixkxAHZ4Y8dd-hD__T1ci0LS28Orphs3Q@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 12 Jul 2016 09:21:14 -0700
Message-ID: <CAHQ1cqErr9g83qpDASymTnR78YGJcS8tvb=VD8CthOZMJTNEpw@mail.gmail.com>
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

On Tue, Jun 21, 2016 at 7:34 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> On Tue, Jun 21, 2016 at 2:07 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 21/06/2016 at 15:49:04 -0500, Rob Herring wrote :
>>> So wouldn't you want to set one mode while running and the lower power
>>> mode while suspended? I'm trying to understand the frequency of changing
>>> this. If it is always one setting for a board, then yes it belongs in
>>> DT. If it is a user decision, then it probably shouldn't be in DT.
>>>
>>> Seeing as these are reused, I've probably already had this discussion...
>>>
>>
>> I would agree with Rob here. It may be better to provide a sysfs
>> interface to configure that particular behavior.
>
> I don't see any value in doing that, could you give me a realistic
> example of a scenario in which a user would want to spend some of
> uptime with RTC oscillator fault detection/glitch filtering disabled
> and then enable it?
>
>> This is usually ok because the use case is:
>>  - the RTC is not configured, time has never been set
>>  - time is set for the first time
>>  - the user can set the oscillator mode/detection/...
>
> Unfortunately exposing that feature using sysfs gives you a leaky
> abstraction and your userspace instead of using a generic RTC starts
> using DS1341 RTC. So to accommodate for that a user would have to:
>
> a) Write + integrate a userspace tool to set the mode (which IMHO is
> decided upon once and doesn't change)
> b) If a board design is new and there's a chance of moving this chip
> to a different I2C bus, the code above would have to account for that
> and not hardcore sysfs path
> c) If board's BSP is intended to be used in multiple generations of a
> product, not all of which would use DS1341, it would be necessary to
> accommodate for that by either more code in the tool or an additional
> BSP build configuration variant
>
>>  - on subsequent reboots, the mode is kept alongside the time and date
>>
>
> This assumes that your bootloader leaves those mode bits alone.
>
>> I would advise against trying to set a mode automatically in the driver
>> because you may have unexpected power cuts and it may then let the RTC
>> consume more power than what you really want.
>>
>
> I fell like I am not understanding you correctly.  Why would moving
> configuration decision logic into userspace improve the situation in
> case of unexpected power loss?
>
> Andrey


Alexandre, what's the status of this discussion/patchset? Would it be
more acceptable if I dropped all of the refactoring and just kept the
code adding new feature + DT binding for it? I am more than happy to
drop all but essential parts of the patches if that would allow us to
make progress.

Thank you,
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
