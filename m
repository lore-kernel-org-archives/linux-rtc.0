Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:54095 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdLFTtl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 14:49:41 -0500
From: Andreas Platschek <andreas.platschek@opentech.at>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org,
        Andreas Platschek <andreas.platschek@opentech.at>
Subject: [PATCH 0/2] rtc: omap: clk_prepare_enable error handling
Date: Wed,  6 Dec 2017 20:42:36 +0100
Message-Id: <20171206194238.12824-1-andreas.platschek@opentech.at>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The unbalanced clk_prepare_enable/clk_disable_unprepare were found
by Linux Driver Verification project (linuxtesting.org). While
going through the report from LDV, the missing check of the return
value from clk_prepare_enable() was found.

Andreas Platschek (2):
  rtc: omap: check for clk_prepare_enable() error
  rtc: omap: fix unbalanced clk_prepare_enable/clk_disable_unprepare

 drivers/rtc/rtc-omap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.11.0
