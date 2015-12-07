Return-Path: <rtc-linux+bncBCJP7WOE5UIBBAHISOZQKGQENOAOYSQ@googlegroups.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com. [2607:f8b0:4002:c07::235])
        by gmr-mx.google.com with ESMTPS id v66si1972183ywa.0.2015.12.06.18.50.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2015 18:50:40 -0800 (PST)
Received: by mail-yk0-x235.google.com with SMTP id s79so181616132ykf.1
        for <rtc-linux@googlegroups.com>; Sun, 06 Dec 2015 18:50:40 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <5664E1CF.8030406@rock-chips.com>
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
Date: Sun, 6 Dec 2015 18:50:39 -0800
Message-ID: <CAD=FV=V6x94vFCcCwRa=YH+NFCRKCGkNVyE8NTAnXVxX9Bac2Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Doug Anderson <dianders@chromium.org>
To: Chris Zhong <zyw@rock-chips.com>
Cc: Julius Werner <jwerner@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Sonny Rao <sonnyrao@chromium.org>,
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

Chris,

On Sun, Dec 6, 2015 at 5:33 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Hi Doug
>
> RK808 has a shadowed register for saving a "frozen" RTC time.
> When we setting "GET_TIME" to 1, the time will save in this shadowed
> register. So if we do not set the "GET_TIME", we always get the last time.
>
> read the old time before "get_time", and then read the time again for new
> time. If the old time earlier than 12.1 && new time later than 12.1, we
> should
> +1 day for the correct rtc time.
>
> On the other hand, we should set the "GET_TIME" after rk808_rtc_set_time,
> for restore the time before suspend/shut_down.

Ah, good idea using the shadow registers.  The whole point of the
shadow registers is to enable atomic read of time, right?  So if the
clock ticks as you are reading 23:59:59 you don't end up reading
23:59:00 or 24:59:59 (you'll get either 23:59:59 or 24:00:00).  So
right, time read will now be:

1. Read GET_TIME.  Confirm it's 1.
2. Read the time.
3. Set GET_TIME to 0.
4. Set GET_TIME to 1.
5. Read the time.

If time from #2 < 11/31 and time from #5 >= 11/31 then we do the
adjust.  If GET_TIME wasn't 1 in step #1 then we won't do any
adjusting unless the time is actually 11/31.

Between steps #4 and #5 we'll need to add a small delay since old code
used to use the setting to 0 as a delay (as commented).

We should presumably always leave GET_TIME as 1 unless we're actively
reading the time for the most reliability.  Also, if we've already
read the time this bootup, we can certainly optimize the above by
skipping #1 and #2.

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
