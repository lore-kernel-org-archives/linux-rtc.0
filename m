Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D83B38AA;
	Tue, 25 Aug 2026 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642387; cv=none; b=KBd+Bff+ie1YJUFGIMN8hYoPnI6p1DZhR1I+dRMfABvBAVWVUbOZWHYNccVPSPnXfGrL6y5Eh6Ce7SZgmUuXy61Rvn/88lBf4ZXyxD0Tw4rLZ8En0waz2o/REHAFbWBt7bNCKeXu+0VyNqXu577PEBsk9nnpOPjQdcvnnpCCe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642387; c=relaxed/simple;
	bh=64tTLfUjsiOKasoYzG6gDsbRAPUK3rskVkMUqYWNZKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d04KPNhRiam3kf9gAjq6uS6ldyKvhtFdejSz3hJIv9u9AZbUkr68yk9KzfR2iDjhyGwXyvUXPIooXdRfVqBJ3dCewfDycRXQnXlr3iEXm6VD89ckfs0A7++foWPeVISGibft5MpQR0grDkHUIZfIcyDUPsO2FQcqckjbhXHnZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=FJP0j+rM; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="FJP0j+rM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EBFF11CC16;
	Tue, 25 Aug 2026 09:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787642379; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GeNCEPrxHWtAS5ptxcQfWjWwOtPD6ysK/kV9MqcdTzc=;
	b=FJP0j+rMYXffqUNEJl9kOslemhWBUC2XStSVvAzDq6OZTSLAlnFW8Lp3SDO5XjVm/A0xET
	OGP5ArjLpK0lFUVUCsUJFXTe3J+usgnIs9BcF8MQ1Jx9lKQdvemtDKJMVA21LcCeVrFljz
	vG+K+Xn14TcgTYTfqAVb3KmuktPHySdSjGfRGgRMBIleJ//M/6iGjRPzWaOyqS1y0k7Dyd
	rdLkfj1UkYzet1AFnvI+Brh9AogPFjQw7pJZ52KnIzRld6o3d53C6tniYGYy+/vt+HrkEU
	JRpvV0igIcVyKTZLxKnWzzR0K6DRTR5dBkmnoQrOenlJzpzIbeVgXHuLljjstQ==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/3] rtc: rs5c372: add support for Ricoh R2223x
Date: Tue, 25 Aug 2026 09:19:17 +0200
Message-ID: <20260825071927.4090460-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825071927.4090460-1-hs@nabladev.com>
References: <20260825071927.4090460-1-hs@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The R2223x is an I2C RTC from the same family as the r2025sd and r2221tl
that this driver already handles. It shares the R2x2x control register
layout, so treat it like the r2221tl. The oscillator interrupt flag is
reported through XSTP, and the 24 hour mode bit lives in CTRL1. It also
has the DEV bit in the trim register, so same as r2221tl.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=2
Closes: https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=3
---
checkpatch reports on this patch

  ERROR: trailing statements should be on next line
  +                     case rtc_r2223x:        s = "r2223x"; break;

I did not fix this checkpatch error, as the whole switch statement uses
this format.

Changes in v2:
- Fixed the sashiko review of v1: handle the new type in
  rs5c372_ioctl(), rs5c372_read_offset() and rs5c372_set_offset()
  https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=2
- Added sashiko review for patch 3 in this patch, as it fits better here
  https://sashiko.dev/#/patchset/20260824110452.4038870-1-hs@nabladev.com?part=3

 drivers/rtc/rtc-rs5c372.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 24bd795d9d95..c65b76cc0dc6 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -68,6 +68,7 @@ enum rtc_type {
 	rtc_undef = 0,
 	rtc_r2025sd,
 	rtc_r2221tl,
+	rtc_r2223x,
 	rtc_rs5c372a,
 	rtc_rs5c372b,
 	rtc_rv5c386,
@@ -77,6 +78,7 @@ enum rtc_type {
 static const struct i2c_device_id rs5c372_id[] = {
 	{ .name = "r2025sd", .driver_data = rtc_r2025sd },
 	{ .name = "r2221tl", .driver_data = rtc_r2221tl },
+	{ .name = "r2223x", .driver_data = rtc_r2223x },
 	{ .name = "rs5c372a", .driver_data = rtc_rs5c372a },
 	{ .name = "rs5c372b", .driver_data = rtc_rs5c372b },
 	{ .name = "rv5c386", .driver_data = rtc_rv5c386 },
@@ -94,6 +96,10 @@ static const __maybe_unused struct of_device_id rs5c372_of_match[] = {
 		.compatible = "ricoh,r2221tl",
 		.data = (void *)rtc_r2221tl
 	},
+	{
+		.compatible = "ricoh,r2223x",
+		.data = (void *)rtc_r2223x
+	},
 	{
 		.compatible = "ricoh,rs5c372a",
 		.data = (void *)rtc_rs5c372a
@@ -221,8 +227,10 @@ static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	switch (rs5c->type) {
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		if ((rs5c->type == rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
-		    (rs5c->type == rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
+		    ((rs5c->type == rtc_r2221tl || rs5c->type == rtc_r2223x) &&
+		     (ctrl2 & R2x2x_CTRL2_XSTP))) {
 			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
 			return -EINVAL;
 		}
@@ -292,6 +300,7 @@ static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	switch (rs5c->type) {
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		ctrl2 &= ~(R2x2x_CTRL2_VDET | R2x2x_CTRL2_PON);
 		if (rs5c->type == rtc_r2025sd)
 			ctrl2 |= R2x2x_CTRL2_XSTP;
@@ -511,8 +520,10 @@ static int rs5c372_ioctl(struct device *dev, unsigned int cmd, unsigned long arg
 		switch (rs5c->type) {
 		case rtc_r2025sd:
 		case rtc_r2221tl:
+		case rtc_r2223x:
 			if ((rs5c->type == rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
-				(rs5c->type == rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
+			    ((rs5c->type == rtc_r2221tl || rs5c->type == rtc_r2223x) &&
+			     (ctrl2 & R2x2x_CTRL2_XSTP))) {
 				flags |= RTC_VL_DATA_INVALID;
 			}
 			if (ctrl2 & R2x2x_CTRL2_VDET)
@@ -527,7 +538,8 @@ static int rs5c372_ioctl(struct device *dev, unsigned int cmd, unsigned long arg
 		return put_user(flags, (unsigned int __user *)arg);
 	case RTC_VL_CLR:
 		/* clear VDET bit */
-		if (rs5c->type == rtc_r2025sd || rs5c->type == rtc_r2221tl) {
+		if (rs5c->type == rtc_r2025sd || rs5c->type == rtc_r2221tl ||
+		    rs5c->type == rtc_r2223x) {
 			ctrl2 &= ~R2x2x_CTRL2_VDET;
 			if (i2c_smbus_write_byte_data(rs5c->client, addr, ctrl2) < 0) {
 				dev_dbg(&rs5c->client->dev, "%s: write error in line %i\n",
@@ -554,6 +566,7 @@ static int rs5c372_read_offset(struct device *dev, long *offset)
 
 	switch (rs5c->type) {
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		ppb_per_step = val & R2221TL_TRIM_DEV ? 1017 : 3051;
 		break;
 	case rtc_rs5c372a:
@@ -600,6 +613,7 @@ static int rs5c372_set_offset(struct device *dev, long offset)
 		}
 		break;
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		/*
 		 * Check if it is possible to use high resolution mode (DEV=1).
 		 * In this mode, the minimum resolution is 2 / (32768 * 20 * 3),
@@ -750,6 +764,7 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 			return ret;
 		break;
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		if (!(buf[1] & R2x2x_CTRL2_XSTP))
 			return ret;
 		break;
@@ -768,6 +783,7 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 		break;
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
 		buf[0] |= RV5C387_CTRL1_24;
@@ -847,6 +863,7 @@ static int rs5c372_probe(struct i2c_client *client)
 		break;
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
 		if (rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24)
@@ -876,6 +893,7 @@ static int rs5c372_probe(struct i2c_client *client)
 			({ char *s; switch (rs5c372->type) {
 			case rtc_r2025sd:	s = "r2025sd"; break;
 			case rtc_r2221tl:	s = "r2221tl"; break;
+			case rtc_r2223x:	s = "r2223x"; break;
 			case rtc_rs5c372a:	s = "rs5c372a"; break;
 			case rtc_rs5c372b:	s = "rs5c372b"; break;
 			case rtc_rv5c386:	s = "rv5c386"; break;
-- 
2.55.0

