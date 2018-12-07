Return-Path: <SRS0=ySH3=OQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE70C07E85
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD78920892
	for <linux-rtc@archiver.kernel.org>; Fri,  7 Dec 2018 11:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD78920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGLge (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:36:34 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:5386 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbeLGLge (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Dec 2018 06:36:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539615600"; 
   d="scan'208";a="2022480"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2018 20:36:32 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07AC140455F9;
        Fri,  7 Dec 2018 20:36:29 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-rtc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/5] rtc: pcf85363: Add support for NXP pcf85263 rtc
Date:   Fri,  7 Dec 2018 11:27:44 +0000
Message-Id: <1544182066-31528-4-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
with pcf85363,except that pcf85363 has additional 64 bytes of RAM.

1 byte of nvmem is supported and exposed in sysfs (# is the instance
number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
V1-->V2
	* Incorporated Alexandre and Geert's review comment.
V2-->V3
	* Incorporated Geert's review comment.
V3-->V4
	* Incorporated Geert's and Alexandre's review comment.
---
 drivers/rtc/rtc-pcf85363.c | 94 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c04a1ed..a398807 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -120,6 +120,11 @@ struct pcf85363 {
 	struct regmap		*regmap;
 };
 
+struct pcf85x63_config {
+	struct regmap_config regmap;
+	unsigned int num_nvram;
+};
+
 static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
@@ -311,25 +316,75 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
 				 val, bytes);
 }
 
-static const struct regmap_config regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = 0x7f,
+static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+	unsigned int tmp_val;
+	int ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_RAMBYTE, &tmp_val);
+	(*(unsigned char *) val) = (unsigned char) tmp_val;
+
+	return ret;
+}
+
+static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct pcf85363 *pcf85363 = priv;
+	unsigned char tmp_val;
+
+	tmp_val = *((unsigned char *)val);
+	return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
+				(unsigned int)tmp_val);
+}
+
+static const struct pcf85x63_config pcf_85263_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x2f,
+	},
+	.num_nvram = 1
+};
+
+static const struct pcf85x63_config pcf_85363_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x7f,
+	},
+	.num_nvram = 2
 };
 
 static int pcf85363_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	struct pcf85363 *pcf85363;
-	struct nvmem_config nvmem_cfg = {
-		.name = "pcf85363-",
-		.word_size = 1,
-		.stride = 1,
-		.size = NVRAM_SIZE,
-		.reg_read = pcf85363_nvram_read,
-		.reg_write = pcf85363_nvram_write,
+	const struct pcf85x63_config *config = &pcf_85363_config;
+	const void *data = of_device_get_match_data(&client->dev);
+	static struct nvmem_config nvmem_cfg[] = {
+		{
+			.name = "pcf85x63-",
+			.word_size = 1,
+			.stride = 1,
+			.size = 1,
+			.reg_read = pcf85x63_nvram_read,
+			.reg_write = pcf85x63_nvram_write,
+		}, {
+			.name = "pcf85363-",
+			.word_size = 1,
+			.stride = 1,
+			.size = NVRAM_SIZE,
+			.reg_read = pcf85363_nvram_read,
+			.reg_write = pcf85363_nvram_write,
+		},
 	};
-	int ret;
+	int ret, i;
+
+	if (data)
+		config = data;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -339,7 +394,7 @@ static int pcf85363_probe(struct i2c_client *client,
 	if (!pcf85363)
 		return -ENOMEM;
 
-	pcf85363->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	pcf85363->regmap = devm_regmap_init_i2c(client, &config->regmap);
 	if (IS_ERR(pcf85363->regmap)) {
 		dev_err(&client->dev, "regmap allocation failed\n");
 		return PTR_ERR(pcf85363->regmap);
@@ -370,15 +425,18 @@ static int pcf85363_probe(struct i2c_client *client,
 
 	ret = rtc_register_device(pcf85363->rtc);
 
-	nvmem_cfg.priv = pcf85363;
-	rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg);
+	for (i = 0; i < config->num_nvram; i++) {
+		nvmem_cfg[i].priv = pcf85363;
+		rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
+	}
 
 	return ret;
 }
 
 static const struct of_device_id dev_ids[] = {
-	{ .compatible = "nxp,pcf85363" },
-	{}
+	{ .compatible = "nxp,pcf85263", .data = &pcf_85263_config },
+	{ .compatible = "nxp,pcf85363", .data = &pcf_85363_config },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
 
@@ -393,5 +451,5 @@ static struct i2c_driver pcf85363_driver = {
 module_i2c_driver(pcf85363_driver);
 
 MODULE_AUTHOR("Eric Nelson");
-MODULE_DESCRIPTION("pcf85363 I2C RTC driver");
+MODULE_DESCRIPTION("pcf85263/pcf85363 I2C RTC driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

