Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5942FCB7
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107506; cv=none; b=RiI1KXVp/PREP+U+TGABiGhmNi0aTabM1bvS14LDJCWBmtUDWd1uFqoWgRj0ixXCegISuH3O3r90C2eJbwdZ9LVLF+KgARkMjtf//6zk8buhJtg8bKGmB8tcOaEi1CCmwH6gPZXmDmBIgvCZCsiWgxr3DkeTd5umos/yN4kLTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107506; c=relaxed/simple;
	bh=6UIFMuAWn+MOW/yWn5Z1SIDBs5DoTk2T2BrB8ro/0Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OR0JhjkFg4n6vl3pL9rqPybcuH5V7N8AQ20oaVl0zDQgO52Dmvau4Gj3J3V/fbExMGiXX2qnuZuK6uduNMk1XZD9w9Qti52EjfQti2fdpQEIvbv1HdypB0oT08kZUiAWxCIiyA30FjpJPj6BmS8wrxLJ2sd4QccF9cptXBKprec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=DLJ7E1nR; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="DLJ7E1nR"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202608071258053aa2c025af000207a9
        for <linux-rtc@vger.kernel.org>;
        Fri, 07 Aug 2026 14:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iKfVzn8Vftj6bw2MSm/OU4HW96AhumUBAC182UHvreQ=;
 b=DLJ7E1nR2xb2LDsM9HGSVNirGBA+6cnr8GxwegGqWCWqp5o2C5dhzwXU5jnAtOtKEBeK7x
 lb1eyd/Gc+gpAf1V7bD72TEOOEyU0jxJYvzM0xVRw1MlmZymG5TS622q1xVFdUbGNg8tA6oF
 rJ0C9smnyKXhl1KiA5WlYDm4iohjLc3EfnWhNNXrXFakVGXD/x0+4RHSpRaDlJhHq6ny53kD
 8oCzPhfVhQhCYcL+TqyhFHHTic+LU6XIUgfoq8nn/h6Oyd15jIEPnDsKbXp6ZUBQQRmXDirX
 nVLJZwQuHC9qwHP3sFMr5cl2LIyVsCvTquFH8xx5N+f52D2dr98S52dA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH] rtc: pcf85063: add 1 Hz update interrupt (UIE) support
Date: Fri,  7 Aug 2026 14:57:52 +0200
Message-ID: <20260807125757.2908175-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The PCF85063A/RV8263 have no dedicated 1 Hz update interrupt, but their
countdown timer can be sourced from a 1 Hz clock (TCF = 1 Hz, T = 1) to
generate a periodic interrupt on the INT pin. Use it to offload UIE to
the hardware, following the pattern of other RTC drivers: the timer is
enabled from set_alarm()/alarm_irq_enable() whenever uie_rtctimer is
active, and the IRQ handler reports RTC_UF when the timer flag (TF) is
set.

RTC_FEATURE_UPDATE_INTERRUPT is now only cleared when no usable interrupt
is wired, preserving the polling emulation for those configurations.

Co-developed-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/rtc/rtc-pcf85063.c | 97 ++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 01e209d88f5f3..76675b75388e4 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -44,6 +44,7 @@
 #define PCF85063_REG_CTRL2		0x01
 #define PCF85063_CTRL2_AF		BIT(6)
 #define PCF85063_CTRL2_AIE		BIT(7)
+#define PCF85063_CTRL2_TF		BIT(3)
 
 #define PCF85063_REG_OFFSET		0x02
 #define PCF85063_OFFSET_SIGN_BIT	6	/* 2's complement sign bit */
@@ -63,6 +64,14 @@
 #define PCF85063_REG_ALM_S		0x0b
 #define PCF85063_AEN			BIT(7)
 
+#define PCF85063_REG_TIMER_VALUE	0x10
+#define PCF85063_REG_TIMER_MODE		0x11
+#define PCF85063_TIMER_MODE_TI_TP	BIT(0)
+#define PCF85063_TIMER_MODE_TIE		BIT(1)
+#define PCF85063_TIMER_MODE_TE		BIT(2)
+#define PCF85063_TIMER_MODE_TCF_MASK	GENMASK(4, 3)
+#define PCF85063_TIMER_MODE_TCF_1HZ	(2 << 3)
+
 struct pcf85063_config {
 	struct regmap_config regmap;
 	unsigned has_alarms:1;
@@ -188,12 +197,64 @@ static int pcf85063_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
+/*
+ * The chip has no dedicated 1 Hz update interrupt. Drive the countdown timer
+ * at 1 Hz to emulate it, so the RTC core can offload UIE to the hardware
+ * instead of polling. A free-running timer is left untouched to preserve its
+ * phase across the per-second re-arming done by the core.
+ */
+static int pcf85063_set_timer_1hz(struct pcf85063 *pcf85063, bool enable)
+{
+	unsigned int mask = PCF85063_TIMER_MODE_TCF_MASK |
+			    PCF85063_TIMER_MODE_TIE |
+			    PCF85063_TIMER_MODE_TI_TP |
+			    PCF85063_TIMER_MODE_TE;
+	unsigned int mode = 0;
+	unsigned int cur;
+	int ret;
+
+	if (enable)
+		mode = PCF85063_TIMER_MODE_TCF_1HZ | PCF85063_TIMER_MODE_TIE |
+		       PCF85063_TIMER_MODE_TI_TP | PCF85063_TIMER_MODE_TE;
+
+	ret = regmap_read(pcf85063->regmap, PCF85063_REG_TIMER_MODE, &cur);
+	if (ret)
+		return ret;
+
+	if ((cur & mask) == mode)
+		return 0;
+
+	/* Stop the counter before changing its reload value. */
+	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_TIMER_MODE,
+				 PCF85063_TIMER_MODE_TE, 0);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		ret = regmap_write(pcf85063->regmap, PCF85063_REG_TIMER_VALUE, 1);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+					 PCF85063_CTRL2_TF, 0);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_TIMER_MODE,
+				  mask, mode);
+}
+
 static int pcf85063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
 	u8 buf[5];
 	int ret;
 
+	ret = pcf85063_set_timer_1hz(pcf85063, pcf85063->rtc->uie_rtctimer.enabled);
+	if (ret)
+		return ret;
+
 	buf[0] = bin2bcd(alrm->time.tm_sec);
 	buf[1] = bin2bcd(alrm->time.tm_min);
 	buf[2] = bin2bcd(alrm->time.tm_hour);
@@ -212,22 +273,32 @@ static int pcf85063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
 				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
-				  alrm->enabled ? PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_CTRL2_AF);
+				  pcf85063->rtc->aie_timer.enabled ?
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_CTRL2_AF);
 }
 
 static int pcf85063_rtc_alarm_irq_enable(struct device *dev,
 					 unsigned int enabled)
 {
 	struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pcf85063_set_timer_1hz(pcf85063, pcf85063->rtc->uie_rtctimer.enabled);
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
 				  PCF85063_CTRL2_AIE,
-				  enabled ? PCF85063_CTRL2_AIE : 0);
+				  pcf85063->rtc->aie_timer.enabled ?
+				  PCF85063_CTRL2_AIE : 0);
 }
 
 static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
 {
 	struct pcf85063 *pcf85063 = dev_id;
+	unsigned long events = RTC_IRQF;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int mask = 0;
 	unsigned int val;
 	int err;
 
@@ -236,14 +307,23 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PCF85063_CTRL2_AF) {
-		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
-		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-				   PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
-				   0);
-		return IRQ_HANDLED;
+		events |= RTC_AF;
+		mask |= PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF;
+		ret = IRQ_HANDLED;
+	}
+
+	if (val & PCF85063_CTRL2_TF) {
+		events |= RTC_UF;
+		mask |= PCF85063_CTRL2_TF;
+		ret = IRQ_HANDLED;
+	}
+
+	if (ret == IRQ_HANDLED) {
+		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2, mask, 0);
+		rtc_update_irq(pcf85063->rtc, 1, events);
 	}
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static int pcf85063_read_offset(struct device *dev, long *offset)
@@ -607,6 +687,7 @@ static int pcf85063_probe(struct device *dev, struct regmap *regmap, int irq,
 			dev_warn(&pcf85063->rtc->dev,
 				 "unable to request IRQ, alarms disabled\n");
 		} else {
+			set_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
 			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 			device_init_wakeup(dev, true);
 			err = dev_pm_set_wake_irq(dev, irq);
-- 
2.55.0

