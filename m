Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578B242D72
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609799; cv=none; b=b6IZ/a8+3Pn+F7/rHmgWRpiwQ8mhXzm9EP9g4synfGxdp/o9s7Me4w3+FBkjBpTqr/OhA6kVU0A5DPge6ODU1KHImAlyBC6B1CR/J0emT73daa+xXbc1rQqsNbzqOOtaMeYgRmEGpovHohg7bv8+CDcauzhBlRItBxDN65BkchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609799; c=relaxed/simple;
	bh=yZjweCJcsptb0VYNMvC+HHHEQ1gNnBraKUjH/ut1+VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGAuzfyzM7ZAPuxsWPZXgTrn7+W9lUcLA58xZ9mYMpG3rHDYhZSFav0h/ek+W6hhRgNMlUOEUUPghni/o62NYwbtt8dfxclYqABkL8N2PKBcNE+1eh9WSFnTuvuuZTsov9nRbTPJyIaeUqp07yLXp7GXW/OgEZulz24cg8j0aVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kGMwdG+v; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kGMwdG+v"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BE1DC240103
	for <linux-rtc@vger.kernel.org>; Sat,  1 Aug 2026 20:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785609784;
	bh=FqVh05ZmUUOgEsKcHQf6YryhRCr6yZI80Wbx2TgUXRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=kGMwdG+vZ9tomSVhSoGyuPWYSJoXYyXgZjEa2u+OAZObEIXVPqW6vlgBNop5guuNy
	 J0rk2weqz9QnJnpZacQJAGh3Z0JiqEI8XpNrQL19MDQwPd1zn6tMjRa85LpTkXzPX4
	 q/Uo5jLY38He3CQAzIckyxfSLn84aPL8KKIvxWANcBm+YecLdbkl9amtbndzH0Awy5
	 N9XIi+gFLI+g+lBXnszCIDCz8mS+E//tyV7BiVKAjPqh3wgmQHZmpb82+D272+tTjX
	 KyaHjDK84wRhi+4/AD1pGF9/IKD1j+U3JLpu3Iyk1YYTXM5LElH/5sQPGnmkEPL7xg
	 c32oeW94PS9+g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hCBdf4zWzz9rxB;
	Sat,  1 Aug 2026 20:43:02 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 01 Aug 2026 18:43:04 +0000
Subject: [PATCH v2 4/5] rtc: s35390a: Add pinctrl
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-rtc_s35390a_int1-v2-4-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
In-Reply-To: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=17249;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=yZjweCJcsptb0VYNMvC+HHHEQ1gNnBraKUjH/ut1+VI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqbj4weQI3Lg/GAhr2jpN/+eVXX7MrbMW9ITjkD
 Zy3aLMiwICJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCam4+MBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KLdQ//btSdpTOwptr/kjwQ4ZnWPq+XeefIoQo
 bT48UMYuofjBjS4MidCMunqBEjaI04aupPLTuuL2paRe3ZQmGXE0GozxhN8RnIxJOk1/ph3fxHb
 aSPU/tQzcU19JvKj5BuCaEtRmBs9YTzDtIRrmk93ksWsg/HFCT21AaOwMl9H+Pa92d2K/5fSJdc
 XKr3+zRDLnZNbXWI3UKXJ6c5uCzKWEBLJs3FXPNn/wz6x24jh07q2zQIm2eQrmJ0BdU50iXhiG3
 F1i2b73+aiLi1uIMsPX0y5lLJTR9W/sL6GVwakfFZdZ8OlTTZwQAn7WcqbPsyJdIhw/Y5TIzA9u
 zUoAFKKbP74hK3f0SInkbW3q/PgqdSXhgl0xZPjG5u2PlrztSwiHkdcNvYdfzfXrlJnrRcZ1SuW
 N4ljQo5rw3do2jUkg4giimZ8dVTNRGfXnO6nvSF9sTcQ9pPKbOFqNAXzxsjtJjyd0GjF8a5viT1
 X0TCZBgEL3kY17w8p0T/pC2stXV8Tw9xzk3S8MSblJcIk92TBIxVbiSvRNTGOaogz3c9ms7wCNk
 cU8eJR4mkIC6IxoIShBiOxD/Yp49Ojl0c1Qxox255DmIRFe0komdlwraqC5oxeeI7xRPvedvaIV
 g52W7bmXIzI2KrdVTcgvThlbljjRm72UqQdw8XX1vKEZnJI1bWFY=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Allow configuration of other output modes than wake alarm, including:
- keeping the previous configured mode
- disabling output
- custom frequency
- minute periodical interrupt (1: 50% duty, 2: 7.81 ms)
- raw 32.768 kHz output

Allow use of interrupt signal 1.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/Kconfig       |   3 +
 drivers/rtc/rtc-s35390a.c | 403 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 349 insertions(+), 57 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 01def8231873..054ff134d84e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -668,7 +668,10 @@ config RTC_DRV_RC5T619
 
 config RTC_DRV_S35390A
 	tristate "Seiko Instruments S-35390A"
+	depends on OF
+	depends on PINCTRL
 	select BITREVERSE
+	select GENERIC_PINCONF
 	help
 	  If you say yes here you will get support for the Seiko
 	  Instruments S-35390A.
diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index fbf5471eb3d0..fc0dbce0e8f4 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -12,11 +12,18 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <dt-bindings/rtc/s35390a.h>
+
+#define DRIVER_NAME "rtc-s35390a"
 
 #define S35390A_CMD_STATUS1	0
 #define S35390A_CMD_STATUS2	1
 #define S35390A_CMD_TIME1	2
 #define S35390A_CMD_TIME2	3
+#define S35390A_CMD_INT1_REG1	4
 #define S35390A_CMD_INT2_REG1	5
 #define S35390A_CMD_FREE_REG    7
 
@@ -36,19 +43,31 @@
 #define S35390A_FLAG_POC	BIT(0)
 #define S35390A_FLAG_BLD	BIT(1)
 #define S35390A_FLAG_INT2	BIT(2)
+#define S35390A_FLAG_INT1	BIT(3)
 #define S35390A_FLAG_24H	BIT(6)
 #define S35390A_FLAG_RESET	BIT(7)
 
 /* flag for STATUS2 */
 #define S35390A_FLAG_TEST	BIT(0)
 
+
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
 
 static const struct i2c_device_id s35390a_id[] = {
 	{ .name = "s35390a" },
@@ -64,8 +83,15 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
-	struct rtc_time tm_alarm;
+	struct rtc_device *rtc;
+	struct pinctrl_dev *pinctrl;
+	struct rtc_wkalrm alarm;
 	int twentyfourhour;
+
+	struct mutex mode_lock;
+	bool mode_init;
+	int mode[2];
+	u8 freq[2];
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
@@ -283,33 +309,33 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		alm->time.tm_min, alm->time.tm_hour, alm->time.tm_mday,
 		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
 
-	/* disable interrupt (which deasserts the irq line) */
-	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
-	if (err < 0)
-		return err;
+	guard(mutex)(&s35390a->mode_lock);
 
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
+	if (s35390a->mode[0] == S35390A_MODE_WAKEUP)
+		sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
+
+	if (s35390a->mode[1] == S35390A_MODE_WAKEUP)
+		sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
 
-	/* set interrupt mode*/
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
 
+	if (!alm->enabled)
+		goto end;
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
@@ -318,13 +344,33 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	for (i = 0; i < 3; ++i)
 		buf[i] = bitrev8(buf[i]);
 
-	err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
-								sizeof(buf));
+	/* set interrupt mode */
+	if (s35390a->mode[0] == S35390A_MODE_WAKEUP)
+		sts = (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_ALARM;
+
+	if (s35390a->mode[1] == S35390A_MODE_WAKEUP)
+		sts = (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_ALARM;
+
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	if (err < 0)
+		return err;
+
+	if (s35390a->mode[0] == S35390A_MODE_WAKEUP) {
+		err = s35390a_set_reg(s35390a, S35390A_CMD_INT1_REG1, buf, sizeof(buf));
+		if (err)
+			return err;
+	}
+
+	if (s35390a->mode[1] == S35390A_MODE_WAKEUP) {
+		err = s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(buf));
+		if (err)
+			return err;
+	}
 
-	if (!err)
-		s35390a->tm_alarm = alm->time;
+end:
+	s35390a->alarm = *alm;
 
-	return err;
+	return 0;
 }
 
 static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
@@ -332,24 +378,35 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	u8 buf[3], sts;
-	int i, err;
+	int i, err, reg;
+
+	guard(mutex)(&s35390a->mode_lock);
 
 	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
 		return err;
 
-	if ((sts & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
+	if (s35390a->mode[1] == S35390A_MODE_WAKEUP
+		&& (sts & S35390A_INT2_MODE_MASK) == S35390A_INT2_MODE_ALARM) {
+
+		reg = S35390A_CMD_INT2_REG1;
+	} else if (s35390a->mode[0] == S35390A_MODE_WAKEUP
+		&& (sts & S35390A_INT1_MODE_MASK) == S35390A_INT1_MODE_ALARM) {
+
+		reg = S35390A_CMD_INT1_REG1;
+	} else {
 		/*
 		 * When the alarm isn't enabled, the register to configure
 		 * the alarm time isn't accessible.
 		 */
 		alm->enabled = 0;
+		alm->time = s35390a->alarm.time;
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
 
@@ -358,7 +415,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		buf[i] = bitrev8(buf[i]);
 
 	/*
-	 * B0 of the three matching registers is an enable flag. Iff it is set
+	 * B0 of the three matching registers is an enable flag. If it is set
 	 * the configured value is used for matching.
 	 */
 	if (buf[S35390A_ALRM_BYTE_WDAY] & 0x80)
@@ -388,10 +445,10 @@ static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled
 	struct s35390a *s35390a = dev_get_drvdata(dev);
 	struct rtc_wkalrm alm;
 
-	alm.enabled = enabled;
-
 	if (enabled)
-		alm.time = s35390a->tm_alarm;
+		alm = s35390a->alarm;
+
+	alm.enabled = enabled;
 
 	return s35390a_rtc_set_alarm(dev, &alm);
 }
@@ -452,13 +509,241 @@ static int s35390a_nvmem_write(void *priv, unsigned int offset, void *val,
 	return s35390a_set_reg(s35390a, S35390A_CMD_FREE_REG, val, bytes);
 }
 
+static int s35390a_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *s35390a_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+						  unsigned int group)
+{
+	return NULL;
+}
+
+static const struct pinctrl_pin_desc s35390a_pins_desc[] = {
+	PINCTRL_PIN(0, "int1"),
+	PINCTRL_PIN(1, "int2"),
+};
+
+static const struct pinctrl_ops s35390a_pinctrl_ops = {
+	.get_groups_count = s35390a_pinctrl_get_groups_count,
+	.get_group_name = s35390a_pinctrl_get_group_name,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+#define PIN_CONFIG_MODE		(PIN_CONFIG_END + 1)
+#define PIN_CONFIG_FREQ		(PIN_CONFIG_END + 2)
+
+static const struct pinconf_generic_params s35390a_pinconf_params[] = {
+	{"sii,mode", PIN_CONFIG_MODE},
+	{"sii,frequency", PIN_CONFIG_FREQ},
+};
+
+static int s35390a_set_freq(struct s35390a *s35390a, int pin, int freq)
+{
+	int err, reg;
+	u8 buf;
+
+	reg = pin == 0 ? S35390A_CMD_INT1_REG1 : S35390A_CMD_INT2_REG1;
+
+	buf = bitrev8(freq);
+
+	err = s35390a_set_reg(s35390a, reg, &buf, 1);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int s35390a_update_mode(struct s35390a *s35390a, int pin, int mode, int freq)
+{
+	int err;
+	u8 buf, status1, flag, mask;
+	bool update_irq = false;
+
+	mask = pin == 0 ? S35390A_INT1_MODE_MASK : S35390A_INT2_MODE_MASK;
+
+	s35390a->mode_init = true;
+
+	guard(mutex)(&s35390a->mode_lock);
+
+	dev_dbg(&s35390a->client[0]->dev, "%s: pin=%d mode=%d\n",
+			__func__, pin, mode);
+
+	if (mode == S35390A_MODE_FREQ) {
+		if (freq & ~S35390A_FREQ_MASK) {
+			dev_err(&s35390a->client[0]->dev, "Unsupported frequency %u\n", freq);
+			return -EINVAL;
+		}
+	} else
+		freq = 0;
+
+	if (mode == s35390a->mode[pin] && freq == s35390a->freq[pin])
+		return 0;
+
+	s35390a->mode[pin] = mode;
+	s35390a->freq[pin] = freq;
+
+	if (mode == S35390A_MODE_IGNORE)
+		return 0;
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
+	if (err < 0) {
+		dev_err(&s35390a->client[0]->dev, "error reading status\n");
+		return err;
+	}
+
+	switch (mode) {
+	case S35390A_MODE_DISABLE:
+	case S35390A_MODE_ALARM: /* not implemented */
+		buf = (buf & ~mask) | S35390A_INT_MODE_NOINTR;
+		break;
+	case S35390A_MODE_WAKEUP:
+		flag = pin == 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_ALARM;
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
+		flag = pin == 0 ? S35390A_FLAG_INT1 : S35390A_FLAG_INT2;
+
+		/* disable alarm */
+		if (status1 & flag) {
+			buf = (buf & ~mask) | S35390A_INT_MODE_NOINTR;
+			update_irq = true;
+		}
+
+		break;
+	case S35390A_MODE_FREQ:
+		flag = pin == 0 ? S35390A_INT1_MODE_FREQ : S35390A_INT2_MODE_FREQ;
+		buf = (buf & ~mask) | flag;
+		break;
+	case S35390A_MODE_PMIN1:
+		flag = pin == 0 ? S35390A_INT1_MODE_PMIN1 : S35390A_INT2_MODE_PMIN1;
+		buf = (buf & ~mask) | flag;
+		break;
+
+	/* INT1 only modes */
+	case S35390A_MODE_PMIN2:
+		buf = (buf & ~mask) | S35390A_INT1_MODE_PMIN2;
+		break;
+	case S35390A_MODE_32768KHZ:
+		buf = (buf & ~mask) | S35390A_INT1_MODE_32768KHZ;
+		break;
+	}
+
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
+	if (err < 0) {
+		dev_err(&s35390a->client[0]->dev, "error setting interrupts\n");
+		return err;
+	}
+
+	if (freq) {
+		err = s35390a_set_freq(s35390a, pin, freq);
+		if (err < 0) {
+			dev_err(&s35390a->client[0]->dev, "error setting frequency\n");
+			return err;
+		}
+	}
+
+	if (update_irq)
+		rtc_update_irq(s35390a->rtc, 1, RTC_AF);
+
+	return 0;
+}
+
+static int s35390a_pinconf_get(struct pinctrl_dev *pctldev,
+			       unsigned int pin, unsigned long *config)
+{
+	struct s35390a *s35390a = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	u16 arg;
+
+	switch (param) {
+	case PIN_CONFIG_MODE:
+		arg = s35390a->mode[pin];
+		break;
+	case PIN_CONFIG_FREQ:
+		arg = s35390a->freq[pin];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int s35390a_pinconf_set(struct pinctrl_dev *pctldev,
+			       unsigned int pin, unsigned long *configs,
+			       unsigned int num_configs)
+{
+	struct s35390a *s35390a = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param;
+	u32 param_val;
+	int i, mode, freq = 0;
+
+	mode = pin == 0 ? S35390A_MODE_IGNORE : S35390A_MODE_WAKEUP;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[0]);
+		param_val = pinconf_to_config_argument(configs[0]);
+
+		switch (param) {
+		case PIN_CONFIG_MODE:
+			if (param_val <= (pin == 0 ? S35390A_MODE_INT1_MAX : S35390A_MODE_INT2_MAX))
+				mode = param_val;
+			else {
+				dev_err(&s35390a->client[0]->dev, "Unsupported pin mode %u\n",
+					param_val);
+				return -EINVAL;
+			}
+			break;
+		case PIN_CONFIG_FREQ:
+			freq = param_val;
+			break;
+		default:
+			dev_err(&s35390a->client[0]->dev, "Property %u not supported\n",
+				param);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return s35390a_update_mode(s35390a, pin, mode, freq);
+}
+
+
+static const struct pinconf_ops s35390a_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = s35390a_pinconf_get,
+	.pin_config_set = s35390a_pinconf_set,
+};
+
+static struct pinctrl_desc s35390a_pinctrl_desc = {
+	.name = DRIVER_NAME,
+	.pins = s35390a_pins_desc,
+	.npins = ARRAY_SIZE(s35390a_pins_desc),
+	.pctlops = &s35390a_pinctrl_ops,
+	.confops = &s35390a_pinconf_ops,
+	.custom_params = s35390a_pinconf_params,
+	.num_custom_params = ARRAY_SIZE(s35390a_pinconf_params),
+	.owner = THIS_MODULE,
+};
+
 static int s35390a_probe(struct i2c_client *client)
 {
 	int err, err_read;
 	unsigned int i;
 	struct s35390a *s35390a;
 	struct rtc_device *rtc;
-	u8 buf, status1;
+	u8 status1;
 	struct device *dev = &client->dev;
 	struct nvmem_config nvmem_cfg = {
 		.name = "s35390a_nvram",
@@ -477,7 +762,10 @@ static int s35390a_probe(struct i2c_client *client)
 	if (!s35390a)
 		return -ENOMEM;
 
+	mutex_init(&s35390a->mode_lock);
+
 	s35390a->client[0] = client;
+
 	i2c_set_clientdata(client, s35390a);
 
 	/* This chip uses multiple addresses, use dummy devices for them */
@@ -492,10 +780,37 @@ static int s35390a_probe(struct i2c_client *client)
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
 
+	rtc->ops = &s35390a_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
+
+	s35390a->rtc = rtc;
+
+	err = devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s35390a,
+					     &s35390a->pinctrl);
+	if (err)
+		return err;
+
+	/* If no pinctrl config is defined in DT, fallback to previous behaviour */
+	if (!s35390a->mode_init) {
+		err = s35390a_update_mode(s35390a, 1, S35390A_MODE_WAKEUP, 0);
+		if (err)
+			return err;
+	}
+
 	err_read = s35390a_read_status(s35390a, &status1);
 	if (err_read < 0) {
 		dev_err(dev, "error resetting chip\n");
@@ -507,34 +822,8 @@ static int s35390a_probe(struct i2c_client *client)
 	else
 		s35390a->twentyfourhour = 0;
 
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
 	device_set_wakeup_capable(dev, 1);
 
-	rtc->ops = &s35390a_rtc_ops;
-	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	rtc->range_max = RTC_TIMESTAMP_END_2099;
-
-	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
-	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
-
-	if (status1 & S35390A_FLAG_INT2)
-		rtc_update_irq(rtc, 1, RTC_AF);
-
 	nvmem_cfg.priv = s35390a;
 	err = devm_rtc_nvmem_register(rtc, &nvmem_cfg);
 	if (err)
@@ -545,7 +834,7 @@ static int s35390a_probe(struct i2c_client *client)
 
 static struct i2c_driver s35390a_driver = {
 	.driver		= {
-		.name	= "rtc-s35390a",
+		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(s35390a_of_match),
 	},
 	.probe		= s35390a_probe,

-- 
2.54.0

