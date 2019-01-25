Return-Path: <SRS0=r6Xw=QB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A0CC282C0
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679DE218D0
	for <linux-rtc@archiver.kernel.org>; Fri, 25 Jan 2019 14:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfAYOgW (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:36:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59873 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAYOgW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 Jan 2019 09:36:22 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aR-0001kc-II; Fri, 25 Jan 2019 15:36:03 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ukl@pengutronix.de>)
        id 1gn2aQ-0007B5-3L; Fri, 25 Jan 2019 15:36:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-rtc@vger.kernel.org
Subject: [PATCH 2/5] rtc: ds1307: forward declare chips array instead of a bunch of functions
Date:   Fri, 25 Jan 2019 15:35:55 +0100
Message-Id: <20190125143558.27450-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
References: <20190125143558.27450-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

There used to be 16 declarations for static functions. By just adding a
declaration for the chips array and reordering the functions the 16
function declarations can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-ds1307.c | 992 +++++++++++++++++++--------------------
 1 file changed, 482 insertions(+), 510 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index f7a47ee5cdf6..a4883d59d88d 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -184,289 +184,7 @@ struct chip_desc {
 						    bool);
 };
 
-static int ds1307_get_time(struct device *dev, struct rtc_time *t);
-static int ds1307_set_time(struct device *dev, struct rtc_time *t);
-static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled);
-static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
-static irqreturn_t rx8130_irq(int irq, void *dev_id);
-static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled);
-static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
-static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
-static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
-static int m41txx_rtc_read_offset(struct device *dev, long *offset);
-static int m41txx_rtc_set_offset(struct device *dev, long offset);
-
-static const struct rtc_class_ops rx8130_rtc_ops = {
-	.read_time      = ds1307_get_time,
-	.set_time       = ds1307_set_time,
-	.read_alarm     = rx8130_read_alarm,
-	.set_alarm      = rx8130_set_alarm,
-	.alarm_irq_enable = rx8130_alarm_irq_enable,
-};
-
-static const struct rtc_class_ops mcp794xx_rtc_ops = {
-	.read_time      = ds1307_get_time,
-	.set_time       = ds1307_set_time,
-	.read_alarm     = mcp794xx_read_alarm,
-	.set_alarm      = mcp794xx_set_alarm,
-	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
-};
-
-static const struct rtc_class_ops m41txx_rtc_ops = {
-	.read_time      = ds1307_get_time,
-	.set_time       = ds1307_set_time,
-	.read_alarm	= ds1337_read_alarm,
-	.set_alarm	= ds1337_set_alarm,
-	.alarm_irq_enable = ds1307_alarm_irq_enable,
-	.read_offset	= m41txx_rtc_read_offset,
-	.set_offset	= m41txx_rtc_set_offset,
-};
-
-static const struct chip_desc chips[last_ds_type] = {
-	[ds_1307] = {
-		.nvram_offset	= 8,
-		.nvram_size	= 56,
-	},
-	[ds_1308] = {
-		.nvram_offset	= 8,
-		.nvram_size	= 56,
-	},
-	[ds_1337] = {
-		.alarm		= 1,
-		.century_reg	= DS1307_REG_MONTH,
-		.century_bit	= DS1337_BIT_CENTURY,
-	},
-	[ds_1338] = {
-		.nvram_offset	= 8,
-		.nvram_size	= 56,
-	},
-	[ds_1339] = {
-		.alarm		= 1,
-		.century_reg	= DS1307_REG_MONTH,
-		.century_bit	= DS1337_BIT_CENTURY,
-		.bbsqi_bit	= DS1339_BIT_BBSQI,
-		.trickle_charger_reg = 0x10,
-		.do_trickle_setup = &do_trickle_setup_ds1339,
-	},
-	[ds_1340] = {
-		.century_reg	= DS1307_REG_HOUR,
-		.century_enable_bit = DS1340_BIT_CENTURY_EN,
-		.century_bit	= DS1340_BIT_CENTURY,
-		.do_trickle_setup = &do_trickle_setup_ds1339,
-		.trickle_charger_reg = 0x08,
-	},
-	[ds_1341] = {
-		.century_reg	= DS1307_REG_MONTH,
-		.century_bit	= DS1337_BIT_CENTURY,
-	},
-	[ds_1388] = {
-		.offset		= 1,
-		.trickle_charger_reg = 0x0a,
-	},
-	[ds_3231] = {
-		.alarm		= 1,
-		.century_reg	= DS1307_REG_MONTH,
-		.century_bit	= DS1337_BIT_CENTURY,
-		.bbsqi_bit	= DS3231_BIT_BBSQW,
-	},
-	[rx_8130] = {
-		.alarm		= 1,
-		/* this is battery backed SRAM */
-		.nvram_offset	= 0x20,
-		.nvram_size	= 4,	/* 32bit (4 word x 8 bit) */
-		.offset		= 0x10,
-		.irq_handler = rx8130_irq,
-		.rtc_ops = &rx8130_rtc_ops,
-	},
-	[m41t0] = {
-		.rtc_ops	= &m41txx_rtc_ops,
-	},
-	[m41t00] = {
-		.rtc_ops	= &m41txx_rtc_ops,
-	},
-	[m41t11] = {
-		/* this is battery backed SRAM */
-		.nvram_offset	= 8,
-		.nvram_size	= 56,
-		.rtc_ops	= &m41txx_rtc_ops,
-	},
-	[mcp794xx] = {
-		.alarm		= 1,
-		/* this is battery backed SRAM */
-		.nvram_offset	= 0x20,
-		.nvram_size	= 0x40,
-		.irq_handler = mcp794xx_irq,
-		.rtc_ops = &mcp794xx_rtc_ops,
-	},
-};
-
-static const struct i2c_device_id ds1307_id[] = {
-	{ "ds1307", ds_1307 },
-	{ "ds1308", ds_1308 },
-	{ "ds1337", ds_1337 },
-	{ "ds1338", ds_1338 },
-	{ "ds1339", ds_1339 },
-	{ "ds1388", ds_1388 },
-	{ "ds1340", ds_1340 },
-	{ "ds1341", ds_1341 },
-	{ "ds3231", ds_3231 },
-	{ "m41t0", m41t0 },
-	{ "m41t00", m41t00 },
-	{ "m41t11", m41t11 },
-	{ "mcp7940x", mcp794xx },
-	{ "mcp7941x", mcp794xx },
-	{ "pt7c4338", ds_1307 },
-	{ "rx8025", rx_8025 },
-	{ "isl12057", ds_1337 },
-	{ "rx8130", rx_8130 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds1307_id);
-
-#ifdef CONFIG_OF
-static const struct of_device_id ds1307_of_match[] = {
-	{
-		.compatible = "dallas,ds1307",
-		.data = (void *)ds_1307
-	},
-	{
-		.compatible = "dallas,ds1308",
-		.data = (void *)ds_1308
-	},
-	{
-		.compatible = "dallas,ds1337",
-		.data = (void *)ds_1337
-	},
-	{
-		.compatible = "dallas,ds1338",
-		.data = (void *)ds_1338
-	},
-	{
-		.compatible = "dallas,ds1339",
-		.data = (void *)ds_1339
-	},
-	{
-		.compatible = "dallas,ds1388",
-		.data = (void *)ds_1388
-	},
-	{
-		.compatible = "dallas,ds1340",
-		.data = (void *)ds_1340
-	},
-	{
-		.compatible = "dallas,ds1341",
-		.data = (void *)ds_1341
-	},
-	{
-		.compatible = "maxim,ds3231",
-		.data = (void *)ds_3231
-	},
-	{
-		.compatible = "st,m41t0",
-		.data = (void *)m41t0
-	},
-	{
-		.compatible = "st,m41t00",
-		.data = (void *)m41t00
-	},
-	{
-		.compatible = "st,m41t11",
-		.data = (void *)m41t11
-	},
-	{
-		.compatible = "microchip,mcp7940x",
-		.data = (void *)mcp794xx
-	},
-	{
-		.compatible = "microchip,mcp7941x",
-		.data = (void *)mcp794xx
-	},
-	{
-		.compatible = "pericom,pt7c4338",
-		.data = (void *)ds_1307
-	},
-	{
-		.compatible = "epson,rx8025",
-		.data = (void *)rx_8025
-	},
-	{
-		.compatible = "isil,isl12057",
-		.data = (void *)ds_1337
-	},
-	{
-		.compatible = "epson,rx8130",
-		.data = (void *)rx_8130
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ds1307_of_match);
-#endif
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id ds1307_acpi_ids[] = {
-	{ .id = "DS1307", .driver_data = ds_1307 },
-	{ .id = "DS1308", .driver_data = ds_1308 },
-	{ .id = "DS1337", .driver_data = ds_1337 },
-	{ .id = "DS1338", .driver_data = ds_1338 },
-	{ .id = "DS1339", .driver_data = ds_1339 },
-	{ .id = "DS1388", .driver_data = ds_1388 },
-	{ .id = "DS1340", .driver_data = ds_1340 },
-	{ .id = "DS1341", .driver_data = ds_1341 },
-	{ .id = "DS3231", .driver_data = ds_3231 },
-	{ .id = "M41T0", .driver_data = m41t0 },
-	{ .id = "M41T00", .driver_data = m41t00 },
-	{ .id = "M41T11", .driver_data = m41t11 },
-	{ .id = "MCP7940X", .driver_data = mcp794xx },
-	{ .id = "MCP7941X", .driver_data = mcp794xx },
-	{ .id = "PT7C4338", .driver_data = ds_1307 },
-	{ .id = "RX8025", .driver_data = rx_8025 },
-	{ .id = "ISL12057", .driver_data = ds_1337 },
-	{ .id = "RX8130", .driver_data = rx_8130 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
-#endif
-
-/*
- * The ds1337 and ds1339 both have two alarms, but we only use the first
- * one (with a "seconds" field).  For ds1337 we expect nINTA is our alarm
- * signal; ds1339 chips have only one alarm signal.
- */
-static irqreturn_t ds1307_irq(int irq, void *dev_id)
-{
-	struct ds1307		*ds1307 = dev_id;
-	struct mutex		*lock = &ds1307->rtc->ops_lock;
-	int			stat, ret;
-
-	mutex_lock(lock);
-	ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &stat);
-	if (ret)
-		goto out;
-
-	if (stat & DS1337_BIT_A1I) {
-		stat &= ~DS1337_BIT_A1I;
-		regmap_write(ds1307->regmap, DS1337_REG_STATUS, stat);
-
-		ret = regmap_update_bits(ds1307->regmap, DS1337_REG_CONTROL,
-					 DS1337_BIT_A1IE, 0);
-		if (ret)
-			goto out;
-
-		rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
-	}
-
-out:
-	mutex_unlock(lock);
-
-	return IRQ_HANDLED;
-}
-
-/*----------------------------------------------------------------------*/
+static const struct chip_desc chips[last_ds_type];
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
@@ -692,19 +410,28 @@ static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled)
 				  enabled ? DS1337_BIT_A1IE : 0);
 }
 
-static const struct rtc_class_ops ds13xx_rtc_ops = {
-	.read_time	= ds1307_get_time,
-	.set_time	= ds1307_set_time,
-	.read_alarm	= ds1337_read_alarm,
-	.set_alarm	= ds1337_set_alarm,
-	.alarm_irq_enable = ds1307_alarm_irq_enable,
-};
-
-/*----------------------------------------------------------------------*/
+static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307, u32 ohms, bool diode)
+{
+	u8 setup = (diode) ? DS1307_TRICKLE_CHARGER_DIODE :
+		DS1307_TRICKLE_CHARGER_NO_DIODE;
 
-/*
- * Alarm support for rx8130 devices.
- */
+	switch (ohms) {
+	case 250:
+		setup |= DS1307_TRICKLE_CHARGER_250_OHM;
+		break;
+	case 2000:
+		setup |= DS1307_TRICKLE_CHARGER_2K_OHM;
+		break;
+	case 4000:
+		setup |= DS1307_TRICKLE_CHARGER_4K_OHM;
+		break;
+	default:
+		dev_warn(ds1307->dev,
+			 "Unsupported ohm value %u in dt\n", ohms);
+		return 0;
+	}
+	return setup;
+}
 
 static irqreturn_t rx8130_irq(int irq, void *dev_id)
 {
@@ -829,58 +556,479 @@ static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 				 sizeof(ctl));
 }
 
-static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
+static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	int ret, reg;
+
+	if (!test_bit(HAS_ALARM, &ds1307->flags))
+		return -EINVAL;
+
+	ret = regmap_read(ds1307->regmap, RX8130_REG_CONTROL0, &reg);
+	if (ret < 0)
+		return ret;
+
+	if (enabled)
+		reg |= RX8130_REG_CONTROL0_AIE;
+	else
+		reg &= ~RX8130_REG_CONTROL0_AIE;
+
+	return regmap_write(ds1307->regmap, RX8130_REG_CONTROL0, reg);
+}
+
+static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
+{
+	struct ds1307           *ds1307 = dev_id;
+	struct mutex            *lock = &ds1307->rtc->ops_lock;
+	int reg, ret;
+
+	mutex_lock(lock);
+
+	/* Check and clear alarm 0 interrupt flag. */
+	ret = regmap_read(ds1307->regmap, MCP794XX_REG_ALARM0_CTRL, &reg);
+	if (ret)
+		goto out;
+	if (!(reg & MCP794XX_BIT_ALMX_IF))
+		goto out;
+	reg &= ~MCP794XX_BIT_ALMX_IF;
+	ret = regmap_write(ds1307->regmap, MCP794XX_REG_ALARM0_CTRL, reg);
+	if (ret)
+		goto out;
+
+	/* Disable alarm 0. */
+	ret = regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
+				 MCP794XX_BIT_ALM0_EN, 0);
+	if (ret)
+		goto out;
+
+	rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
+
+out:
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
+static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	u8 regs[10];
+	int ret;
+
+	if (!test_bit(HAS_ALARM, &ds1307->flags))
+		return -EINVAL;
+
+	/* Read control and alarm 0 registers. */
+	ret = regmap_bulk_read(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
+			       sizeof(regs));
+	if (ret)
+		return ret;
+
+	t->enabled = !!(regs[0] & MCP794XX_BIT_ALM0_EN);
+
+	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
+	t->time.tm_sec = bcd2bin(regs[3] & 0x7f);
+	t->time.tm_min = bcd2bin(regs[4] & 0x7f);
+	t->time.tm_hour = bcd2bin(regs[5] & 0x3f);
+	t->time.tm_wday = bcd2bin(regs[6] & 0x7) - 1;
+	t->time.tm_mday = bcd2bin(regs[7] & 0x3f);
+	t->time.tm_mon = bcd2bin(regs[8] & 0x1f) - 1;
+	t->time.tm_year = -1;
+	t->time.tm_yday = -1;
+	t->time.tm_isdst = -1;
+
+	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
+		"enabled=%d polarity=%d irq=%d match=%lu\n", __func__,
+		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
+		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled,
+		!!(regs[6] & MCP794XX_BIT_ALMX_POL),
+		!!(regs[6] & MCP794XX_BIT_ALMX_IF),
+		(regs[6] & MCP794XX_MSK_ALMX_MATCH) >> 4);
+
+	return 0;
+}
+
+/*
+ * We may have a random RTC weekday, therefore calculate alarm weekday based
+ * on current weekday we read from the RTC timekeeping regs
+ */
+static int mcp794xx_alm_weekday(struct device *dev, struct rtc_time *tm_alarm)
+{
+	struct rtc_time tm_now;
+	int days_now, days_alarm, ret;
+
+	ret = ds1307_get_time(dev, &tm_now);
+	if (ret)
+		return ret;
+
+	days_now = div_s64(rtc_tm_to_time64(&tm_now), 24 * 60 * 60);
+	days_alarm = div_s64(rtc_tm_to_time64(tm_alarm), 24 * 60 * 60);
+
+	return (tm_now.tm_wday + days_alarm - days_now) % 7 + 1;
+}
+
+static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned char regs[10];
+	int wday, ret;
+
+	if (!test_bit(HAS_ALARM, &ds1307->flags))
+		return -EINVAL;
+
+	wday = mcp794xx_alm_weekday(dev, &t->time);
+	if (wday < 0)
+		return wday;
+
+	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
+		"enabled=%d pending=%d\n", __func__,
+		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
+		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon,
+		t->enabled, t->pending);
+
+	/* Read control and alarm 0 registers. */
+	ret = regmap_bulk_read(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
+			       sizeof(regs));
+	if (ret)
+		return ret;
+
+	/* Set alarm 0, using 24-hour and day-of-month modes. */
+	regs[3] = bin2bcd(t->time.tm_sec);
+	regs[4] = bin2bcd(t->time.tm_min);
+	regs[5] = bin2bcd(t->time.tm_hour);
+	regs[6] = wday;
+	regs[7] = bin2bcd(t->time.tm_mday);
+	regs[8] = bin2bcd(t->time.tm_mon + 1);
+
+	/* Clear the alarm 0 interrupt flag. */
+	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
+	/* Set alarm match: second, minute, hour, day, date, month. */
+	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
+	/* Disable interrupt. We will not enable until completely programmed */
+	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
+
+	ret = regmap_bulk_write(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
+				sizeof(regs));
+	if (ret)
+		return ret;
+
+	if (!t->enabled)
+		return 0;
+	regs[0] |= MCP794XX_BIT_ALM0_EN;
+	return regmap_write(ds1307->regmap, MCP794XX_REG_CONTROL, regs[0]);
+}
+
+static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	int ret, reg;
 
 	if (!test_bit(HAS_ALARM, &ds1307->flags))
 		return -EINVAL;
 
-	ret = regmap_read(ds1307->regmap, RX8130_REG_CONTROL0, &reg);
-	if (ret < 0)
-		return ret;
+	return regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
+				  MCP794XX_BIT_ALM0_EN,
+				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
+}
 
-	if (enabled)
-		reg |= RX8130_REG_CONTROL0_AIE;
+static int m41txx_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned int ctrl_reg;
+	u8 val;
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	val = ctrl_reg & M41TXX_M_CALIBRATION;
+
+	/* check if positive */
+	if (ctrl_reg & M41TXX_BIT_CALIB_SIGN)
+		*offset = (val * M41TXX_POS_OFFSET_STEP_PPB);
 	else
-		reg &= ~RX8130_REG_CONTROL0_AIE;
+		*offset = -(val * M41TXX_NEG_OFFSET_STEP_PPB);
 
-	return regmap_write(ds1307->regmap, RX8130_REG_CONTROL0, reg);
+	return 0;
+}
+
+static int m41txx_rtc_set_offset(struct device *dev, long offset)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned int ctrl_reg;
+
+	if ((offset < M41TXX_MIN_OFFSET) || (offset > M41TXX_MAX_OFFSET))
+		return -ERANGE;
+
+	if (offset >= 0) {
+		ctrl_reg = DIV_ROUND_CLOSEST(offset,
+					     M41TXX_POS_OFFSET_STEP_PPB);
+		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
+	} else {
+		ctrl_reg = DIV_ROUND_CLOSEST(abs(offset),
+					     M41TXX_NEG_OFFSET_STEP_PPB);
+	}
+
+	return regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL,
+				  M41TXX_M_CALIBRATION | M41TXX_BIT_CALIB_SIGN,
+				  ctrl_reg);
 }
 
-/*----------------------------------------------------------------------*/
+static const struct rtc_class_ops rx8130_rtc_ops = {
+	.read_time      = ds1307_get_time,
+	.set_time       = ds1307_set_time,
+	.read_alarm     = rx8130_read_alarm,
+	.set_alarm      = rx8130_set_alarm,
+	.alarm_irq_enable = rx8130_alarm_irq_enable,
+};
+
+static const struct rtc_class_ops mcp794xx_rtc_ops = {
+	.read_time      = ds1307_get_time,
+	.set_time       = ds1307_set_time,
+	.read_alarm     = mcp794xx_read_alarm,
+	.set_alarm      = mcp794xx_set_alarm,
+	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
+};
+
+static const struct rtc_class_ops m41txx_rtc_ops = {
+	.read_time      = ds1307_get_time,
+	.set_time       = ds1307_set_time,
+	.read_alarm	= ds1337_read_alarm,
+	.set_alarm	= ds1337_set_alarm,
+	.alarm_irq_enable = ds1307_alarm_irq_enable,
+	.read_offset	= m41txx_rtc_read_offset,
+	.set_offset	= m41txx_rtc_set_offset,
+};
+
+static const struct chip_desc chips[last_ds_type] = {
+	[ds_1307] = {
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
+	[ds_1308] = {
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
+	[ds_1337] = {
+		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
+	},
+	[ds_1338] = {
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
+	[ds_1339] = {
+		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
+		.bbsqi_bit	= DS1339_BIT_BBSQI,
+		.trickle_charger_reg = 0x10,
+		.do_trickle_setup = &do_trickle_setup_ds1339,
+	},
+	[ds_1340] = {
+		.century_reg	= DS1307_REG_HOUR,
+		.century_enable_bit = DS1340_BIT_CENTURY_EN,
+		.century_bit	= DS1340_BIT_CENTURY,
+		.do_trickle_setup = &do_trickle_setup_ds1339,
+		.trickle_charger_reg = 0x08,
+	},
+	[ds_1341] = {
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
+	},
+	[ds_1388] = {
+		.offset		= 1,
+		.trickle_charger_reg = 0x0a,
+	},
+	[ds_3231] = {
+		.alarm		= 1,
+		.century_reg	= DS1307_REG_MONTH,
+		.century_bit	= DS1337_BIT_CENTURY,
+		.bbsqi_bit	= DS3231_BIT_BBSQW,
+	},
+	[rx_8130] = {
+		.alarm		= 1,
+		/* this is battery backed SRAM */
+		.nvram_offset	= 0x20,
+		.nvram_size	= 4,	/* 32bit (4 word x 8 bit) */
+		.offset		= 0x10,
+		.irq_handler = rx8130_irq,
+		.rtc_ops = &rx8130_rtc_ops,
+	},
+	[m41t0] = {
+		.rtc_ops	= &m41txx_rtc_ops,
+	},
+	[m41t00] = {
+		.rtc_ops	= &m41txx_rtc_ops,
+	},
+	[m41t11] = {
+		/* this is battery backed SRAM */
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+		.rtc_ops	= &m41txx_rtc_ops,
+	},
+	[mcp794xx] = {
+		.alarm		= 1,
+		/* this is battery backed SRAM */
+		.nvram_offset	= 0x20,
+		.nvram_size	= 0x40,
+		.irq_handler = mcp794xx_irq,
+		.rtc_ops = &mcp794xx_rtc_ops,
+	},
+};
+
+static const struct i2c_device_id ds1307_id[] = {
+	{ "ds1307", ds_1307 },
+	{ "ds1308", ds_1308 },
+	{ "ds1337", ds_1337 },
+	{ "ds1338", ds_1338 },
+	{ "ds1339", ds_1339 },
+	{ "ds1388", ds_1388 },
+	{ "ds1340", ds_1340 },
+	{ "ds1341", ds_1341 },
+	{ "ds3231", ds_3231 },
+	{ "m41t0", m41t0 },
+	{ "m41t00", m41t00 },
+	{ "m41t11", m41t11 },
+	{ "mcp7940x", mcp794xx },
+	{ "mcp7941x", mcp794xx },
+	{ "pt7c4338", ds_1307 },
+	{ "rx8025", rx_8025 },
+	{ "isl12057", ds_1337 },
+	{ "rx8130", rx_8130 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1307_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id ds1307_of_match[] = {
+	{
+		.compatible = "dallas,ds1307",
+		.data = (void *)ds_1307
+	},
+	{
+		.compatible = "dallas,ds1308",
+		.data = (void *)ds_1308
+	},
+	{
+		.compatible = "dallas,ds1337",
+		.data = (void *)ds_1337
+	},
+	{
+		.compatible = "dallas,ds1338",
+		.data = (void *)ds_1338
+	},
+	{
+		.compatible = "dallas,ds1339",
+		.data = (void *)ds_1339
+	},
+	{
+		.compatible = "dallas,ds1388",
+		.data = (void *)ds_1388
+	},
+	{
+		.compatible = "dallas,ds1340",
+		.data = (void *)ds_1340
+	},
+	{
+		.compatible = "dallas,ds1341",
+		.data = (void *)ds_1341
+	},
+	{
+		.compatible = "maxim,ds3231",
+		.data = (void *)ds_3231
+	},
+	{
+		.compatible = "st,m41t0",
+		.data = (void *)m41t0
+	},
+	{
+		.compatible = "st,m41t00",
+		.data = (void *)m41t00
+	},
+	{
+		.compatible = "st,m41t11",
+		.data = (void *)m41t11
+	},
+	{
+		.compatible = "microchip,mcp7940x",
+		.data = (void *)mcp794xx
+	},
+	{
+		.compatible = "microchip,mcp7941x",
+		.data = (void *)mcp794xx
+	},
+	{
+		.compatible = "pericom,pt7c4338",
+		.data = (void *)ds_1307
+	},
+	{
+		.compatible = "epson,rx8025",
+		.data = (void *)rx_8025
+	},
+	{
+		.compatible = "isil,isl12057",
+		.data = (void *)ds_1337
+	},
+	{
+		.compatible = "epson,rx8130",
+		.data = (void *)rx_8130
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ds1307_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ds1307_acpi_ids[] = {
+	{ .id = "DS1307", .driver_data = ds_1307 },
+	{ .id = "DS1308", .driver_data = ds_1308 },
+	{ .id = "DS1337", .driver_data = ds_1337 },
+	{ .id = "DS1338", .driver_data = ds_1338 },
+	{ .id = "DS1339", .driver_data = ds_1339 },
+	{ .id = "DS1388", .driver_data = ds_1388 },
+	{ .id = "DS1340", .driver_data = ds_1340 },
+	{ .id = "DS1341", .driver_data = ds_1341 },
+	{ .id = "DS3231", .driver_data = ds_3231 },
+	{ .id = "M41T0", .driver_data = m41t0 },
+	{ .id = "M41T00", .driver_data = m41t00 },
+	{ .id = "M41T11", .driver_data = m41t11 },
+	{ .id = "MCP7940X", .driver_data = mcp794xx },
+	{ .id = "MCP7941X", .driver_data = mcp794xx },
+	{ .id = "PT7C4338", .driver_data = ds_1307 },
+	{ .id = "RX8025", .driver_data = rx_8025 },
+	{ .id = "ISL12057", .driver_data = ds_1337 },
+	{ .id = "RX8130", .driver_data = rx_8130 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
+#endif
 
 /*
- * Alarm support for mcp794xx devices.
+ * The ds1337 and ds1339 both have two alarms, but we only use the first
+ * one (with a "seconds" field).  For ds1337 we expect nINTA is our alarm
+ * signal; ds1339 chips have only one alarm signal.
  */
-
-static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
+static irqreturn_t ds1307_irq(int irq, void *dev_id)
 {
-	struct ds1307           *ds1307 = dev_id;
-	struct mutex            *lock = &ds1307->rtc->ops_lock;
-	int reg, ret;
+	struct ds1307		*ds1307 = dev_id;
+	struct mutex		*lock = &ds1307->rtc->ops_lock;
+	int			stat, ret;
 
 	mutex_lock(lock);
-
-	/* Check and clear alarm 0 interrupt flag. */
-	ret = regmap_read(ds1307->regmap, MCP794XX_REG_ALARM0_CTRL, &reg);
-	if (ret)
-		goto out;
-	if (!(reg & MCP794XX_BIT_ALMX_IF))
-		goto out;
-	reg &= ~MCP794XX_BIT_ALMX_IF;
-	ret = regmap_write(ds1307->regmap, MCP794XX_REG_ALARM0_CTRL, reg);
+	ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &stat);
 	if (ret)
 		goto out;
 
-	/* Disable alarm 0. */
-	ret = regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
-				 MCP794XX_BIT_ALM0_EN, 0);
-	if (ret)
-		goto out;
+	if (stat & DS1337_BIT_A1I) {
+		stat &= ~DS1337_BIT_A1I;
+		regmap_write(ds1307->regmap, DS1337_REG_STATUS, stat);
 
-	rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
+		ret = regmap_update_bits(ds1307->regmap, DS1337_REG_CONTROL,
+					 DS1337_BIT_A1IE, 0);
+		if (ret)
+			goto out;
+
+		rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
+	}
 
 out:
 	mutex_unlock(lock);
@@ -888,167 +1036,15 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
-{
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	u8 regs[10];
-	int ret;
-
-	if (!test_bit(HAS_ALARM, &ds1307->flags))
-		return -EINVAL;
-
-	/* Read control and alarm 0 registers. */
-	ret = regmap_bulk_read(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
-			       sizeof(regs));
-	if (ret)
-		return ret;
-
-	t->enabled = !!(regs[0] & MCP794XX_BIT_ALM0_EN);
-
-	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
-	t->time.tm_sec = bcd2bin(regs[3] & 0x7f);
-	t->time.tm_min = bcd2bin(regs[4] & 0x7f);
-	t->time.tm_hour = bcd2bin(regs[5] & 0x3f);
-	t->time.tm_wday = bcd2bin(regs[6] & 0x7) - 1;
-	t->time.tm_mday = bcd2bin(regs[7] & 0x3f);
-	t->time.tm_mon = bcd2bin(regs[8] & 0x1f) - 1;
-	t->time.tm_year = -1;
-	t->time.tm_yday = -1;
-	t->time.tm_isdst = -1;
-
-	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
-		"enabled=%d polarity=%d irq=%d match=%lu\n", __func__,
-		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
-		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled,
-		!!(regs[6] & MCP794XX_BIT_ALMX_POL),
-		!!(regs[6] & MCP794XX_BIT_ALMX_IF),
-		(regs[6] & MCP794XX_MSK_ALMX_MATCH) >> 4);
-
-	return 0;
-}
-
-/*
- * We may have a random RTC weekday, therefore calculate alarm weekday based
- * on current weekday we read from the RTC timekeeping regs
- */
-static int mcp794xx_alm_weekday(struct device *dev, struct rtc_time *tm_alarm)
-{
-	struct rtc_time tm_now;
-	int days_now, days_alarm, ret;
-
-	ret = ds1307_get_time(dev, &tm_now);
-	if (ret)
-		return ret;
-
-	days_now = div_s64(rtc_tm_to_time64(&tm_now), 24 * 60 * 60);
-	days_alarm = div_s64(rtc_tm_to_time64(tm_alarm), 24 * 60 * 60);
-
-	return (tm_now.tm_wday + days_alarm - days_now) % 7 + 1;
-}
-
-static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
-{
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	unsigned char regs[10];
-	int wday, ret;
-
-	if (!test_bit(HAS_ALARM, &ds1307->flags))
-		return -EINVAL;
-
-	wday = mcp794xx_alm_weekday(dev, &t->time);
-	if (wday < 0)
-		return wday;
-
-	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
-		"enabled=%d pending=%d\n", __func__,
-		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
-		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon,
-		t->enabled, t->pending);
-
-	/* Read control and alarm 0 registers. */
-	ret = regmap_bulk_read(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
-			       sizeof(regs));
-	if (ret)
-		return ret;
-
-	/* Set alarm 0, using 24-hour and day-of-month modes. */
-	regs[3] = bin2bcd(t->time.tm_sec);
-	regs[4] = bin2bcd(t->time.tm_min);
-	regs[5] = bin2bcd(t->time.tm_hour);
-	regs[6] = wday;
-	regs[7] = bin2bcd(t->time.tm_mday);
-	regs[8] = bin2bcd(t->time.tm_mon + 1);
-
-	/* Clear the alarm 0 interrupt flag. */
-	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
-	/* Set alarm match: second, minute, hour, day, date, month. */
-	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
-	/* Disable interrupt. We will not enable until completely programmed */
-	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
-
-	ret = regmap_bulk_write(ds1307->regmap, MCP794XX_REG_CONTROL, regs,
-				sizeof(regs));
-	if (ret)
-		return ret;
-
-	if (!t->enabled)
-		return 0;
-	regs[0] |= MCP794XX_BIT_ALM0_EN;
-	return regmap_write(ds1307->regmap, MCP794XX_REG_CONTROL, regs[0]);
-}
-
-static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-
-	if (!test_bit(HAS_ALARM, &ds1307->flags))
-		return -EINVAL;
-
-	return regmap_update_bits(ds1307->regmap, MCP794XX_REG_CONTROL,
-				  MCP794XX_BIT_ALM0_EN,
-				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
-}
-
-static int m41txx_rtc_read_offset(struct device *dev, long *offset)
-{
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	unsigned int ctrl_reg;
-	u8 val;
-
-	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
-
-	val = ctrl_reg & M41TXX_M_CALIBRATION;
-
-	/* check if positive */
-	if (ctrl_reg & M41TXX_BIT_CALIB_SIGN)
-		*offset = (val * M41TXX_POS_OFFSET_STEP_PPB);
-	else
-		*offset = -(val * M41TXX_NEG_OFFSET_STEP_PPB);
-
-	return 0;
-}
-
-static int m41txx_rtc_set_offset(struct device *dev, long offset)
-{
-	struct ds1307 *ds1307 = dev_get_drvdata(dev);
-	unsigned int ctrl_reg;
-
-	if ((offset < M41TXX_MIN_OFFSET) || (offset > M41TXX_MAX_OFFSET))
-		return -ERANGE;
-
-	if (offset >= 0) {
-		ctrl_reg = DIV_ROUND_CLOSEST(offset,
-					     M41TXX_POS_OFFSET_STEP_PPB);
-		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
-	} else {
-		ctrl_reg = DIV_ROUND_CLOSEST(abs(offset),
-					     M41TXX_NEG_OFFSET_STEP_PPB);
-	}
+/*----------------------------------------------------------------------*/
 
-	return regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL,
-				  M41TXX_M_CALIBRATION | M41TXX_BIT_CALIB_SIGN,
-				  ctrl_reg);
-}
+static const struct rtc_class_ops ds13xx_rtc_ops = {
+	.read_time	= ds1307_get_time,
+	.set_time	= ds1307_set_time,
+	.read_alarm	= ds1337_read_alarm,
+	.set_alarm	= ds1337_set_alarm,
+	.alarm_irq_enable = ds1307_alarm_irq_enable,
+};
 
 static ssize_t frequency_test_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -1137,30 +1133,6 @@ static int ds1307_nvram_write(void *priv, unsigned int offset, void *val,
 
 /*----------------------------------------------------------------------*/
 
-static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307,
-				  u32 ohms, bool diode)
-{
-	u8 setup = (diode) ? DS1307_TRICKLE_CHARGER_DIODE :
-		DS1307_TRICKLE_CHARGER_NO_DIODE;
-
-	switch (ohms) {
-	case 250:
-		setup |= DS1307_TRICKLE_CHARGER_250_OHM;
-		break;
-	case 2000:
-		setup |= DS1307_TRICKLE_CHARGER_2K_OHM;
-		break;
-	case 4000:
-		setup |= DS1307_TRICKLE_CHARGER_4K_OHM;
-		break;
-	default:
-		dev_warn(ds1307->dev,
-			 "Unsupported ohm value %u in dt\n", ohms);
-		return 0;
-	}
-	return setup;
-}
-
 static u8 ds1307_trickle_init(struct ds1307 *ds1307,
 			      const struct chip_desc *chip)
 {
-- 
2.20.1

