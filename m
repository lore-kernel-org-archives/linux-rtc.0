Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0F377541
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935503; cv=none; b=W6Chd+1C/bJ37toqmSPOtJJrxzgbqwY0ub/oz0seaROGe70YbPfcGugIcu0EY6oCREWvOTgdG7POEeEDjzD7p5wYz7KOAb3dPTiuUqSBA0qFQcg/gi7Xzue9rT0vT2tbYnf79KhsS5hg8q3JPSNdrwiaoUqOFSvA/JjOwd1n++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935503; c=relaxed/simple;
	bh=u6cJ7MqHLoBC0SNILU3oVgTt8kyg2HB9w5otXpHsJaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGjpcQmozpGZ8zSWgIF0CDQx1kO2pUUwwY//0Rh5t9CYlVqt0h3xkM96brxLrsHc2Ts+rNJhZu2npGI8oziw0ssjNfqVxIU6EBCMXSMoFhTvrb5evOezZO5Hi2PRJrou9zcUH4ujQkAtlXjCpc7i5YfZX6q+0rcjPwEmPIOMup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=WsFgI7zp; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="WsFgI7zp"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260828164449275e87e83300020776
        for <linux-rtc@vger.kernel.org>;
        Fri, 28 Aug 2026 18:44:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dvxXBp5fhAtU91nrjYLGWWLKhFtygUw1X+1C/cjNPxw=;
 b=WsFgI7zpQSOzTdQhd/2GUadY9mOd7PXfSbW0JGD54u1e8OMSkVPFIchO2EompoM5rCC6pp
 Dtgedu3UkmP3AHbNcrN0wp25vezUtdT3147KobTHoAtMqYBTa1IGXDuqbybCc7ksCL94jtv8
 aiNEsdre+o54xUuNrh6CAog+zxATAeABZogBVyerkL+CRLBV+OfNp1yvw+NgSHFr4XxhSB4n
 BRne4v57ydN32qD4vYxlaxsWVS4RWcwxm5hudGjpTOPt2ozt1rxN/GluTxyrZcOW/vhxnLGH
 d6gaBI669537SXDxDTE7UhJpL2O576Tjz1KBU2MVbgqFVOpXKzBrsS0w==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-rtc@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 4/4] rtc: pcf85063: add 1 Hz update interrupt (UIE) support
Date: Fri, 28 Aug 2026 18:44:42 +0200
Message-ID: <20260828164445.3907839-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
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
Changelog:
v3:
- replaced racy regmap_write() with regmap_update_bits() in IRQ handler
- the timer flag (TF) is write-0-to-clear, so every read-modify-write of
  CTRL2 preserves it by writing it back as 1
v2:
- preserve AF bit in pcf85063_set_timer_1hz()
- faster and less racy (regarding AF flag) pcf85063_rtc_handle_irq()
- https://lore.kernel.org/all/20260820112437.3715237-1-alexander.sverdlin@siemens.com/

 drivers/rtc/rtc-pcf85063.c | 121 +++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index a3af86456ccfc..32952e73f2f1c 100644
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
@@ -188,20 +197,75 @@ static int pcf85063_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
+		/* Clear TF but preserve AF */
+		ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
+					 PCF85063_CTRL2_TF | PCF85063_CTRL2_AF, PCF85063_CTRL2_AF);
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
 	buf[3] = bin2bcd(alrm->time.tm_mday);
 	buf[4] = PCF85063_AEN; /* Do not match on week day */
 
+	/* Preserve TF */
 	ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-				 PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF, 0);
+				 PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF,
+				 PCF85063_CTRL2_TF);
 	if (ret)
 		return ret;
 
@@ -211,23 +275,33 @@ static int pcf85063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 
 	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF,
-				  alrm->enabled ? PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF : PCF85063_CTRL2_AF);
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF,
+				  pcf85063->rtc->aie_timer.enabled ?
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF :
+				  PCF85063_CTRL2_AF | PCF85063_CTRL2_TF);
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
-				  PCF85063_CTRL2_AIE,
-				  enabled ? PCF85063_CTRL2_AIE : 0);
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_TF,
+				  pcf85063->rtc->aie_timer.enabled ?
+				  PCF85063_CTRL2_AIE | PCF85063_CTRL2_TF : PCF85063_CTRL2_TF);
 }
 
 static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
 {
 	struct pcf85063 *pcf85063 = dev_id;
+	unsigned long events = RTC_IRQF;
+	irqreturn_t ret = IRQ_NONE;
 	unsigned int val;
 	int err;
 
@@ -236,13 +310,33 @@ static irqreturn_t pcf85063_rtc_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (val & PCF85063_CTRL2_AF) {
-		rtc_update_irq(pcf85063->rtc, 1, RTC_IRQF | RTC_AF);
+		events |= RTC_AF;
+		val &= ~PCF85063_CTRL2_AF;
+		ret = IRQ_HANDLED;
+	} else {
+		/* Preserve AF if it comes after the above regmap_read() */
+		val |= PCF85063_CTRL2_AF;
+	}
+
+	if (val & PCF85063_CTRL2_TF) {
+		events |= RTC_UF;
+		val &= ~PCF85063_CTRL2_TF;
+		ret = IRQ_HANDLED;
+	} else {
+		/*
+		 * While not documented, TF demonstrates the same
+		 * write-1-to-preserve semantics as AF in real HW
+		 */
+		val |= PCF85063_CTRL2_TF;
+	}
+
+	if (ret == IRQ_HANDLED) {
 		regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-				   PCF85063_CTRL2_AF, 0);
-		return IRQ_HANDLED;
+				   PCF85063_CTRL2_AF | PCF85063_CTRL2_TF, val);
+		rtc_update_irq(pcf85063->rtc, 1, events);
 	}
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static int pcf85063_read_offset(struct device *dev, long *offset)
@@ -431,8 +525,8 @@ static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] == rate)
 			return regmap_update_bits(pcf85063->regmap,
 				PCF85063_REG_CTRL2,
-				PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
-				i | PCF85063_CTRL2_AF);
+				PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF,
+				i | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF);
 
 	return -EINVAL;
 }
@@ -461,8 +555,8 @@ static int pcf85063_clkout_control(struct clk_hw *hw, bool enable)
 	}
 
 	return regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
-				  PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF,
-				  buf | PCF85063_CTRL2_AF);
+				  PCF85063_REG_CLKO_F_MASK | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF,
+				  buf | PCF85063_CTRL2_AF | PCF85063_CTRL2_TF);
 }
 
 static int pcf85063_clkout_prepare(struct clk_hw *hw)
@@ -609,6 +703,7 @@ static int pcf85063_probe(struct device *dev, struct regmap *regmap, int irq,
 			dev_warn(&pcf85063->rtc->dev,
 				 "unable to request IRQ, alarms disabled\n");
 		} else {
+			set_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
 			set_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 			device_init_wakeup(dev, true);
 			err = dev_pm_set_wake_irq(dev, irq);
-- 
2.55.0

