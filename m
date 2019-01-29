Return-Path: <SRS0=ea8V=QF=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981DC169C4
	for <linux-rtc@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551B4214DA
	for <linux-rtc@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfA2Lki (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:38 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37683 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfA2Lkf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 29 Jan 2019 06:40:35 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43pl1F2DQsz1r8jg;
        Tue, 29 Jan 2019 12:40:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43pl1F218Xz1r2HY;
        Tue, 29 Jan 2019 12:40:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id PFckvQMkaREG; Tue, 29 Jan 2019 12:40:32 +0100 (CET)
X-Auth-Info: vWpcjf5YxdsvZ2mPGeNqzaF2Z+IBGFcAAf01MBVeWhM=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 29 Jan 2019 12:40:32 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     linux-rtc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] rtc: abx80x: Configure reserved bits in RV1805
Date:   Tue, 29 Jan 2019 12:40:28 +0100
Message-Id: <20190129114028.6113-1-marex@denx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

The RV1805 uses smaller package than the AB1805, discern those two
chips based on the compatible value and configure reserved bits in
the RV1805 to prevent current leakage and accidental test mode entry.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
---
 drivers/rtc/rtc-abx80x.c | 67 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 4d24f7288ad7..b76f65983658 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -46,6 +46,9 @@
 #define ABX8XX_CTRL_ARST	BIT(2)
 #define ABX8XX_CTRL_12_24	BIT(6)
 
+#define ABX8XX_REG_CTRL2	0x11
+#define ABX8XX_CTRL2_RSVD	BIT(5)
+
 #define ABX8XX_REG_IRQ		0x12
 #define ABX8XX_IRQ_AIE		BIT(2)
 #define ABX8XX_IRQ_IM_1_4	(0x3 << 5)
@@ -78,6 +81,9 @@
 
 #define ABX8XX_REG_ID0		0x28
 
+#define ABX8XX_REG_OUT_CTRL	0x30
+#define ABX8XX_OUT_CTRL_EXDS	BIT(4)
+
 #define ABX8XX_REG_TRICKLE	0x20
 #define ABX8XX_TRICKLE_CHARGE_ENABLE	0xa0
 #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
@@ -86,7 +92,7 @@
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
 enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
-	AB1801, AB1803, AB1804, AB1805, ABX80X};
+	AB1801, AB1803, AB1804, AB1805, RV1805, ABX80X};
 
 struct abx80x_cap {
 	u16 pn;
@@ -103,6 +109,7 @@ static struct abx80x_cap abx80x_caps[] = {
 	[AB1803] = {.pn = 0x1803},
 	[AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
 	[AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
+	[RV1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
 	[ABX80X] = {.pn = 0}
 };
 
@@ -723,6 +730,62 @@ static int abx80x_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
+	/* Configure RV1805 specifics */
+	if (part == RV1805) {
+		/*
+		 * Avoid accidentally entering test mode. This can happen
+		 * on the RV1805 in case the reserved bit 5 in control2
+		 * register is set. RV-1805-C3 datasheet indicates that
+		 * the bit should be cleared in section 11h - Control2.
+		 */
+		data = i2c_smbus_read_byte_data(client, ABX8XX_REG_CTRL2);
+		if (data < 0) {
+			dev_err(&client->dev,
+				"Unable to read control2 register\n");
+			return -EIO;
+		}
+
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CTRL2,
+						data & ~ABX8XX_CTRL2_RSVD);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Unable to write control2 register\n");
+			return -EIO;
+		}
+
+		/*
+		 * Avoid extra power leakage. The RV1805 uses smaller
+		 * 10pin package and the EXTI input is not present.
+		 * Disable it to avoid leakage.
+		 */
+		data = i2c_smbus_read_byte_data(client, ABX8XX_REG_OUT_CTRL);
+		if (data < 0) {
+			dev_err(&client->dev,
+				"Unable to read output control register\n");
+			return -EIO;
+		}
+
+		/*
+		 * Write the configuration key register to enable access to
+		 * the config2 register
+		 */
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_CFG_KEY,
+						ABX8XX_CFG_KEY_MISC);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Unable to write configuration key\n");
+			return -EIO;
+		}
+
+		err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OUT_CTRL,
+						data | ABX8XX_OUT_CTRL_EXDS);
+		if (err < 0) {
+			dev_err(&client->dev,
+				"Unable to write output control register\n");
+			return -EIO;
+		}
+	}
+
 	/* part autodetection */
 	if (part == ABX80X) {
 		for (i = 0; abx80x_caps[i].pn; i++)
@@ -826,7 +889,7 @@ static const struct i2c_device_id abx80x_id[] = {
 	{ "ab1803", AB1803 },
 	{ "ab1804", AB1804 },
 	{ "ab1805", AB1805 },
-	{ "rv1805", AB1805 },
+	{ "rv1805", RV1805 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, abx80x_id);
-- 
2.19.2

