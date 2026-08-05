Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B03E0080
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958370; cv=none; b=Mrz1fFefhCorvLdE/Y1dQtjQ7P5X44OmY5iJTPAjlLE7sEubsAgAhNQR3K4N6pEkE/SzVQTzAROqozMnmtSg9WvSayTd1TSzPJZ1LMhU+fKWlcg/CqUO+a2sOWJrHAzv/oD9eBL5zI4YZJHCApmzONioYlcWeVU+0Rmqxvf8R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958370; c=relaxed/simple;
	bh=6wArxx1l8Hm9Dqx4mugbk8wsFGsXoxVI7ksSr89OEeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoTRFcWQRD3vP0A+byOSqL9QUNUoaXNySYDXtUnOpyp1Yy2mvGlCKqBv2h6+KEct6NEDKKsFb6HwEFgGitTXLbV00MN3xBrsF4522Zt+aHrcLkUJOMNytO7dZpk0JOXb6cjU3b4+WyBTue1HqvtQ8nTTt0o4eMNdKjgKmiHRyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=EgVyNUWA; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="EgVyNUWA"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EEF6D240104
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 21:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785958350;
	bh=/IrZMEnYMWz3cHmLNm2dkUh37mtplEA3JG88ye8+6jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=EgVyNUWAgSNI7TGxiW5Er63huSy6ETJH1XVOF/S0PNJH8zbnR5Vk4pekALIPE7vLN
	 nZU8BE6zUAHgqPSqZE/41YWgd5g8G6jzbbJYdq5Z7HHDxN/HvWeH6sr8yaStGWMcEP
	 ql5hr0ccS3lfdHSTUM8e/+Db+vBzWx+YLu0eqIiPlE5LRPQ1Do4V5blf7T1jbAM1RB
	 aeDsl+9pVi2Jg43ClgThj+/PBQTQj4K6r8agN1r5752ZZ3JgeSiJDprCJ5nsKYE4lM
	 STyOkwUnVyYUAelism7pMeeigkEJFsTSGALFowyj5RmfqL3ZumCz4+5AUo6rIIcVtV
	 9BZQ4uWyO6G+A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hFgXr4lJpz6twf;
	Wed,  5 Aug 2026 21:32:28 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 05 Aug 2026 19:32:29 +0000
Subject: [PATCH v3 3/5] rtc: s35390a: Fix alarm not disabling
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-rtc_s35390a_int1-v3-3-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
In-Reply-To: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=6wArxx1l8Hm9Dqx4mugbk8wsFGsXoxVI7ksSr89OEeg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqc4/G8UFEgIUIj1dxW5fXqz5P2FhwjmUfsNPzG
 L3BQP87DfyJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCanOPxhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JkMQ//VUG7xlXHpcWrxeNCe/jaspdRDOeVzi8
 ptENaq5YFWo4i2dsiIfEizlEusdgLNg1RfF0qlTfJ35L2c0ZAfJe54i2feKJOLInHMlCluHh/ia
 wpJG6RVDIGEP4slQQYd0jNU8VQuQYhG28ckK879WdcMFAH0DgAWidxWRT7c50znjTfWVoIFfA86
 d+oommVuI+d0y2Gl588xQmsfJDXr3YJNdwZLS5x5RZ4ir16FWCte4bk80iP4SeL6W66I3ENGUxe
 EdP1K2gBYorQYWm7YKBpUeEDrvT7YPM9RKE3OxM8l+ZvJRHUGY50ltpz9FjaCeMtPhPk5cbltx0
 jfPySCcF+AIFYijQ2RlRSlIxcqVqWVqMbhvwln8GeywNVhyucCKqdqQA+UKVk9z+7tme4+1m6eP
 3VGUOiHlLyTjJGyyw+k2JmZHMx2tB4M8jdDDMJeolSgDycDihbTY85m8c3m2/Y+0nD4gldA+7zU
 KdCk+Pwmn0iD0lVRzkfumWlmYrgB6YeZg4gYLqt+srxXFeQ7Ccv6in03L65D8om2z1mNtQd+HIW
 FAyCS+VpGpqfwB/CTksG1ekYOY2QPTZM2auaH7A2VtT1ry8iQmGgywS6108afBIGOo6CsMlQRp5
 F//zqehHOwsp7AAScuiQzWsqsV1kO8Zm/x8yAd9/lfGh4CiUY/VA=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement alarm_irq_enable callback.

Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support for rtc-s35390A rtc chip")
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 4cfe7034c516..575bb256eb25 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -270,6 +270,24 @@ static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct s35390a *s35390a = dev_get_drvdata(dev);
+	u8 sts;
+	int err;
+
+	if (enabled)
+		sts = S35390A_INT2_MODE_ALARM;
+	else
+		sts = S35390A_INT2_MODE_NOINTR;
+
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -410,11 +428,12 @@ static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
 }
 
 static const struct rtc_class_ops s35390a_rtc_ops = {
-	.read_time	= s35390a_rtc_read_time,
-	.set_time	= s35390a_rtc_set_time,
-	.set_alarm	= s35390a_rtc_set_alarm,
-	.read_alarm	= s35390a_rtc_read_alarm,
-	.ioctl          = s35390a_rtc_ioctl,
+	.read_time		= s35390a_rtc_read_time,
+	.set_time		= s35390a_rtc_set_time,
+	.set_alarm		= s35390a_rtc_set_alarm,
+	.read_alarm		= s35390a_rtc_read_alarm,
+	.alarm_irq_enable	= s35390a_rtc_alarm_irq_enable,
+	.ioctl			= s35390a_rtc_ioctl,
 };
 
 static int s35390a_nvmem_read(void *priv, unsigned int offset, void *val,

-- 
2.54.0

