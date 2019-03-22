Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0692C43381
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B1721900
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GkE73CX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfCVRRh (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:17:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33114 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVRRh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 13:17:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MHGRlI004174;
        Fri, 22 Mar 2019 12:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553274987;
        bh=PgBTOzI5zbCXhrsAXfG9v/XgIvObQktHAGxLfUxmfiI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GkE73CX9vAQYtzMT41I/0adNyT389auV/5cJN/CBO7ALwlxRvngjXDkGIM5wYhUds
         Jmm5c+9knbVdMKLmaS+qpu5somZgbZ/QJOcpp3BXiI32TVqrV5uI2x0B70ZZiFE2IT
         rAUU8+piWT+xvKvtLJum5LDzWKns9jYTkBG+HTSI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MHGRe7041046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 12:16:27 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 12:16:26 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 12:16:27 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MHGHYL006487;
        Fri, 22 Mar 2019 12:16:24 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>, <alexandre.belloni@bootlin.com>,
        <a.zummo@towertech.it>, <t-kristo@ti.com>
CC:     <ssantosh@kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <j-keerthy@ti.com>
Subject: [PATCH 2/5] rtc: interface: Add power_off_program to rtc_class_ops
Date:   Fri, 22 Mar 2019 22:46:16 +0530
Message-ID: <20190322171619.4180-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322171619.4180-1-j-keerthy@ti.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add an interface function to set up the rtc for a power_off
mode.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/interface.c | 12 ++++++++++++
 drivers/rtc/rtc-omap.c  |  1 +
 include/linux/rtc.h     |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 28bd767e03a0..3a9141ceb365 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1065,3 +1065,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	trace_rtc_set_offset(offset, ret);
 	return ret;
 }
+
+/**
+ * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
+ * line and can be used to power off the SoC.
+ *
+ * Kernel interface to program rtc to power off
+ */
+int rtc_power_off_program(struct rtc_device *rtc)
+{
+	return rtc->ops->power_off_program(rtc->dev.parent);
+}
+EXPORT_SYMBOL_GPL(rtc_power_off_program);
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 9b58c933e37d..74cd391eeef7 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -511,6 +511,7 @@ static const struct rtc_class_ops omap_rtc_ops = {
 	.read_alarm	= omap_rtc_read_alarm,
 	.set_alarm	= omap_rtc_set_alarm,
 	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
+	.power_off_program = omap_rtc_power_off_program,
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index f89bfbb54902..9be8d97534b4 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -84,6 +84,7 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	int (*power_off_program)(struct device *dev);
 };
 
 struct rtc_device;
@@ -209,6 +210,7 @@ void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
 int rtc_read_offset(struct rtc_device *rtc, long *offset);
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
+int rtc_power_off_program(struct rtc_device *rtc);
 
 static inline bool is_leap_year(unsigned int year)
 {
-- 
2.17.1

