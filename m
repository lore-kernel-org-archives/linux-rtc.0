Return-Path: <rtc-linux+bncBDDJNTW5VUMBBA7HQGZQKGQEG7JA6SI@googlegroups.com>
Received: from mail-vk0-x22c.google.com (mail-vk0-x22c.google.com. [2607:f8b0:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id p196si436150vkp.2.2015.12.03.08.53.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2015 08:53:22 -0800 (PST)
Received: by mail-vk0-x22c.google.com with SMTP id a188so49518509vkc.0
        for <rtc-linux@googlegroups.com>; Thu, 03 Dec 2015 08:53:22 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20151203144203.GA3515@piout.net>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
	<20151203144203.GA3515@piout.net>
Date: Thu, 3 Dec 2015 08:53:22 -0800
Message-ID: <CAODwPW-KS4f8GQ2ooOhdA+ZrDUPvvv6r0795f+QyHrjWagMHhA@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Julius Werner <jwerner@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Doug Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, LKML <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> I would have liked to be in copy of that mail. Maybe you used
> get_maintainers on an old tree?

Oops, yes, sorry, I ran it on a 3.14 backport and then just added
people I found in older patches for that file.

> I hope reading the time properly fails thanks to the rtc_valid_tm(tm) in
> __rtc_read_time().

It should, yeah. I haven't tested it (beyond compiling) on master, and
our version doesn't have that code yet, so I can't say for sure.

> It will also happen if nobody reads the RTC time for that day (highly
> improbable in a default configuration). Do you need that patch for 4.4
> or can it wait 4.5?

True. I don't really need the patch to land in a particular release
since we maintain our own tree with backports. It would probably still
be nice if you can get it into the 4.4 LTS to reduce the chance this
will hit anyone again next year.

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
