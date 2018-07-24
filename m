Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:61312 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388256AbeGXMrY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 24 Jul 2018 08:47:24 -0400
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v5 1/5] rtc: sysfs: facilitate attribute add to rtc device
Date: Tue, 24 Jul 2018 11:31:22 +0000
Message-ID: <20180724095437.6016-2-Denis.Osterland@diehl.com>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Denis Osterland <Denis.Osterland@diehl.com>

This patches addresses following problem:
rtc_allocate_device
devm_device_add_group  <-- kernel oops / null pointer, because
			sysfs entry does not yet exist
rtc_register_device
rc = devm_device_add_group
if (rc)
	return rc;     <-- forbidden to return error code
			after device register

This patch adds rtc_add_group(s) functions.
The functions store the sum of attribute groups as device resource.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-core.h  | 13 +++++++++++++
 drivers/rtc/rtc-sysfs.c | 43 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 0abf98983e13..c74537d03644 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -40,9 +40,22 @@ static inline void rtc_proc_del_device(struct rtc_device *rtc)
 
 #ifdef CONFIG_RTC_INTF_SYSFS
 const struct attribute_group **rtc_get_dev_attribute_groups(void);
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp);
+int rtc_add_groups(struct rtc_device *rtc,
+					const struct attribute_group **grps);
 #else
 static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return NULL;
 }
+static inline
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	return 0;
+}
+static inline
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+{
+	return 0;
+}
 #endif
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 454da38c6012..498e65f13686 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -317,3 +317,46 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
 {
 	return rtc_attr_groups;
 }
+
+int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
+{
+	size_t old_cnt = 0, add_cnt = 0, new_cnt;
+	const struct attribute_group **groups, **old;
+
+	if (rtc->registered)
+		return -EINVAL;
+	if (!grps)
+		return -EINVAL;
+
+	groups = rtc->dev.groups;
+	if (groups)
+		for (; *groups; groups++)
+			old_cnt++;
+
+	for (groups = grps; *groups; groups++)
+		add_cnt++;
+
+	new_cnt = old_cnt + add_cnt + 1;
+	groups = devm_kcalloc(&rtc->dev, new_cnt, sizeof(*groups), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(groups))
+		return PTR_ERR(groups);
+	memcpy(groups, rtc->dev.groups, old_cnt*sizeof(*groups));
+	memcpy(groups+old_cnt, grps, add_cnt*sizeof(*groups));
+	groups[old_cnt+add_cnt] = NULL;
+
+	old = rtc->dev.groups;
+	rtc->dev.groups = groups;
+	if (old && old != rtc_attr_groups)
+		devm_kfree(&rtc->dev, old);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtc_add_groups);
+
+int rtc_add_group(struct rtc_device *rtc, const struct attribute_group *grp)
+{
+	const struct attribute_group *groups[] = { grp, NULL };
+
+	return rtc_add_groups(rtc, groups);
+}
+EXPORT_SYMBOL(rtc_add_group);
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
