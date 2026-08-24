Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800240910F;
	Mon, 24 Aug 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569523; cv=none; b=MExitnVl4/7uxu7PVx4IE1erxx7moIHFuaHjxIPH5djn5OxckqdsEzpHaZWWyvZDJ0wdTSgfCUtsYv0aThPchOOhgIDm6glIr42akGEjdJ47mGhoqQYyr4USO0PduPYLv1n43yJ345x3WAoDy65oq1QDyNJRdnGvCLJgJknbJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569523; c=relaxed/simple;
	bh=GcuzZzMgXlZr7Ml9+AjMGUPaMcuUnnrgM239rBKAJvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyPqOCsh3XylS1L86VLvvm0tB4fGNlAg50bonfGj4JP1/XScJ0b9pUctwRTS/aNVDx3B/GtvP+ow6FRNJCA9yHKAUfBHlJNQkOK/S60ZD5OnUunBC8xZJy4HfM4hSwxTHowCAjW+xtFNPI/P8T/mzopsYCoMTeQGIv5y7Nq5AWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Lw/0z+Ht; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Lw/0z+Ht"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 711F411C977;
	Mon, 24 Aug 2026 13:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787569513; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QPTqfBjTjo/ZWOB0b3uKN9Svl/mVme7DBSerj9nAyI0=;
	b=Lw/0z+HtvZSy8g9TvvQEYk8jikzozYyeFMFewaXQ5TSKCeg4ejxwBYBvXUsDCUj0KQuu+N
	Gv6CxKjTKr7iaKhN5uwh4JsuV3CC3NSLzBzu0IvKZVUal+Jyvj2CpgSYMUo15q+RfLlvh2
	as3g60xhFS09ugEM4Kb2P/Bv+K1jDKDFugWS7VaN+6wS/SUSYksr69HNUy3ltWKBQ0DCsj
	eVWqFObfD4+FMSmhaL8OAOZtPu/6rjyjCL4TcvkkAj7Cmw25nVlqwLQkUd9pkXG1F0ERUM
	tJsilKZ+w0h1Gkj5rOp+v3/qeaDkrSi1QBgbitw028TeSF+NvMg64VfHO4MtJw==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v1 2/3] rtc: rs5c372: add support for Ricoh R2223x
Date: Mon, 24 Aug 2026 13:04:25 +0200
Message-ID: <20260824110452.4038870-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824110452.4038870-1-hs@nabladev.com>
References: <20260824110452.4038870-1-hs@nabladev.com>
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
reported through XSTP, and the 24 hour mode bit lives in CTRL1.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch reports on this patch

  ERROR: trailing statements should be on next line
  +                     case rtc_r2223x:        s = "r2223x"; break;

I did not fix this checkpatch error, as the whole switch statement uses
this format.

 drivers/rtc/rtc-rs5c372.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 24bd795d9d95..30e272d65021 100644
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
@@ -750,6 +759,7 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 			return ret;
 		break;
 	case rtc_r2221tl:
+	case rtc_r2223x:
 		if (!(buf[1] & R2x2x_CTRL2_XSTP))
 			return ret;
 		break;
@@ -768,6 +778,7 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 		break;
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
 		buf[0] |= RV5C387_CTRL1_24;
@@ -847,6 +858,7 @@ static int rs5c372_probe(struct i2c_client *client)
 		break;
 	case rtc_r2025sd:
 	case rtc_r2221tl:
+	case rtc_r2223x:
 	case rtc_rv5c386:
 	case rtc_rv5c387a:
 		if (rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24)
@@ -876,6 +888,7 @@ static int rs5c372_probe(struct i2c_client *client)
 			({ char *s; switch (rs5c372->type) {
 			case rtc_r2025sd:	s = "r2025sd"; break;
 			case rtc_r2221tl:	s = "r2221tl"; break;
+			case rtc_r2223x:	s = "r2223x"; break;
 			case rtc_rs5c372a:	s = "rs5c372a"; break;
 			case rtc_rs5c372b:	s = "rs5c372b"; break;
 			case rtc_rv5c386:	s = "rv5c386"; break;
-- 
2.55.0

