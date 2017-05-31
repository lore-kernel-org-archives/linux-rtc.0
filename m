Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37952 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaVOH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 31 May 2017 17:14:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id n195so7270480wmg.1
        for <linux-rtc@vger.kernel.org>; Wed, 31 May 2017 14:14:07 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/4] rtc: ds1307: series with refactorings
Message-ID: <85789383-af9c-fdbb-ff58-121d9fd432f5@gmail.com>
Date: Wed, 31 May 2017 23:06:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Series with certain refactorings for the ds1307 rtc driver.

Heiner Kallweit (4):
  rtc: ds1307: make definition of ds1307_of_match more compact
  rtc: ds1307: use regmap_update_bits where applicable
  rtc: ds1307: factor out century bit handling
  rtc: ds1307: change nvram handling to use the nvmem subsystem

 drivers/rtc/rtc-ds1307.c | 316 ++++++++++++++---------------------------------
 1 file changed, 91 insertions(+), 225 deletions(-)

-- 
2.13.0
