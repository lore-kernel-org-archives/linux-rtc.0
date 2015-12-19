Return-Path: <rtc-linux+bncBDDJNTW5VUMBBZOK2KZQKGQEHVGTS5Y@googlegroups.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com. [2a00:1450:400c:c09::229])
        by gmr-mx.google.com with ESMTPS id b62si285395wmc.0.2015.12.18.16.31.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2015 16:31:33 -0800 (PST)
Received: by mail-wm0-x229.google.com with SMTP id p187so4904440wmp.0
        for <rtc-linux@googlegroups.com>; Fri, 18 Dec 2015 16:31:33 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=XwhF7zkURD9wKP4PaShSE0zuZy6EvbkveCc08RtyPv8Q@mail.gmail.com>
References: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
	<1450220569-10670-1-git-send-email-jwerner@chromium.org>
	<CAODwPW8b9WnrPmtzBZEqCxevYEjYBBKR28PgkwVrwqfCw6-txA@mail.gmail.com>
	<CAD=FV=XwhF7zkURD9wKP4PaShSE0zuZy6EvbkveCc08RtyPv8Q@mail.gmail.com>
Date: Fri, 18 Dec 2015 16:31:32 -0800
Message-ID: <CAODwPW9JP_DhKC73f5CWcMkkOM=KX3M8v7y0cke0y13Ywcxv_w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv3] RTC: RK808: Compensate for Rockchip
 calendar deviation on November 31st
From: Julius Werner <jwerner@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, LKML <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

> There's actually a real world case that's pretty common where we want
> to work with dates before 2016.  When I power cycle my device and it
> totally loses battery, I notice that the firmware seems to start as:
>
>  2013-01-21 00:50:02
>
> It's possible we could need to run for a while in this state and we
> possibly could even need alarms to fire.  ...but that's nowhere near
> the problematic dates and presumably someone wouldn't have a system in
> the "clock set totally wrong" state for a really long time.

Yeah... I don't think it really makes much sense to worry about that.
At that point it's much more likely that you will loose an alarm
because the user finally fixes the clock at some point (either
manually or by connecting to a network and having some automated sync
service jump in), and we never worry about something like that either.
I mean, fixing it wouldn't be a big deal (another 5 lines or so
maybe), but I just don't think it's worth adding any complexity.

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
