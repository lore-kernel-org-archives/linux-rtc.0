Return-Path: <rtc-linux+bncBCJP7WOE5UIBBEOI2KZQKGQEDI2IJCY@googlegroups.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com. [2607:f8b0:4002:c07::22a])
        by gmr-mx.google.com with ESMTPS id i82si131091ywb.7.2015.12.18.16.25.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2015 16:25:52 -0800 (PST)
Received: by mail-yk0-x22a.google.com with SMTP id p130so77127111yka.1
        for <rtc-linux@googlegroups.com>; Fri, 18 Dec 2015 16:25:52 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAODwPW8b9WnrPmtzBZEqCxevYEjYBBKR28PgkwVrwqfCw6-txA@mail.gmail.com>
References: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
	<1450220569-10670-1-git-send-email-jwerner@chromium.org>
	<CAODwPW8b9WnrPmtzBZEqCxevYEjYBBKR28PgkwVrwqfCw6-txA@mail.gmail.com>
Date: Fri, 18 Dec 2015 16:25:52 -0800
Message-ID: <CAD=FV=XwhF7zkURD9wKP4PaShSE0zuZy6EvbkveCc08RtyPv8Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv3] RTC: RK808: Compensate for Rockchip
 calendar deviation on November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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

Julius,

On Tue, Dec 15, 2015 at 3:14 PM, Julius Werner <jwerner@chromium.org> wrote:
> Okay, wrote up and tested the anchor date version. I think once you
> get over the initial weirdness of the approach this one is really much
> cleaner and safer.
>
> I tested this with the older rtc_tm_to_time() API and only ported it
> over to rtc_tm_to_time64() for submission, since my 3.14 kernel didn't
> have that yet... but it still compiles fine and the change was very
> trivial so I'm confident that it should work.
>
> I also did a big manual test for my conversion functions where I just
> threw a whole bunch of dates at them, results below for reference:
>
> [    1.431216] jwerner: Testing translation functions:
> [    1.431221] 2015-01-01 to_rockchip: 2015-01-02 to_gregorian: 2014-12-31
> [    1.431224] 2015-10-30 to_rockchip: 2015-10-31 to_gregorian: 2015-10-29
> [    1.431228] 2015-10-31 to_rockchip: 2015-11-01 to_gregorian: 2015-10-30
> [    1.431231] 2015-11-01 to_rockchip: 2015-11-02 to_gregorian: 2015-10-31
> [    1.431235] 2015-11-27 to_rockchip: 2015-11-28 to_gregorian: 2015-11-26
> [    1.431238] 2015-11-28 to_rockchip: 2015-11-29 to_gregorian: 2015-11-27
> [    1.431242] 2015-11-29 to_rockchip: 2015-11-30 to_gregorian: 2015-11-28
> [    1.431245] 2015-11-30 to_rockchip: 2015-12-01 to_gregorian: 2015-11-29
>
> This one is actually a bug... to_rockchip should be 2015-11-31 here.
> It happens because the "compensate if we went back over" part of
> gregorian_to_rockchip() only checks whether we went over *backwards*,
> which happens if the date is after the anchor date. If it was before
> we can go back over forwards and I didn't bother to handle that case.
> I think this is fine since all affected dates lie in the past and
> there's no real-world use case where you'd ever need them to work
> again.

Thanks for the testing.

Ah, I see, so the problem with your patch is only right around 11/31
in years past.  That seems OK to me.

There's actually a real world case that's pretty common where we want
to work with dates before 2016.  When I power cycle my device and it
totally loses battery, I notice that the firmware seems to start as:

 2013-01-21 00:50:02

It's possible we could need to run for a while in this state and we
possibly could even need alarms to fire.  ...but that's nowhere near
the problematic dates and presumably someone wouldn't have a system in
the "clock set totally wrong" state for a really long time.

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
