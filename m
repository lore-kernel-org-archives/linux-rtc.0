Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B304C652E
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574458; cv=none; b=nkF+DxIoMeMNTlcJfATgtFpOdMAQV79zNQPTwXAPJiEU6AHVjJeW0KQZZvcgwIlbJQKtVjfj/b3PvjzCwaMUTP6LpapvGuGU1LMtloocRejDKB3yehjElChKe3ufaHGzomZorDj/gueKe1KI7IJ9iflM3DAOTvjJdPycyx7mnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574458; c=relaxed/simple;
	bh=UeH8IT8dr/3TVi3DglHaZFIOqlvZBpR7RvdSiyHbxgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOwrUNlOvesv0ken9AhuiS+kCKMhXVZ6aD4CKDgdwJUOUUxSNCFhZvXmsUkXUNJBS+voC4pJxe7A6dJ5tTtk9xrpf9WgUJ/dkcHXlIWbZ1XW2HByiEQ6GFMPUqncxR2f0foZz1wCCybg78TClPGDZrr3GrjJZqm2houiLzY/Lik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=YYkfdlft; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YYkfdlft"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 04954240105
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 18:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789574447;
	bh=OfhCcDimQydckibdghCTJJWOOyfGObrpnuJon29Aw7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=YYkfdlft0hBz+D+m3ZRXe2eC/EW8YO1GHlNkfSEjaOkiWKvHLmXCfAqbWdxNHRriW
	 oasAPmYXKkXjbBX//KoutcNrzUy+h8DGgnLYlthBtyEd0JeH5L2aN8couMOdddT/OG
	 oxonl/+ph1UdoSZ5wbz0ili870hp5swSCQYfkG0evexgD4cpB3kgin17wKKzfr5zIi
	 P0lLNYRAd4wNycQmT6s9x8deYIrwndmUKPdOlytDrfLCW0c25zgf2u3B354VD6pnVl
	 a3i2kVVCvA7iaM/L940NPwkOYzZSzY0WFZcYOsgAU88A8A8K8FyofJZql1znRGpK+7
	 z2RlSJ30COKVg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hlNs727Cdz9rxK;
	Wed, 16 Sep 2026 18:00:43 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 16 Sep 2026 16:00:45 +0000
Subject: [PATCH v9 6/6] rtc: s35390a: Add synology quirk
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-rtc_s35390a_int1-v9-6-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
In-Reply-To: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=UeH8IT8dr/3TVi3DglHaZFIOqlvZBpR7RvdSiyHbxgg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqqr0fecYk+1B3lD3RBeXyAiZ31ZaxIfLWZaoTJ
 PjcAwjGi6OJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaqq9HxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9J3sw/8DXsuT9zEamOZXeF9s+YO7W/7BTPWppD
 xwP3HetzPqyTrK8SudraRoe8E8qqpeMf0AQqT+0paazq8WJclwJOX/s7JcSc1VyK+vo0SE6Am0X
 xNBSnUXcjJ2KEGuBzqE9v9S/JvXr3+kexQCDWHZnT+fYl9QC8A1ASuFmvXxowllOfL6ZwROJjEY
 2ZE2SXcDIf5/11DowwKmfqqpJHDhsT/1BS+DXukw3Zo6rdjEEpzoIM2hIgXWkBWydtpq4t+Gr2O
 Wc99pPMBGXNtHGyCmg3J8HpNSI/MCGYyCp7dc06y2TSPDVoEn7vJdkOFPvybz/aZ5hRZMtLMjBn
 qGUs7M9UYkV5EWc9xp9qrhtIXXb406AVwsNxEjEDUzj1IySm8YeB8rYsh8EPZvfJwv7cKvIbu0l
 JXAY33OAswForhIQQMuvxIhqRGTeivpExDQH68kQR9xK3WXmLcCbUEdPGcezbDj3v3W4mPiPap7
 g1feclPWFLb3ws8qknEy4IkyccM24K/IOci/IGOLk6Eh43/7RH/ihGE09uneEZtMmmUdpXKvlsL
 /9/LLconOA5/lPD1kGe3dvVqXAaCspFreIYQPQKE2ydtKw1VPrWzNZOkBEk4sDp0AVF1SBPStCH
 4vR/DL9mRbyqA1nceEcWhPktY5M1cVFgReH9K4y/FKZ0BBZpUAyA=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
it is not possible to configure pinctrl.

Use interrupt signal 1 for wakeup if no pinmux function has been
configured in devicetree and dmi sys vendor matches "Synology Inc.".

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 649d36d37f1f..d3e829052927 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2007 Byron Bradley
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/i2c.h>
@@ -778,8 +779,18 @@ static int s35390a_probe(struct i2c_client *client)
 		return dev_err_probe(dev, err, "pinctrl enable failed\n");
 
 	/* If no pinmux function is defined in DT, fallback to previous behaviour */
-	fallback[0] = S35390A_FUNC_IGNORE;
-	fallback[1] = S35390A_FUNC_WAKEUP;
+
+	if (dmi_match(DMI_SYS_VENDOR, "Synology Inc.")) {
+		/*
+		 * Synology uses interrupt signal 1 for wakeup. Since pinctrl cannot be
+		 * configured on ACPI, we check against the dmi sys vendor.
+		 */
+		fallback[0] = S35390A_FUNC_WAKEUP;
+		fallback[1] = S35390A_FUNC_DISABLE;
+	} else {
+		fallback[0] = S35390A_FUNC_IGNORE;
+		fallback[1] = S35390A_FUNC_WAKEUP;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
 		if (s35390a->pinfunction[i] == -1) {

-- 
2.55.0

