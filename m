Return-Path: <rtc-linux+bncBCJP7WOE5UIBBBMGR2ZQKGQEB7ZRFYA@googlegroups.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com. [2607:f8b0:4002:c07::229])
        by gmr-mx.google.com with ESMTPS id v66si1665524ywa.0.2015.12.05.16.36.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2015 16:36:21 -0800 (PST)
Received: by mail-yk0-x229.google.com with SMTP id v3so160886925ykd.0
        for <rtc-linux@googlegroups.com>; Sat, 05 Dec 2015 16:36:21 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAODwPW-UAVRHVwsA=ZBgL=ZRrW0+WJSmPDcF5jv=bwnePsTe5w@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
	<CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
	<CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
	<CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
	<CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
	<CAODwPW-UAVRHVwsA=ZBgL=ZRrW0+WJSmPDcF5jv=bwnePsTe5w@mail.gmail.com>
Date: Sat, 5 Dec 2015 16:36:21 -0800
Message-ID: <CAD=FV=USMU1eQ8-kA0ysyciXzU-EW6Zy-xZnmtEHsC39xOYrZw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
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

On Fri, Dec 4, 2015 at 11:17 PM, Julius Werner <jwerner@chromium.org> wrote:
>> If you set the alarm
>> for Dec 25th and it's currently Oct 31st then you'll have to adjust in
>> the alarm code and you'll really set it for Dec 24th.  As per above,
>> we're in S3 (presumably) or have some persistent kernel state so we
>> know to adjust everything when we wake up (even if we wake up for a
>> non-alarm reason).
>
> How do you deal with the case where you set an alarm in late December,
> but you then power the system on earlier in December by other means? I
> think then you couldn't tell if the fix had already been applied?

I was presuming that alarms were never set at power off time unless
power off happened due to an exceptional case.  AKA: normal Linux
shutdown disables all alarms.  If you happened to have an exceptional
shutdown (out of battery?) while an alarm is set then, yes, my
solution fails.  Presumably if the RTC keeps state but the system ran
out of battery, you've got two batteries in your system (something
none of the rk808-based Chromebooks have--we back rk808 state up with
the main battery, not a coin cell).

In Chromebooks you could possibly get a shutdown that Linux didn't
know anything about if you got a forcible reboot (watchdog, crash, or
Refresh-Power) and then you managed to convince the BIOS to shut you
down (you have the dev screen and press power off there).  Again, this
seems pretty darn rare.


>> You'll still get a failure if you set the alarm and then forcibly go
>> into S5 without software knowledge, then stay in S5 long enough to
>> cross over Nov 31st without seeing it (but somehow keep the RTC
>> state).  ...but come on, that seems so incredibly rare!  :-P
>
> I think you could just set it to "November 31st, disabled" at probe
> time (if it isn't already) and keep it like that indefinitely? I think
> as long as you don't need to actually use the alarm, that would work
> fine.

Yup.  In ChromeOS we only use the alarm in suspend stress testing, but
I'd believe that anyone using Android on one of these systems would
use the RTC much more.

We might (?) use the RTC alarm in ChromeOS if we ever support dark
resume etc on rk3288-based devices, right?


> Still, with the vast majority of practically existing devices with an
> RK808 almost constantly connected to some network, I'm not sure if a
> huge hack-around is really worth it here. (I guess we could still just
> do the S3 thing which is much less complicated, assuming we can
> guarantee correct identification.)

I'm pretty certain that we need to handle correcting the alarm.
Setting an alarm for 10 seconds from now and getting the alarm firing
1 day and 10 seconds from now seems like a pretty huge problem, at
least for any system that relies on the RTC alarm a lot.  That pretty
much means that we need some way to identify problematic devices.
...so I think if we have no revision register then we should either
assume all rk808 devices have this problem (and hope and pray that
Rockchip gives us a way to ID things if they ever add a fix) or come
up with some other type of solution (probe one time when the clock is
presumably wrong and store something somewhere in rk808 to indicate
that we've already probed)

Once we have to fix the alarm, handling S3 seems like it will be not
much more work.

I'm OK with not handling S5, but I think with my proposed scheme we
could also handle it if we wanted.


All hacks should be contained in the rk808 driver, which should make
them much less objectionable in general.

-Doug

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
