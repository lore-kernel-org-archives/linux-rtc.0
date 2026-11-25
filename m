Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610581;
	b=g3sV2ugYI7Epl6yN6/IS1BajdmXC3N0MaABADMLg6FyhjCc+8KqExbx0ihL3ORTuL1kH
	 8bmlOYq0JVMKcMtj6n2LzSEpin6NkJGlgko3EyB7DNZo6oZRoBJE5LZ8Kimo4NvGu4nV2
	 lNdwjcqY1iCZYDHDxM3AuEwByCmqZtrNgJvGb02fqdM5bDcbKi7SWcCNrBysrEWy5+IMS
	 5W3qY1GLjGjG3ssOhJte2sh3tSkR24O+Llpgg+hEJqtXPxGtZFa7iZNCbQNx13w81AKsa
	 bldUCCUi9QcGMmhYcw4wutKZAnFJX8/Gr9gZRoisNCNTSIHKv8YOo8SVTICFC5r4tLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iZI22dC0BuvL3b6xzlWPN3s8IoHdRulrkyuTDVsWIGE=;
	b=x0XB4Go7fjRufjfx4/otNdN7dMvL2D9v9KTuEVW3j/RhESEvwb308S7MdR3PurTUZpYZ
	 Q6/7cuWq44RttqchIqRGjJyrpf294cpagqEmlKE1ssjFOuz2aIhlSBpLV1OrC28vGhldZ
	 6epLfkWAHffY2itcBKBAf4Vjn4wxWIFSZyaXn3/9WMLjM4rTJ3rdUNicA6KFQEKNaJAUF
	 BnjOVUFGEgaWdPoG6prW/seiTk3RDaz5XpXhdyJK1qnTIWM28/cXVout7txxU9Zz/WRTm
	 Gl5LQs0ApUnDh5qsrADFcc5GRHbu2payuteRX3efRz1srEB2SP75p/+ya381Q2/JkeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lH5SZz6G;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC7606A326
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 12:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EDC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lH5SZz6G
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2871650eec.0
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610580; x=1796215380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZI22dC0BuvL3b6xzlWPN3s8IoHdRulrkyuTDVsWIGE=;
        b=lH5SZz6G6yeLj1J77LPO8OzqF3h6LykbNJQG+IgdKowAQe+tIg92nG/LJzr8oDG7QK
         22vlr2hdsiJaW4j7X1BrcgRTu2hQFhVwtU2Q7utU7f6afn5mQCqxB6BgQoChloU5p0oN
         isQcsbLTuDAe7JWjIyc/r025qrQ1YSiMgy6zzbbAC4K+8PoiTkDhNJCy+M2H3wMGgPQ0
         nOY/2ca0dwbVIsZL9/NBAJrUutu8W7PHKNHXMO84Kdvo1Ced9JjCS5jveavst0aVwQ+q
         o+5sZPk4OLyvxRm89tbPPoBABipm6JY6LmWTB/Psl+Gk512Iutbb6h0fqb2RobUXiAih
         QQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610580; x=1796215380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZI22dC0BuvL3b6xzlWPN3s8IoHdRulrkyuTDVsWIGE=;
        b=knONoGv5d/zQ4yIu0URw9awnD6VLuQ5e+OG06xmei76wEjh7CQN7c/9h0+zT9QeORB
         4uKXa/Sv/QGIfNRWcZ3jnR3Zg4aGKRQlFERYzn2cjMyh2xbI5ffyX7fH9EwFC0tPuVFd
         MNQB4ReKxjxC8HinAzawJ6TPC2eG/ZOr2BVP3st7jANGzpnpiscMdKtnx5QJKNSaB2yE
         EAvBN0LlA4mUaUZpt6BLn8grZeNlLjC/LIWHciZlBie8+RAD188zvwSMv9yc/G5sKfr+
         mLxWJZrwLARZ20hRbicKW5atZo+Avf7BamMYjp/C1Pyrz7ZbnkHpULQsvve8wbpOK6eL
         TYhQ==
X-Gm-Message-State: APuU4Z9y6GOIiGctrOAQ6WAzPngQgH7bhs5haZpXPiEIFZ0+PViLbFt6
	lAxfSw5a+Bs5ZLP/YDVLCowsH+MwU9vZ+NWAWYMpcR+EsJ10p/8+lwSE
X-Gm-Gg: AZFdTZdFaK+LWAimT47jD3m3+lwRr7MW5NfhqbqcOsZ8rhfR6sZI6aS36CtB8nbR6mn
	3hHuIWHBXeAb9SjKDD9s7G2CBgqnq0qO+LdJQ0ZH0UL/DcKRKYXFLim56SOLCw5MUMzCOJdQlL9
	5NjT2TT5l0BYlNfmyiMmT3NX1wXrSFC8ccpfY90gEr48Bo3pl8UGAq5Omiqs/R7TLGbdb8U5wPa
	L6OI+NNVOb/dxFwyWC83Hz1Gdzxus/KJIXfkXc/Z3nwdW0czGzT5Aso2TY7D/MrTFV8336/U6S5
	qG0B0mkQV2jD7tDD42Cy42MF1DX/YomjTpFj4jNUEsknHScfZfZLwI4aTGf1b6XS9GCqugSpaSD
	6Lo8M19JBKPCqnGn5eevyAXo1Y5TBjVZSIjEhZDrft+mdtv7BwLI/0GZqeKsfsDY94dE8+A1tbq
	NroUoEu1D4Eo63quVrGRbOsUpSkjVPcccymsWr8tGlDKguuZGnWXy+3AcUhclW76o6eMhJqIs6C
	aTAeoRr1iFCzudFsozcApyDxbbwC9Q7T4Wxm6gnEtrfK+l/5wI/fB5gKWgzAaL0aMf+X9TP71p0
	9F8/FtCZT8kpfqjQsm0UoBO/zmdjf9EQeD60jB8XCsjoM3qSLujtrZ7xDgTP
X-Received: by 2002:a05:693c:69c7:b0:386:b745:ac60 with SMTP id 5a478bee46e88-386b745b019mr7056277eec.18.1795610579840;
        Wed, 25 Nov 2026 04:42:59 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([152.58.24.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm60000044eec.21.2026.11.25.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:42:59 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Elena Popa <elena.popa@nxp.com>,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH] rtc: pcf2127: use const per-variant regmap_config tables
Date: Wed, 25 Nov 2026 12:44:15 +0000
Message-ID: <20261125124416.468-1-akshatrawat095@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both pcf2127_i2c_probe() and pcf2127_spi_probe() declare config as a
static struct regmap_config and update it in place based on the chip
variant.

In pcf2127_spi_probe(), if a PCF2131 probes first, read_flag_mask and
write_flag_mask are overwritten to 0 and never restored. Any PCF2127 or
PCF2129 probed later reuses those zeroed masks instead of 0xa0/0x20,
breaking SPI register access. Modifying static max_register and flag
masks also races if multiple instances probe concurrently.

Replace the shared mutable config structs in both probe paths with
per-variant static const struct regmap_config tables, and drop the
now-unused max_register field from struct pcf21xx_config.

Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration structure")
Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
Cc: stable@vger.kernel.org
Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
Compile-tested (x86_64 gcc 15.2.0, W=1, CONFIG_WERROR=y) with
I2C+SPI, I2C-only, and SPI-only configs; not tested on hardware.

 drivers/rtc/rtc-pcf2127.c | 65 +++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 27c5fb9b2aaa..b665728c6c1d 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -186,7 +186,6 @@ struct pcf21xx_ts_config {
 
 struct pcf21xx_config {
 	int type; /* IC variant */
-	int max_register;
 	unsigned int has_nvmem:1;
 	unsigned int has_bit_wd_ctl_cd0:1;
 	unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
@@ -1020,7 +1019,6 @@ static struct attribute *pcf2131_attrs[] = {
 static struct pcf21xx_config pcf21xx_cfg[] = {
 	[PCF2127] = {
 		.type = PCF2127,
-		.max_register = 0x1d,
 		.has_nvmem = 1,
 		.has_bit_wd_ctl_cd0 = 1,
 		.wd_val_reg_readable = 1,
@@ -1048,7 +1046,6 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 	},
 	[PCF2129] = {
 		.type = PCF2129,
-		.max_register = 0x19,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.wd_val_reg_readable = 1,
@@ -1076,7 +1073,6 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
 	},
 	[PCF2131] = {
 		.type = PCF2131,
-		.max_register = 0x36,
 		.has_nvmem = 0,
 		.has_bit_wd_ctl_cd0 = 0,
 		.wd_val_reg_readable = 0,
@@ -1452,13 +1448,27 @@ static const struct i2c_device_id pcf2127_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
 
+static const struct regmap_config pcf2127_i2c_regmap_config[PCF21XX_LAST_ID] = {
+	[PCF2127] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x1d,
+	},
+	[PCF2129] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x19,
+	},
+	[PCF2131] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x36,
+	},
+};
+
 static int pcf2127_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
-	static struct regmap_config config = {
-		.reg_bits = 8,
-		.val_bits = 8,
-	};
 	const struct pcf21xx_config *variant;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -1468,10 +1478,9 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
 	if (!variant)
 		return -ENODEV;
 
-	config.max_register = variant->max_register,
-
 	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
-					&client->dev, &config);
+				  &client->dev,
+				  &pcf2127_i2c_regmap_config[variant->type]);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
 			__func__, PTR_ERR(regmap));
@@ -1518,14 +1527,30 @@ static void pcf2127_i2c_unregister_driver(void)
 static struct spi_driver pcf2127_spi_driver;
 static const struct spi_device_id pcf2127_spi_id[];
 
-static int pcf2127_spi_probe(struct spi_device *spi)
-{
-	static struct regmap_config config = {
+static const struct regmap_config pcf2127_spi_regmap_config[PCF21XX_LAST_ID] = {
+	[PCF2127] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.read_flag_mask = 0xa0,
+		.write_flag_mask = 0x20,
+		.max_register = 0x1d,
+	},
+	[PCF2129] = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.read_flag_mask = 0xa0,
 		.write_flag_mask = 0x20,
-	};
+		.max_register = 0x19,
+	},
+	[PCF2131] = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x36,
+	},
+};
+
+static int pcf2127_spi_probe(struct spi_device *spi)
+{
 	struct regmap *regmap;
 	const struct pcf21xx_config *variant;
 
@@ -1541,14 +1566,8 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 		variant = &pcf21xx_cfg[type];
 	}
 
-	if (variant->type == PCF2131) {
-		config.read_flag_mask = 0x0;
-		config.write_flag_mask = 0x0;
-	}
-
-	config.max_register = variant->max_register;
-
-	regmap = devm_regmap_init_spi(spi, &config);
+	regmap = devm_regmap_init_spi(spi,
+				      &pcf2127_spi_regmap_config[variant->type]);
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
 			__func__, PTR_ERR(regmap));
-- 
2.56.1.windows.1

