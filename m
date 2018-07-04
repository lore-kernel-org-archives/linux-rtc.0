Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43832 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934314AbeGDJGb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Jul 2018 05:06:31 -0400
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] rtc: omap: drop unnecessary register unlock around reads
Date: Wed,  4 Jul 2018 11:05:58 +0200
Message-Id: <20180704090558.16647-5-johan@kernel.org>
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Drop unnecessary register write-unlock around two read accesses.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 7f9ee559dd99..323ff55cc165 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -583,9 +583,7 @@ static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
 	u32 val;
 	u16 arg = 0;
 
-	rtc->type->unlock(rtc);
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
-	rtc->type->lock(rtc);
 
 	switch (param) {
 	case PIN_CONFIG_INPUT_ENABLE:
@@ -615,9 +613,7 @@ static int rtc_pinconf_set(struct pinctrl_dev *pctldev,
 	u32 param_val;
 	int i;
 
-	rtc->type->unlock(rtc);
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
-	rtc->type->lock(rtc);
 
 	/* active low by default */
 	val |= OMAP_RTC_PMIC_EXT_WKUP_POL(pin);
-- 
2.18.0
