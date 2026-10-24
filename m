Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839900;
	b=VYAOzcLf8HJRP4nxdBsI1iJURE4Ki0vovHP/ydIvtlH3zKJjQHdyX77TcuSh+KasqC+m
	 /vaAKME5bNbkPQTNPuztjUDVnBpW6zYKByczLmO2xPouLt86QXxkLIFOG9zRHdPEswWzG
	 xqQy7sm+cvHbe33KhotUbSdDq65OMl2gdJWNFZ1OceUmlTVskiWGL5D9q2CCTG4+b+JG5
	 iCaOLuLWJUhUxOR4a/OR+BFGX7GfNO2eTAgZppQvlGH8kzlRsCZWxiMGR7j/hrjmu6lO+
	 iDXAVVfYMzL3v6FgdKYNgHaDiEw3z4RThARebKozhr83jYmTm7bvU1zhfbKOSIxckQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839900;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=sEyNkV+19qaFWUhLjfO8Dq5LZOCQ9Ap5kzRiIh87C4o=;
	b=kt55pxehd7jDMJlWnBL4ngjmOzeC3eNGyjaoDq6ymUtj4mkuG3VegmhnyZAXB32JzQ4w
	 4KSRdmHFIbCrwgUYybS50mo6i+gSTLNHiWuZ4sPc94cMqx8X7zZpK+HzRCq6WXGvg0raV
	 FZ31++uzZxhxwYGaSOkelpxlZ2AaAl6lflk8nzQ/jswYO3zszu6phSc8kRjRpNIvDLO7U
	 d5zp1s0l/aSLzrPyzylWCiB8ocOIOwkJ44gzULHGHWGw5OFSHx31NCHLBlcytlAqz3N6B
	 wMrUSQQcquTJqgLTlZi7h7Q3AFQkg7Q5I6AcE/UOqVd9rqS5n1upGAOzsDFks/Dt/Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43990606A320;
	Sat, 24 Oct 2026 11:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43990606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB912200145;
	Sat, 24 Oct 2026 13:04:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E21C200002;
	Sat, 24 Oct 2026 13:04:51 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 454301800068;
	Sat, 24 Oct 2026 19:04:48 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	potin.lai.pt@gmail.com
Cc: pankit.garg@nxp.com,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>,
	Daniel Aguirre <daniel.aguirre@nxp.com>
Subject: [PATCH v11 2/2] rtc: Add NXP PCF85053 driver support
Date: Sat, 24 Oct 2026 16:34:37 +0530
Message-Id: <20261024110437.2851275-2-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
References: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
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
X-Virus-Scanned: ClamAV using ClamSMTP

PCF85053 is i2c based RTC which supports timer and calendar
functionality.

Features supported:
1. Read/Write time
2. Get/Set Alarm
3. Wakeup Source
4. Generate up to 32768Hz clock output
5. Primary/Secondary i2c bus

Signed-off-by: Daniel Aguirre <daniel.aguirre@nxp.com>
Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
V10 -> V11: - When no firmware node is present, default to a standalone primary
	      interface and claim time-register write ownership, allowing devices
	      instantiated through the I2C new_device interface to probe and set
	      time.
	    - Use device_property_*() for the interface and write-ownership
	      properties.
V9 -> V10: - Move the PCF85053 MAINTAINERS entry from the binding patch.
	   - No driver functional changes.
V8 -> V9: - Select REGMAP_I2C; avoid RMW on write-0-to-clear status flags.
	  - Fix alarm IRQ enable/flag sequencing; disable unused OFIE/CIE sources.
	  - Limit alarms to the 24-hour window; handle alarm don't-care values.
	  - Restrict alarm IRQ handling to the primary interface.
	  - Handle CLKOUT ownership via XCLK; register provider only with #clock-cells.
	  - Use managed wake IRQ handling.
V7 -> V8: - read_time(): evaluate the status register and return -EINVAL when the
	    OF (oscillator fail) or RTCF flag is set, instead of ignoring it and
	    using a corrupted time.
	  - set_time()/set_alarm(): stop forcing 24h/binary mode; format values to
	    match the mode the device is currently configured for, avoiding
	    corruption of the running clock and the read-only secondary interface.
	  - set_time(): read-modify-write the interleaved time/alarm block so a
	    previously configured alarm is preserved instead of being cleared.
	  - Clear OF/RTCF after a valid set_time() and add an RTC_VL_CLR ioctl so the
	    RTC no longer reports data permanently invalid after a power loss.
	  - clkout: use devm_clk_hw_register()/devm_of_clk_add_hw_provider() so the
	    clock provider is removed on unbind/probe failure, fixing the leak and
	    potential use-after-free.
V6 -> V7: - Addressed minor cleanups from review: use dev_get_drvdata()/dev_set_drvdata()
	    consistently, fix alarm IRQ dev_id handling, and switch to devm_device_init_wakeup().
	  - Simplified time/alarm programming by forcing 24h + binary mode in hardware,
	    dropping complex 12h/BCD handling in setters.
	  - Documented the 2000-2099 supported year range, explaining how the 00-99 year
	    register maps to leap-year behavior in the device.
V5 -> V6: no changes
V4 -> V5: no changes
V3 -> V4: - Handle multi-host ownership explicitly using primary/secondary bus hadling.
          - Probe no longer changes any CTRL bits unconditionally and do not clear ST/AF/OF
            avoiding lost interrupts or silent mode changes.
          - Read/Set time & alarm now respect HF(12/24h) and DM(BCD/BIN) converting
            hour fields correctly for all combinations.
          - Minor changes: drop noisy warnings, tidy error paths/comments.
V2 -> V3: Add MAINTAINERS file changes to this patch
V1 -> V2: no changes
---
 MAINTAINERS                |   8 +
 drivers/rtc/Kconfig        |  11 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-pcf85053.c | 912 +++++++++++++++++++++++++++++++++++++
 4 files changed, 932 insertions(+)
 create mode 100644 drivers/rtc/rtc-pcf85053.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c..79b3fc694120 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19788,6 +19788,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
 F:	drivers/extcon/extcon-ptn5150.c
 
+NXP RTC PCF85053 DRIVER
+M:	Pankit Garg <pankit.garg@nxp.com>
+M:	Lakshay Piplani <lakshay.piplani@nxp.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
+F:	drivers/rtc/rtc-pcf85053.c
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	linux-sound@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..d261d71a0af3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1005,6 +1005,17 @@ config RTC_DRV_PCF85063
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf85063.
 
+config RTC_DRV_PCF85053
+	tristate "NXP PCF85053"
+	depends on OF && I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the NXP PCF85053 I2C Bootable CPU RTC
+	  chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf85053.
+
 config RTC_DRV_RV3029C2
 	tristate "Micro Crystal RV3029/3049"
 	depends on RTC_I2C_AND_SPI
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0347645b021f..9bf36f3b76e7 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_RTC_DRV_PALMAS)	+= rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF85063)	+= rtc-pcf85063.o
+obj-$(CONFIG_RTC_DRV_PCF85053)	+= rtc-pcf85053.o
 obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
 obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
diff --git a/drivers/rtc/rtc-pcf85053.c b/drivers/rtc/rtc-pcf85053.c
new file mode 100644
index 000000000000..59cbd9dfde7c
--- /dev/null
+++ b/drivers/rtc/rtc-pcf85053.c
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2025-2026 NXP
+
+#include <linux/bcd.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+
+#define PCF85053_REG_SC		0x00 /* seconds */
+#define PCF85053_REG_SCA	0x01 /* alarm */
+#define PCF85053_REG_MN		0x02 /* minutes */
+#define PCF85053_REG_MNA	0x03 /* alarm */
+#define PCF85053_REG_HR		0x04 /* hour */
+#define PCF85053_REG_HRA	0x05 /* alarm */
+#define PCF85053_REG_DW		0x06 /* day of week */
+#define PCF85053_REG_DM		0x07 /* day of month */
+#define PCF85053_REG_MO		0x08 /* month */
+#define PCF85053_REG_YR		0x09 /* year */
+#define PCF85053_REG_CTRL	0x0A /* timer control */
+#define PCF85053_REG_ST		0x0B /* status */
+#define PCF85053_REG_CLKO	0x0C /* clock out */
+#define PCF85053_REG_ACC	0x14 /* xclk access */
+
+#define PCF85053_BIT_AF		BIT(7)
+#define PCF85053_BIT_ST		BIT(7)
+#define PCF85053_BIT_DM		BIT(6)
+#define PCF85053_BIT_HF		BIT(5)
+#define PCF85053_BIT_DSM	BIT(4)
+#define PCF85053_BIT_AIE	BIT(3)
+#define PCF85053_BIT_OFIE	BIT(2)
+#define PCF85053_BIT_CIE	BIT(1)
+#define PCF85053_BIT_TWO	BIT(0)
+#define PCF85053_BIT_XCLK	BIT(7)
+
+#define PCF85053_REG_CLKO_F_MASK	0x03 /* Frequency mask */
+#define PCF85053_REG_CLKO_CKE	0x80 /* clock out enabled */
+#define PCF85053_BIT_OF	BIT(6)
+#define PCF85053_BIT_RTCF	BIT(5)
+#define PCF85053_BIT_CIF	BIT(4)
+
+#define PCF85053_HR_PM	BIT(7)
+#define PCF85053_HR_24H_MASK	GENMASK(5, 0)
+
+/*
+ * Writing 0xC0-0xFF to an alarm register (SCA/MNA/HRA) marks that field as a
+ * "don't care" so it is excluded from the alarm match, e.g. for periodic
+ * alarms (datasheet 7.3). Every value in that range has the top two bits set,
+ * so test for those bits.
+ */
+#define PCF85053_ALARM_DONT_CARE_BITS	GENMASK(7, 6)
+
+struct pcf85053_config {
+	const struct regmap_config regmap;
+	unsigned has_alarms:1;
+};
+
+struct pcf85053 {
+	struct rtc_device *rtc;
+	struct regmap	*regmap;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw clkout_hw;
+#endif
+	bool is_primary;
+};
+
+static inline int pcf85053_read_two_bit(struct pcf85053 *pcf85053, bool *two)
+{
+	unsigned int ctrl;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+	if (err)
+		return err;
+
+	*two = !!(ctrl & PCF85053_BIT_TWO);
+
+	return 0;
+}
+
+static int pcf85053_time_write_access(struct pcf85053 *pcf85053,
+				      bool *write_access)
+{
+	bool two;
+	int err;
+
+	err = pcf85053_read_two_bit(pcf85053, &two);
+	if (err)
+		return err;
+
+	/* Primary writes iff TWO=1; secondary writes iff TWO=0 */
+	*write_access = pcf85053->is_primary ? two : !two;
+
+	return 0;
+}
+
+/*
+ * AF/OF/RTCF/CIF are write-0-to-clear. Write 1 to every flag except the ones
+ * being cleared; a read-modify-write could drop a flag asserted between the
+ * read and the write. BVL[2:0] are read-only and the reserved bit is 0.
+ */
+static int pcf85053_clear_status(struct regmap *regmap, u8 clr)
+{
+	u8 keep = PCF85053_BIT_AF | PCF85053_BIT_OF |
+		  PCF85053_BIT_RTCF | PCF85053_BIT_CIF;
+
+	return regmap_write(regmap, PCF85053_REG_ST, keep & ~clr);
+}
+
+static int pcf85053_set_aie(struct regmap *regmap, bool enable)
+{
+	return regmap_update_bits(regmap, PCF85053_REG_CTRL,
+				  PCF85053_BIT_AIE,
+				  enable ? PCF85053_BIT_AIE : 0);
+}
+
+static int pcf85053_get_alarm_mode(struct device *dev,
+				   unsigned char *alarm_enable, unsigned char *alarm_flag)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	unsigned int val;
+	int err;
+
+	if (alarm_enable) {
+		err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &val);
+		if (err)
+			return err;
+
+		*alarm_enable = !!(val & PCF85053_BIT_AIE);
+	}
+
+	if (alarm_flag) {
+		err = regmap_read(pcf85053->regmap, PCF85053_REG_ST, &val);
+		if (err)
+			return err;
+
+		*alarm_flag = !!(val & PCF85053_BIT_AF);
+	}
+
+	return 0;
+}
+
+static irqreturn_t pcf85053_irq(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	unsigned int st;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_ST, &st);
+	if (err || !(st & PCF85053_BIT_AF))
+		return IRQ_NONE;
+
+	/*
+	 * The alarm matches every day; disable AIE to make it one-shot. Mask
+	 * the interrupt before clearing AF so there is no window where AF is
+	 * cleared but AIE is still able to re-assert the line.
+	 */
+	err = pcf85053_set_aie(pcf85053->regmap, false);
+	if (err)
+		dev_err_ratelimited(dev, "failed to disable alarm interrupt\n");
+
+	/* Clear AF to release the interrupt line. */
+	err = pcf85053_clear_status(pcf85053->regmap, PCF85053_BIT_AF);
+	if (err) {
+		dev_err_ratelimited(dev, "failed to clear alarm flag\n");
+		return IRQ_HANDLED;
+	}
+
+	rtc_update_irq(pcf85053->rtc, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static int pcf85053_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	unsigned int ctrl, st, h12;
+	bool is_24h, is_bin;
+	u8 regs[10], hr;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+	if (err)
+		return err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_ST, &st);
+	if (err)
+		return err;
+
+	/*
+	 * The stored time cannot be trusted when the clock is stopped (ST is
+	 * set), when the oscillator has failed since the last valid time (OF is
+	 * set on power-up or oscillator failure), or when the device lost power
+	 * entirely (RTCF is set). None of these flags are cleared automatically,
+	 * so treat any of them as an invalid time.
+	 */
+	if ((ctrl & PCF85053_BIT_ST) ||
+	    (st & (PCF85053_BIT_OF | PCF85053_BIT_RTCF)))
+		return -EINVAL;
+
+	err = regmap_bulk_read(pcf85053->regmap, PCF85053_REG_SC, regs, sizeof(regs));
+	if (err)
+		return err;
+
+	if (ctrl & PCF85053_BIT_DM) {
+		tm->tm_sec = regs[PCF85053_REG_SC] & 0x7F;
+		tm->tm_min = regs[PCF85053_REG_MN] & 0x7F;
+		tm->tm_mday = regs[PCF85053_REG_DM] & 0x3F;
+		tm->tm_mon = (regs[PCF85053_REG_MO] & 0x1F) - 1;
+		tm->tm_year = regs[PCF85053_REG_YR] + 100;
+	} else {
+		tm->tm_sec = bcd2bin(regs[PCF85053_REG_SC] & 0x7F);
+		tm->tm_min = bcd2bin(regs[PCF85053_REG_MN] & 0x7F);
+		tm->tm_mday = bcd2bin(regs[PCF85053_REG_DM] & 0x3F);
+		tm->tm_mon = bcd2bin(regs[PCF85053_REG_MO] & 0x1F) - 1;
+		tm->tm_year = bcd2bin(regs[PCF85053_REG_YR]) + 100;
+	}
+	/* Hardware weekday is 1-7 (Sunday=1); Linux tm_wday is 0-6. */
+	tm->tm_wday = (regs[PCF85053_REG_DW] & 0x07) - 1;
+
+	hr = regs[PCF85053_REG_HR];
+	is_24h = ctrl & PCF85053_BIT_HF;
+	is_bin = ctrl & PCF85053_BIT_DM;
+
+	if (is_24h) {
+		tm->tm_hour = is_bin
+		? (hr & PCF85053_HR_24H_MASK)
+		: bcd2bin(hr & PCF85053_HR_24H_MASK);
+	} else {
+		h12 = is_bin ? (hr & PCF85053_HR_24H_MASK)
+			     : bcd2bin(hr & PCF85053_HR_24H_MASK);
+
+		tm->tm_hour = (h12 == 12) ? ((hr & PCF85053_HR_PM) ? 12 : 0) :
+			       ((hr & PCF85053_HR_PM) ? h12 + 12 : h12);
+	}
+
+	return 0;
+}
+
+/* Encode a value into the current data mode: binary when DM=1, BCD otherwise. */
+static inline u8 pcf85053_encode_val(u8 val, bool is_bin)
+{
+	return is_bin ? val : bin2bcd(val);
+}
+
+/*
+ * Encode an hour (0-23) into the current hour format: stored directly in
+ * 24-hour mode, or mapped to 1-12 with the PM flag (BIT7) in 12-hour mode.
+ */
+static u8 pcf85053_encode_hour(int hour, bool is_24h, bool is_bin)
+{
+	u8 h12, val;
+
+	if (is_24h) {
+		val = hour & PCF85053_HR_24H_MASK;
+		return is_bin ? val : bin2bcd(val);
+	}
+
+	if (hour == 0) {
+		h12 = 12;		/* 12 AM */
+		val = 0;
+	} else if (hour < 12) {
+		h12 = hour;		/* 1-11 AM */
+		val = 0;
+	} else if (hour == 12) {
+		h12 = 12;		/* 12 PM */
+		val = PCF85053_HR_PM;
+	} else {
+		h12 = hour - 12;	/* 1-11 PM */
+		val = PCF85053_HR_PM;
+	}
+
+	val |= is_bin ? h12 : bin2bcd(h12);
+	return val;
+}
+
+static int pcf85053_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	bool is_24h, is_bin, write_access;
+	unsigned int ctrl;
+	int err, ret;
+	u8 buf[10];
+
+	/* TWO gates time-register writes: primary owns it at TWO=1, secondary at TWO=0. */
+	err = pcf85053_time_write_access(pcf85053, &write_access);
+	if (err)
+		return err;
+
+	if (!write_access)
+		return -EACCES;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+	if (err)
+		return err;
+
+	/*
+	 * Format the values to match the hour format (HF) and data mode (DM)
+	 * the device is already configured for, rather than forcing those bits.
+	 * The secondary interface cannot write the control register, and
+	 * changing HF or DM without converting the stored values would make the
+	 * hardware reinterpret the existing time.
+	 */
+	is_24h = !!(ctrl & PCF85053_BIT_HF);
+	is_bin = !!(ctrl & PCF85053_BIT_DM);
+
+	/*
+	 * The datasheet requires seconds through years to be transferred in
+	 * one I2C access. Alarm registers are interleaved at 01h, 03h and 05h,
+	 * so read the whole block first and write those bytes back unchanged.
+	 */
+	err = regmap_bulk_read(pcf85053->regmap, PCF85053_REG_SC, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	buf[0] = pcf85053_encode_val(tm->tm_sec, is_bin) & 0x7F;
+	buf[2] = pcf85053_encode_val(tm->tm_min, is_bin) & 0x7F;
+	buf[4] = pcf85053_encode_hour(tm->tm_hour, is_24h, is_bin);
+	/* Hardware weekday is 1-7 (Sunday=1); Linux tm_wday is 0-6. */
+	buf[6] = (tm->tm_wday + 1) & 0x07;
+	buf[7] = pcf85053_encode_val(tm->tm_mday, is_bin) & 0x3F;
+	buf[8] = pcf85053_encode_val(tm->tm_mon + 1, is_bin) & 0x1F;
+	buf[9] = pcf85053_encode_val(tm->tm_year - 100, is_bin);
+
+	if (pcf85053->is_primary) {
+		err = regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
+					 PCF85053_BIT_ST, PCF85053_BIT_ST);
+		if (err)
+			return err;
+
+		ret = regmap_bulk_write(pcf85053->regmap, PCF85053_REG_SC, buf, sizeof(buf));
+		err = regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
+					 PCF85053_BIT_ST, 0);
+		if (ret)
+			return ret;
+		if (err)
+			return err;
+
+		/* ST=1 sets OF, so clear the validity flags after releasing ST. */
+		return pcf85053_clear_status(pcf85053->regmap,
+					     PCF85053_BIT_OF | PCF85053_BIT_RTCF);
+	}
+
+	return regmap_bulk_write(pcf85053->regmap, PCF85053_REG_SC, buf, sizeof(buf));
+}
+
+/* See PCF85053_ALARM_DONT_CARE_BITS: both top bits set means "don't care". */
+static bool pcf85053_alarm_is_dont_care(u8 val)
+{
+	return (val & PCF85053_ALARM_DONT_CARE_BITS) == PCF85053_ALARM_DONT_CARE_BITS;
+}
+
+static int pcf85053_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *tm)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	unsigned int ctrl, h12;
+	bool is_24h, is_bin, pm;
+	u8 buf[5];
+	u8 hr;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+	if (err)
+		return err;
+
+	err = regmap_bulk_read(pcf85053->regmap, PCF85053_REG_SCA, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	is_24h = !!(ctrl & PCF85053_BIT_HF);
+	is_bin = !!(ctrl & PCF85053_BIT_DM);
+
+	/*
+	 * Report don't-care fields as -1; the RTC core fills those in from the
+	 * current time, so it never tries to interpret the wildcard encoding as
+	 * a real value.
+	 */
+	if (pcf85053_alarm_is_dont_care(buf[0])) /* SCA */
+		tm->time.tm_sec = -1;
+	else
+		tm->time.tm_sec = is_bin ? (buf[0] & 0x7F) : bcd2bin(buf[0] & 0x7F);
+
+	if (pcf85053_alarm_is_dont_care(buf[2])) /* MNA */
+		tm->time.tm_min = -1;
+	else
+		tm->time.tm_min = is_bin ? (buf[2] & 0x7F) : bcd2bin(buf[2] & 0x7F);
+
+	hr = buf[4];
+
+	if (pcf85053_alarm_is_dont_care(hr)) {
+		tm->time.tm_hour = -1;
+	} else if (is_24h) {
+		tm->time.tm_hour = is_bin
+		? (hr & PCF85053_HR_24H_MASK)
+		: bcd2bin(hr & PCF85053_HR_24H_MASK);
+	} else {
+		pm = !!(hr & PCF85053_HR_PM);
+
+		if (is_bin)
+			h12 = (hr & PCF85053_HR_24H_MASK);
+		else
+			h12 = (bcd2bin(hr & PCF85053_HR_24H_MASK));
+
+		if (h12 == 12)
+			h12 = 0;
+		tm->time.tm_hour = pm ? (h12 + 12) : h12;
+	}
+
+	return pcf85053_get_alarm_mode(dev, &tm->enabled, &tm->pending);
+}
+
+static int pcf85053_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	bool is_24h, is_bin;
+	struct rtc_time now_tm;
+	time64_t now, later;
+	unsigned int ctrl;
+	u8 sec, min, hr;
+	int err;
+
+	/* Secondary has read-only access to the alarm registers. */
+	if (!pcf85053->is_primary)
+		return -EACCES;
+
+	/* The alarm matches only HH:MM:SS, so reject requests beyond 24 hours. */
+	later = rtc_tm_to_time64(&tm->time);
+
+	err = pcf85053_rtc_read_time(dev, &now_tm);
+	if (err)
+		return err;
+
+	now = rtc_tm_to_time64(&now_tm);
+
+	if (later <= now)
+		return -EINVAL;
+
+	if (later - now > pcf85053->rtc->alarm_offset_max)
+		return -ERANGE;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+	if (err)
+		return err;
+
+	/*
+	 * Format the alarm values to match the hour format (HF) and data mode
+	 * (DM) the device is already configured for, rather than forcing those
+	 * bits. Changing HF or DM without converting the stored time would
+	 * corrupt the running clock.
+	 */
+	is_24h = !!(ctrl & PCF85053_BIT_HF);
+	is_bin = !!(ctrl & PCF85053_BIT_DM);
+
+	/*
+	 * Disable AIE, program the alarm, clear any match that occurred while
+	 * programming, then set AIE to the requested state. Clearing AF after
+	 * the writes (not before) ensures a stale/transient match cannot leave
+	 * AF asserted once the interrupt is enabled.
+	 */
+	err = pcf85053_set_aie(pcf85053->regmap, false);
+	if (err)
+		return err;
+
+	sec = pcf85053_encode_val(tm->time.tm_sec, is_bin) & 0x7F;
+	min = pcf85053_encode_val(tm->time.tm_min, is_bin) & 0x7F;
+	hr  = pcf85053_encode_hour(tm->time.tm_hour, is_24h, is_bin);
+
+	err = regmap_write(pcf85053->regmap, PCF85053_REG_SCA, sec);
+	if (err)
+		return err;
+
+	err = regmap_write(pcf85053->regmap, PCF85053_REG_MNA, min);
+	if (err)
+		return err;
+
+	err = regmap_write(pcf85053->regmap, PCF85053_REG_HRA, hr);
+	if (err)
+		return err;
+
+	err = pcf85053_clear_status(pcf85053->regmap, PCF85053_BIT_AF);
+	if (err)
+		return err;
+
+	return pcf85053_set_aie(pcf85053->regmap, tm->enabled);
+}
+
+static int pcf85053_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	int err;
+
+	/* Only the primary interface may write the control/status registers. */
+	if (!pcf85053->is_primary)
+		return -EACCES;
+
+	dev_dbg(dev, "%s: alarm enable=%d\n", __func__, enabled);
+
+	if (!enabled)
+		return pcf85053_set_aie(pcf85053->regmap, false);
+
+	err = pcf85053_clear_status(pcf85053->regmap, PCF85053_BIT_AF);
+	if (err)
+		return err;
+
+	return pcf85053_set_aie(pcf85053->regmap, true);
+}
+
+static int pcf85053_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct pcf85053 *pcf85053 = dev_get_drvdata(dev);
+	unsigned int val = 0, vl_status = 0;
+	int status;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		status = regmap_read(pcf85053->regmap, PCF85053_REG_ST, &val);
+		if (status)
+			return status;
+
+		if (val & (PCF85053_BIT_OF | PCF85053_BIT_RTCF))
+			vl_status |= RTC_VL_DATA_INVALID;
+
+		return put_user(vl_status, (unsigned int __user *)arg);
+
+	case RTC_VL_CLR:
+		/* Only the primary interface may write the status register. */
+		if (!pcf85053->is_primary)
+			return -EACCES;
+
+		return pcf85053_clear_status(pcf85053->regmap,
+					     PCF85053_BIT_OF | PCF85053_BIT_RTCF);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+#ifdef CONFIG_COMMON_CLK
+/*
+ * Handling of the clkout
+ */
+
+#define clkout_hw_to_pcf85053(_hw) container_of(_hw, struct pcf85053, clkout_hw)
+
+static const int clkout_rates[] = {
+	32768,
+	1024,
+	32,
+	1,
+};
+
+/*
+ * XCLK selects the CLKOUT owner: primary has write access when XCLK=1,
+ * secondary when XCLK=0. Only the primary can change XCLK, so it claims
+ * ownership; the secondary may proceed only while XCLK=0.
+ */
+static int pcf85053_clkout_write_access(struct pcf85053 *pcf85053)
+{
+	unsigned int acc;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_ACC, &acc);
+	if (err)
+		return err;
+
+	if (pcf85053->is_primary) {
+		if (acc & PCF85053_BIT_XCLK)
+			return 0;
+
+		return regmap_update_bits(pcf85053->regmap, PCF85053_REG_ACC,
+					  PCF85053_BIT_XCLK, PCF85053_BIT_XCLK);
+	}
+
+	return (acc & PCF85053_BIT_XCLK) ? -EACCES : 0;
+}
+
+static unsigned long pcf85053_clkout_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct pcf85053 *pcf85053 = clkout_hw_to_pcf85053(hw);
+	unsigned int val = 0;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CLKO, &val);
+	if (err)
+		return 0;
+
+	val &= PCF85053_REG_CLKO_F_MASK;
+	return clkout_rates[val];
+}
+
+static int pcf85053_clkout_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	int i;
+	unsigned long best = 0;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++) {
+		if (clkout_rates[i] <= req->rate) {
+			best = clkout_rates[i];
+			break;
+		}
+	}
+	if (!best)
+		best = clkout_rates[ARRAY_SIZE(clkout_rates) - 1];
+
+	req->rate = best;
+	return 0;
+}
+
+static int pcf85053_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct pcf85053 *pcf85053 = clkout_hw_to_pcf85053(hw);
+	unsigned int val = 0;
+	int err, i;
+
+	err = pcf85053_clkout_write_access(pcf85053);
+	if (err)
+		return err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CLKO, &val);
+	if (err)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
+		if (clkout_rates[i] == rate) {
+			val &= ~PCF85053_REG_CLKO_F_MASK;
+			val |= i;
+			return regmap_write(pcf85053->regmap, PCF85053_REG_CLKO, val);
+		}
+
+	return -EINVAL;
+}
+
+static int pcf85053_clkout_control(struct clk_hw *hw, bool enable)
+{
+	struct pcf85053 *pcf85053 = clkout_hw_to_pcf85053(hw);
+	unsigned int val = 0;
+	int err;
+
+	err = pcf85053_clkout_write_access(pcf85053);
+	if (err)
+		return err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CLKO, &val);
+	if (err)
+		return err;
+
+	if (enable)
+		val |= PCF85053_REG_CLKO_CKE;
+	else
+		val &= ~PCF85053_REG_CLKO_CKE;
+
+	return regmap_write(pcf85053->regmap, PCF85053_REG_CLKO, val);
+}
+
+static int pcf85053_clkout_prepare(struct clk_hw *hw)
+{
+	return pcf85053_clkout_control(hw, 1);
+}
+
+static void pcf85053_clkout_unprepare(struct clk_hw *hw)
+{
+	pcf85053_clkout_control(hw, 0);
+}
+
+static int pcf85053_clkout_is_prepared(struct clk_hw *hw)
+{
+	struct pcf85053 *pcf85053 = clkout_hw_to_pcf85053(hw);
+	unsigned int val = 0;
+	int err;
+
+	err = regmap_read(pcf85053->regmap, PCF85053_REG_CLKO, &val);
+	if (err)
+		return err;
+
+	return !!(val & PCF85053_REG_CLKO_CKE);
+}
+
+static const struct clk_ops pcf85053_clkout_ops = {
+	.prepare = pcf85053_clkout_prepare,
+	.unprepare = pcf85053_clkout_unprepare,
+	.is_prepared = pcf85053_clkout_is_prepared,
+	.recalc_rate = pcf85053_clkout_recalc_rate,
+	.determine_rate = pcf85053_clkout_determine_rate,
+	.set_rate = pcf85053_clkout_set_rate,
+};
+
+static int pcf85053_clkout_register_clk(struct pcf85053 *pcf85053)
+{
+	struct device *dev = pcf85053->rtc->dev.parent;
+	struct device_node *node = dev->of_node;
+	struct clk_init_data init = {};
+	int err;
+
+	/*
+	 * Only expose CLKOUT as a clock provider when the device tree opts in
+	 * with #clock-cells; otherwise there is nothing to register.
+	 */
+	if (!device_property_present(dev, "#clock-cells"))
+		return 0;
+
+	init.name = "pcf85053-clkout";
+	init.ops = &pcf85053_clkout_ops;
+	init.flags = 0;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	pcf85053->clkout_hw.init = &init;
+
+	/* optional override of the clockname */
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	err = devm_clk_hw_register(dev, &pcf85053->clkout_hw);
+	if (err)
+		return err;
+
+	/* devres-managed so the provider is removed on unbind/probe failure. */
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &pcf85053->clkout_hw);
+}
+#endif
+
+static const struct rtc_class_ops pcf85053_rtc_ops = {
+	.read_time	= pcf85053_rtc_read_time,
+	.set_time	= pcf85053_rtc_set_time,
+	.read_alarm	= pcf85053_rtc_read_alarm,
+	.set_alarm	= pcf85053_rtc_set_alarm,
+	.alarm_irq_enable = pcf85053_irq_enable,
+	.ioctl		= pcf85053_ioctl,
+};
+
+static const struct pcf85053_config config_pcf85053 = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x1D,
+	},
+	.has_alarms = 1,
+};
+
+static int pcf85053_probe(struct i2c_client *client)
+{
+	const struct pcf85053_config *config;
+	struct device *dev = &client->dev;
+	const char *iface = NULL;
+	struct pcf85053 *pcf85053;
+	bool no_fwnode;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	pcf85053 = devm_kzalloc(dev, sizeof(struct pcf85053),
+				GFP_KERNEL);
+	if (!pcf85053)
+		return -ENOMEM;
+
+	config = i2c_get_match_data(client);
+	if (!config)
+		return -ENODEV;
+
+	pcf85053->regmap = devm_regmap_init_i2c(client, &config->regmap);
+	if (IS_ERR(pcf85053->regmap))
+		return PTR_ERR(pcf85053->regmap);
+
+	dev_set_drvdata(dev, pcf85053);
+
+	no_fwnode = !dev_fwnode(dev);
+
+	pcf85053->is_primary = true;
+
+	if (!no_fwnode) {
+		err = device_property_read_string(dev, "nxp,interface", &iface);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Failed to read nxp,interface\n");
+
+		if (!strcmp(iface, "secondary"))
+			pcf85053->is_primary = false;
+		else if (strcmp(iface, "primary"))
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value for nxp,interface: %s\n",
+					     iface);
+	}
+
+	if (pcf85053->is_primary) {
+		bool claim_write_access;
+		unsigned int ctrl;
+
+		claim_write_access = no_fwnode ||
+				     device_property_read_bool(dev, "nxp,write-access");
+
+		err = regmap_read(pcf85053->regmap, PCF85053_REG_CTRL, &ctrl);
+		if (err)
+			return err;
+
+		if (claim_write_access) {
+			if (!(ctrl & PCF85053_BIT_TWO)) {
+				err = regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
+							 PCF85053_BIT_TWO, PCF85053_BIT_TWO);
+				if (err)
+					return err;
+			}
+			dev_dbg(dev, "Ownership set: TWO=1 (primary writes)\n");
+		} else {
+			/* Relinquish ownership (TWO=0) so the secondary may write. */
+			if (ctrl & PCF85053_BIT_TWO) {
+				err = regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
+							 PCF85053_BIT_TWO, 0);
+				if (err)
+					return err;
+			}
+			dev_dbg(dev, "Default ownership set: TWO=0 (secondary writes)\n");
+		}
+	}
+
+	pcf85053->rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(pcf85053->rtc))
+		return PTR_ERR(pcf85053->rtc);
+
+	/*
+	 * The year register is 00-99 with (year % 4) leap-year logic, so map
+	 * it to 2000-2099 to keep leap years correct.
+	 */
+	pcf85053->rtc->ops = &pcf85053_rtc_ops;
+	pcf85053->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pcf85053->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	/*
+	 * The alarm has second, minute and hour fields but no date, so it can
+	 * only match within a 24-hour window. Bound the offset so the core
+	 * rejects requests further out instead of silently arming an alarm
+	 * within the next day.
+	 */
+	pcf85053->rtc->alarm_offset_max = 24 * 60 * 60;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85053->rtc->features);
+	clear_bit(RTC_FEATURE_ALARM, pcf85053->rtc->features);
+
+	if (config->has_alarms && pcf85053->is_primary && client->irq > 0) {
+		/*
+		 * ALRT is shared by the alarm (AIE), oscillator-fail (OFIE) and
+		 * RTC-clear (CIE) sources. This driver only services the alarm,
+		 * so disable the other two; otherwise ALRT could stay asserted
+		 * with AF=0 and the handler could not clear it.
+		 */
+		err = regmap_update_bits(pcf85053->regmap, PCF85053_REG_CTRL,
+					 PCF85053_BIT_OFIE | PCF85053_BIT_CIE, 0);
+		if (err)
+			return err;
+
+		err = devm_request_threaded_irq(dev, client->irq,
+						NULL, pcf85053_irq,
+						IRQF_ONESHOT,
+						"pcf85053", dev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "unable to request IRQ %d\n",
+					     client->irq);
+
+		set_bit(RTC_FEATURE_ALARM, pcf85053->rtc->features);
+		err = devm_device_init_wakeup(dev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to initialize wakeup\n");
+		err = devm_pm_set_wake_irq(dev, client->irq);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to set wake IRQ\n");
+	}
+
+#ifdef CONFIG_COMMON_CLK
+	err = pcf85053_clkout_register_clk(pcf85053);
+	if (err)
+		return err;
+#endif
+
+	return devm_rtc_register_device(pcf85053->rtc);
+}
+
+static const struct i2c_device_id pcf85053_id[] = {
+	{ "pcf85053", .driver_data = (kernel_ulong_t)&config_pcf85053 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf85053_id);
+
+static const struct of_device_id pcf85053_of_match[] = {
+	{ .compatible = "nxp,pcf85053", .data = &config_pcf85053 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pcf85053_of_match);
+
+static struct i2c_driver pcf85053_driver = {
+	.driver		= {
+		.name	= "rtc-pcf85053",
+		.of_match_table = of_match_ptr(pcf85053_of_match),
+	},
+	.probe		= pcf85053_probe,
+	.id_table	= pcf85053_id,
+};
+
+module_i2c_driver(pcf85053_driver);
+
+MODULE_AUTHOR("Pankit Garg <pankit.garg@nxp.com>");
+MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
+MODULE_DESCRIPTION("NXP pcf85053 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

