Return-Path: <rtc-linux+bncBCW4XG6ATMLBBTMGQHBQKGQECE6ADXY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id l66si3089900wml.0.2016.12.25.14.08.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2016 14:08:12 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id x140so9833753lfa.2
        for <rtc-linux@googlegroups.com>; Sun, 25 Dec 2016 14:08:12 -0800 (PST)
From: Emil Bartczak <emilbart@gmail.com>
To: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Emil Bartczak <emilbart@gmail.com>
Subject: [rtc-linux] [PATCH v2 2/2] rtc: mcp795: add alarm support.
Date: Sun, 25 Dec 2016 23:07:43 +0100
Message-Id: <1482703663-9115-3-git-send-email-emilbart@gmail.com>
In-Reply-To: <1482703663-9115-1-git-send-email-emilbart@gmail.com>
References: <1482703663-9115-1-git-send-email-emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch adds alarm support. This allows to configure the chip
to generate an interrupt when the alarm matches current time value.
Alarm can be programmed up to one year in the future
and is accurate to the second.

Signed-off-by: Emil Bartczak <emilbart@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 8107fc0..77f2133 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -44,12 +44,22 @@
 #define MCP795_REG_DAY		0x04
 #define MCP795_REG_MONTH	0x06
 #define MCP795_REG_CONTROL	0x08
+#define MCP795_REG_ALM0_SECONDS	0x0C
+#define MCP795_REG_ALM0_DAY	0x0F
 
 #define MCP795_ST_BIT		BIT(7)
 #define MCP795_24_BIT		BIT(6)
 #define MCP795_LP_BIT		BIT(5)
 #define MCP795_EXTOSC_BIT	BIT(3)
 #define MCP795_OSCON_BIT	BIT(5)
+#define MCP795_ALM0_BIT		BIT(4)
+#define MCP795_ALM1_BIT		BIT(5)
+#define MCP795_ALM0IF_BIT	BIT(3)
+#define MCP795_ALM0C0_BIT	BIT(4)
+#define MCP795_ALM0C1_BIT	BIT(5)
+#define MCP795_ALM0C2_BIT	BIT(6)
+
+#define SEC_PER_DAY		(24 * 60 * 60)
 
 static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 {
@@ -150,6 +160,30 @@ static int mcp795_start_oscillator(struct device *dev, bool *extosc)
 			dev, MCP795_REG_SECONDS, MCP795_ST_BIT, MCP795_ST_BIT);
 }
 
+/* Enable or disable Alarm 0 in RTC */
+static int mcp795_update_alarm(struct device *dev, bool enable)
+{
+	int ret;
+
+	dev_dbg(dev, "%s alarm\n", enable ? "Enable" : "Disable");
+
+	if (enable) {
+		/* clear ALM0IF (Alarm 0 Interrupt Flag) bit */
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_ALM0_DAY,
+					MCP795_ALM0IF_BIT, 0);
+		if (ret)
+			return ret;
+		/* enable alarm 0 */
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
+					MCP795_ALM0_BIT, MCP795_ALM0_BIT);
+	} else {
+		/* disable alarm 0 and alarm 1 */
+		ret = mcp795_rtcc_set_bits(dev, MCP795_REG_CONTROL,
+					MCP795_ALM0_BIT | MCP795_ALM1_BIT, 0);
+	}
+	return ret;
+}
+
 static int mcp795_set_time(struct device *dev, struct rtc_time *tim)
 {
 	int ret;
@@ -231,9 +265,127 @@ static int mcp795_read_time(struct device *dev, struct rtc_time *tim)
 	return rtc_valid_tm(tim);
 }
 
+static int mcp795_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	struct rtc_time now_tm;
+	time64_t now;
+	time64_t later;
+	u8 tmp[6];
+	int ret;
+
+	/* Read current time from RTC hardware */
+	ret = mcp795_read_time(dev, &now_tm);
+	if (ret)
+		return ret;
+	/* Get the number of seconds since 1970 */
+	now = rtc_tm_to_time64(&now_tm);
+	later = rtc_tm_to_time64(&alm->time);
+	if (later <= now)
+		return -EINVAL;
+	/* make sure alarm fires within the next one year */
+	if ((later - now) >=
+		(SEC_PER_DAY * (365 + is_leap_year(alm->time.tm_year))))
+		return -EDOM;
+	/* disable alarm */
+	ret = mcp795_update_alarm(dev, false);
+	if (ret)
+		return ret;
+	/* Read registers, so we can leave configuration bits untouched */
+	ret = mcp795_rtcc_read(dev, MCP795_REG_ALM0_SECONDS, tmp, sizeof(tmp));
+	if (ret)
+		return ret;
+
+	alm->time.tm_year	= -1;
+	alm->time.tm_isdst	= -1;
+	alm->time.tm_yday	= -1;
+
+	tmp[0] = (tmp[0] & 0x80) | bin2bcd(alm->time.tm_sec);
+	tmp[1] = (tmp[1] & 0x80) | bin2bcd(alm->time.tm_min);
+	tmp[2] = (tmp[2] & 0xE0) | bin2bcd(alm->time.tm_hour);
+	tmp[3] = (tmp[3] & 0x80) | bin2bcd(alm->time.tm_wday + 1);
+	/* set alarm match: seconds, minutes, hour, day, date and month */
+	tmp[3] |= (MCP795_ALM0C2_BIT | MCP795_ALM0C1_BIT | MCP795_ALM0C0_BIT);
+	tmp[4] = (tmp[4] & 0xC0) | bin2bcd(alm->time.tm_mday);
+	tmp[5] = (tmp[5] & 0xE0) | bin2bcd(alm->time.tm_mon + 1);
+
+	ret = mcp795_rtcc_write(dev, MCP795_REG_ALM0_SECONDS, tmp, sizeof(tmp));
+	if (ret)
+		return ret;
+
+	/* enable alarm if requested */
+	if (alm->enabled) {
+		ret = mcp795_update_alarm(dev, true);
+		if (ret)
+			return ret;
+		dev_dbg(dev, "Alarm IRQ armed\n");
+	}
+	dev_dbg(dev, "Set alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
+			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
+			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	return 0;
+}
+
+static int mcp795_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	u8 data[6];
+	int ret;
+
+	ret = mcp795_rtcc_read(
+			dev, MCP795_REG_ALM0_SECONDS, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	alm->time.tm_sec	= bcd2bin(data[0] & 0x7F);
+	alm->time.tm_min	= bcd2bin(data[1] & 0x7F);
+	alm->time.tm_hour	= bcd2bin(data[2] & 0x1F);
+	alm->time.tm_wday	= bcd2bin(data[3] & 0x07) - 1;
+	alm->time.tm_mday	= bcd2bin(data[4] & 0x3F);
+	alm->time.tm_mon	= bcd2bin(data[5] & 0x1F) - 1;
+	alm->time.tm_year	= -1;
+	alm->time.tm_isdst	= -1;
+	alm->time.tm_yday	= -1;
+
+	dev_dbg(dev, "Read alarm: %02d-%02d(%d) %02d:%02d:%02d\n",
+			alm->time.tm_mon, alm->time.tm_mday, alm->time.tm_wday,
+			alm->time.tm_hour, alm->time.tm_min, alm->time.tm_sec);
+	return 0;
+}
+
+static int mcp795_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	return mcp795_update_alarm(dev, !!enabled);
+}
+
+static irqreturn_t mcp795_irq(int irq, void *data)
+{
+	struct spi_device *spi = data;
+	struct rtc_device *rtc = spi_get_drvdata(spi);
+	struct mutex *lock = &rtc->ops_lock;
+	int ret;
+
+	mutex_lock(lock);
+
+	/* Disable alarm.
+	 * There is no need to clear ALM0IF (Alarm 0 Interrupt Flag) bit,
+	 * because it is done every time when alarm is enabled.
+	 */
+	ret = mcp795_update_alarm(&spi->dev, false);
+	if (ret)
+		dev_err(&spi->dev,
+			"Failed to disable alarm in IRQ (ret=%d)\n", ret);
+	rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
+
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
 static const struct rtc_class_ops mcp795_rtc_ops = {
 		.read_time = mcp795_read_time,
-		.set_time = mcp795_set_time
+		.set_time = mcp795_set_time,
+		.read_alarm = mcp795_read_alarm,
+		.set_alarm = mcp795_set_alarm,
+		.alarm_irq_enable = mcp795_alarm_irq_enable
 };
 
 static int mcp795_probe(struct spi_device *spi)
@@ -261,6 +413,23 @@ static int mcp795_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, rtc);
 
+	if (spi->irq > 0) {
+		dev_dbg(&spi->dev, "Alarm support enabled\n");
+
+		/* Clear any pending alarm (ALM0IF bit) before requesting
+		 * the interrupt.
+		 */
+		mcp795_rtcc_set_bits(&spi->dev, MCP795_REG_ALM0_DAY,
+					MCP795_ALM0IF_BIT, 0);
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
+				mcp795_irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				dev_name(&rtc->dev), spi);
+		if (ret)
+			dev_err(&spi->dev, "Failed to request IRQ: %d: %d\n",
+						spi->irq, ret);
+		else
+			device_init_wakeup(&spi->dev, true);
+	}
 	return 0;
 }
 
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
