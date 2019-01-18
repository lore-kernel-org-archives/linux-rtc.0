Return-Path: <SRS0=aUxY=P2=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F187FC43387
	for <linux-rtc@archiver.kernel.org>; Fri, 18 Jan 2019 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04852087E
	for <linux-rtc@archiver.kernel.org>; Fri, 18 Jan 2019 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kko2/4n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfARN2s (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:28:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39753 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfARN2s (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 18 Jan 2019 08:28:48 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190118132847euoutp0289d6cf30ed8a24ba8e4c1d55ad357c18~69GLI4sLv1541315413euoutp02f;
        Fri, 18 Jan 2019 13:28:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190118132847euoutp0289d6cf30ed8a24ba8e4c1d55ad357c18~69GLI4sLv1541315413euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547818127;
        bh=L6FPGWfIKhhmcvf+DKkC4G1EAjrk+deIgEZEBlDM8C0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Kko2/4n9s5gPCBUNY5M1A3DGQAfPSJwE51UiAXzerKe96jnnTiUSyVrgtZ/3gDE3b
         xNhNRuMYAZsVn0YjB2AIGLYd9LPDoJUbsznsfTRFiKHcuzJMOqbk/BrhUrJ/boOZe+
         ol1OWq+64Y3UyAFrnjk/S3G/z2K1EgubwDrV5qO8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118132846eucas1p2fe6f95e420886392b186e7f76c51607c~69GKdf16q0282402824eucas1p2E;
        Fri, 18 Jan 2019 13:28:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0A.26.04294.D84D14C5; Fri, 18
        Jan 2019 13:28:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094~69GJxQnmA0861308613eucas1p2i;
        Fri, 18 Jan 2019 13:28:45 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9a-5c41d48df859
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.60.04284.D84D14C5; Fri, 18
        Jan 2019 13:28:45 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PLJ0099K43TMY40@eusync3.samsung.com>;
        Fri, 18 Jan 2019 13:28:45 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] rtc: s3c: Use generic helper to get driver data
Date:   Fri, 18 Jan 2019 14:28:37 +0100
Message-id: <20190118132837.15713-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7djP87p9VxxjDCZ2MFosuXiV3aL93TJ2
        i40z1rNanD+/gd3i2OorbBYzzu9jslh75C67A7vHvDXVHptWdbJ59G1Zxegxfd5PJo/Pm+QC
        WKO4bFJSczLLUov07RK4Mo4s62Eq+M1VcW7KAdYGxhmcXYwcHBICJhJPbqh1MXJxCAmsYJR4
        vHstM4TzmVHi/pdDTF2MnGBFsx8uhUosY5R48XEzO4TTwCRxZUUjK0gVm4ChRNfbLjYQW0TA
        QeLrn7csIEXMAu8YJfasXcMCkhAGSmy92AE2lkVAVaJn5jd2EJtXwFbi8snzUOvkJVZvOAC2
        TkLgLavE+ZMr2CASLhJvWrexQ9jCEq+Ob4GyZSQ6Ow4yQTQ0M0q0z5jFDuH0MEpsnbMDqtta
        4vDxi2C3MgvwSUzaNp0ZEgS8Eh1tQhAlHhKr501gBrGFBGIlLj+5zTSBUWIBI8MqRvHU0uLc
        9NRio7zUcr3ixNzi0rx0veT83E2MwEg7/e/4lx2Mu/4kHWIU4GBU4uGdsMUhRog1say4MvcQ
        owQHs5IIL9cKxxgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwc
        nFINjI1s0ZGVngs+/+4+8v1939/tD1W2x5o/PcKzwCYoIGF+2St39987eJ9vkqvp55059xST
        Q4NZyjIxi+xPPXeu1lY+UT+88bfx0xDDdLu0W//ds6LrrFNn3M/nytt3atNyIaHE8ttP9edO
        z7z5b0P7E8c9SV47HyySfff6f9AxDvslvHePHFh2VleJpTgj0VCLuag4EQBpQGc+sAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsVy+t/xq7q9VxxjDNZ+FLFYcvEqu0X7u2Xs
        FhtnrGe1OH9+A7vFsdVX2CxmnN/HZLH2yF12B3aPeWuqPTat6mTz6NuyitFj+ryfTB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZRxZ1sNU8Jur4tyUA6wNjDM4uxg5OSQETCRmP1zK3MXIxSEksIRR
        Yt/dtVBOE5PEqafTWUCq2AQMJbredrGB2CICDhJf/7xlASliFvjAKLHkwhlmkIQwUGLrxQ4m
        EJtFQFWiZ+Y3dhCbV8BW4vLJ80wQ6+QlVm84wDyBkWsBI8MqRpHU0uLc9NxiQ73ixNzi0rx0
        veT83E2MwGDYduzn5h2MlzYGH2IU4GBU4uF9sc0hRog1say4MvcQowQHs5IIL9cKxxgh3pTE
        yqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjDYHa6/9YZso0D7/
        /onezgl+jEvEeheV+p15uEW95ELJ1YU2ahtvCn28mF0gF93eoPiSw3RXd8KeJ1wWv21i5BPV
        b+00Czp9YvanSQsa+W9Nq78SNJGz5IOzx89PZp2fP4stPzu/zCclQ+fJ9N/tkvzBExccuHV8
        i6q43i1H7kX7uz4+9/D6ka/EUpyRaKjFXFScCAC0O4/0AgIAAA==
X-CMS-MailID: 20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094
References: <CGME20190118132845eucas1p2c3e5f6dadb6af90a3701fca03599e094@eucas1p2.samsung.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Replace of_match_node() with of_device_get_match_data(), which removes a
few lines of code from the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index e682977b4f6e..2904b872db88 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -26,6 +26,7 @@
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 
@@ -443,16 +444,6 @@ static int s3c_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id s3c_rtc_dt_match[];
-
-static const struct s3c_rtc_data *s3c_rtc_get_data(struct platform_device *pdev)
-{
-	const struct of_device_id *match;
-
-	match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
-	return match->data;
-}
-
 static int s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct s3c_rtc *info = NULL;
@@ -472,7 +463,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 	info->dev = &pdev->dev;
-	info->data = s3c_rtc_get_data(pdev);
+	info->data = of_device_get_match_data(&pdev->dev);
 	if (!info->data) {
 		dev_err(&pdev->dev, "failed getting s3c_rtc_data\n");
 		return -EINVAL;
-- 
2.17.1

