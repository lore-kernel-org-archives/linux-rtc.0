Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37061 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdGWUPf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 23 Jul 2017 16:15:35 -0400
Received: by mail-wm0-f53.google.com with SMTP id c184so17150649wmd.0
        for <linux-rtc@vger.kernel.org>; Sun, 23 Jul 2017 13:15:34 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
        linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Duplicated drivers for Epson RX8025 RTC support
Message-ID: <a82c9f50-31d2-d750-39fc-05501f3724ad@gmail.com>
Date: Sun, 23 Jul 2017 22:15:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

When working on refactoring parts of the ds1307 I stumbled across the fact
that there are two rtc drivers claiming to support the Epson RX8025 chip.

1. ds1307 claims to support also this chip. Support was added in 2009,
   however I have doubts that it actually works.
   RX8025 needs a special addressing mode (register address has to be
   left-shifted by 4 bits) which is implemented for both control
   registers but not for the standard registers.

   Also support for this chip misses the fix from patch 2e10e74df72
   ("rtc: rx8025: fix transfer mode")

   I'm curious whether support for this chip was ever tested, commit message
   of a216685818a5 "rtc: add EPSON RX8025 support to DS1307 RTC driver"
   does not mention that this piece of code was tested with any device
   with this chip.

2. There's a separate driver for this chip (rtc-rx8025), also added in 2009.
   This drivers is actively maintained.

The separate driver mentions that it supports SA/NB variants of the chip.
There's no info regarding supported chip variants in the ds1307-integrated
driver. So there is a small chance that both drivers support different
chip variants (in this case however the ds1307-integrated driver should
clearly mention this, also in the Kconfig help text).

For me it's more likely that both drivers try support the same chip.
Having said that I would propose to remove (rudimentary) RX8025 support
in ds1307. As a first step we could leave the code in but use a WARN_ON
to notify potential users that this code is deprecated and they should
use the separate driver instead.

Rgds, Heiner
