Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5CAC6369E
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8E2223C
	for <linux-rtc@archiver.kernel.org>; Sat, 14 Nov 2020 13:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="i9mgL68P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgKNNQn (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 14 Nov 2020 08:16:43 -0500
Received: from vultr.net.flygoat.com ([149.28.68.211]:49244 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNNQn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 14 Nov 2020 08:16:43 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 08:16:42 EST
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 87E091F9D6;
        Sat, 14 Nov 2020 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1605359378; bh=mMIE2hN/JfHnSDIQ/zpBJ/qacpl8m9Gr7aP3uk2YC9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9mgL68P0U9dlr62Gdcse55woqmp+FtROAJRCJOKKd93m1F4rqUeKZQ0LoD8/4aHI
         hJKVNdqJke7New4w3SVHYegzEc2n4E0nwZNdYC+4C7xXOQY/5a23t+X7X6bXsxGJLL
         OKynERJ7Kw22f1xqUSlOloiNxmjnG9VyfP0WsvWm6u3Z5zmR71sUNa11Ippn10uE1S
         ZCKCYrxYnnXbYzXtBZjl++vS0asaSAnFMMIbTqSt8bfW7MK0Jym7nSeULKT0q1wqaq
         EdMi8lvhTo3WnXK8IViHvYfkGVg8R9kMRV5G3u7bKbeRUa770LEAaGwL1+UcyUYkhK
         4IVEcDb83kRSA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 1/2] rtc: goldfish: Remove GOLDFISH dependency
Date:   Sat, 14 Nov 2020 21:09:20 +0800
Message-Id: <20201114130921.651882-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114130921.651882-1-jiaxun.yang@flygoat.com>
References: <20201114130921.651882-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Goldfish platform is covered with dust.
However the goldfish-rtc had been used as virtualized RTC
in QEMU for RISC-V virt hw and MIPS loongson3-virt hw, thus
we can drop other parts of goldfish but leave goldfish-rtc here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/rtc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65ad9d0b47ab..f784b52381b1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1935,7 +1935,6 @@ config RTC_DRV_HID_SENSOR_TIME
 config RTC_DRV_GOLDFISH
 	tristate "Goldfish Real Time Clock"
 	depends on OF && HAS_IOMEM
-	depends on GOLDFISH || COMPILE_TEST
 	help
 	  Say yes to enable RTC driver for the Goldfish based virtual platform.
 
-- 
2.29.2

