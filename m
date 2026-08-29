Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156C3ACA5B
	for <linux-rtc@vger.kernel.org>; Sat, 29 Aug 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013394; cv=none; b=X7J9RVcjjHXKK0BpXy3JSbcGkz1NANZzNxtWGflcAZY3v6r1RBc3f0ecDXU8TNDk1CJQ2z9VLqclX1BHGz/7ZDckM0XSDE7j6nHnSF7Vz0qkN0mMAEFB0CmtZp8ha7GMW7AoUISFkiMI1XankexIOTm4UNl8ILXvvtZtiQm3aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013394; c=relaxed/simple;
	bh=M24Mz218ImJKt0KkgI5/Aj2azuDGtFNwOJqCp02b7jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfIJVNUoclzpD69BxCFloZB94iBNuYIcUBx84oRsYC4rpaIkgz1prUiJeGe/VYQn3ZipqF/GurtWskMDZfPe4h44AWAwJfe0D8W5O0ecN74WzQUlQP48fDfbJyQ/Q+Ws/9S4I28YWxz0DVchBqM1UFxRYWfA16Y0zFDeaGA8STI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=imtzIf/O; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="imtzIf/O"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C690D240028
	for <linux-rtc@vger.kernel.org>; Sat, 29 Aug 2026 16:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788013382;
	bh=Vny3X+6YwhmSlpKhlU7/WA6I3FFRVj0JW+94btVUxuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=imtzIf/OCYNkjAjjTkp4DlTbYlTqI4gcfXmtKk2eahqG/A5MphLtXVBEQV3uWzr1P
	 23FrajcbjXdsRb17YpPuy9GOy5nv7DVM4UAd63+Vge0ZPwmHKrvYCi7JlBCqMvWJj1
	 4krImG5o4iQLrKEOrMNmObii4RyxllKstABCl4Y0Rs4l6DkrR9gWioxP238xALctxB
	 T5vNxYne7wc6EtqUl+NhFnDH00zIXd1LSWCBBO7cDsRs7qiPQ6BrvUVEIc1W+vo0NQ
	 aazXMaedRuhVnQ54dM7XQqpvOFeYHdjY/h+LETiL9kdLcZ7lSlKyW0q56Gdo5komoI
	 IReT521EhxfHg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hXHXf6tlpz6v38;
	Sat, 29 Aug 2026 16:22:58 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 29 Aug 2026 14:22:59 +0000
Subject: [PATCH v7 6/6] rtc: s35390a: Add synology quirk
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-rtc_s35390a_int1-v7-6-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
In-Reply-To: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
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
 bh=M24Mz218ImJKt0KkgI5/Aj2azuDGtFNwOJqCp02b7jM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqkus+heprlaHloBu5NQiKtk7+FGyvRlrumONr1
 mVEsW2uLCWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCapLrPhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JtlA/9ER3qaF8lUylr2eTx6R4Uvv7WSqQj7Oj
 re6uFDpyskTO51xuWjt1rBQL0LZuBomVyXjmigFs9gSM5lR40gDaAqKY0ksgEv33gfe3W27ISZg
 EOYGzRMnHcisHJuo7OUSXYczdrn0JEOIRcst/maOEGK9ev2HGitiBsMOq7JFEHBxH6OAvBMLwgI
 W/jZ68Eq8dVKjOPW6Z9dVQNg1UDJo0kVEBABAv8OJ9duT/ZNa8A/1n03mLriXTxbvGG0LhlFnTg
 noXLbqoB8MeN3RGZ0qHuS9ZriN9D8mPdkwpiRoevxM98JtgWR43Mkb/1BDauTFsww4sho05Z2DG
 ziQYghXjdrB5X0aDJ6BAZrGzLWStt8T2J6r2PQIDo/fQGrLcy6K+NHunslcX6tZHakCIBe4LGe/
 Z/RbQB8t6cVgjw92WR0v7nZYT71e2i86vxtEKNp92uONgKLo6bEk8o6qJLyY31A5MqM3rkEwZkW
 1P7E+7B8Dv3gtBYUQk/gsVBBGGYtsHw3hbP/iNs56/yGA4IYJOvg6LCOCxuqYhDYUdo1thm/44L
 s2n4Wq98Q1fcpnaF44rkUYaAnHGC423t+51jxRz+0S0C2bBmi6NqLjwURiPLXe2qK5lKRLo7I/a
 Uu7dgDK0IwqVTpfCOLlUazM1KY55Ih5Yp5jBUIN3FdGlDqiUL6TE=
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
index 66ae58ac06dd..860977fbae87 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2007 Byron Bradley
  */
 
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/i2c.h>
@@ -780,8 +781,18 @@ static int s35390a_probe(struct i2c_client *client)
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
2.54.0

