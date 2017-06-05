Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38411 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFEPsW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Jun 2017 11:48:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id n195so79357394wmg.1
        for <linux-rtc@vger.kernel.org>; Mon, 05 Jun 2017 08:48:21 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/4] rtc: ds1307: series with refactorings
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Message-ID: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
Date: Mon, 5 Jun 2017 17:48:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Series with certain refactorings for the ds1307 rtc driver.

v2:
- improved nvmem patch

v3:
- use IS_REACHABLE in nvmem patch to make sure that nvmem API
  isn't used if ds1307 is built-in and nvmem is a module
- add Reviewed-by to first three patches

Heiner Kallweit (4):
  rtc: ds1307: make definition of ds1307_of_match more compact
  rtc: ds1307: use regmap_update_bits where applicable
  rtc: ds1307: factor out century bit handling
  rtc: ds1307: change nvram handling to use the nvmem subsystem

 drivers/rtc/rtc-ds1307.c | 316 ++++++++++++++---------------------------------
 1 file changed, 91 insertions(+), 225 deletions(-)

-- 
2.13.0
