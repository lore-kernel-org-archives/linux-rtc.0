Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9231DCCA483
	for <linux-rtc@archiver.kernel.org>; Wed,  8 Jun 2022 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbiFHQUb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245359AbiFHQU3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Jun 2022 12:20:29 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45D40902;
        Wed,  8 Jun 2022 09:20:26 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 0D9A540723;
        Wed,  8 Jun 2022 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1654704731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yNCEI1M50WCFwTtBdpIGCBslfrVDPiRRt09PxL34Ks=;
        b=MGlNPMSr/ikza8N8iG35Niw1MJ4Zhxd419d8LEqdGJ1FuFgjrBL+iXSYqk76JJPhxqc5kT
        +MTeqLq5/JNSywC/QWrixzy7jyL1FnIF09NoHI4jiVUL+JQ94NnPJOC+Jm5kvfxksbPKgC
        OLJQM1ggc7G9rXwDyNdgxnt6qXKEV+U=
Received: from frank-G5.. (fttx-pool-80.245.76.43.bambit.de [80.245.76.43])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 333C8100CFB;
        Wed,  8 Jun 2022 16:12:10 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2] rtc: hym8563: try multiple times to init device
Date:   Wed,  8 Jun 2022 18:11:48 +0200
Message-Id: <20220608161150.58919-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220608161150.58919-1-linux@fw-web.de>
References: <20220608161150.58919-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 86d1654e-4123-44a3-899d-68cca389b7da
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Peter Geis <pgwipeout@gmail.com>

RTC sometimes does not respond the first time in init.
Try multiple times to get a response.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/rtc/rtc-hym8563.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 90e602e99d03..9adcedaa4613 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
+#include <linux/delay.h>
 #include <linux/rtc.h>
 
 #define HYM8563_CTL1		0x00
@@ -438,10 +439,16 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
 
 static int hym8563_init_device(struct i2c_client *client)
 {
-	int ret;
+	int ret, i;
 
 	/* Clear stop flag if present */
-	ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
+	for (i = 0; i < 3; i++) {
+		ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
+		if (ret == 0)
+			break;
+		msleep(20);
+	}
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

