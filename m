Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38950 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdGXJQM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 24 Jul 2017 05:16:12 -0400
Date: Mon, 24 Jul 2017 11:16:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
        linux-rtc@vger.kernel.org
Subject: Re: Duplicated drivers for Epson RX8025 RTC support
Message-ID: <20170724091601.sjz5shnv3ozq6the@piout.net>
References: <a82c9f50-31d2-d750-39fc-05501f3724ad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a82c9f50-31d2-d750-39fc-05501f3724ad@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 23/07/2017 at 22:15:24 +0200, Heiner Kallweit wrote:
> When working on refactoring parts of the ds1307 I stumbled across the fact
> that there are two rtc drivers claiming to support the Epson RX8025 chip.
> 
> 1. ds1307 claims to support also this chip. Support was added in 2009,
>    however I have doubts that it actually works.
>    RX8025 needs a special addressing mode (register address has to be
>    left-shifted by 4 bits) which is implemented for both control
>    registers but not for the standard registers.
> 
>    Also support for this chip misses the fix from patch 2e10e74df72
>    ("rtc: rx8025: fix transfer mode")
> 
>    I'm curious whether support for this chip was ever tested, commit message
>    of a216685818a5 "rtc: add EPSON RX8025 support to DS1307 RTC driver"
>    does not mention that this piece of code was tested with any device
>    with this chip.
> 
> 2. There's a separate driver for this chip (rtc-rx8025), also added in 2009.
>    This drivers is actively maintained.
> 
> The separate driver mentions that it supports SA/NB variants of the chip.
> There's no info regarding supported chip variants in the ds1307-integrated
> driver. So there is a small chance that both drivers support different
> chip variants (in this case however the ds1307-integrated driver should
> clearly mention this, also in the Kconfig help text).
> 
> For me it's more likely that both drivers try support the same chip.
> Having said that I would propose to remove (rudimentary) RX8025 support
> in ds1307. As a first step we could leave the code in but use a WARN_ON
> to notify potential users that this code is deprecated and they should
> use the separate driver instead.
> 

The remaining issue is described here:
https://groups.google.com/d/msg/rtc-linux/M_uv9YkRbC8/MaKpMa3LGgAJ

It is even more apparent after your regmap rework.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
