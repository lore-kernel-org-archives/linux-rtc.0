Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32940 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756704AbdHYTaT (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Aug 2017 15:30:19 -0400
Received: by mail-wr0-f171.google.com with SMTP id k46so2171642wre.0
        for <linux-rtc@vger.kernel.org>; Fri, 25 Aug 2017 12:30:18 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe and
 improve ds1307_set_time
Message-ID: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Date: Fri, 25 Aug 2017 21:30:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Final goal of the refactoring is to abstract everything that the chips
have in common and handle it in generic code. Then we can get rid of
all the "switch (chip)" and "if (chip == xxx)" code.

To give one example:
A lot of chips have a bit for setting 12hr / 24hr mode. However some
chips have this config bit in the timekeeping registers, others in
a config register, and on some chips it's inverted.
But the functionality of the bit is always the same.

Ultimately adding support for a chip just requires to add one config
structure member.

The way to reach this goal is a long one and to faciliate reviewing
the patches I'll split them into series of 5 to 10 patches.

Heiner Kallweit (5):
  rtc: ds1307: factor out determining the chip type
  rtc: ds1307: factor out trickle charger initialization
  rtc: ds1307: factor out fixing the weekday
  rtc: ds1307: introduce constants for the timekeeping register masks
  rtc: ds1307: improve ds1307_set_time to respect config flag bits

 drivers/rtc/rtc-ds1307.c | 256 ++++++++++++++++++++++++++---------------------
 1 file changed, 140 insertions(+), 116 deletions(-)

-- 
2.14.1
