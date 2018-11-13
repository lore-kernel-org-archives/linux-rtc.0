Return-Path: <SRS0=UNq1=NY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D98BC43441
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3F2250E
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pP3Lv3MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3F2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeKMVat (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:30:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49572 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbeKMVas (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Nov 2018 16:30:48 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181113113304euoutp0202edc798eaf2a65e9f7d7cc64ebc9ebb~mq8Tmmotl1489714897euoutp02j;
        Tue, 13 Nov 2018 11:33:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181113113304euoutp0202edc798eaf2a65e9f7d7cc64ebc9ebb~mq8Tmmotl1489714897euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542108784;
        bh=iOoJU0iNTiK0psWiZsqYmpjNB24OGeS0a90Pg8Yxgi0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pP3Lv3MXhrBEMXkn3ipG067fFwY4QNIinhm8Nak3/ogRbzKDWmvIVR41UWHboO+yR
         tvRcfpSnwazI5IUNkwkIqTL9kstPDGWpE+FRZiLH6RoySsyzSonDWcqCejmpK15NPG
         jnGBvE2Btpp66GbXKcvRDzrSUiY9Iyy0UnTvR11Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113113303eucas1p27c45246d5cb0910f3adf933eca6510f4~mq8S7RjVr3240232402eucas1p2b;
        Tue, 13 Nov 2018 11:33:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.F1.04441.F66BAEB5; Tue, 13
        Nov 2018 11:33:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6~mq8SPhyim3147531475eucas1p1Q;
        Tue, 13 Nov 2018 11:33:03 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-c6-5beab66fdd2c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.52.04284.F66BAEB5; Tue, 13
        Nov 2018 11:33:03 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PI4008Z7QQZ3H30@eusync4.samsung.com>;
        Tue, 13 Nov 2018 11:33:03 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
Date:   Tue, 13 Nov 2018 12:32:50 +0100
Message-id: <20181113113250.15527-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7djPc7r5215FGxx7rWix5OJVdov2d8vY
        LTbOWM9qcf78BnaLY6uvsFnMOL+PyWLtkbvsDuwe89ZUe2xa1cnm0bdlFaPH9Hk/mTw+b5IL
        YI3isklJzcksSy3St0vgyvi1fyVTwTKBihNbVRoYt/J2MXJySAiYSPx+O5G9i5GLQ0hgBaPE
        4flnmCGcz4wS3Ws+MMNUrXjzkBUisYxRYubqlSwQTgOTxLGp09lAqtgEDCW63naB2SICDhJf
        /7wFK2IWeMcosWftGhaQhLCAk8Tvm7vAbBYBVYkzv4+B2bwCthJv/16FWicvsXrDASj7JavE
        tDX2ELaLxOw9B9kgbGGJV8e3sEPYMhKdHQeZQJZJCDQzSrTPmMUO4fQwSmydswOqw1ri8PGL
        rCA2swCfxKRt04E2cADFeSU62oQgSjwk+tcfASsREoiV6L74mWkCo8QCRoZVjOKppcW56anF
        hnmp5XrFibnFpXnpesn5uZsYgXF2+t/xTzsYv15KOsQowMGoxMN7YvrLaCHWxLLiytxDjBIc
        zEoivDtNXkUL8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRq
        YFzj8DPWkI2xzvB7z4bz4pOebT4ie/NSzLfpl/qX1FiJfetc86z8eu1q2f2TOQMu2fLbCHhk
        fs8XShfkXGipJTetTJLJ4P7sxG13dhiKmIh8XRj7LmVz8rU1tnayyVPMV77fyCLc4+3StsPs
        3hoeL8FphvpXjj5vdDD/+3HFu99ePwJaC8s0FiqxFGckGmoxFxUnAgCw/MtKrwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsVy+t/xa7r5215FGxyawGqx5OJVdov2d8vY
        LTbOWM9qcf78BnaLY6uvsFnMOL+PyWLtkbvsDuwe89ZUe2xa1cnm0bdlFaPH9Hk/mTw+b5IL
        YI3isklJzcksSy3St0vgyvi1fyVTwTKBihNbVRoYt/J2MXJySAiYSKx485C1i5GLQ0hgCaPE
        wWstUE4Tk8StfXtYQKrYBAwlut52sYHYIgIOEl//vGUBKWIW+MAoseTCGWaQhLCAk8Tvm7vA
        GlgEVCXO/D4GZvMK2Eq8/XuVGWKdvMTqDQeYJzByLWBkWMUoklpanJueW2yoV5yYW1yal66X
        nJ+7iREYCtuO/dy8g/HSxuBDjAIcjEo8vCemv4wWYk0sK67MPcQowcGsJMK70+RVtBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQZGj55tE0Jbuf8wJTyI
        rw4Mfdjx5Oq8p5mtQhPz4t/dmnP++fniX3eX2fJbPvW/N336g/idF/Z8XdXy5aWUdw7z35wW
        vy9rj51pq/0iwf/427dE36UBHX2nvn+dpuCzPpjpQPzdGNH8Ga3bG31NikLrj1nOdCtpD11w
        ijOoq335PtVO1ghp5ZVflViKMxINtZiLihMBAYklngECAAA=
X-CMS-MailID: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

(RTC,ALM)YEAR registers of Exynos built-in RTC device contains 3 BCD
characters. s3c-rtc driver uses only 2 lower of them and supports years
from 2000..2099 range. The third BCD value is typically set to 0, but it
looks that handling of it is broken in the hardware. It sometimes
defaults to a random (even non-BCD) value. This is not an issue
for handling RTCYEAR register, because bcd2bin() properly handles only
8bit values (2 BCD characters, the third one is skipped). The problem
is however with ALMYEAR register and proper RTC alarm operation. When
YEAREN bit is set for the configured alarm, RTC hardware triggers alarm
only when ALMYEAR and RTCYEAR matches. This usually doesn't happen
because of the random noise on the third BCD character.

Fix this by simply skipping setting ALMYEAR register in alarm
configuration. This workaround fixes broken alarm operation on Exynos
built-in rtc device. My tests revealed that the issue happens on the
following Exynos series: 3250, 4210, 4412, 5250 and 5410.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 75c8c5033e08..58e03ac3578b 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -327,7 +327,6 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_time *tm = &alrm->time;
 	unsigned int alrm_en;
 	int ret;
-	int year = tm->tm_year - 100;
 
 	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
 		alrm->enabled,
@@ -356,11 +355,6 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		writeb(bin2bcd(tm->tm_hour), info->base + S3C2410_ALMHOUR);
 	}
 
-	if (year < 100 && year >= 0) {
-		alrm_en |= S3C2410_RTCALM_YEAREN;
-		writeb(bin2bcd(year), info->base + S3C2410_ALMYEAR);
-	}
-
 	if (tm->tm_mon < 12 && tm->tm_mon >= 0) {
 		alrm_en |= S3C2410_RTCALM_MONEN;
 		writeb(bin2bcd(tm->tm_mon + 1), info->base + S3C2410_ALMMON);
-- 
2.17.1

