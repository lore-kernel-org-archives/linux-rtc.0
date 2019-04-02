Return-Path: <SRS0=5rMO=SE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B3EC4360F
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FDA2084C
	for <linux-rtc@archiver.kernel.org>; Tue,  2 Apr 2019 03:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="captx7HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDBDn1 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:43:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfDBDn1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Apr 2019 23:43:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x323giXC100400;
        Mon, 1 Apr 2019 22:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554176564;
        bh=YvW/fVNx3pSrzTQQlLtpcs156biU6OqjBjB9Ji+/iNo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=captx7HKDknwwnQNREzlkEMfZ9s3KkGgNiW8movM8aPAbNcE6u4DRqjoxHdxKYoMa
         hY1maopGQ+d9pPjYgFEu0y9PYRJzRpHocHhzgjlinitU3S25eEqIZWaqbhvNrPxd0k
         CRLlKSA48N191eWq+RLkEC7fYmJIUzRHediWFmBA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x323gia8081945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 22:42:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 22:42:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 22:42:43 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x323gb9F070613;
        Mon, 1 Apr 2019 22:42:41 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH v2 1/5] rtc: OMAP: Add support for rtc-only mode
Date:   Tue, 2 Apr 2019 09:12:49 +0530
Message-ID: <20190402034253.4928-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402034253.4928-1-j-keerthy@ti.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
omap_rtc_power_off now should cater to two features:

1) RTC plus DDR in self-refresh is power a saving mode where in the
entire system including the different voltage rails from PMIC are
shutdown except the ones feeding on to RTC and DDR. DDR is kept in
self-refresh hence the contents are preserved. RTC ALARM2 is connected
to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
ALARM1 triggers waking up the system[1]. The control goes to bootloader.
The bootloader then checks RTC scratchpad registers to confirm it was an
rtc_only wakeup and follows a different path, configure bare minimal
clocks for ddr and then jumps to the resume address in another RTC
scratchpad registers and transfers the control to Kernel. Kernel then
restores the saved context. omap_rtc_power_off_program does the ALARM2
programming part.

     [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884

2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
above omap_rtc_power_off_program function and in addition to that
programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
the pushbutton and shuts off the PMIC.

Hence the split in omap_rtc_power_off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 48 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 32994b0dd139..b467154443a4 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -403,15 +403,12 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static struct omap_rtc *omap_rtc_power_off_rtc;
 
-/*
- * omap_rtc_poweroff: RTC-controlled power off
- *
- * The RTC can be used to control an external PMIC via the pmic_power_en pin,
- * which can be configured to transition to OFF on ALARM2 events.
- *
- * Called with local interrupts disabled.
+/**
+ * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
+ * generates pmic_pwr_enable control, which can be used to control an external
+ * PMIC.
  */
-static void omap_rtc_power_off(void)
+static int omap_rtc_power_off_program(struct device *dev)
 {
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
@@ -425,6 +422,9 @@ static void omap_rtc_power_off(void)
 	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
 
 again:
+	/* Clear any existing ALARM2 event */
+	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
+
 	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
 	seconds = tm.tm_sec;
@@ -461,6 +461,38 @@ static void omap_rtc_power_off(void)
 
 	rtc->type->lock(rtc);
 
+	return 0;
+}
+
+/*
+ * omap_rtc_poweroff: RTC-controlled power off
+ *
+ * The RTC can be used to control an external PMIC via the pmic_power_en pin,
+ * which can be configured to transition to OFF on ALARM2 events.
+ *
+ * Notes:
+ * The one-second alarm offset is the shortest offset possible as the alarm
+ * registers must be set before the next timer update and the offset
+ * calculation is too heavy for everything to be done within a single access
+ * period (~15 us).
+ *
+ * Called with local interrupts disabled.
+ */
+static void omap_rtc_power_off(void)
+{
+	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
+	u32 val;
+
+	omap_rtc_power_off_program(rtc->dev.parent);
+
+	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
+	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
+	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
+	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
+			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
+	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
+
 	/*
 	 * Wait for alarm to trigger (within one second) and external PMIC to
 	 * power off the system. Add a 500 ms margin for external latencies
-- 
2.17.1

