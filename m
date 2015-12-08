Return-Path: <rtc-linux+bncBCJP7WOE5UIBBRW7TCZQKGQEA4JDLZI@googlegroups.com>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com. [2607:f8b0:400d:c09::229])
        by gmr-mx.google.com with ESMTPS id u69si63892ywf.5.2015.12.07.17.17.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 17:17:58 -0800 (PST)
Received: by mail-qk0-x229.google.com with SMTP id b5so8090498qkd.0
        for <rtc-linux@googlegroups.com>; Mon, 07 Dec 2015 17:17:58 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAODwPW-zWHgmyHX8svgokEhVsaqyx6zZWwvm+-166aNYcj4z-A@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
	<CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
	<CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
	<CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
	<CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
	<CAODwPW-UAVRHVwsA=ZBgL=ZRrW0+WJSmPDcF5jv=bwnePsTe5w@mail.gmail.com>
	<CAD=FV=USMU1eQ8-kA0ysyciXzU-EW6Zy-xZnmtEHsC39xOYrZw@mail.gmail.com>
	<5664E1CF.8030406@rock-chips.com>
	<CAD=FV=V6x94vFCcCwRa=YH+NFCRKCGkNVyE8NTAnXVxX9Bac2Q@mail.gmail.com>
	<CAD=FV=VJKHK2Eu75UJPf+3i7Gaxa09g+Hwfy7nwWYrgMvocarg@mail.gmail.com>
	<5664F837.607@rock-chips.com>
	<CAODwPW-zWHgmyHX8svgokEhVsaqyx6zZWwvm+-166aNYcj4z-A@mail.gmail.com>
Date: Mon, 7 Dec 2015 17:17:58 -0800
Message-ID: <CAD=FV=Wx2E+sVOyMuNyzBnkJrzYuG_yoC7b54EApLg7QTu2sxQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Chris Zhong <zyw@rock-chips.com>, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Sonny Rao <sonnyrao@chromium.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Julius,

On Mon, Dec 7, 2015 at 12:28 PM, Julius Werner <jwerner@chromium.org> wrote:
>> I was presuming that alarms were never set at power off time unless
>> power off happened due to an exceptional case.  AKA: normal Linux
>> shutdown disables all alarms.
>
> Hmm... maybe I misunderstand how this works. Are alarms never used to
> wake from S5? (It doesn't seem to work on my HiSense Chromebook right
> now, but maybe that's just an artifact of our board design? I'm pretty
> sure I've seen S5-wakes work on other platforms... I doubt that RK808
> is intrinsically incapable of that, it just depends on how you hook it
> up.)

Good point.  The hardware out to be capable of it.


>> RK808 has a shadowed register for saving a "frozen" RTC time.
>> When we setting "GET_TIME" to 1, the time will save in this shadowed
>> register. So if we do not set the "GET_TIME", we always get the last
>> time.
>>
>> read the old time before "get_time", and then read the time again for new
>> time. If the old time earlier than 12.1 && new time later than 12.1, we should
>> +1 day for the correct rtc time.
>
> Unfortunately, this doesn't work through S5 if system firmware also
> accesses the RTC and transitions GET_TIME on boot (which it does on
> Chromebooks). We could fix this for coreboot, but it's probably still
> a bad idea to rely on it since Linux should be as firmware-agnostic as
> possible.

Dang.  Who wrote that firmware, anyway?  :-P

Technically you could still implement this and if firmware happens to
read the RTC (and doesn't correct things) then we won't be able to
correct things.  ...but certainly if you read the old time and then
the new time and the old time was < 11/31 and the new time was >=
11/31 you know you need to correct.

I'd say that there's a good chance that other firmware (UBoot) doesn't
actually read the RTC anyway.  Why would it?  We only do it for even
log, right?


>> I'm pretty certain that we need to handle correcting the alarm.
>> Setting an alarm for 10 seconds from now and getting the alarm firing
>> 1 day and 10 seconds from now seems like a pretty huge problem, at
>> least for any system that relies on the RTC alarm a lot.  That pretty
>> much means that we need some way to identify problematic devices.
>> ...so I think if we have no revision register then we should either
>> assume all rk808 devices have this problem (and hope and pray that
>> Rockchip gives us a way to ID things if they ever add a fix) or come
>> up with some other type of solution (probe one time when the clock is
>> presumably wrong and store something somewhere in rk808 to indicate
>> that we've already probed)
>
>> Once we have to fix the alarm, handling S3 seems like it will be not
>> much more work.
>
> Agreed, scheduling alarms in the future is also an important point. So
> I guess I'll update the patch to fix alarm scheduling and S3 as well,
> and we'll just ignore S5 as infeasible?

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
