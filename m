Return-Path: <rtc-linux+bncBC433LF43MBBBUGY33AAKGQEYE45ZTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id s80si2479629wme.3.2016.10.31.13.40.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 13:40:48 -0700 (PDT)
From: Paul Cercueil <paul@crapouillou.net>
To: rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Cc: Paul Cercueil <paul@crapouillou.net>
Subject: [rtc-linux] [PATCH v3 1/7] rtc: rtc-jz4740: Add support for the RTC
 in the jz4780 SoC
Date: Mon, 31 Oct 2016 21:39:45 +0100
Message-Id: <20161031203951.5444-1-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The RTC unit present in the JZ4780 works mostly the same as the one in
the JZ4740. The major difference is that register writes need to be
explicitly enabled, by writing a magic code (0xA55A) to a "write
enable" register before each access.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/rtc/Kconfig      |  6 +++---
 drivers/rtc/rtc-jz4740.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

v2: No change
v3: No change

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4cbea34..1d0ae30 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1550,10 +1550,10 @@ config RTC_DRV_MPC5121
 
 config RTC_DRV_JZ4740
 	tristate "Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	depends on MACH_INGENIC || COMPILE_TEST
 	help
-	  If you say yes here you get support for the Ingenic JZ4740 SoC RTC
-	  controller.
+	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
+	  controllers.
 
 	  This driver can also be buillt as a module. If so, the module
 	  will be called rtc-jz4740.
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 5e14651..c616efe 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -29,6 +29,10 @@
 #define JZ_REG_RTC_HIBERNATE	0x20
 #define JZ_REG_RTC_SCRATCHPAD	0x34
 
+/* The following are present on the jz4780 */
+#define JZ_REG_RTC_WENR	0x3C
+#define JZ_RTC_WENR_WEN	BIT(31)
+
 #define JZ_RTC_CTRL_WRDY	BIT(7)
 #define JZ_RTC_CTRL_1HZ		BIT(6)
 #define JZ_RTC_CTRL_1HZ_IRQ	BIT(5)
@@ -37,8 +41,17 @@
 #define JZ_RTC_CTRL_AE		BIT(2)
 #define JZ_RTC_CTRL_ENABLE	BIT(0)
 
+/* Magic value to enable writes on jz4780 */
+#define JZ_RTC_WENR_MAGIC	0xA55A
+
+enum jz4740_rtc_type {
+	ID_JZ4740,
+	ID_JZ4780,
+};
+
 struct jz4740_rtc {
 	void __iomem *base;
+	enum jz4740_rtc_type type;
 
 	struct rtc_device *rtc;
 
@@ -64,11 +77,33 @@ static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
 	return timeout ? 0 : -EIO;
 }
 
+static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
+{
+	uint32_t ctrl;
+	int ret, timeout = 1000;
+
+	ret = jz4740_rtc_wait_write_ready(rtc);
+	if (ret != 0)
+		return ret;
+
+	writel(JZ_RTC_WENR_MAGIC, rtc->base + JZ_REG_RTC_WENR);
+
+	do {
+		ctrl = readl(rtc->base + JZ_REG_RTC_WENR);
+	} while (!(ctrl & JZ_RTC_WENR_WEN) && --timeout);
+
+	return timeout ? 0 : -EIO;
+}
+
 static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
 	uint32_t val)
 {
-	int ret;
-	ret = jz4740_rtc_wait_write_ready(rtc);
+	int ret = 0;
+
+	if (rtc->type >= ID_JZ4780)
+		ret = jz4780_rtc_enable_write(rtc);
+	if (ret == 0)
+		ret = jz4740_rtc_wait_write_ready(rtc);
 	if (ret == 0)
 		writel(val, rtc->base + reg);
 
@@ -216,11 +251,14 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	struct jz4740_rtc *rtc;
 	uint32_t scratchpad;
 	struct resource *mem;
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
+	rtc->type = id->driver_data;
+
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0) {
 		dev_err(&pdev->dev, "Failed to get platform irq\n");
@@ -295,12 +333,20 @@ static const struct dev_pm_ops jz4740_pm_ops = {
 #define JZ4740_RTC_PM_OPS NULL
 #endif  /* CONFIG_PM */
 
+static const struct platform_device_id jz4740_rtc_ids[] = {
+	{ "jz4740-rtc", ID_JZ4740 },
+	{ "jz4780-rtc", ID_JZ4780 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
+
 static struct platform_driver jz4740_rtc_driver = {
 	.probe	 = jz4740_rtc_probe,
 	.driver	 = {
 		.name  = "jz4740-rtc",
 		.pm    = JZ4740_RTC_PM_OPS,
 	},
+	.id_table = jz4740_rtc_ids,
 };
 
 module_platform_driver(jz4740_rtc_driver);
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
