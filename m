Return-Path: <SRS0=P+fM=N6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B689C43441
	for <linux-rtc@archiver.kernel.org>; Mon, 19 Nov 2018 11:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0C206BA
	for <linux-rtc@archiver.kernel.org>; Mon, 19 Nov 2018 11:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A0C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeKSVvw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:51:52 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:5545 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbeKSVvw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 19 Nov 2018 16:51:52 -0500
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Nov 2018 20:23:28 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 729704017F31;
        Mon, 19 Nov 2018 20:23:26 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH  2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
Date:   Mon, 19 Nov 2018 11:15:06 +0000
Message-Id: <1542626108-61344-3-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
with pcf85363,except that pcf85363 has additional 64 bytes of RAM.

1 byte of nvmem is supported and exposed in sysfs (# is the instance
number,starting with 0): /sys/bus/nvmem/devices/pcf85263-#/nvmem

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/rtc/rtc-pcf85363.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c04a1ed..6996aa5 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -311,7 +311,30 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
 				 val, bytes);
 }
 
-static const struct regmap_config regmap_config = {
+static int pcf85263_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val);
+}
+
+static int pcf85263_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+
+	return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
+				*((unsigned int *)val));
+}
+
+static const struct regmap_config pcf_85263_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x2f,
+};
+
+static const struct regmap_config pcf_85363_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x7f,
@@ -321,6 +344,7 @@ static int pcf85363_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct pcf85363 *pcf85363;
+	const struct regmap_config *regmap_config = &pcf_85363_regmap_config;
 	struct nvmem_config nvmem_cfg = {
 		.name = "pcf85363-",
 		.word_size = 1,
@@ -339,7 +363,16 @@ static int pcf85363_probe(struct i2c_client *client,
 	if (!pcf85363)
 		return -ENOMEM;
 
-	pcf85363->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (of_device_get_match_data(&client->dev) ==
+					&pcf_85263_regmap_config) {
+		regmap_config = &pcf_85263_regmap_config;
+		nvmem_cfg.name = "pcf85263-";
+		nvmem_cfg.size = 1;
+		nvmem_cfg.reg_read = pcf85263_nvram_read;
+		nvmem_cfg.reg_write = pcf85263_nvram_write;
+	}
+
+	pcf85363->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(pcf85363->regmap)) {
 		dev_err(&client->dev, "regmap allocation failed\n");
 		return PTR_ERR(pcf85363->regmap);
@@ -377,8 +410,9 @@ static int pcf85363_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id dev_ids[] = {
-	{ .compatible = "nxp,pcf85363" },
-	{}
+	{ .compatible = "nxp,pcf85263", .data = &pcf_85263_regmap_config },
+	{ .compatible = "nxp,pcf85363", .data = &pcf_85363_regmap_config },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
 
@@ -393,5 +427,5 @@ static struct i2c_driver pcf85363_driver = {
 module_i2c_driver(pcf85363_driver);
 
 MODULE_AUTHOR("Eric Nelson");
-MODULE_DESCRIPTION("pcf85363 I2C RTC driver");
+MODULE_DESCRIPTION("pcf85263/pcf85363 I2C RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

