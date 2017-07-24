Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34272 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdGXUPZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 Jul 2017 16:15:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id o33so10778625wrb.1
        for <linux-rtc@vger.kernel.org>; Mon, 24 Jul 2017 13:15:25 -0700 (PDT)
Subject: Re: Duplicated drivers for Epson RX8025 RTC support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
        linux-rtc@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Alessandro Zummo <a.zummo@towertech.it>
References: <a82c9f50-31d2-d750-39fc-05501f3724ad@gmail.com>
 <20170724091601.sjz5shnv3ozq6the@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e38a63be-55c0-98bf-38e3-79ffe03d028a@gmail.com>
Date: Mon, 24 Jul 2017 22:15:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170724091601.sjz5shnv3ozq6the@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 24.07.2017 um 11:16 schrieb Alexandre Belloni:
> Hi,
> 
> On 23/07/2017 at 22:15:24 +0200, Heiner Kallweit wrote:
>> When working on refactoring parts of the ds1307 I stumbled across the fact
>> that there are two rtc drivers claiming to support the Epson RX8025 chip.
>>
>> 1. ds1307 claims to support also this chip. Support was added in 2009,
>>    however I have doubts that it actually works.
>>    RX8025 needs a special addressing mode (register address has to be
>>    left-shifted by 4 bits) which is implemented for both control
>>    registers but not for the standard registers.
>>
After checking again it could work due to the fact that mainly bulk ops
starting with address 0 are used. Therefore the missing shift doesn't hurt.

>>    Also support for this chip misses the fix from patch 2e10e74df72
>>    ("rtc: rx8025: fix transfer mode")
>>
>>    I'm curious whether support for this chip was ever tested, commit message
>>    of a216685818a5 "rtc: add EPSON RX8025 support to DS1307 RTC driver"
>>    does not mention that this piece of code was tested with any device
>>    with this chip.
>>
>> 2. There's a separate driver for this chip (rtc-rx8025), also added in 2009.
>>    This drivers is actively maintained.
>>
>> The separate driver mentions that it supports SA/NB variants of the chip.
>> There's no info regarding supported chip variants in the ds1307-integrated
>> driver. So there is a small chance that both drivers support different
>> chip variants (in this case however the ds1307-integrated driver should
>> clearly mention this, also in the Kconfig help text).
>>
>> For me it's more likely that both drivers try support the same chip.
>> Having said that I would propose to remove (rudimentary) RX8025 support
>> in ds1307. As a first step we could leave the code in but use a WARN_ON
>> to notify potential users that this code is deprecated and they should
>> use the separate driver instead.
>>
> 
> The remaining issue is described here:
> https://groups.google.com/d/msg/rtc-linux/M_uv9YkRbC8/MaKpMa3LGgAJ
> 
Thanks a lot for sharing the link. So I involve the people from the
previous discussion.

> It is even more apparent after your regmap rework.
> 
Most likely best would be to switch rtc-rx8025 to regmap-i2c as well
as it automatically selects proper low-level access methods based on
the supported i2c functions.
Shouldn't be a big deal using 11e5890b5342 "rtc: ds1307: convert driver
to regmap" as blueprint.

Afterwards support for rx8025 in ds1307 could be dropped.

Rgds, Heiner
