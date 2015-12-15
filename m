Return-Path: <rtc-linux+bncBDDJNTW5VUMBBUN5YKZQKGQESFT4J6I@googlegroups.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id w187si445198wmw.1.2015.12.15.15.14.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2015 15:14:25 -0800 (PST)
Received: by mail-wm0-x22d.google.com with SMTP id n186so117433858wmn.0
        for <rtc-linux@googlegroups.com>; Tue, 15 Dec 2015 15:14:25 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1450220569-10670-1-git-send-email-jwerner@chromium.org>
References: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
	<1450220569-10670-1-git-send-email-jwerner@chromium.org>
Date: Tue, 15 Dec 2015 15:14:25 -0800
Message-ID: <CAODwPW8b9WnrPmtzBZEqCxevYEjYBBKR28PgkwVrwqfCw6-txA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv3] RTC: RK808: Compensate for Rockchip
 calendar deviation on November 31st
From: Julius Werner <jwerner@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	LKML <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Okay, wrote up and tested the anchor date version. I think once you
get over the initial weirdness of the approach this one is really much
cleaner and safer.

I tested this with the older rtc_tm_to_time() API and only ported it
over to rtc_tm_to_time64() for submission, since my 3.14 kernel didn't
have that yet... but it still compiles fine and the change was very
trivial so I'm confident that it should work.

I also did a big manual test for my conversion functions where I just
threw a whole bunch of dates at them, results below for reference:

[    1.431216] jwerner: Testing translation functions:
[    1.431221] 2015-01-01 to_rockchip: 2015-01-02 to_gregorian: 2014-12-31
[    1.431224] 2015-10-30 to_rockchip: 2015-10-31 to_gregorian: 2015-10-29
[    1.431228] 2015-10-31 to_rockchip: 2015-11-01 to_gregorian: 2015-10-30
[    1.431231] 2015-11-01 to_rockchip: 2015-11-02 to_gregorian: 2015-10-31
[    1.431235] 2015-11-27 to_rockchip: 2015-11-28 to_gregorian: 2015-11-26
[    1.431238] 2015-11-28 to_rockchip: 2015-11-29 to_gregorian: 2015-11-27
[    1.431242] 2015-11-29 to_rockchip: 2015-11-30 to_gregorian: 2015-11-28
[    1.431245] 2015-11-30 to_rockchip: 2015-12-01 to_gregorian: 2015-11-29

This one is actually a bug... to_rockchip should be 2015-11-31 here.
It happens because the "compensate if we went back over" part of
gregorian_to_rockchip() only checks whether we went over *backwards*,
which happens if the date is after the anchor date. If it was before
we can go back over forwards and I didn't bother to handle that case.
I think this is fine since all affected dates lie in the past and
there's no real-world use case where you'd ever need them to work
again.

[    1.431249] 2015-11-31 to_rockchip: 2015-12-02 to_gregorian: 2015-11-30
[    1.431252] 2015-12-01 to_rockchip: 2015-12-01 to_gregorian: 2015-12-01
[    1.431256] 2015-12-02 to_rockchip: 2015-12-02 to_gregorian: 2015-12-02
[    1.431259] 2015-12-03 to_rockchip: 2015-12-03 to_gregorian: 2015-12-03
[    1.431262] 2015-12-04 to_rockchip: 2015-12-04 to_gregorian: 2015-12-04
[    1.431266] 2015-12-05 to_rockchip: 2015-12-05 to_gregorian: 2015-12-05
[    1.431269] 2015-12-30 to_rockchip: 2015-12-30 to_gregorian: 2015-12-30
[    1.431273] 2015-12-31 to_rockchip: 2015-12-31 to_gregorian: 2015-12-31
[    1.431276] 2016-01-01 to_rockchip: 2016-01-01 to_gregorian: 2016-01-01
[    1.431279] 2016-10-30 to_rockchip: 2016-10-30 to_gregorian: 2016-10-30
[    1.431283] 2016-10-31 to_rockchip: 2016-10-31 to_gregorian: 2016-10-31
[    1.431287] 2016-11-01 to_rockchip: 2016-11-01 to_gregorian: 2016-11-01
[    1.431291] 2016-11-27 to_rockchip: 2016-11-27 to_gregorian: 2016-11-27
[    1.431295] 2016-11-28 to_rockchip: 2016-11-28 to_gregorian: 2016-11-28
[    1.431299] 2016-11-29 to_rockchip: 2016-11-29 to_gregorian: 2016-11-29
[    1.431302] 2016-11-30 to_rockchip: 2016-11-30 to_gregorian: 2016-11-30
[    1.431306] 2016-11-31 to_rockchip: 2016-12-01 to_gregorian: 2016-12-01
[    1.431310] 2016-12-01 to_rockchip: 2016-11-31 to_gregorian: 2016-12-02
[    1.431313] 2016-12-02 to_rockchip: 2016-12-01 to_gregorian: 2016-12-03
[    1.431317] 2016-12-03 to_rockchip: 2016-12-02 to_gregorian: 2016-12-04
[    1.431321] 2016-12-04 to_rockchip: 2016-12-03 to_gregorian: 2016-12-05
[    1.431324] 2016-12-05 to_rockchip: 2016-12-04 to_gregorian: 2016-12-06
[    1.431328] 2016-12-30 to_rockchip: 2016-12-29 to_gregorian: 2016-12-31
[    1.431332] 2016-12-31 to_rockchip: 2016-12-30 to_gregorian: 2017-01-01
[    1.431335] 2017-01-01 to_rockchip: 2016-12-31 to_gregorian: 2017-01-02
[    1.431338] 2017-10-30 to_rockchip: 2017-10-29 to_gregorian: 2017-10-31
[    1.431342] 2017-10-31 to_rockchip: 2017-10-30 to_gregorian: 2017-11-01
[    1.431345] 2017-11-01 to_rockchip: 2017-10-31 to_gregorian: 2017-11-02
[    1.431349] 2017-11-27 to_rockchip: 2017-11-26 to_gregorian: 2017-11-28
[    1.431352] 2017-11-28 to_rockchip: 2017-11-27 to_gregorian: 2017-11-29
[    1.431356] 2017-11-29 to_rockchip: 2017-11-28 to_gregorian: 2017-11-30
[    1.431359] 2017-11-30 to_rockchip: 2017-11-29 to_gregorian: 2017-12-01
[    1.431363] 2017-11-31 to_rockchip: 2017-11-30 to_gregorian: 2017-12-02
[    1.431366] 2017-12-01 to_rockchip: 2017-11-30 to_gregorian: 2017-12-03
[    1.431369] 2017-12-02 to_rockchip: 2017-11-31 to_gregorian: 2017-12-04
[    1.431373] 2017-12-03 to_rockchip: 2017-12-01 to_gregorian: 2017-12-05
[    1.431376] 2017-12-04 to_rockchip: 2017-12-02 to_gregorian: 2017-12-06
[    1.431380] 2017-12-05 to_rockchip: 2017-12-03 to_gregorian: 2017-12-07
[    1.431383] 2017-12-30 to_rockchip: 2017-12-28 to_gregorian: 2018-01-01
[    1.431386] 2017-12-31 to_rockchip: 2017-12-29 to_gregorian: 2018-01-02
[    1.431389] 2020-01-01 to_rockchip: 2019-12-28 to_gregorian: 2020-01-05
[    1.431393] 2020-10-30 to_rockchip: 2020-10-26 to_gregorian: 2020-11-03
[    1.431397] 2020-10-31 to_rockchip: 2020-10-27 to_gregorian: 2020-11-04
[    1.431400] 2020-11-01 to_rockchip: 2020-10-28 to_gregorian: 2020-11-05
[    1.431404] 2020-11-27 to_rockchip: 2020-11-23 to_gregorian: 2020-12-01
[    1.431408] 2020-11-28 to_rockchip: 2020-11-24 to_gregorian: 2020-12-02
[    1.431411] 2020-11-29 to_rockchip: 2020-11-25 to_gregorian: 2020-12-03
[    1.431415] 2020-11-30 to_rockchip: 2020-11-26 to_gregorian: 2020-12-04
[    1.431419] 2020-11-31 to_rockchip: 2020-11-27 to_gregorian: 2020-12-05
[    1.431422] 2020-12-01 to_rockchip: 2020-11-27 to_gregorian: 2020-12-06
[    1.431426] 2020-12-02 to_rockchip: 2020-11-28 to_gregorian: 2020-12-07
[    1.431430] 2020-12-03 to_rockchip: 2020-11-29 to_gregorian: 2020-12-08
[    1.431434] 2020-12-04 to_rockchip: 2020-11-30 to_gregorian: 2020-12-09
[    1.431437] 2020-12-05 to_rockchip: 2020-11-31 to_gregorian: 2020-12-10
[    1.431441] 2020-12-30 to_rockchip: 2020-12-25 to_gregorian: 2021-01-04
[    1.431444] 2020-12-31 to_rockchip: 2020-12-26 to_gregorian: 2021-01-05
[    1.431447] 2030-01-01 to_rockchip: 2029-12-18 to_gregorian: 2030-01-15
[    1.431450] 2030-10-30 to_rockchip: 2030-10-16 to_gregorian: 2030-11-13
[    1.431454] 2030-10-31 to_rockchip: 2030-10-17 to_gregorian: 2030-11-14
[    1.431457] 2030-11-01 to_rockchip: 2030-10-18 to_gregorian: 2030-11-15
[    1.431461] 2030-11-27 to_rockchip: 2030-11-13 to_gregorian: 2030-12-11
[    1.431464] 2030-11-28 to_rockchip: 2030-11-14 to_gregorian: 2030-12-12
[    1.431468] 2030-11-29 to_rockchip: 2030-11-15 to_gregorian: 2030-12-13
[    1.431471] 2030-11-30 to_rockchip: 2030-11-16 to_gregorian: 2030-12-14
[    1.431474] 2030-11-31 to_rockchip: 2030-11-17 to_gregorian: 2030-12-15
[    1.431478] 2030-12-01 to_rockchip: 2030-11-17 to_gregorian: 2030-12-16
[    1.431481] 2030-12-02 to_rockchip: 2030-11-18 to_gregorian: 2030-12-17
[    1.431485] 2030-12-03 to_rockchip: 2030-11-19 to_gregorian: 2030-12-18
[    1.431488] 2030-12-04 to_rockchip: 2030-11-20 to_gregorian: 2030-12-19
[    1.431492] 2030-12-05 to_rockchip: 2030-11-21 to_gregorian: 2030-12-20
[    1.431495] 2030-12-30 to_rockchip: 2030-12-15 to_gregorian: 2031-01-14
[    1.431498] 2030-12-31 to_rockchip: 2030-12-16 to_gregorian: 2031-01-15
[    1.431501] 2060-01-01 to_rockchip: 2059-11-19 to_gregorian: 2060-02-14
[    1.431505] 2060-10-30 to_rockchip: 2060-09-16 to_gregorian: 2060-12-13
[    1.431509] 2060-10-31 to_rockchip: 2060-09-17 to_gregorian: 2060-12-14
[    1.431512] 2060-11-01 to_rockchip: 2060-09-18 to_gregorian: 2060-12-15
[    1.431516] 2060-11-27 to_rockchip: 2060-10-14 to_gregorian: 2061-01-10
[    1.431519] 2060-11-28 to_rockchip: 2060-10-15 to_gregorian: 2061-01-11
[    1.431522] 2060-11-29 to_rockchip: 2060-10-16 to_gregorian: 2061-01-12
[    1.431525] 2060-11-30 to_rockchip: 2060-10-17 to_gregorian: 2061-01-13
[    1.431528] 2060-11-31 to_rockchip: 2060-10-18 to_gregorian: 2061-01-14
[    1.431532] 2060-12-01 to_rockchip: 2060-10-18 to_gregorian: 2061-01-15
[    1.431536] 2060-12-02 to_rockchip: 2060-10-19 to_gregorian: 2061-01-16
[    1.431540] 2060-12-03 to_rockchip: 2060-10-20 to_gregorian: 2061-01-17
[    1.431544] 2060-12-04 to_rockchip: 2060-10-21 to_gregorian: 2061-01-18
[    1.431548] 2060-12-05 to_rockchip: 2060-10-22 to_gregorian: 2061-01-19
[    1.431551] 2060-12-30 to_rockchip: 2060-11-16 to_gregorian: 2061-02-13
[    1.431554] 2060-12-31 to_rockchip: 2060-11-17 to_gregorian: 2061-02-14

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
