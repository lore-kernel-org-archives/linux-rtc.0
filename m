Return-Path: <rtc-linux+bncBDDJNTW5VUMBBI47RKZQKGQEDGDE44I@googlegroups.com>
Received: from mail-vk0-x229.google.com (mail-vk0-x229.google.com. [2607:f8b0:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id g91si870054vki.3.2015.12.04.23.17.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 23:17:54 -0800 (PST)
Received: by vkca188 with SMTP id a188so78840129vkc.0
        for <rtc-linux@googlegroups.com>; Fri, 04 Dec 2015 23:17:54 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=VVU0ucrL9gsMGKBwMCg_d6aTZWXTpxwNmfNp0k0BzbdQ@mail.gmail.com>
	<CAODwPW_xoF8KYRPWvSrs89F-ZKxWMC4_Gp-vdEYENfzESin=ig@mail.gmail.com>
	<CAD=FV=VLVmJQbY45De7qyg9AsW-VDqKfvj7MHMWXiGCrrx6WDA@mail.gmail.com>
	<CAODwPW939ZrmGsspk42BU=U+hca4hyT4W0ceOZCVWtu057i58A@mail.gmail.com>
	<CAD=FV=Ur0+qmQ1mnvV3Er1RjfMU8DY7yk9PPf04wAJ7Xrt+7vw@mail.gmail.com>
	<CAD=FV=X_1yUONf53AXGBZps=3VFnGFDq5u2-57SoBGtvBFiWHg@mail.gmail.com>
Date: Fri, 4 Dec 2015 23:17:54 -0800
Message-ID: <CAODwPW-UAVRHVwsA=ZBgL=ZRrW0+WJSmPDcF5jv=bwnePsTe5w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Sonny Rao <sonnyrao@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
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

> If you set the alarm
> for Dec 25th and it's currently Oct 31st then you'll have to adjust in
> the alarm code and you'll really set it for Dec 24th.  As per above,
> we're in S3 (presumably) or have some persistent kernel state so we
> know to adjust everything when we wake up (even if we wake up for a
> non-alarm reason).

How do you deal with the case where you set an alarm in late December,
but you then power the system on earlier in December by other means? I
think then you couldn't tell if the fix had already been applied?

> You'll still get a failure if you set the alarm and then forcibly go
> into S5 without software knowledge, then stay in S5 long enough to
> cross over Nov 31st without seeing it (but somehow keep the RTC
> state).  ...but come on, that seems so incredibly rare!  :-P

I think you could just set it to "November 31st, disabled" at probe
time (if it isn't already) and keep it like that indefinitely? I think
as long as you don't need to actually use the alarm, that would work
fine.

Still, with the vast majority of practically existing devices with an
RK808 almost constantly connected to some network, I'm not sure if a
huge hack-around is really worth it here. (I guess we could still just
do the S3 thing which is much less complicated, assuming we can
guarantee correct identification.)

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
