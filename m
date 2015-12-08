Return-Path: <rtc-linux+bncBDDJNTW5VUMBBVHKTCZQKGQE2NFXV6I@googlegroups.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id g21si846872wmd.3.2015.12.07.17.41.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 17:41:40 -0800 (PST)
Received: by mail-wm0-x22b.google.com with SMTP id c201so10668529wme.1
        for <rtc-linux@googlegroups.com>; Mon, 07 Dec 2015 17:41:40 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=Wx2E+sVOyMuNyzBnkJrzYuG_yoC7b54EApLg7QTu2sxQ@mail.gmail.com>
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
	<CAD=FV=Wx2E+sVOyMuNyzBnkJrzYuG_yoC7b54EApLg7QTu2sxQ@mail.gmail.com>
Date: Mon, 7 Dec 2015 17:41:39 -0800
Message-ID: <CAODwPW8XmGkPNTw4y_UG7Qy4P1B6y4VH6MOHi1905S_VCrnTPg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
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

> Technically you could still implement this and if firmware happens to
> read the RTC (and doesn't correct things) then we won't be able to
> correct things.  ...but certainly if you read the old time and then
> the new time and the old time was < 11/31 and the new time was >=
> 11/31 you know you need to correct.
>
> I'd say that there's a good chance that other firmware (UBoot) doesn't
> actually read the RTC anyway.  Why would it?  We only do it for even
> log, right?

Hah! Sounds like you assume U-Boot was doing the things it does with
comprehensible reasoning. From my experience, that's a dangerous wager
(not that I'm biased or anything... ;) ). FWIW, they seem to be having
a huge (175kloc, of only the finest copied kernel code from 10+ years
ago, I presume) repository of RTC drivers, a separate command line
command to read/write to it, and an SNTP client.

Still, you're right that adding the GET_TIME check wouldn't hurt... at
worst it just does nothing. I'll try it out.

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
