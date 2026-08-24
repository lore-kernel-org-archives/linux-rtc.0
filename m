Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C49408600;
	Mon, 24 Aug 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569525; cv=none; b=M5tjbPX6FkfN32Hj+Nr0j6DrVmj2gi/NVxLuJ4ZMmYdD0TscN1veUk8jwAw/oZofjgokhbbTKT2W45KadP/P27RDu0YgSII/Fy6BxY4E6geaoaQIJkjUBt9w2d/zbrMQcsXlRm0YSnh/H+LtzCQVkE36ip6ERx+0k0atAGU5gbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569525; c=relaxed/simple;
	bh=AXXzxZOVFVp5X1iXfysEhnZiwNgzRYwKDrjFSlNasnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKz25CsnoCNuCEttMyHzPfgdu8pZcvcssCf1fmpj36CzgyQA8SD4Y0Pq7Ge8EybcoK4nnLu+Torx8euP8nWHcek7WxmFNX7iovIh+n8TVs4AeAj2S+3jagEaQBhwqDLQRO4CR+OusGQbsJFtnO9FfHOfJD1eA7yPPjCyyN+G3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=dkkwqBDe; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="dkkwqBDe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2699611C980;
	Mon, 24 Aug 2026 13:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787569518; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FpxiEYtnqxJP+VIz0Hk8ir5Iu/kohRwyYSXoTqAl+wA=;
	b=dkkwqBDe+BhPACZyI9OiUnSMt++SYY1zPOojETSH37sBsnrZKWHZQLyQLCoMvpOL9PDfPi
	XwhXgzMMwGBodlUwfduQdScsVgmBTpfwmPC2whAVhs3VL1ILbH3Os5YY/NCKpl6gOR6IKj
	liL7ctdJBzG3SBdbmLICyazY17ggTXd0o/aDM5BYQkatxr80BtQx7+wiXuk4kfsKZptnLY
	5Yz1ogauLepkyCQ+XOmQwjcqzHaPD1MWWDKSmdOaFhOjSNd/vrLHSwp5UFpUfsfomGOR5U
	UOMkAD0TlDROQ6EP26ZXOCni5Mmxrt1TnsSzCXv2D0N+XldzYD2KVhoMfrXTcQ==
From: Heiko Schocher <hs@nabladev.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Heiko Schocher <hs@nabladev.com>
Subject: [PATCH v1 3/3] rtc: rs5c372: support eco mode on R2223x
Date: Mon, 24 Aug 2026 13:04:26 +0200
Message-ID: <20260824110452.4038870-4-hs@nabladev.com>
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

The R2223x can run in an eco mode that lowers its current consumption
from the backup supply. Enable it when ricoh,eco-mode property is
set in the device tree.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 drivers/rtc/rtc-rs5c372.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 30e272d65021..41d391bf07f7 100644
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
@@ -802,6 +803,24 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
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
@@ -898,6 +917,13 @@ static int rs5c372_probe(struct i2c_client *client)
 			rs5c372->time24 ? "24hr" : "am/pm"
 			);
 
+	if (rs5c372->type == rtc_r2223x &&
+	    device_property_read_bool(&client->dev, "ricoh,eco-mode")) {
+		err = rs5c372_set_eco_mode(rs5c372, true);
+		if (err < 0)
+			return err;
+	}
+
 	/* REVISIT use client->irq to register alarm irq ... */
 	rs5c372->rtc = devm_rtc_device_register(&client->dev,
 					rs5c372_driver.driver.name,
-- 
2.55.0

