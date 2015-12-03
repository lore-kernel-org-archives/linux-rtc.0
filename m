Return-Path: <rtc-linux+bncBDS7HNEFSALRBPFJQGZQKGQEMDIIHOQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i77si246251wmf.1.2015.12.03.06.42.04
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Dec 2015 06:42:04 -0800 (PST)
Date: Thu, 3 Dec 2015 15:42:03 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julius Werner <jwerner@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Doug Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] RTC: RK808: Work around hardware bug on
 November 31st
Message-ID: <20151203144203.GA3515@piout.net>
References: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449107584-3192-1-git-send-email-jwerner@chromium.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

I would have liked to be in copy of that mail. Maybe you used
get_maintainers on an old tree?

On 02/12/2015 at 17:53:04 -0800, Julius Werner wrote :
> In Fuzhou, China, the month of November seems to be having 31 days.
> That's nice and all (I'm sure you can get a lot more done in a year that
> way), but back here in other parts of the world we are not so lucky.
> Therefore, if we read that date from the RTC we should correct it to
> December 1st.
> 

Wow, nice one...

I hope reading the time properly fails thanks to the rtc_valid_tm(tm) in
__rtc_read_time().

> This is not a full workaround. Since the RTC actually ticks all the way
> through that imaginary day, there's no easy way to detect and correct
> this issue if the device was offline the whole time and allowed it to
> tick through to December 1st on the Rockchip calendar (which would be
> December 2nd on the Gregorian one). Those edge cases can only really be
> solved by regularly syncing to an external time source (e.g. NTP).
> 

It will also happen if nobody reads the RTC time for that day (highly
improbable in a default configuration). Do you need that patch for 4.4
or can it wait 4.5?


> Signed-off-by: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
>  drivers/rtc/rtc-rk808.c | 93 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
