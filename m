Return-Path: <rtc-linux+bncBDDJNTW5VUMBBZMVTCZQKGQEX6QSMFQ@googlegroups.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id 204si853745wmx.1.2015.12.07.14.40.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 14:40:36 -0800 (PST)
Received: by mail-wm0-x230.google.com with SMTP id w144so6810653wmw.0
        for <rtc-linux@googlegroups.com>; Mon, 07 Dec 2015 14:40:36 -0800 (PST)
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
Date: Mon, 7 Dec 2015 14:40:36 -0800
Message-ID: <CAODwPW-gGnZUoNm4M1v5rEM3LCtPD23EZknRqOqw5cDeviWJ9w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Chris Zhong <zyw@rock-chips.com>, Doug Anderson <dianders@chromium.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
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

[+Alexandre... sorry, didn't notice that you somehow fell off the
thread again, but I presume you get rtc-linux anyway]

> Agreed, scheduling alarms in the future is also an important point. So
> I guess I'll update the patch to fix alarm scheduling and S3 as well,
> and we'll just ignore S5 as infeasible?

Found another edge case trying to implement this: if you set an alarm
on Nov 25th for Dec 5th, the code will have to adjust it to Dec 4th to
account for the extra day. But if you then power off (or brownout) to
S5 and don't power it on again until December, you have no way of
knowing whether the already set alarm timestamp is on the Rockchip or
the Gregorian calendar. You may or may not sync your current time back
through an external source, but you have no way of knowing what you
should do with the alarm.

Other than that my current idea is roughly:

- if the current time gets written, always assume the new date is correct
- store a "last known timestamp" in memory on boot and on every write
- if the current time gets read, adjust it forward by the amount of
Nov 31sts since the stored timestamp (this adjustment itself
constitutes a write)
- if an alarm is written, adjust the timestamp written to hardware
backward by the amount of Nov 31sts between the stored timestamp and
the alarm time
- if an alarm is read, adjust the returned result forward by the
amount of Nov 31sts between the stored timestamp and the alarm time
- if the current time gets written, read the alarm time before the
write and write it back afterwards (the last known timestamp will
change as a result of writing the current time, meaning the newly
written hardware alarm time may be different from the old one)

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
