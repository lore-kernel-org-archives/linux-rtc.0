Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1F39CD1C
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958367; cv=none; b=Zy1KUBgJRmHjdMyILF+gQwK+y9k5gTQScBNv+UHbm1itlsyAK+JIWA6C9wMD6G2lS/1bpvqatorznyS09UW6A06tdMrJxsKvBoym3vRGZ1XXW5boKPYhLF39X2SNS/04eCx3P8M+SQNlww/hfO6ZbROFpTCJgLTZDCTafjvLpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958367; c=relaxed/simple;
	bh=+IeJdobYk33kbrWcmPukzeecuTpw5d70OaILFXM9AWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SD1YJ1rWKy/IlWFkMAb1ls5EvuVpEXmpNk3xDA5UrAKJ8BygOTeNCVGP3oF68+5ew9Rb4JUp1JEQY950iAc49hMFAZAZhUuDQOoQCvKRbs8KrzEM+N9sQrxJPiJ3zL3Rv36+715WwhY4IEdnnhYIbVlZ3NCA6sJB2+sYKEHNHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=M0i3nJs8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="M0i3nJs8"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 38EFF240106
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 21:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785958352;
	bh=w3OK+8XA5nJGzpoQM29xYb848dehbBe9QI/Kz3xljOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=M0i3nJs8++8Nbst6BcXxR9gwgpwGyP9KxBs9dC/pMxsvR80kMGPOKPwUQ4WMT7KJu
	 1qeizQOE0LirtDO/QeHHzpQ8H3Raq06bzADbzwTFuGvdRPVLC8ieZc00qXA3FT7hr3
	 3nz1uIhfkMxr+OJ9cCc28cfaI0JDt5FoNNxiMu1djEswGwnV/V4oEE7XTv9/JuHu2s
	 t94lGP45r1KII8V2pBls0L4hysUJF+baZzTN9emMJNzhyQynC/F2REKJ7RfUVn7veQ
	 EcU+yN7qQuNBSph3Yt5SbmjD+JCZnAOsP0fchMgY4egyVfld5gEHwf6Q4sIyH1DeBK
	 6jxhIvBZbde/g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hFgXt0Rmxz6trs;
	Wed,  5 Aug 2026 21:32:30 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 05 Aug 2026 19:32:31 +0000
Subject: [PATCH v3 4/5] rtc: s35390a: Add pinctrl
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-rtc_s35390a_int1-v3-4-e836faba3e25@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18472;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=+IeJdobYk33kbrWcmPukzeecuTpw5d70OaILFXM9AWg=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqc4/G/0NBQEKmo8gmwzYq1WgjEadrIvqiEsFf6
 wJaKK2gghOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCanOPxhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KOuw/9GTpx4U8ie41vKgRsCL0j1QspyCpfouy
 8hTuBjNV4J5lnR66bnVyGkZp9JkO+pgsTT8eTS4gMFmYBTGl6/HS34e+CQwP6Hl9hYvIAOXhgV1
 B1AgwjMtefG32ORBEm+sgd9eAvc7RfgvgBjL7Z7M9To0mJpDY24K/Bg00AhnssTWvWouWQhj/ZY
 bGBQaBpWi0zxggJJrv1kWhuv+P74eJsbKPevxTn8FF0qlyarltd5fWTRTHqlBQL5tuPPaAyCOJJ
 cXf4sUvsVtz9AmkV3PggiZsartH1AWJg8mLomYynFgoWhGYbZRwJRVVm0DtkdkojCS27xAz5JB0
 2prduzAhKzqLLbJuGTBpNAb7ZKTXcNdn8EcsyWfBNBbvLOxXRZahMRvOosqDAvX56+QAPXTdDIa
 h58IzHK1Nu7yVG9gOTWClz5HydjMgLR3P7I0eGN8dPxXWG9DsycK1Q2wkt1UeLvnqqIA6IaULwa
 kjapUspg9zSKTOTFdaGOSqil+ENzoSgZTyIEek7U2X7ns2kJiW19f2N+VYLSAzwnIDecsc2+dI8
 TeeoPQvxwnloTuRLwwyBpCLOfbebRtkjnqfFfbwYp+Yzl6zHrK/4UEiB5po2fAUc6f76IIuql/D
 tjte+QpfTCZqkfRgkEIUqaaW508OjjE2YYFBHzssSDQZXNLPcxK8=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Allow configuration of pin functions, including:
- keeping the previous configured function
- disabling output
- waking up the system
- minute periodical interrupt (1: 50% duty, 2: 7.81 ms)

If no function has been configured, fallback to previous behaviour.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/Kconfig       |   1 +
 drivers/rtc/rtc-s35390a.c | 381 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 320 insertions(+), 62 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..4e0374129a4e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -668,6 +668,7 @@ config RTC_DRV_RC5T619
 
 config RTC_DRV_S35390A
 	tristate "Seiko Instruments S-35390A"
+	depends on PINCTRL
 	select BITREVERSE
 	help
 	  If you say yes here you will get support for the Seiko
diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 575bb256eb25..d63bdeff8cdb 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -12,11 +12,16 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define DRIVER_NAME "rtc-s35390a"
 
 #define S35390A_CMD_STATUS1	0
 #define S35390A_CMD_STATUS2	1
 #define S35390A_CMD_TIME1	2
 #define S35390A_CMD_TIME2	3
+#define S35390A_CMD_INT1_REG1	4
 #define S35390A_CMD_INT2_REG1	5
 #define S35390A_CMD_FREE_REG    7
 
@@ -36,19 +41,38 @@
 #define S35390A_FLAG_POC	BIT(0)
 #define S35390A_FLAG_BLD	BIT(1)
 #define S35390A_FLAG_INT2	BIT(2)
+#define S35390A_FLAG_INT1	BIT(3)
 #define S35390A_FLAG_24H	BIT(6)
 #define S35390A_FLAG_RESET	BIT(7)
 
 /* flag for STATUS2 */
 #define S35390A_FLAG_TEST	BIT(0)
 
+#define S35390A_INT_MODE_NOINTR	0x00
+
 /* INT2 pin output mode */
 #define S35390A_INT2_MODE_MASK		0x0E
-#define S35390A_INT2_MODE_NOINTR	0x00
 #define S35390A_INT2_MODE_ALARM		BIT(1) /* INT2AE */
 #define S35390A_INT2_MODE_PMIN_EDG	BIT(2) /* INT2ME */
 #define S35390A_INT2_MODE_FREQ		BIT(3) /* INT2FE */
-#define S35390A_INT2_MODE_PMIN		(BIT(3) | BIT(2)) /* INT2FE | INT2ME */
+#define S35390A_INT2_MODE_PMIN1		(BIT(3) | BIT(2)) /* INT2FE | INT2ME */
+
+/* INT1 pin output mode */
+#define S35390A_INT1_MODE_MASK		0xF0
+#define S35390A_INT1_MODE_ALARM		BIT(5) /* INT1AE */
+#define S35390A_INT1_MODE_PMIN_EDG	BIT(6) /* INT1ME */
+#define S35390A_INT1_MODE_FREQ		BIT(7) /* INT1FE */
+#define S35390A_INT1_MODE_PMIN1		(BIT(7) | BIT(6)) /* INT1FE | INT1ME */
+#define S35390A_INT1_MODE_PMIN2		(BIT(7) | BIT(6) | BIT(5)) /* INT1FE | INT1ME | INT1AE */
+#define S35390A_INT1_MODE_32768KHZ	BIT(4) /* 32kE */
+
+#define S35390A_FUNC_IGNORE		0x00
+#define S35390A_FUNC_DISABLE		0x01
+#define S35390A_FUNC_WAKEUP		0x02
+#define S35390A_FUNC_CLOCK		0x03
+#define S35390A_FUNC_PMIN1		0x04
+#define S35390A_FUNC_PMIN2		0x05
+
 
 static const struct i2c_device_id s35390a_id[] = {
 	{ .name = "s35390a" },
@@ -64,7 +88,11 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
+	struct rtc_device *rtc;
 	int twentyfourhour;
+
+	struct mutex pinfunction_lock; /* lock preventing concurrent access of pin function */
+	int pinfunction[2];
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
@@ -276,10 +304,25 @@ static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled
 	u8 sts;
 	int err;
 
-	if (enabled)
-		sts = S35390A_INT2_MODE_ALARM;
-	else
-		sts = S35390A_INT2_MODE_NOINTR;
+	guard(mutex)(&s35390a->pinfunction_lock);
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	if (err < 0)
+		return err;
+
+	if (enabled) {
+		if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_ALARM;
+
+		if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_ALARM;
+	} else {
+		if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+
+		if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+	}
 
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
@@ -292,7 +335,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
-	u8 buf[3], sts = 0;
+	u8 buf[3], sts = 0, tmp;
 	int err, i;
 
 	dev_dbg(&client->dev, "%s: alm is secs=%d, mins=%d, hours=%d mday=%d, "\
@@ -300,33 +343,35 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		alm->time.tm_min, alm->time.tm_hour, alm->time.tm_mday,
 		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
 
-	/* disable interrupt (which deasserts the irq line) */
-	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
-	if (err < 0)
-		return err;
+	guard(mutex)(&s35390a->pinfunction_lock);
 
-	/* clear pending interrupt (in STATUS1 only), if any */
-	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &sts, sizeof(sts));
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
 
-	if (alm->enabled)
-		sts = S35390A_INT2_MODE_ALARM;
-	else
-		sts = S35390A_INT2_MODE_NOINTR;
+	/* disable interrupt (which deasserts the irq line) */
+	if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+		sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+
+	if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+		sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
 
-	/* set interrupt mode*/
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
 
+	/* clear pending interrupt (in STATUS1 only), if any */
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &tmp, sizeof(tmp));
+	if (err < 0)
+		return err;
+
 	if (alm->time.tm_wday != -1)
 		buf[S35390A_ALRM_BYTE_WDAY] = bin2bcd(alm->time.tm_wday) | 0x80;
 	else
 		buf[S35390A_ALRM_BYTE_WDAY] = 0;
 
 	buf[S35390A_ALRM_BYTE_HOURS] = s35390a_hr2reg(s35390a,
-			alm->time.tm_hour) | 0x80;
+						      alm->time.tm_hour) | 0x80;
 	buf[S35390A_ALRM_BYTE_MINS] = bin2bcd(alm->time.tm_min) | 0x80;
 
 	if (alm->time.tm_hour >= 12)
@@ -335,10 +380,32 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	for (i = 0; i < 3; ++i)
 		buf[i] = bitrev8(buf[i]);
 
-	err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
-								sizeof(buf));
+	if (alm->enabled) {
+		/* set interrupt mode */
+		if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_ALARM;
+
+		if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+			sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_ALARM;
+
+		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+		if (err < 0)
+			return err;
+	}
+
+	if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP) {
+		err = s35390a_set_reg(s35390a, S35390A_CMD_INT1_REG1, buf, sizeof(buf));
+		if (err < 0)
+			return err;
+	}
+
+	if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP) {
+		err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(buf));
+		if (err < 0)
+			return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
@@ -346,24 +413,32 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	u8 buf[3], sts;
-	int i, err;
+	int i, err, reg;
+
+	guard(mutex)(&s35390a->pinfunction_lock);
 
 	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
 
-	if ((sts & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
+	if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP &&
+	    (sts & S35390A_INT2_MODE_MASK) == S35390A_INT2_MODE_ALARM) {
+		reg = S35390A_CMD_INT2_REG1;
+	} else if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP &&
+		   (sts & S35390A_INT1_MODE_MASK) == S35390A_INT1_MODE_ALARM) {
+		reg = S35390A_CMD_INT1_REG1;
+	} else {
 		/*
 		 * When the alarm isn't enabled, the register to configure
 		 * the alarm time isn't accessible.
 		 */
 		alm->enabled = 0;
 		return 0;
-	} else {
-		alm->enabled = 1;
 	}
 
-	err = s35390a_get_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(buf));
+	alm->enabled = 1;
+
+	err = s35390a_get_reg(s35390a, reg, buf, sizeof(buf));
 	if (err < 0)
 		return err;
 
@@ -372,7 +447,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		buf[i] = bitrev8(buf[i]);
 
 	/*
-	 * B0 of the three matching registers is an enable flag. Iff it is set
+	 * B0 of the three matching registers is an enable flag. If it is set
 	 * the configured value is used for matching.
 	 */
 	if (buf[S35390A_ALRM_BYTE_WDAY] & 0x80)
@@ -453,13 +528,181 @@ static int s35390a_nvmem_write(void *priv, unsigned int offset, void *val,
 	return s35390a_set_reg(s35390a, S35390A_CMD_FREE_REG, val, bytes);
 }
 
+static const struct pinctrl_pin_desc s35390a_pins_desc[] = {
+	PINCTRL_PIN(0, "int1"),
+	PINCTRL_PIN(1, "int2"),
+};
+
+static const unsigned int int1_pins[] = { 0 };
+static const unsigned int int2_pins[] = { 1 };
+
+static const struct pingroup s35390a_pin_groups[] = {
+	PINCTRL_PINGROUP("int1_grp", int1_pins, ARRAY_SIZE(int1_pins)),
+	PINCTRL_PINGROUP("int2_grp", int2_pins, ARRAY_SIZE(int2_pins)),
+};
+
+static int s35390a_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(s35390a_pin_groups);
+}
+
+static const char *s35390a_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+						  unsigned int group)
+{
+	return s35390a_pin_groups[group].name;
+}
+
+static int s35390a_pinctrl_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+					  const unsigned int **pins, unsigned int *npins)
+{
+	*pins = s35390a_pin_groups[selector].pins;
+	*npins = s35390a_pin_groups[selector].npins;
+	return 0;
+}
+
+static const char * const all_groups[] = { "int1_grp", "int2_grp" };
+static const char * const int1_groups[] = { "int1_grp" };
+
+static const struct pinfunction s35390a_functions[] = {
+	[S35390A_FUNC_IGNORE] = PINCTRL_PINFUNCTION("ignore", all_groups, ARRAY_SIZE(all_groups)),
+	[S35390A_FUNC_DISABLE] = PINCTRL_PINFUNCTION("disable", all_groups, ARRAY_SIZE(all_groups)),
+	[S35390A_FUNC_WAKEUP] = PINCTRL_PINFUNCTION("wakeup", all_groups, ARRAY_SIZE(all_groups)),
+	[S35390A_FUNC_CLOCK] = PINCTRL_PINFUNCTION("clock", all_groups, ARRAY_SIZE(all_groups)),
+	[S35390A_FUNC_PMIN1] = PINCTRL_PINFUNCTION("pmin1", all_groups, ARRAY_SIZE(all_groups)),
+	[S35390A_FUNC_PMIN2] = PINCTRL_PINFUNCTION("pmin2", int1_groups, ARRAY_SIZE(int1_groups)),
+};
+
+static int s35390a_pinctrl_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(s35390a_functions);
+}
+
+static const char *s35390a_pinctrl_get_function_name(struct pinctrl_dev *pctldev,
+						     unsigned int selector)
+{
+	return s35390a_functions[selector].name;
+}
+
+static int s35390a_pinctrl_get_function_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+					       const char * const **groups,
+					       unsigned int * const ngroups)
+{
+	*groups = s35390a_functions[selector].groups;
+	*ngroups = s35390a_functions[selector].ngroups;
+	return 0;
+}
+
+static int s35390a_pinctrl_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
+				   unsigned int group)
+{
+	int err;
+	u8 buf, status1, flag, mask;
+	bool update_irq = false;
+	struct s35390a *s35390a = pinctrl_dev_get_drvdata(pctldev);
+
+	mask = group == 0 ? S35390A_INT1_MODE_MASK : S35390A_INT2_MODE_MASK;
+
+	guard(mutex)(&s35390a->pinfunction_lock);
+
+	dev_dbg(&s35390a->client[0]->dev, "%s: function=%d group=%d\n",
+		__func__, function, group);
+
+	if (function == s35390a->pinfunction[group])
+		return 0;
+
+	if (function == S35390A_FUNC_IGNORE)
+		goto end;
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
+	if (err < 0) {
+		dev_err(&s35390a->client[0]->dev, "error reading status\n");
+		return err;
+	}
+
+	switch (function) {
+	case S35390A_FUNC_DISABLE:
+	case S35390A_FUNC_CLOCK: /* not implemented */
+		buf = (buf & ~mask) | S35390A_INT_MODE_NOINTR;
+		break;
+	case S35390A_FUNC_WAKEUP:
+		flag = group == 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_ALARM;
+		if ((buf & mask) != flag) {
+			buf = (buf & ~mask) | S35390A_INT_MODE_NOINTR;
+			break;
+		}
+
+		err = s35390a_read_status(s35390a, &status1);
+		if (err < 0) {
+			dev_err(&s35390a->client[0]->dev, "error reading status\n");
+			return err;
+		}
+
+		flag = group == 0 ? S35390A_FLAG_INT1 : S35390A_FLAG_INT2;
+
+		/* disable alarm */
+		if (status1 & flag) {
+			buf = (buf & ~mask) | S35390A_INT_MODE_NOINTR;
+			update_irq = true;
+		}
+
+		break;
+	case S35390A_FUNC_PMIN1:
+		flag = group == 0 ? S35390A_INT1_MODE_PMIN1 : S35390A_INT2_MODE_PMIN1;
+		buf = (buf & ~mask) | flag;
+		break;
+
+	/* INT1 only modes */
+	case S35390A_FUNC_PMIN2:
+		buf = (buf & ~mask) | S35390A_INT1_MODE_PMIN2;
+		break;
+	}
+
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
+	if (err < 0) {
+		dev_err(&s35390a->client[0]->dev, "error setting interrupts\n");
+		return err;
+	}
+
+	if (update_irq)
+		rtc_update_irq(s35390a->rtc, 1, RTC_AF);
+
+end:
+	s35390a->pinfunction[group] = function;
+
+	return 0;
+}
+
+static const struct pinctrl_ops s35390a_pinctrl_ops = {
+	.get_groups_count = s35390a_pinctrl_get_groups_count,
+	.get_group_name = s35390a_pinctrl_get_group_name,
+	.get_group_pins = s35390a_pinctrl_get_group_pins,
+};
+
+static const struct pinmux_ops s35390a_pinmux_ops = {
+	.get_functions_count = s35390a_pinctrl_get_functions_count,
+	.get_function_name = s35390a_pinctrl_get_function_name,
+	.get_function_groups = s35390a_pinctrl_get_function_groups,
+	.set_mux = s35390a_pinctrl_set_mux,
+	.strict = true,
+};
+
+static struct pinctrl_desc s35390a_pinctrl_desc = {
+	.name = DRIVER_NAME,
+	.pins = s35390a_pins_desc,
+	.npins = ARRAY_SIZE(s35390a_pins_desc),
+	.pctlops = &s35390a_pinctrl_ops,
+	.pmxops = &s35390a_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
 static int s35390a_probe(struct i2c_client *client)
 {
-	int err, err_read;
+	int err;
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_device *rtc;
-	u8 buf, status1;
+	struct pinctrl_dev *pctl;
+	u8 status1;
 	struct device *dev = &client->dev;
 	struct nvmem_config nvmem_cfg = {
 		.name = "s35390a_nvram",
@@ -470,6 +713,7 @@ static int s35390a_probe(struct i2c_client *client)
 		.reg_read = s35390a_nvmem_read,
 		.reg_write = s35390a_nvmem_write,
 	};
+	int fallback[ARRAY_SIZE(s35390a_pin_groups)];
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -478,7 +722,11 @@ static int s35390a_probe(struct i2c_client *client)
 	if (!s35390a)
 		return -ENOMEM;
 
+	mutex_init(&s35390a->pinfunction_lock);
+	memset(s35390a->pinfunction, -1, sizeof(s35390a->pinfunction));
+
 	s35390a->client[0] = client;
+
 	i2c_set_clientdata(client, s35390a);
 
 	/* This chip uses multiple addresses, use dummy devices for them */
@@ -493,39 +741,16 @@ static int s35390a_probe(struct i2c_client *client)
 		}
 	}
 
+	err = s35390a_disable_test_mode(s35390a);
+	if (err < 0) {
+		dev_err(dev, "error disabling test mode\n");
+		return err;
+	}
+
 	rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	err_read = s35390a_read_status(s35390a, &status1);
-	if (err_read < 0) {
-		dev_err(dev, "error resetting chip\n");
-		return err_read;
-	}
-
-	if (status1 & S35390A_FLAG_24H)
-		s35390a->twentyfourhour = 1;
-	else
-		s35390a->twentyfourhour = 0;
-
-	if (status1 & S35390A_FLAG_INT2) {
-		/* disable alarm (and maybe test mode) */
-		buf = 0;
-		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
-		if (err < 0) {
-			dev_err(dev, "error disabling alarm\n");
-			return err;
-		}
-	} else {
-		err = s35390a_disable_test_mode(s35390a);
-		if (err < 0) {
-			dev_err(dev, "error disabling test mode\n");
-			return err;
-		}
-	}
-
-	device_set_wakeup_capable(dev, 1);
-
 	rtc->ops = &s35390a_rtc_ops;
 	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->range_max = RTC_TIMESTAMP_END_2099;
@@ -533,8 +758,40 @@ static int s35390a_probe(struct i2c_client *client)
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
-	if (status1 & S35390A_FLAG_INT2)
-		rtc_update_irq(rtc, 1, RTC_AF);
+	s35390a->rtc = rtc;
+
+	device_set_wakeup_capable(dev, 1);
+
+	err = devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s35390a, &pctl);
+	if (err)
+		return dev_err_probe(dev, err, "pinctrl register failed\n");
+
+	err = pinctrl_enable(pctl);
+	if (err)
+		return dev_err_probe(dev, err, "pinctrl enable failed\n");
+
+	/* If no pinmux function is defined in DT, fallback to previous behaviour */
+	fallback[0] = S35390A_FUNC_IGNORE;
+	fallback[1] = S35390A_FUNC_WAKEUP;
+
+	for (i = 0; i < ARRAY_SIZE(s35390a_pin_groups); i++) {
+		if (s35390a->pinfunction[i] == -1) {
+			err = s35390a_pinctrl_set_mux(pctl, fallback[i], i);
+			if (err)
+				return err;
+		}
+	}
+
+	err = s35390a_read_status(s35390a, &status1);
+	if (err < 0) {
+		dev_err(dev, "error resetting chip\n");
+		return err;
+	}
+
+	if (status1 & S35390A_FLAG_24H)
+		s35390a->twentyfourhour = 1;
+	else
+		s35390a->twentyfourhour = 0;
 
 	nvmem_cfg.priv = s35390a;
 	err = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
@@ -546,7 +803,7 @@ static int s35390a_probe(struct i2c_client *client)
 
 static struct i2c_driver s35390a_driver = {
 	.driver		= {
-		.name	= "rtc-s35390a",
+		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(s35390a_of_match),
 	},
 	.probe		= s35390a_probe,

-- 
2.54.0

