Return-Path: <rtc-linux+bncBAABBIUJRDCAKGQE65IFQSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail02.prevas.se (mail02.prevas.se. [62.95.78.10])
        by gmr-mx.google.com with ESMTPS id h62si105086wme.2.2017.01.20.04.37.53
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 04:37:53 -0800 (PST)
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: rtc-linux@googlegroups.com
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [rtc-linux] [PATCH 2/2] rtc: pcf2127: add support for pcf2127 tamper functionality
Date: Fri, 20 Jan 2017 13:36:44 +0100
Message-Id: <20170120123644.118612-2-sean.nyekjaer@prevas.dk>
In-Reply-To: <20170120123644.118612-1-sean.nyekjaer@prevas.dk>
References: <20170120123644.118612-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/rtc/Kconfig       |   7 +++
 drivers/rtc/rtc-pcf2127.c | 128 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c8985be81d83..e8d7944a4018 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -806,6 +806,13 @@ config RTC_DRV_PCF2127_WDT
 	  If you say Y here you will get support for the
 	  watchdog timer in the NXP PCF2127 chip real-time clock chips.
 
+config RTC_DRV_PCF2127_TAMPER
+	bool "NXP PCF2127 tamper"
+	depends on RTC_DRV_PCF2127
+	help
+	  If you say Y here you will get support for the
+	  tamper device in the NXP PCF2127 chip real-time clock chips.
+
 config RTC_DRV_RV3029C2
 	tristate "Micro Crystal RV3029/3049"
 	depends on RTC_I2C_AND_SPI
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 31627c59c44d..5f96cff9ebd5 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -30,7 +30,10 @@
 #endif
 
 #define PCF2127_REG_CTRL1       (0x00)  /* Control Register 1 */
+#define PCF2127_TSF1		BIT(4)
 #define PCF2127_REG_CTRL2       (0x01)  /* Control Register 2 */
+#define PCF2127_TSIE		BIT(2)
+#define PCF2127_TSF2		BIT(5)
 
 #define PCF2127_REG_CTRL3       (0x02)  /* Control Register 3 */
 #define PCF2127_REG_CTRL3_BLF		BIT(2)
@@ -42,6 +45,17 @@
 #define PCF2127_REG_WDG_T_TF_1HZ	BIT(1)	/* Timer clock source */
 #define PCF2127_REG_WDG_TIMVAL		(0x11)
 
+#define PCF2127_REG_TIMSTP_CTL		(0x12)
+#define PCF2127_TSM			BIT(7)
+#define PCF2127_TSOFF			BIT(6)
+
+#define PCF2127_REG_TIMSTP_SC		(0x01)
+#define PCF2127_REG_TIMSTP_MN		(0x02)
+#define PCF2127_REG_TIMSTP_HR		(0x03)
+#define PCF2127_REG_TIMSTP_DM		(0x04)
+#define PCF2127_REG_TIMSTP_MO		(0x05)
+#define PCF2127_REG_TIMSTP_YR		(0x06)
+
 #define PCF2127_REG_SC          (0x03)  /* datetime */
 #define PCF2127_REG_MN          (0x04)
 #define PCF2127_REG_HR          (0x05)
@@ -55,10 +69,84 @@
 struct pcf2127 {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
+	struct rtc_time tamper_event;
+	bool tamper_enabled;
+	int irq;
 };
 
-#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+#if defined(CONFIG_RTC_DRV_PCF2127_TAMPER) || defined(CONFIG_RTC_DRV_PCF2127_WDT)
 static struct pcf2127 *save_pcf2127;
+#endif
+
+#ifdef CONFIG_RTC_DRV_PCF2127_TAMPER
+static int pcf2127_tamper_event_print(struct device *dev)
+{
+	int err;
+	unsigned char buf[7];
+	struct rtc_time *tm;
+
+	err = regmap_bulk_read(save_pcf2127->regmap, PCF2127_REG_TIMSTP_CTL,
+			       buf, sizeof(buf));
+	if (err)
+		return err;
+
+	tm = &save_pcf2127->tamper_event;
+
+	tm->tm_sec = bcd2bin(buf[PCF2127_REG_TIMSTP_SC] & 0x7F);
+	tm->tm_min = bcd2bin(buf[PCF2127_REG_TIMSTP_MN] & 0x7F);
+	tm->tm_hour = bcd2bin(buf[PCF2127_REG_TIMSTP_HR] & 0x3F);
+	tm->tm_mday = bcd2bin(buf[PCF2127_REG_TIMSTP_DM] & 0x3F);
+	tm->tm_mon = bcd2bin(buf[PCF2127_REG_TIMSTP_MO] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(buf[PCF2127_REG_TIMSTP_YR]);
+
+	dev_emerg(dev, "%s: Tamper detected at secs=%d, mins=%d, hours=%d, "
+		  "mday=%d, mon=%d, year=%d\n",
+		  __func__,
+		  tm->tm_sec, tm->tm_min, tm->tm_hour,
+		  tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	return 0;
+}
+
+static int pcf2127_tamper_enable(void)
+{
+	int err;
+
+	/* Enable interrupt on tamper event */
+	err = regmap_write_bits(save_pcf2127->regmap, PCF2127_REG_CTRL2,
+				PCF2127_TSIE, PCF2127_TSIE);
+	if (err)
+		return err;
+
+	/* Enable timestamp function */
+	err = regmap_write_bits(save_pcf2127->regmap, PCF2127_REG_TIMSTP_CTL,
+				PCF2127_TSM | PCF2127_TSOFF, PCF2127_TSM);
+	if (err)
+		return err;
+
+	save_pcf2127->tamper_enabled = true;
+
+	return 0;
+}
+
+static irqreturn_t pcf2127_tamper_event_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+
+	pcf2127_tamper_event_print(dev);
+
+	/* Clear interrupt pin */
+	regmap_write_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+			PCF2127_TSF1, 0);
+	regmap_write_bits(pcf2127->regmap, PCF2127_REG_CTRL2,
+			PCF2127_TSF2, 0);
+
+	return IRQ_HANDLED;
+}
+#endif
+
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
 
 /* default 32 sec timeout */
 #define WD_TIMO 32
@@ -219,6 +307,11 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			 "oscillator stop detected, date/time is not reliable\n");
 		return -EINVAL;
 	}
+#ifdef CONFIG_RTC_DRV_PCF2127_TAMPER
+	if (buf[PCF2127_REG_CTRL1] & PCF2127_TSF1) {
+		pcf2127_tamper_event_print(dev);
+	}
+#endif
 
 	dev_dbg(dev,
 		"%s: raw data is cr1=%02x, cr2=%02x, cr3=%02x, "
@@ -319,9 +412,9 @@ static const struct rtc_class_ops pcf2127_rtc_ops = {
 };
 
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-			const char *name)
+			 const char *name, int irq)
 {
-#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+#if defined(CONFIG_RTC_DRV_PCF2127_TAMPER) || defined(CONFIG_RTC_DRV_PCF2127_WDT)
 	int ret;
 #endif
 	struct pcf2127 *pcf2127;
@@ -332,7 +425,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (!pcf2127)
 		return -ENOMEM;
 
-#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+#if defined(CONFIG_RTC_DRV_PCF2127_TAMPER) || defined(CONFIG_RTC_DRV_PCF2127_WDT)
 	save_pcf2127 = pcf2127;
 #endif
 
@@ -358,6 +451,28 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	pcf2127_wdt_settimeout(32);
 #endif
 
+#ifdef CONFIG_RTC_DRV_PCF2127_TAMPER
+	pcf2127->tamper_enabled = false;
+
+	if (!of_device_is_compatible(dev->of_node, "nxp,pcf2127"))
+		return 0;
+
+	if (of_property_read_bool(dev->of_node, "tamper")) {
+		pcf2127_tamper_enable();
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						pcf2127_tamper_event_irq,
+						IRQF_ONESHOT | IRQF_TRIGGER_FALLING, dev_name(dev),
+						dev);
+		if (ret < 0) {
+			dev_err(dev, "IRQ is not free.\n");
+			return ret;
+		}
+
+		pcf2127->irq = irq;
+	}
+#endif
+
 	return 0;
 }
 
@@ -466,7 +581,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client,
 	}
 
 	return pcf2127_probe(&client->dev, regmap,
-				pcf2127_i2c_driver.driver.name);
+				pcf2127_i2c_driver.driver.name, client->irq);
 }
 
 static const struct i2c_device_id pcf2127_i2c_id[] = {
@@ -529,7 +644,8 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return pcf2127_probe(&spi->dev, regmap, pcf2127_spi_driver.driver.name);
+	return pcf2127_probe(&spi->dev, regmap, pcf2127_spi_driver.driver.name,
+			     spi->irq);
 }
 
 static const struct spi_device_id pcf2127_spi_id[] = {
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
