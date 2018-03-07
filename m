Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.49.219]:22134 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbeCGUeU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Mar 2018 15:34:20 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 5E853BF43
        for <linux-rtc@vger.kernel.org>; Wed,  7 Mar 2018 14:11:34 -0600 (CST)
Date: Wed, 7 Mar 2018 14:11:33 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] rtc: remove VLA usage
Message-ID: <20180307201133.GA5860@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rtc/rtc-bq32k.c  | 2 +-
 drivers/rtc/rtc-mcp795.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index e8698e9..e4b234a 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -74,7 +74,7 @@ static int bq32k_read(struct device *dev, void *data, uint8_t off, uint8_t len)
 static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	uint8_t buffer[len + 1];
+	uint8_t buffer[256];
 
 	buffer[0] = off;
 	memcpy(&buffer[1], data, len);
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 79e24ea..00e11c1 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -82,7 +82,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	int ret;
-	u8 tx[2 + count];
+	u8 tx[257];
 
 	tx[0] = MCP795_WRITE;
 	tx[1] = addr;
-- 
2.7.4
