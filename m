Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36581 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdJLMUM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 08:20:12 -0400
Date: Thu, 12 Oct 2017 14:20:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH RfC] rtc: ds1307: improve weekday handling
Message-ID: <20171012122009.vqv4d3o6levhrxeo@piout.net>
References: <abf5f5ff-b406-eff0-a1ec-9486efbe8506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <abf5f5ff-b406-eff0-a1ec-9486efbe8506@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 29/08/2017 at 21:52:56 +0200, Heiner Kallweit wrote:
> The current code for checking and fixing the weekday in ds1307_probe
> faces some issues:
> - This check is applied to all chips even if its applicable (AFAIK)
>   to mcp794xx only
> - The check uses MCP794XX constants for registers and bits even though
>   it's executed also on other chips (ok, this could be fixed easily)
> - It relies on tm_wday being properly populated when core calls set_time
>   and set_alarm. This is not guaranteed at all.
> 
> First two issue we could solve by moving the check to the
> mcp794xx-specific initialization (where also VBATEN flag is set).
> 
> The proposed alternative is in the set_alarm path for mcp794xx only and
> calculates the alarm weekday based on the current weekday in the RTC
> timekeeping regs and the difference between alarm date and current date.
> So we are fine with any weekday even if it doesn't match the date.
> 
> Still there are cases where this could fail, e.g.:
> - rtc date/time + weekday have power-on-reset default values
> - alarm is set to actual date/time + x
> - set_time is called (may change diff between rtc weekday and actual
>   weekday)
> 
> But similar issues we have with the current code too:
> - rtc date/time + weekday have power-on-reset default values
> - alarm is set to rtc date/time + x
> - set_time is called before the alarm triggers
> 
> Using random rtc date/time with relative alarms simply can interfere
> with set_time. I'm not totally convinced of either option yet.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 52 ++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 

It took me some time to test it (I've received an mcp79410) because at
first, it seemed the regmap conversion made the IO timeout. I can't
reproduce that anymore though.

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
