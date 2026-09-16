Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F64CEE44
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574460; cv=none; b=QWNGiKt64Lw4BF1BlvvY2SQyK2xlYU/ySWe3hkPilC4u4xW1AvYnUC/vG8MUjo1qnZQZBccwFV/8KI6dI4Hf6TLHmDmmM4NIDY2wVgzM3Ngbcc3v/yikkSGuIpig6kmbzvmq35mG4znSAq7eZA8fz2iE21c3FvL3J6Aq1dDSKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574460; c=relaxed/simple;
	bh=FYoQlUDgCRNSVctLBUq2157n5gxHm80aT5LNffMkb04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/KzUI0xsdLSq1HxfnHvEmzb4DIioJ6kbVlwNLQtaioQH7ByFkTaMBoF/lloyQOKJkF+3DZZotuPmA+iVLTY05NEjH9j7uZB5ctvjeHFjOYLZffAjcB6Blt0EXtyeRjN/c2dUbIDUCXFlzA81vp8yqwWbIXIzsaiyRcY2lEJsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=jzcF2UUi; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="jzcF2UUi"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E12FE24002B
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 18:00:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789574443;
	bh=ce/UduRNkMNJQ2TzeVdWzc7HEaRTTcY3rIYP1QPIoe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=jzcF2UUickivwf2ulnk/vl67NEyrotmSgKUXMQulIKB0B2fehSE6KYhgyUcaeMEll
	 qdtFnt71siUKOCkXyLFyPh0/gdAlygdjYTGMoGpwBWfgnWJvvWPpiV7gLG8h2/R4rO
	 fvg5DM5/noP3ee3syix8L7DsCvDVVkS6oPSjH0DGApM+bpftNO2Mx4ZpBDjh0DHxyt
	 OdS4SnKyIcZOVqXoHwmTv72MwHN+93AhWH9uDxAvPz1Tsys3zqUXPjdeoT+ruo6OpS
	 Fc729G0/GZrQdv9VWuV2VoIeq7ZvIBxd1UXIysnsXdP1/8x+xrb6Mclmj4lG5wDmCZ
	 jAr3i7ZpgBf9A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hlNs54jWrz9rxN;
	Wed, 16 Sep 2026 18:00:41 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 16 Sep 2026 16:00:43 +0000
Subject: [PATCH v9 5/6] rtc: s35390a: Add pinctrl
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-rtc_s35390a_int1-v9-5-b2567a3e4959@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18551;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=FYoQlUDgCRNSVctLBUq2157n5gxHm80aT5LNffMkb04=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqqr0fage3lpFdkmaVZpmJM2V/w6dk1xsR2feK6
 vJTdeZ5Z+6JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaqq9HxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JoFA//VVaYhxgRODazpWzNWtBS2ct8grurZPL
 t8Yu7MOvmQJ/0zoYjtw3WMuSqAkTG30/OzA6rnbXuDmIgpC7uM7kT+UT8L/b3PU11PKYv+ZTxDg
 SN+PjR4xAHaDfa+GMNr0O1IOxORBNWpxs8CK+G8BCwJDrvA9RlyY2DcPmZSA53pSz4iErpIMGLi
 UNxYRtgwubLHakHtr/v+FltnT446f9aLsf4cqvH958OHo9WqO2oos3yTqtWuCgNb/Z8OGtZ9qDv
 SLKu2PWA+dWu4yTL85m0tXxtdIfOVYGdrPzAl1eNgqx2GxTlmcPS1kjIuigqnrSxVyfb/Un2KIU
 aXlKiMpfvoLDH7XNlCnyYqSBAH/zdRDmibrmhCKGQgeevpYd9ym1OIplcik4ztYizpJeCDQVB08
 HVU0spItFfXpQAkHjCJnIxDwxd98IbzpOUcCXrQ/an4H5Htl4ioGik/GhOnKxqTpaNhiZQBDOfA
 oINXNRlVftg3+7B2FMR45UuSo0Dq3KHTEqvMb8YrCzNRWpIRn8q9wf82VU3krua6FOC8JMep7s1
 IYAL1JIcSPL4cPjtgGAdZtOr+lihde2Pu/Y10V16f2HwdC7kGaiOH7hEcCPjCaJoKLw1vdimZe7
 8M3kCQT73Gi3lT6LHsX6P/j/+fpDv/n++S6OKJl7L7sVfSIKK0BY=
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/Kconfig       |   2 +
 drivers/rtc/rtc-s35390a.c | 375 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 313 insertions(+), 64 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..c73c7d9751d9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -668,7 +668,9 @@ config RTC_DRV_RC5T619
 
 config RTC_DRV_S35390A
 	tristate "Seiko Instruments S-35390A"
+	select PINCTRL
 	select BITREVERSE
+	select GENERIC_PINCONF
 	help
 	  If you say yes here you will get support for the Seiko
 	  Instruments S-35390A.
diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 12ed504db94d..649d36d37f1f 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -12,11 +12,17 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+#define DRIVER_NAME "rtc-s35390a"
 
 #define S35390A_CMD_STATUS1	0
 #define S35390A_CMD_STATUS2	1
 #define S35390A_CMD_TIME1	2
 #define S35390A_CMD_TIME2	3
+#define S35390A_CMD_INT1_REG1	4
 #define S35390A_CMD_INT2_REG1	5
 #define S35390A_CMD_FREE_REG    7
 
@@ -36,19 +42,38 @@
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
@@ -64,6 +89,10 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
+	struct rtc_device *rtc;
+
+	struct mutex pinfunction_lock; /* lock preventing concurrent access of pin function */
+	int pinfunction[2];
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
@@ -165,20 +194,6 @@ static int s35390a_read_status(struct s35390a *s35390a, char *status1)
 	return 0;
 }
 
-static int s35390a_disable_test_mode(struct s35390a *s35390a)
-{
-	u8 buf[1];
-
-	if (s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf)) < 0)
-		return -EIO;
-
-	if (!(buf[0] & S35390A_FLAG_TEST))
-		return 0;
-
-	buf[0] &= ~S35390A_FLAG_TEST;
-	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
-}
-
 static char s35390a_hr2reg(int hour, bool twentyfourhour)
 {
 	if (twentyfourhour)
@@ -281,10 +296,25 @@ static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled
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
@@ -305,7 +335,19 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		alm->time.tm_min, alm->time.tm_hour, alm->time.tm_mday,
 		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
 
+	guard(mutex)(&s35390a->pinfunction_lock);
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
+	if (err < 0)
+		return err;
+
 	/* disable interrupt (which deasserts the irq line) */
+	if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+		status2 = (status2 & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+
+	if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+		status2 = (status2 & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
 	if (err < 0)
 		return err;
@@ -315,16 +357,6 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (err < 0)
 		return err;
 
-	if (alm->enabled)
-		status2 = S35390A_INT2_MODE_ALARM;
-	else
-		status2 = S35390A_INT2_MODE_NOINTR;
-
-	/* set interrupt mode*/
-	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
-	if (err < 0)
-		return err;
-
 	if (alm->time.tm_wday != -1)
 		buf[S35390A_ALRM_BYTE_WDAY] = bin2bcd(alm->time.tm_wday) | 0x80;
 	else
@@ -340,10 +372,32 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	for (i = 0; i < 3; ++i)
 		buf[i] = bitrev8(buf[i]);
 
-	err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
-								sizeof(buf));
+	if (alm->enabled) {
+		/* set interrupt mode */
+		if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP)
+			status2 = (status2 & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_ALARM;
+
+		if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP)
+			status2 = (status2 & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_ALARM;
 
-	return err;
+		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
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
+
+	return 0;
 }
 
 static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
@@ -351,7 +405,9 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	u8 buf[3], status1, status2;
-	int i, err;
+	int i, err, reg;
+
+	guard(mutex)(&s35390a->pinfunction_lock);
 
 	err = s35390a_read_status(s35390a, &status1);
 	if (err == 1)
@@ -363,18 +419,24 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (err < 0)
 		return err;
 
-	if ((status2 & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
+	if (s35390a->pinfunction[1] == S35390A_FUNC_WAKEUP &&
+	    (status2 & S35390A_INT2_MODE_MASK) == S35390A_INT2_MODE_ALARM) {
+		reg = S35390A_CMD_INT2_REG1;
+	} else if (s35390a->pinfunction[0] == S35390A_FUNC_WAKEUP &&
+		   (status2 & S35390A_INT1_MODE_MASK) == S35390A_INT1_MODE_ALARM) {
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
 
@@ -383,7 +445,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		buf[i] = bitrev8(buf[i]);
 
 	/*
-	 * B0 of the three matching registers is an enable flag. Iff it is set
+	 * B0 of the three matching registers is an enable flag. If it is set
 	 * the configured value is used for matching.
 	 */
 	if (buf[S35390A_ALRM_BYTE_WDAY] & 0x80)
@@ -464,13 +526,168 @@ static int s35390a_nvmem_write(void *priv, unsigned int offset, void *val,
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
+	u8 status2, flag, mask;
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
+	if (function != S35390A_FUNC_IGNORE) {
+		err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, 1);
+		if (err < 0) {
+			dev_err(&s35390a->client[0]->dev, "error reading status\n");
+			return err;
+		}
+
+		switch (function) {
+		case S35390A_FUNC_DISABLE:
+		case S35390A_FUNC_CLOCK: /* not implemented */
+			status2 = (status2 & ~mask) | S35390A_INT_MODE_NOINTR;
+			break;
+		case S35390A_FUNC_WAKEUP:
+			flag = group == 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_ALARM;
+
+			if ((status2 & mask) != flag)
+				status2 = (status2 & ~mask) | S35390A_INT_MODE_NOINTR;
+
+			break;
+		case S35390A_FUNC_PMIN1:
+			flag = group == 0 ? S35390A_INT1_MODE_PMIN1 : S35390A_INT2_MODE_PMIN1;
+			status2 = (status2 & ~mask) | flag;
+			break;
+
+		/* INT1 only modes */
+		case S35390A_FUNC_PMIN2:
+			if (group == 1)
+				return -EINVAL;
+
+			status2 = (status2 & ~mask) | S35390A_INT1_MODE_PMIN2;
+			break;
+		}
+
+		err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, 1);
+		if (err < 0) {
+			dev_err(&s35390a->client[0]->dev, "error setting interrupts\n");
+			return err;
+		}
+	}
+
+	s35390a->pinfunction[group] = function;
+
+	return 0;
+}
+
+static const struct pinctrl_ops s35390a_pinctrl_ops = {
+	.get_groups_count = s35390a_pinctrl_get_groups_count,
+	.get_group_name = s35390a_pinctrl_get_group_name,
+	.get_group_pins = s35390a_pinctrl_get_group_pins,
+#if IS_ENABLED(CONFIG_OF)
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map
+#endif
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
+	u8 status1, status2;
+	bool irq = false;
 	struct device *dev = &client->dev;
 	struct nvmem_config nvmem_cfg = {
 		.name = "s35390a_nvram",
@@ -481,6 +698,7 @@ static int s35390a_probe(struct i2c_client *client)
 		.reg_read = s35390a_nvmem_read,
 		.reg_write = s35390a_nvmem_write,
 	};
+	int fallback[ARRAY_SIZE(s35390a_pin_groups)];
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -489,7 +707,11 @@ static int s35390a_probe(struct i2c_client *client)
 	if (!s35390a)
 		return -ENOMEM;
 
+	mutex_init(&s35390a->pinfunction_lock);
+	memset(s35390a->pinfunction, -1, sizeof(s35390a->pinfunction));
+
 	s35390a->client[0] = client;
+
 	i2c_set_clientdata(client, s35390a);
 
 	/* This chip uses multiple addresses, use dummy devices for them */
@@ -504,33 +726,34 @@ static int s35390a_probe(struct i2c_client *client)
 		}
 	}
 
-	rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	err_read = s35390a_read_status(s35390a, &status1);
-	if (err_read < 0) {
+	err = s35390a_read_status(s35390a, &status1);
+	if (err < 0) {
 		dev_err(dev, "error resetting chip\n");
-		return err_read;
+		return err;
+	}
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
+	if (err < 0)
+		return dev_err_probe(dev, err, "disabling alarm and test mode failed\n");
+
+	if (status1 & S35390A_FLAG_INT1) {
+		status2 = (status2 & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+		irq = true;
 	}
 
 	if (status1 & S35390A_FLAG_INT2) {
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
+		status2 = (status2 & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+		irq = true;
 	}
 
-	device_set_wakeup_capable(dev, 1);
+	status2 &= ~S35390A_FLAG_TEST;
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
+	if (err < 0)
+		return dev_err_probe(dev, err, "disabling alarm and test mode failed\n");
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
 	rtc->ops = &s35390a_rtc_ops;
 	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
@@ -539,9 +762,33 @@ static int s35390a_probe(struct i2c_client *client)
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
-	if (status1 & S35390A_FLAG_INT2)
+	s35390a->rtc = rtc;
+
+	device_set_wakeup_capable(dev, 1);
+
+	if (irq)
 		rtc_update_irq(rtc, 1, RTC_AF);
 
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
 	nvmem_cfg.priv = s35390a;
 	err = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
 	if (err)
@@ -552,7 +799,7 @@ static int s35390a_probe(struct i2c_client *client)
 
 static struct i2c_driver s35390a_driver = {
 	.driver		= {
-		.name	= "rtc-s35390a",
+		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(s35390a_of_match),
 	},
 	.probe		= s35390a_probe,

-- 
2.55.0

