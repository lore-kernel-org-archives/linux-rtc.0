Return-Path: <rtc-linux+bncBDDJNTW5VUMBBFMWU6ZQKGQESWUB2AY@googlegroups.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id b62si4297wmc.0.2015.12.10.10.57.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2015 10:57:24 -0800 (PST)
Received: by mail-wm0-x231.google.com with SMTP id w144so37306931wmw.0
        for <rtc-linux@googlegroups.com>; Thu, 10 Dec 2015 10:57:24 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20151210184119.GL3515@piout.net>
References: <CAODwPW-ZJ2HwrQohmfMYv2-jH2Ofq-O2H_HPfqYLXXnueVYYnA@mail.gmail.com>
	<1449552115-31256-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=U+SYHVkgP1sAF4h3xmrQBhc7o=KpryAGAXjeYOYnNTcA@mail.gmail.com>
	<CAODwPW9M6gWXpUkT2A3k6jmj7sBzwjmScE+ZSAe209UDnAW6mg@mail.gmail.com>
	<20151210184119.GL3515@piout.net>
Date: Thu, 10 Dec 2015 10:57:24 -0800
Message-ID: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Julius Werner <jwerner@chromium.org>, Doug Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
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

> I'll try to review and evaluate both solution by the end of the week (no
> guarantee though).

To summarize, it's a pretty simple trade-off. Do you:

a) try to detect every time the RTC deviated from the real-world time
and correct it instantly? This can be done most of the time but there
are edge cases (when the system is completely powered off while the
RTC ticks over Nov 31st) where you cannot detect it. Or,

b) just completely let the RTC tick in its own world where every year
has an extra day and convert that "calendar" to/from the real-world
calendar on every access. This essentially relegates the RTC to a
"dumb second counter" and the timestamp in its registers doesn't have
any direct connection to the real world time anymore (unless you know
the conversion algorithm). This has the nice advantage that it
perfectly solves all use cases (time-keeping, accurate alarms, even
when shut down or browning out at inopportune times)... the only real
disadvantage is that other software (e.g. U-Boot) reading the same RTC
must know about this and use the same conversion code to get the
correct real-world time from it.

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
