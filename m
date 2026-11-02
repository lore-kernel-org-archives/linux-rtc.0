Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624857;
	b=p1ZCDuHmy5g/lS8Tg+lDfjoTgJlcMzflc+wNeZUCaBC3ZUUkIfAWhg/2//CSjOtyGZQB
	 wTbslh5n8V2Vb99A8NsuEk45gFLX9Eho7VTa6xZ6Xfs41GNTO3bPw9m5nhNixoSkzPxa4
	 f9ImcK1NvJ6sBEl+DwsdRMFPHBJkL4Z8bjEAMX3G6pgGhaOcJxX50R2aSimv/+v63ErPD
	 NnTnTlGrG/Lehx2xWmVYzS3sMpBE2lpilqxacYbhtahqaUjZCxOdMmZEm4LEY1zeoBW3l
	 0PaBB/dJyHxWoWV7KgUM6SCJ5W4Sa1DAte8gPnGsp3kUtqaE69Y51pH06s4HLskcDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624857;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=v/K6VG3HgpGjkaf+e9pnW9D0rn7GuwP3Yu/cl5FHdMI=;
	b=fP79/z4zKTK6I+x8RxIMdEYR+vdbx3IKWhGj4q5aHl6MVPynYwp19xiUzZ+B5Oui+t2N
	 +cl+/wlbRKHxji6JAUQnxa4qi/e1tVTpstXpNfMXxrVPiT1iQr4dYqe/jHDrB6ZPmqu0Z
	 dSJnra4MugYB3rJ4tRrWGCVCezYcNdPqg219e3yTaIPuN/EqgihYOQNVwbJnXApqIBS2p
	 puppWkLmlRM/6pmVi44xfBApVvmSl9xpWPfq3BDCma0jZ5PRf6bBnbWvRMtKM6qLJ0Ktb
	 z0WXzKLXXTwNE0sospSoBG90khFKIZ0wd/C7O6WNRC3oi7TjZhShzv35+E+oFZ647gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SgNL4TTk;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F84606A327;
	Mon,  2 Nov 2026 13:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F84606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SgNL4TTk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AE7C0C4FECD;
	Mon,  2 Nov 2026 13:08:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96B5C60750;
	Mon,  2 Nov 2026 13:07:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9F9F103291B2;
	Mon,  2 Nov 2026 14:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793624849; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=v/K6VG3HgpGjkaf+e9pnW9D0rn7GuwP3Yu/cl5FHdMI=;
	b=SgNL4TTkFIz/bGZE4qSh0Mw8ijXXH35rfmgfmzpOekX2NJ3nqKPL4FhcpbWfQoj/gRFv23
	Ppyp7OYI3HDD1mj8yWGGEvhTDqqH9jvRryGgycmX5NedOkavIGWrA3sQx2ls5Ep1IkhR5c
	K0NI+yk0EGazPqlq2PNXeIQTXiMNI3tsoqQiR1XrBDOZwRU0Ezkc+ecwm2PHDL09DCnjAI
	FmPKVlKktZw/cIomj/h/hVfRUkUwDcR6hOMTqfSFUEw5ko+8PEuFipCtz5VmzqvNkMItaI
	FzUZeN1JU2dSJv64Q0tgBhTaDaOc9bXPMGA3/H1doF6htmvdygc1dDX39ooclA==
From: Herve Codina <herve.codina@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/3] rtc: pcf2127: Add support for the clkout clock
Date: Mon,  2 Nov 2026 14:07:10 +0100
Message-ID: <20261102130712.25104-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102130712.25104-1-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

All devices handled by the pcf2127 driver (i.e. PCF2127, PCF2129,
PCA2129 and PCF2131) have support for an output clock available at their
CLKOUT pins.

The clock frequency can be configured from 1 Hz to 32768 Hz and the
clock can be fully disabled putting the CLKOUT pin in HiZ.

Add support for this clkout output clock.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 186 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 49542cc53411..1bb84f72cf5f 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -17,6 +17,7 @@
  *             https://www.nxp.com/docs/en/data-sheet/PCF2131DS.pdf
  */
 
+#include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/bcd.h>
@@ -60,6 +61,8 @@
 /* CLKOUT control register */
 #define PCF2127_REG_CLKOUT		0x0f
 #define PCF2127_BIT_CLKOUT_OTPR			BIT(5)
+#define PCF2127_CLKOUT_COF			GENMASK(2, 0)
+#define PCF2127_CLKOUT_COF_HIZ			7
 /* Watchdog registers */
 #define PCF2127_REG_WD_CTL		0x10
 #define PCF2127_BIT_WD_CTL_TF0			BIT(0)
@@ -211,6 +214,11 @@ struct pcf2127 {
 	bool irq_enabled;
 	time64_t ts[PCF2127_MAX_TS_SUPPORTED]; /* Timestamp values. */
 	bool ts_valid[PCF2127_MAX_TS_SUPPORTED];  /* Timestamp valid indication. */
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw clkout_hw;
+	u32 clkout_cof;
+	bool clkout_enabled;
+#endif
 };
 
 /*
@@ -626,6 +634,180 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
 	return devm_watchdog_register_device(dev, &pcf2127->wdd);
 }
 
+#ifdef CONFIG_COMMON_CLK
+#define clkout_hw_to_pcf2127(_hw) container_of(_hw, struct pcf2127, clkout_hw)
+
+/* Rates indexed by COF values */
+static int pcf2127_clkout_rates[] = {
+	32768,
+	16384,
+	8192,
+	4096,
+	2048,
+	1024,
+	1,
+	0, /* 0Hz (COF 0b111) will put the clockout signal to HiZ */
+};
+
+static u32 pcf2127_clkout_rate2cof(unsigned long rate)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcf2127_clkout_rates); i++) {
+		if (pcf2127_clkout_rates[i] <= rate)
+			return i;
+	}
+
+	return 0; /* Maximum output clock rate */
+}
+
+static int pcf2127_clkout_cof2rate(u32 cof)
+{
+	return pcf2127_clkout_rates[cof];
+}
+
+static unsigned long pcf2127_clkout_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
+
+	return pcf2127_clkout_cof2rate(pcf2127->clkout_cof);
+}
+
+static int pcf2127_clkout_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	u32 cof;
+
+	cof = pcf2127_clkout_rate2cof(req->rate);
+	req->rate = pcf2127_clkout_cof2rate(cof);
+
+	return 0;
+}
+
+static int pcf2127_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
+	u32 cof;
+	int ret;
+
+	cof = pcf2127_clkout_rate2cof(rate);
+
+	/*
+	 * Setting COF will enable the clock (i.e. output not in HiZ anymore)
+	 * Perform the operation only if already enabled.
+	 * Otherwise, do nothing. The expected COF will be set on prepare()
+	 */
+	if (pcf2127->clkout_enabled) {
+		ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
+					 PCF2127_CLKOUT_COF,
+					 FIELD_PREP(PCF2127_CLKOUT_COF, cof));
+		if (ret)
+			return ret;
+	}
+
+	pcf2127->clkout_cof = cof;
+	return 0;
+}
+
+static int pcf2127_clkout_control(struct clk_hw *hw, bool enable)
+{
+	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
+	u32 cof;
+	int ret;
+
+	cof = enable ? pcf2127->clkout_cof : PCF2127_CLKOUT_COF_HIZ;
+
+	ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
+				 PCF2127_CLKOUT_COF,
+				 FIELD_PREP(PCF2127_CLKOUT_COF, cof));
+	if (ret)
+		return ret;
+
+	pcf2127->clkout_enabled = enable;
+	return 0;
+}
+
+static int pcf2127_clkout_prepare(struct clk_hw *hw)
+{
+	return pcf2127_clkout_control(hw, true);
+}
+
+static void pcf2127_clkout_unprepare(struct clk_hw *hw)
+{
+	pcf2127_clkout_control(hw, false);
+}
+
+static int pcf2127_clkout_is_prepared(struct clk_hw *hw)
+{
+	struct pcf2127 *pcf2127 = clkout_hw_to_pcf2127(hw);
+
+	return pcf2127->clkout_enabled;
+}
+
+static const struct clk_ops pcf2127_clkout_ops = {
+	.prepare = pcf2127_clkout_prepare,
+	.unprepare = pcf2127_clkout_unprepare,
+	.is_prepared = pcf2127_clkout_is_prepared,
+	.recalc_rate = pcf2127_clkout_recalc_rate,
+	.determine_rate = pcf2127_clkout_determine_rate,
+	.set_rate = pcf2127_clkout_set_rate,
+};
+
+static int pcf2127_clkout_init(struct device *dev, struct pcf2127 *pcf2127)
+{
+	struct clk_init_data init = {};
+	const char *name;
+	u32 clkout;
+	int ret;
+
+	/*
+	 * Backward compatibility
+	 *
+	 * The output clock is enabled by default in the hardware.
+	 *
+	 * Handling this clock in a clock driver can lead to stop this clock if
+	 * it is unused. To avoid that and be backward compatible, use the clock
+	 * driver only if we have been told to.
+	 */
+	if (!device_property_present(dev, "#clock-cells"))
+		return 0;
+
+	/* optional override of the clockname */
+	ret = device_property_read_string(dev, "clock-output-names", &name);
+
+	init.name = ret ? "pcf2127-clkout" : name;
+	init.ops = &pcf2127_clkout_ops;
+	pcf2127->clkout_hw.init = &init;
+
+	/* Get the initial value for the COF field */
+	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &clkout);
+	if (ret)
+		return ret;
+
+	pcf2127->clkout_enabled = true;
+	pcf2127->clkout_cof = FIELD_GET(PCF2127_CLKOUT_COF, clkout);
+	if (pcf2127->clkout_cof == PCF2127_CLKOUT_COF_HIZ) {
+		pcf2127->clkout_enabled = false;
+		pcf2127->clkout_cof = 0; /* Maximum rate (32768Hz) */
+	}
+
+	/* register the clock */
+	ret = devm_clk_hw_register(dev, &pcf2127->clkout_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &pcf2127->clkout_hw);
+}
+#else
+static int pcf2127_clkout_init(struct device *dev, struct pcf2127 *pcf2127)
+{
+	return 0;
+}
+#endif
+
 /* Alarm */
 static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
@@ -1319,6 +1501,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 	pcf2127_watchdog_init(dev, pcf2127);
 
+	ret = pcf2127_clkout_init(dev, pcf2127);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Disable battery low/switch-over timestamp and interrupts.
 	 * Clear battery interrupt flags which can block new trigger events.
-- 
2.56.0

