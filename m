Return-Path: <SRS0=aUxY=P2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC0C43387
	for <linux-rtc@archiver.kernel.org>; Fri, 18 Jan 2019 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F1B20883
	for <linux-rtc@archiver.kernel.org>; Fri, 18 Jan 2019 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bIZhk2X1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfARN2a (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:28:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39659 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfARN2a (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 18 Jan 2019 08:28:30 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190118132828euoutp02d1a496c2618d749e279760f47f4fd83c~69F5py7-k1541315413euoutp02V;
        Fri, 18 Jan 2019 13:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190118132828euoutp02d1a496c2618d749e279760f47f4fd83c~69F5py7-k1541315413euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547818108;
        bh=9T7pDl1m4NIwx32hT3P+SHtwJ/zWjl57FsWGKtR9Pf4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bIZhk2X16MiryfwdMR9hhl3/1iYbAWlh1Dg/mnR/v/depIwAQhdwIbYu+8Lmu/oHr
         c9m/YrZFook7+7+xns93cgK8BM1oJb0Gxrb1GHw7PCoX8UJijdkG6AMNungTgDMGBY
         y9Ye961qJ/shrqmx21BpAw7NiDeYWsDKhSohnkls=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190118132827eucas1p128572742fe9ec35c728ae9b49f00047a~69F41SKTp1790717907eucas1p1e;
        Fri, 18 Jan 2019 13:28:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.90.04806.B74D14C5; Fri, 18
        Jan 2019 13:28:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c~69F37JiQL0858808588eucas1p2c;
        Fri, 18 Jan 2019 13:28:26 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-e3-5c41d47b242c
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.A6.04128.A74D14C5; Fri, 18
        Jan 2019 13:28:26 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PLJ00HN642XSW40@eusync3.samsung.com>;
        Fri, 18 Jan 2019 13:28:26 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] rtc: s3c: Rewrite clock handling
Date:   Fri, 18 Jan 2019 14:27:54 +0100
Message-id: <20190118132754.15660-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87rVVxxjDNY+YrFYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/HZLH2yF12B3aPeWuqPTat6mTz6NuyitFj+ryfTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZSzt2MBUcEWxYvadX8wNjKukuxg5OSQETCQ2fFjC1sXIxSEksIJR
        4uyeJ1DOZ0aJhm8PmWCqzj5bwgSRWMYosXt5NzuE08AkMXvuO0aQKjYBQ4mut11sILaIgIPE
        1z9vWUCKmAXeMUrsWbuGBSQhDFS0dxZEEYuAqsTRZz+ZQWxeAVuJ4493MUOsk5dYveEAM0iz
        hMBLVokrr05D3eEisercB1YIW1ji1fEt7BC2jMTlyd0sEA3NjBLtM2axQzg9jBJb5+xgg6iy
        ljh8/CJYN7MAn8SkbdOBVnAAxXklOtqEIEo8JJZd+Q52qZBArMTXLW2MExglFjAyrGIUTy0t
        zk1PLTbOSy3XK07MLS7NS9dLzs/dxAiMtdP/jn/dwbjvT9IhRgEORiUe3hfbHGKEWBPLiitz
        DzFKcDArifByrXCMEeJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbL
        xMEp1cB4OdvzEktXl8ut+bu+Op15/bpv4Ta3pKC7Om0hmlW753gG2s0yDF0y/1XkG/v6zJoW
        l3jViaKJay4WTdBbml+24EvQ8xb/S9q8TmtjZpZOiNCWyK4SZ3CW3T93dtOfDQ9XsTarJIfp
        cB7g/ftNcu3ZaRsn7fwi1OSy/lyyj0nU94DbLau/qX9TYinOSDTUYi4qTgQAKHc+6bECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsVy+t/xq7pVVxxjDC7MY7NYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/HZLH2yF12B3aPeWuqPTat6mTz6NuyitFj+ryfTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZSzt2MBUcEWxYvadX8wNjKukuxg5OSQETCTOPlvC1MXIxSEksIRR
        4se/lWwQThOTxJR5i9lAqtgEDCW63naB2SICDhJf/7xlASliFvjAKLHkwhlmkIQwUNHeWRBF
        LAKqEkef/QSL8wrYShx/vIsZYp28xOoNB5gnMHItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpec
        n7uJERgM24793LKDsetd8CFGAQ5GJR7eF9scYoRYE8uKK3MPMUpwMCuJ8HKtcIwR4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwDhfYP/1HNN5d8xnnXq6
        /7H0c/OEhR533/4Xu7J0o2ZM5Z3oQzoLgvTnTK1+UZQj8aIy7HPFDise9d031qk97J7TYNW9
        98IGU46vrWbPL5/12uQl4pkx+7HL5RKnFoOPLc9TWDaU3hZ6+HLqOYMdO/7N21ukueUo19S2
        qY2WW8rjbiaxduhIyW5QYinOSDTUYi4qTgQAERf2tAICAAA=
X-CMS-MailID: 20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c
References: <CGME20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c@eucas1p2.samsung.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

s3c_rtc_enable/disable_clk() functions were designed to be called multiple
times without reference counting, because they were initially used in
alarm setting/clearing functions, which can be called both when alarm is
already set or not. Later however, calls to those functions have been added to
other places in the driver - like time and /proc reading callbacks, what
results in broken alarm if any of such events happens after the alarm has
been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
to rely on proper reference counting in clock core and move alarm enable
counter to s3c_rtc_setaie() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 67 ++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 04c68178c42d..e682977b4f6e 100644
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
@@ -70,44 +70,28 @@ struct s3c_rtc_data {
 
 static int s3c_rtc_enable_clk(struct s3c_rtc *info)
 {
-	unsigned long irq_flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
+	ret = clk_enable(info->rtc_clk);
+	if (ret)
+		goto out;
 
-	if (info->clk_disabled) {
-		ret = clk_enable(info->rtc_clk);
-		if (ret)
+	if (info->data->needs_src_clk) {
+		ret = clk_enable(info->rtc_src_clk);
+		if (ret) {
+			clk_disable(info->rtc_clk);
 			goto out;
-
-		if (info->data->needs_src_clk) {
-			ret = clk_enable(info->rtc_src_clk);
-			if (ret) {
-				clk_disable(info->rtc_clk);
-				goto out;
-			}
 		}
-		info->clk_disabled = false;
 	}
-
 out:
-	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
-
 	return ret;
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
@@ -135,6 +119,7 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
 static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 {
 	struct s3c_rtc *info = dev_get_drvdata(dev);
+	unsigned long flags;
 	unsigned int tmp;
 	int ret;
 
@@ -151,17 +136,19 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 
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
@@ -357,10 +344,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	writeb(alrm_en, info->base + S3C2410_RTCALM);
 
-	s3c_rtc_disable_clk(info);
-
 	s3c_rtc_setaie(dev, alrm->enabled);
 
+	s3c_rtc_disable_clk(info);
+
 	return 0;
 }
 
@@ -491,7 +478,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	spin_lock_init(&info->pie_lock);
-	spin_lock_init(&info->alarm_clk_lock);
+	spin_lock_init(&info->alarm_lock);
 
 	platform_set_drvdata(pdev, info);
 
@@ -591,6 +578,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	s3c_rtc_setfreq(info, 1);
 
+	s3c_rtc_disable_clk(info);
+
 	return 0;
 
 err_nortc:
-- 
2.17.1

