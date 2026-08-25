Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514293CFF6C;
	Tue, 25 Aug 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642391; cv=none; b=NawFvVSCEQY72jV3lMPEZT3oai1A2uEFhDi/OAeFObySLzIxO/CFJbXStdEe5jopsFUzPBkev2YNSRaWNthUzpfZ6AOHmkKi96RZ/Qbh+QfJYugSfDk9vXSDsxOKSOO6jMT7Q1BGrzr+XhRosG0ml0fHaJeqNCxLRQYS4241cu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642391; c=relaxed/simple;
	bh=85P/R5gcif35u3BDK1lWztpzNfA68IzZXgV7sHTiI5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ2Uuj65UikOGmgt46nmzzBqjXKYQFuhBsqoAaLEUN1ZyFD69XQ6lT4zc2s0WchCiW7W5F/aU4YU8MKcKlQ0DL9aVGlUhw9rG0n2c90tEg+t9sKFtureySVl6dVtL6JuyQKzzLk+mJcpRSliZ1ZkTtPL/CajWTs85TH5Nkzaw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RR4M+vhH; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="RR4M+vhH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4EBE11CC1B;
	Tue, 25 Aug 2026 09:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787642384; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qc/xQJmsi42iCIOkJ2wF2iMJ9+EWHiTHbIMYFOtTR9I=;
	b=RR4M+vhHhH9nrx9bHBtybt4Yzk/2+61NKX3oRzWxwIV28CWfkA6Qc9uyC00Nq5NRZu+LU6
	Bf/T1BZ7IVbIKasLx2vM/yhXw6KHCNh4lOUt5oTkplmxC6tFeJ9JwABTuJUU6YuMI/r17x
	JqP4xUk1DQa0SpP6jmnN+2EPok87/L0qXiu8TCERcqdf5K/x2bBJ3+fpGCKVzfXV2SMW7v
	E45dDRnM6d/dit13GH/GNbznQ1icy/yJE5bv0bXn6B7qrRSGdMu+DF6yp7WeSi/HvjH44z
	jAQ2Wp7TcOViD0pvhTjt9cFw2t8xUZ/iiQo6w91fOVTTqqbGBcemwTV/wRD0pw==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-rtc@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v2 3/3] rtc: rs5c372: support eco mode on R2223x
Date: Tue, 25 Aug 2026 09:19:18 +0200
Message-ID: <20260825071927.4090460-4-hs@nabladev.com>
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

The R2223x can run in an eco mode that lowers its current consumption
from the backup supply. Follow the ricoh,eco-mode property from the
device tree: enable the mode when the property is set, turn it off when
it is not set, as the bit is in CTRL2 register, which is backed by the
same supply and keeps its contents across a reset, and no other path in
the driver touches it.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
- Fixed results of a local run of the sashiko review prompts: apply the
  device tree setting in both directions. v1 only set the eco bit, so
  the mode stayed on when a board dropped the property.
- Leave rs5c372_probe() through goto exit like its other error paths,
  instead of returning directly.

 drivers/rtc/rtc-rs5c372.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index c65b76cc0dc6..9ab6f2c28f7b 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -52,6 +52,7 @@
 #define RS5C_REG_CTRL2		15
 #	define RS5C372_CTRL2_24		(1 << 5)
 #	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
+#	define R2223x_CTRL2_ECO		(1 << 7)	/* only if  R2223x */
 #	define R2x2x_CTRL2_VDET		(1 << 6)	/* only if  R2x2x */
 #	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if  R2x2x */
 #	define R2x2x_CTRL2_PON		(1 << 4)	/* only if  R2x2x */
@@ -807,6 +808,24 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
 	return 0;
 }
 
+static int rs5c372_set_eco_mode(struct rs5c372 *rs5c372, bool eco)
+{
+	struct i2c_client *client = rs5c372->client;
+	int ctrl2;
+
+	ctrl2 = i2c_smbus_read_byte_data(client, RS5C_ADDR(RS5C_REG_CTRL2));
+	if (ctrl2 < 0)
+		return ctrl2;
+
+	if (eco)
+		ctrl2 |= R2223x_CTRL2_ECO;
+	else
+		ctrl2 &= ~R2223x_CTRL2_ECO;
+
+	return i2c_smbus_write_byte_data(client, RS5C_ADDR(RS5C_REG_CTRL2),
+					 ctrl2);
+}
+
 static int rs5c372_probe(struct i2c_client *client)
 {
 	int err = 0;
@@ -903,6 +922,15 @@ static int rs5c372_probe(struct i2c_client *client)
 			rs5c372->time24 ? "24hr" : "am/pm"
 			);
 
+	if (rs5c372->type == rtc_r2223x) {
+		bool eco = device_property_read_bool(&client->dev,
+						     "ricoh,eco-mode");
+
+		err = rs5c372_set_eco_mode(rs5c372, eco);
+		if (err < 0)
+			goto exit;
+	}
+
 	/* REVISIT use client->irq to register alarm irq ... */
 	rs5c372->rtc = devm_rtc_device_register(&client->dev,
 					rs5c372_driver.driver.name,
-- 
2.55.0

