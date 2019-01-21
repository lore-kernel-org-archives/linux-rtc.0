Return-Path: <SRS0=tSN2=P5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F26C7112F
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA60020870
	for <linux-rtc@archiver.kernel.org>; Mon, 21 Jan 2019 11:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LxcF2dav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfAULJm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:09:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44474 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfAULJm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Jan 2019 06:09:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190121110940euoutp01f1a447b85a72b225b92a42b4d4db6ddf~72IkRY_RV1592015920euoutp01V;
        Mon, 21 Jan 2019 11:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190121110940euoutp01f1a447b85a72b225b92a42b4d4db6ddf~72IkRY_RV1592015920euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548068980;
        bh=0vfVcGFfmUZgvArZi89i+iFkcf7k24uC3n1fG0CJzVk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LxcF2dav21uWaEdfISLVzs1KTLGFuXHYAeDjPmEdyvKdly1r/ivTi4tLuR9jjFRZX
         nLIo9+iQQCtl3HvLsut9XK0yMcyOx4qSZrD8z5mNqrsxTGVEH89L0Jc3MdPIqjEu5L
         +mlCEDTv9orXDWgEa60JlkezFt/hJpYlkAPKZm5M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121110939eucas1p2a0c0cbe39628a7cc353ed85397c44ec5~72Ijxo0oh0920609206eucas1p2T;
        Mon, 21 Jan 2019 11:09:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.50.04806.378A54C5; Mon, 21
        Jan 2019 11:09:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463~72IjDihTl2507625076eucas1p2L;
        Mon, 21 Jan 2019 11:09:38 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-f7-5c45a873320b
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.02.04284.278A54C5; Mon, 21
        Jan 2019 11:09:38 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PLO005PIHNZ4850@eusync1.samsung.com>;
        Mon, 21 Jan 2019 11:09:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] rtc: s3c: Rewrite clock handling
Date:   Mon, 21 Jan 2019 12:09:30 +0100
Message-id: <20190121110930.8290-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7djP87rFK1xjDDbNF7ZYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/HZLH2yF12B3aPeWuqPTat6mTz6NuyitFj+ryfTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZUzYd5mxYI9SxaepzxgbGH9LdzFyckgImEhMWPyavYuRi0NIYAWj
        xKflu9ggnM+MEn+udjPBVPWsPcAIkVjGKHF36gRWCKeBSaLv7XQWkCo2AUOJrrddbCC2iICD
        xNc/b1lAipgF3jFK7Fm7BqxIGGhU94VXQDYHB4uAqsSNBlaQMK+AjcTDCdNYIbbJS6zecIAZ
        pFdC4C2rxKEFf1ggEi4S0w50M0LYMhKdHQeZIIqaGSXaZ8xih3B6GCW2ztnBBlFlLXH4+EWw
        scwCfBKTtk1nBtksIcAr0dEmBFHiIbF94WewP4UEYiU2X9rAPoFRfAEjwypG8dTS4tz01GLj
        vNRyveLE3OLSvHS95PzcTYzAiDr97/jXHYz7/iQdYhTgYFTi4f1xzyVGiDWxrLgy9xCjBAez
        kgjva3fXGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2M
        GvWtR/45GvDF/jm3J3zG5p//lj/ffvzwrKlT5yy8bmp46JXlyxa5OzkzDh9YzuVtvPWcux+/
        pPU9j9BP2/+ZW70W4f+ZwpnQv1Jlyawqd8M18k8T55vcLd1RYvQo9WzOIT3eatuH3MWik0W4
        pkQcvRq3wNJfLKB73tZylyubvB6kLd7xZ8qjaCWW4oxEQy3mouJEAI4SCAKkAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsVy+t/xy7pFK1xjDPY/MLBYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/HZLH2yF12B3aPeWuqPTat6mTz6NuyitFj+ryfTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZUzYd5mxYI9SxaepzxgbGH9LdzFyckgImEj0rD3A2MXIxSEksIRR
        Yu+J66wQThOTRNeqmewgVWwChhJdb7vYQGwRAQeJr3/esoAUMQt8YJRYcuEMM0hCGGhU94VX
        QAkODhYBVYkbDawgYV4BG4mHE6axQmyTl1i94QDzBEauBYwMqxhFUkuLc9Nziw31ihNzi0vz
        0vWS83M3MQJDYduxn5t3MF7aGHyIUYCDUYmH98c9lxgh1sSy4srcQ4wSHMxKIryv3V1jhHhT
        EiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTA2ST051z1jqszl
        zSvdIrbpuzUevP6o79a95Ys/ynw0K9dlfbOuY+8O8xUbBN0a8+Zx8Mz03cLgGXNX++vVYGb/
        HdOXszwKUTb2+Kqv1yjkyBYi7uTH5vAgWLYtoUdnT+Xcr7uDVsVJSje8DVJcdDM5u7x4UvYy
        GT3hBQznql52XrXNLLv33VSJpTgj0VCLuag4EQCyODJQAQIAAA==
X-CMS-MailID: 20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463
CMS-TYPE: 201P
X-CMS-RootMailID: 20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463
References: <CGME20190121110938eucas1p2e008ce6dabb0e5c62fdac19dc1491463@eucas1p2.samsung.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

s3c_rtc_enable/disable_clk() functions were designed to be called multiple
times without reference counting, because they were initially only used in
alarm setting/clearing functions, which can be called both when alarm is
already set or not. Later however, calls to those functions have been added to
other places in the driver - like time and /proc reading callbacks, what
results in broken alarm if any of such events happens after the alarm has
been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
to rely on proper reference counting in clock core and move alarm enable
counter to s3c_rtc_setaie() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- simplified code as suggested by Krzysztof
---
 drivers/rtc/rtc-s3c.c | 74 ++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 04c68178c42d..ea82efba6f94 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -39,7 +39,7 @@ struct s3c_rtc {
 	void __iomem *base;
 	struct clk *rtc_clk;
 	struct clk *rtc_src_clk;
-	bool clk_disabled;
+	bool alarm_enabled;
 
 	const struct s3c_rtc_data *data;
 
@@ -47,7 +47,7 @@ struct s3c_rtc {
 	int irq_tick;
 
 	spinlock_t pie_lock;
-	spinlock_t alarm_clk_lock;
+	spinlock_t alarm_lock;
 
 	int ticnt_save;
 	int ticnt_en_save;
@@ -70,44 +70,27 @@ struct s3c_rtc_data {
 
 static int s3c_rtc_enable_clk(struct s3c_rtc *info)
 {
-	unsigned long irq_flags;
-	int ret = 0;
+	int ret;
 
-	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
+	ret = clk_enable(info->rtc_clk);
+	if (ret)
+		return ret;
 
-	if (info->clk_disabled) {
-		ret = clk_enable(info->rtc_clk);
-		if (ret)
-			goto out;
-
-		if (info->data->needs_src_clk) {
-			ret = clk_enable(info->rtc_src_clk);
-			if (ret) {
-				clk_disable(info->rtc_clk);
-				goto out;
-			}
+	if (info->data->needs_src_clk) {
+		ret = clk_enable(info->rtc_src_clk);
+		if (ret) {
+			clk_disable(info->rtc_clk);
+			return ret;
 		}
-		info->clk_disabled = false;
 	}
-
-out:
-	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
-
-	return ret;
+	return 0;
 }
 
 static void s3c_rtc_disable_clk(struct s3c_rtc *info)
 {
-	unsigned long irq_flags;
-
-	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
-	if (!info->clk_disabled) {
-		if (info->data->needs_src_clk)
-			clk_disable(info->rtc_src_clk);
-		clk_disable(info->rtc_clk);
-		info->clk_disabled = true;
-	}
-	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
+	if (info->data->needs_src_clk)
+		clk_disable(info->rtc_src_clk);
+	clk_disable(info->rtc_clk);
 }
 
 /* IRQ Handlers */
@@ -135,6 +118,7 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
 static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 {
 	struct s3c_rtc *info = dev_get_drvdata(dev);
+	unsigned long flags;
 	unsigned int tmp;
 	int ret;
 
@@ -151,17 +135,19 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 
 	writeb(tmp, info->base + S3C2410_RTCALM);
 
-	s3c_rtc_disable_clk(info);
+	spin_lock_irqsave(&info->alarm_lock, flags);
 
-	if (enabled) {
-		ret = s3c_rtc_enable_clk(info);
-		if (ret)
-			return ret;
-	} else {
+	if (info->alarm_enabled && !enabled)
 		s3c_rtc_disable_clk(info);
-	}
+	else if (!info->alarm_enabled && enabled)
+		ret = s3c_rtc_enable_clk(info);
 
-	return 0;
+	info->alarm_enabled = enabled;
+	spin_unlock_irqrestore(&info->alarm_lock, flags);
+
+	s3c_rtc_disable_clk(info);
+
+	return ret;
 }
 
 /* Set RTC frequency */
@@ -357,10 +343,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	writeb(alrm_en, info->base + S3C2410_RTCALM);
 
-	s3c_rtc_disable_clk(info);
-
 	s3c_rtc_setaie(dev, alrm->enabled);
 
+	s3c_rtc_disable_clk(info);
+
 	return 0;
 }
 
@@ -491,7 +477,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	spin_lock_init(&info->pie_lock);
-	spin_lock_init(&info->alarm_clk_lock);
+	spin_lock_init(&info->alarm_lock);
 
 	platform_set_drvdata(pdev, info);
 
@@ -591,6 +577,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	s3c_rtc_setfreq(info, 1);
 
+	s3c_rtc_disable_clk(info);
+
 	return 0;
 
 err_nortc:
-- 
2.17.1

