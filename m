Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36318 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756693AbdGLFuM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 12 Jul 2017 01:50:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so3189140wrb.3
        for <linux-rtc@vger.kernel.org>; Tue, 11 Jul 2017 22:50:12 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 9/9] rtc: ds1307: remove member nvram_offset from struct
 ds1307
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Message-ID: <24eaba2e-5ac5-aa7d-0434-61eebd9f516b@gmail.com>
Date: Wed, 12 Jul 2017 07:49:54 +0200
MIME-Version: 1.0
In-Reply-To: <aded2895-cf4b-12f0-5525-c4389ccf3650@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Remove member nvram_offset from struct ds1307 and use the value stored
in struct chip_desc directly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/rtc-ds1307.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 43babd74..6eb7e86e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -116,7 +116,6 @@ enum ds_type {
 
 struct ds1307 {
 	u8			regs[11];
-	u16			nvram_offset;
 	struct nvmem_config	nvmem_cfg;
 	enum ds_type		type;
 	unsigned long		flags;
@@ -918,8 +917,9 @@ static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
 			     size_t bytes)
 {
 	struct ds1307 *ds1307 = priv;
+	const struct chip_desc *chip = &chips[ds1307->type];
 
-	return regmap_bulk_read(ds1307->regmap, ds1307->nvram_offset + offset,
+	return regmap_bulk_read(ds1307->regmap, chip->nvram_offset + offset,
 				val, bytes);
 }
 
@@ -927,8 +927,9 @@ static int ds1307_nvram_write(void *priv, unsigned int offset, void *val,
 			      size_t bytes)
 {
 	struct ds1307 *ds1307 = priv;
+	const struct chip_desc *chip = &chips[ds1307->type];
 
-	return regmap_bulk_write(ds1307->regmap, ds1307->nvram_offset + offset,
+	return regmap_bulk_write(ds1307->regmap, chip->nvram_offset + offset,
 				 val, bytes);
 }
 
@@ -1673,7 +1674,6 @@ static int ds1307_probe(struct i2c_client *client,
 		ds1307->nvmem_cfg.reg_read = ds1307_nvram_read;
 		ds1307->nvmem_cfg.reg_write = ds1307_nvram_write;
 		ds1307->nvmem_cfg.priv = ds1307;
-		ds1307->nvram_offset = chip->nvram_offset;
 
 		ds1307->rtc->nvmem_config = &ds1307->nvmem_cfg;
 		ds1307->rtc->nvram_old_abi = true;
-- 
2.13.2
