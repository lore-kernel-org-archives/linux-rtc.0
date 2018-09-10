Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:42670 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeIKCde (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Sep 2018 22:33:34 -0400
Received: by mail-io0-f181.google.com with SMTP id n18-v6so1902262ioa.9
        for <linux-rtc@vger.kernel.org>; Mon, 10 Sep 2018 14:37:33 -0700 (PDT)
From: Jeremy Gebben <jgebben@sweptlaser.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] rtc: abx80x: add basic watchdog support
Date: Mon, 10 Sep 2018 15:36:52 -0600
Message-Id: <20180910213654.26059-1-jgebben@sweptlaser.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This patch series adds watchod support for abracon RTC chips which
include basic watchdog functionality.

Changes in v2:
* split out priv structure into a separate patch
* remove new Kconfig option
* fix CONFIG_WATCHDOG dependency
* fix WDT interrupt message


Jeremy Gebben (2):
  rtc: abx80x: use a 'priv' struct for client data
  rtc: abx80x: add basic watchdog support

 drivers/rtc/rtc-abx80x.c | 159 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 12 deletions(-)

-- 
2.17.1
