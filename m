Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46353 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeAQWOQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 17 Jan 2018 17:14:16 -0500
Date: Wed, 17 Jan 2018 23:14:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe
 and improve ds1307_set_time
Message-ID: <20180117221415.GO2678@piout.net>
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
 <20170826081904.ibsxi7crvi7qop3m@piout.net>
 <9ae42f67-9562-16c4-252d-9f629a31b69e@gmail.com>
 <20170826104457.sdeeacwgboeectpw@piout.net>
 <6e668a34-1211-f828-9e79-ab91338a3b14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6e668a34-1211-f828-9e79-ab91338a3b14@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 05/09/2017 at 07:27:08 +0200, Heiner Kallweit wrote:
> Most code went into a new rtc-ds1307-lib library in a generic form, the driver
> contains mainly chip configuration info now plus chip-specific routines for
> reading / setting alarm.
> Now it would require very little effort to e.g. make ds3231 a separate driver
> because the hwmon code is needed for this chip only.

So I had a closer look (very late, sorry...)

I think too much went in the lib and it is not generic enough.

What I'd like are functions that could be used from every driver
handling RTC in [centisec] sec min hour day month year format, not just
ds1307. The ds1307 driver has been abused because it handles that
format. Maybe, we could call that rtc_bcd_* or something similar.

For example, there is nothing ds1307 specific in ds1307_regs_to_tm apart
from the century handling. The same for the function reading or writing
the registers. A function taking a regmap and an offset will be generic
enough for most drivers.

So, the first step would be to make functions to handle that generically
and call them from the driver. It would be good to also have the
conversion of other drivers as a PoC but I can take care of that.

Then, regarding the individual bits, they would be better handled using
regmap_fields instead of rolling our own implementation. Those will have
to be ds1307 specific. I wouldn't bother with their polarity as if it is
different, it probably means a different driver is needed instead.

Have read_time/set_time functions handling the osc bit the century
bit(s) will make them reusable for around 40 drivers. (BTW, it seems
ds1307_set_time() never resets the osc bit).
I'm not sure about the alarm ops yet but they can probably be made
generic enough.

Also, the buffer update optimization instead of updating bits in the
registers makes the code quite complicated. I'm not sure it is worth it.
Also, it doesn't work well with the regmap_field idea.

rtc_ops, irq handling, nvram handling, clock handling, trickle charger
handling and probe should probably stay in the driver for now and will
need to be separated in their own drivers later.

So, let's start small and introduce functions that will work for most
current drivers, handling bcd time. regmap can be used to abstract
register accesses. A struct to pass register offsets and other data
(like presence of wday or number of century bits) will probably be
needed.

I hope this is clear enough.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
