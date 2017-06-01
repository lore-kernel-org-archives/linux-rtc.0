Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36579 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAS6b (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 1 Jun 2017 14:58:31 -0400
Received: by mail-wm0-f47.google.com with SMTP id 7so168967806wmo.1
        for <linux-rtc@vger.kernel.org>; Thu, 01 Jun 2017 11:58:25 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/4] rtc: ds1307: series with refactorings
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Message-ID: <22e48dc3-5d08-681c-5eed-d7c0e4552267@gmail.com>
Date: Thu, 1 Jun 2017 20:57:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Series with certain refactorings for the ds1307 rtc driver.

v2:
- improved nvmem patch

Heiner Kallweit (4):
  rtc: ds1307: make definition of ds1307_of_match more compact
  rtc: ds1307: use regmap_update_bits where applicable
  rtc: ds1307: factor out century bit handling
  rtc: ds1307: change nvram handling to use the nvmem subsystem

 drivers/rtc/rtc-ds1307.c | 316 ++++++++++++++---------------------------------
 1 file changed, 91 insertions(+), 225 deletions(-)

-- 
2.13.0
