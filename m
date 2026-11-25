Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619392;
	b=V9Iay3/o+h9wNORBqJAB6bk0gweKRV0Fa0rR6Stjhhxn0/PTFxcCz35ih+m8FFBjh/Q5
	 OHnR+1LHAeD9QTAs1XOADwHz8+SSWqHO7CRqTTjWECddfw9vrfBK49mKiu+ieliDPKNmh
	 6MkL5qA+/BfvElkzgDJHHC3v0hHz5yLIUzwiMFYDXUHtALVKXD2HW8Vstz2etO34tBOj+
	 2JmKgjn3ZBK4MMiGF5FqEXJPrnreC2fWQ+g+RkE6uDrj6RGqw354GbqgBCdudi/OY193p
	 JAnS8R8K0MI/mEne139vHl8sb+o1wBB+Qh6GzFGm9LEUYek1swmyMqSfxpPb/9hVHxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
	b=ejxfnpvukWIsGwpGyrwCF0pgALWt9fXBdvinkSZjxO3NmWtWwdNz6YG+IrGNEz5Oez6g
	 Wn0IjqqoLwgr1dd/fAF4sFOwm7A7ioUOSyUIg4qWdGxzSXtsE+hyXybfDF2Z4XGMq03a2
	 hpfk6tTVKAzCHbnwPI54ewSBxCrPNgYa9IE3cPHRRkUJu+5X7JBzHnY6JEk62QGUyI28e
	 I/Bfpr7nc/H2Ny/sZLyfnHavmnlu440rTO4Dwk0/5xvyysi/E3YjeuU1mVj293XKFSjrl
	 G1ZjHg9V94B476bSzB1PWdU2eDediTnAU5dJoGJmrBOTBb+9bTg5T3oJ0dtC4mET1Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hU/cJhaK";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EB606A326
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 15:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hU/cJhaK
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b546061d58so13333943c88.1
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619391; x=1796224191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
        b=hU/cJhaKNz93P0GMjl+URa/kTV1SPk5EUW78kR5rcIqbWBPJnNZnSKopxe3Z6sM5mO
         7gMi0+nQDW5f/J6fK3Vrto6r/lfCgiutnUnrBVcPYzyhwSORjvzyY1SVTRM+EGzBFw3u
         1HtNQI48JRidDGAvnuFMQj3k9n/XBUDjXVAddK9i1Y6xj5spbkuQED810lWK21cyS64H
         UoSpqCz+vD04AshM31wrNhQqErNNy98MGxr/fU8dhRApx9eihUH5mIyucLHjb8o3Q5PJ
         u9gtBSysro6RUsF0f+sE6jksOtpW/KlmydrS1rIvLKpgrgS6wgPzMx+ITjCVG8/eY64E
         XYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619391; x=1796224191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wU/3Wiw6HBpJUb9vOL67s+ORbpL0ttUSloHr/zoQa8U=;
        b=kGU9w32slZbYkGgvdz/TeUEsgAm6QvYv3dmnqB6px2u1KLtdT+Ufa3fI5HFvIfxCW7
         FSq4EeMmtBjXzO+MsfBJwy39ry5JvGljyg7Xb3X8nFNMty8PnRLJ17K3RXQjYVfFerTl
         g1JcPh6f6qwSeobomB71N6FPCJzgZti7o+SI3jB//ic/KgY8sIse9xV9pGemnrb6KV8Z
         6h87nOa9HUMbpqKXqWPei8OlTIsNwXRQbF7XkaJOwpKXLX68nWz3H076N1XdsHI+pmOc
         0PaEZQ87ZqpdTOn1Rphao7Mt5XWHHm+opOjf7NPe+errforL2jzABXHQpbh/xnEODUFk
         z7ww==
X-Forwarded-Encrypted: i=1; AL+hErF97pNJqJv68Vp0XtP53KbahsPoodZajsY4GkEEdWmlyXPv/9CPW5cP6M75Qa95/uXW73SNPXEN1M4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xseCeCDzbA4EoyFE5hz0J2Ap84th4Tv5OqmdPQu4Af7IBCHUI
	AKGz79HbpPYcYu1cO03YUW+KNZpv5fa7wQQgpkWXKze2NVus8fnTXjU9
X-Gm-Gg: AZFdTZchFdz7y7RkwGDBE5EClNEXpSRjXnwm8H2m16gUTKJyXHii4NBs3jBYJrrAbbu
	ftAoMqisc/RMWf4F6rTkYgVwYWYq7r24QH/sJM8qly1WveoCHPx0XEltpO3HeqHkZArfKRhDR5/
	q0/RrH1qvC3+yeSadS1Ov8lXy22eiLNIvyoAn0DiSKW9ij8wYBUKX1WUhA2HdAKVkBrjxNxNKEw
	mlbOoEWiW82DoOscb5CW7kz7N0MOcilakq4QhLs5eBOISw7ANyAxcN3v21/SpTPTq/WgzyOXjf3
	Cx8K9+74RxIGdubx22jhpsgWaJnASDILZEDe+B7v21gFJ2TAOUFuKq1IXxl1718oI2NGFnCbYmp
	uOtAFUi+Ej7lTX60gzhJkhVJIj570/uYgYV5BgQy1NGU5ZWVXNtGOZ1hRL2LgPz9g5aaQYur+sm
	N5HqbguJ1+GTwAoUz6HryFerp9baBXKcld0w5n0Dv2GPvomTC5IH/NkAGsf/u00WGaGm/BLmaxI
	E7F6sNEsvSEZ/ucLypp56z7K+RiTqCUPX3v3dSxsz08ylA7dZyzvjmy5PYkvVAq+IoN9lULYbzv
	e9FHsFoiTm+7OA6oOP5DDCOJYcHpljOf8l211GeObDidk5U8t4TgbdpHhv7d
X-Received: by 2002:a05:7022:ea8d:b0:1a7:216d:157c with SMTP id a92af1059eb24-1b556902db6mr18127873c88.34.1795619391089;
        Wed, 25 Nov 2026 07:09:51 -0800 (PST)
Received: from LAPTOP-LJ15R92N.localdomain ([152.58.24.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm41950101c88.2.2026.11.25.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:09:50 -0800 (PST)
From: Akshat Rawat <akshatrawat095@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Elena Popa <elena.popa@nxp.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Akshat Rawat <akshatrawat095@gmail.com>
Subject: [PATCH v2] rtc: pcf2127: fix regmap_config corruption across probes
Date: Wed, 25 Nov 2026 15:11:08 +0000
Message-ID: <20261125151108.423-1-akshatrawat095@gmail.com>
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

Remove the static qualifier from config in both probe functions so each
device gets its own initialized copy on the stack.

Fixes: fd28ceb4603f ("rtc: pcf2127: add variant-specific configuration structure")
Fixes: fa78e9b606a4 ("rtc: pcf2127: fix SPI command byte for PCF2131")
Cc: stable@vger.kernel.org
Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>
---
Changes in v2:
- Reword commit title to state the bug fixed rather than the implementation
- Simplify to dropping static from config in pcf2127_i2c_probe() and
  pcf2127_spi_probe(), as suggested by Hugo Villeneuve (note: checkpatch.pl
  warns that struct regmap_config should normally be const)

Compile-tested (x86_64 gcc 15.2.0, W=1, CONFIG_WERROR=y) with
I2C+SPI, I2C-only, and SPI-only configs; not tested on hardware.

 drivers/rtc/rtc-pcf2127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 27c5fb9b2aaa..d9ac2dbb4023 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1455,7 +1455,7 @@ MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
 static int pcf2127_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
-	static struct regmap_config config = {
+	struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 	};
@@ -1520,7 +1520,7 @@ static const struct spi_device_id pcf2127_spi_id[];
 
 static int pcf2127_spi_probe(struct spi_device *spi)
 {
-	static struct regmap_config config = {
+	struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.read_flag_mask = 0xa0,
-- 
2.56.1.windows.1

