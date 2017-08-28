Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35671 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdH1U0D (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 16:26:03 -0400
Date: Mon, 28 Aug 2017 22:25:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: improve weekday handling
Message-ID: <20170828202551.p2ngspladxlquboc@piout.net>
References: <57598a86-21c7-b354-2840-309563440435@gmail.com>
 <20170828191518.ofntjb2tknttjexq@piout.net>
 <dea642c9-872e-1871-bdcd-13944d77d5be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dea642c9-872e-1871-bdcd-13944d77d5be@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 28/08/2017 at 21:58:23 +0200, Heiner Kallweit wrote:
> Am 28.08.2017 um 21:15 schrieb Alexandre Belloni:
> > On 28/08/2017 at 20:37:21 +0200, Heiner Kallweit wrote:
> >> mcp794xx as one chip supported by this driver needs the weekday for
> >> alarm matching. RTC core ignores the weekday so we can't rely on
> >> the values we receive in member tm_wday of struct rtc_time.
> >> Therefore calculate the weekday from date/time when setting the
> >> time and setting the alarm time for mcp794xx.
> >>
> >> When having this in place we don't have to check the weekday
> >> at each driver load.
> >> After a chip reset date/time and weekday may be out of sync but
> >> in this case date/time need to be set anyway.
> >>
> > 
> > Nope, the core issue is that you can actually set an alarm in the future
> > without setting the time beforehand so this as to be fixed in the probe
> > (this was the issue as reported at the time of the fix).
> > 
> Ah, found the original thread where this was discussed.
> Still I don't really understand the problem. mcp794xx matches based on
> secs, min, hour, wday, mday, month. When I use "rtcwake -s 5" I expect
> the alarm to trigger 5 secs from now. How can this ever work if the
> RTC has random date/time (wday being valid or not)?
> 

wakealarm_store() reads the rtc time, adds the relative offset and sets
the alarm.

> I'd tend to say that if we know the RTC time is incorrect we shouldn't
> allow setting an alarm.

Unfortunately, this would break some platforms. Note that this is
already handled that way by some RTC drivers because they return an
error when it is known that the time is invalid.

I've started to work on that but it is far from finished.

> At least I wouldn't dare to program a bomb explosion time if I stand in
> front of it and know that the bomb's clock has a random value ;)
> 

A timer will work as long as the clock is ticking, it doesn't matter
when it is started ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
