Return-Path: <rtc-linux+bncBAABBIMJRDCAKGQELIM2NCA@googlegroups.com>
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
Subject: [rtc-linux] [PATCH 1/2] rtc: pcf2127: add support for pcf2127
 watchdog functionality
Date: Fri, 20 Jan 2017 13:36:43 +0100
Message-Id: <20170120123644.118612-1-sean.nyekjaer@prevas.dk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

PCF2129 does not have watchdog functionality built-in so we
are only allowing to enable watchdog for PCF2127.

Watchdog functionality is done with great inspiration from
the rtc-ds1374 driver.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/rtc/Kconfig       |   7 ++
 drivers/rtc/rtc-pcf2127.c | 174 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d148aba9..c8985be81d83 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -799,6 +799,13 @@ config RTC_DRV_PCF2127
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf2127.
 
+config RTC_DRV_PCF2127_WDT
+	bool "NXP PCF2127 watchdog timer"
+	depends on RTC_DRV_PCF2127
+	help
+	  If you say Y here you will get support for the
+	  watchdog timer in the NXP PCF2127 chip real-time clock chips.
+
 config RTC_DRV_RV3029C2
 	tristate "Micro Crystal RV3029/3049"
 	depends on RTC_I2C_AND_SPI
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 2bfdf638b673..31627c59c44d 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -21,6 +21,13 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+#endif
 
 #define PCF2127_REG_CTRL1       (0x00)  /* Control Register 1 */
 #define PCF2127_REG_CTRL2       (0x01)  /* Control Register 2 */
@@ -28,6 +35,13 @@
 #define PCF2127_REG_CTRL3       (0x02)  /* Control Register 3 */
 #define PCF2127_REG_CTRL3_BLF		BIT(2)
 
+#define PCF2127_REG_WDG_TIMCTL		(0x10)
+#define PCF2127_REG_WDG_TIMCTL_CD	(BIT(7) | BIT(6))
+#define PCF2127_REG_WDG_T_CD_EN_RST	(BIT(7) | BIT(6))	/* WD en,rst assert */
+#define PCF2127_REG_WDG_TIMCTL_TF	(BIT(1) | BIT(0))
+#define PCF2127_REG_WDG_T_TF_1HZ	BIT(1)	/* Timer clock source */
+#define PCF2127_REG_WDG_TIMVAL		(0x11)
+
 #define PCF2127_REG_SC          (0x03)  /* datetime */
 #define PCF2127_REG_MN          (0x04)
 #define PCF2127_REG_HR          (0x05)
@@ -43,6 +57,138 @@ struct pcf2127 {
 	struct regmap *regmap;
 };
 
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+static struct pcf2127 *save_pcf2127;
+
+/* default 32 sec timeout */
+#define WD_TIMO 32
+
+static int wdt_margin = WD_TIMO;
+
+static const struct watchdog_info pcf2127_wdt_info = {
+	.identity = "PCF2127 WDT",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+};
+
+static int pcf2127_wdt_enable(void)
+{
+	return regmap_write(save_pcf2127->regmap, PCF2127_REG_WDG_TIMCTL,
+			    PCF2127_REG_WDG_T_CD_EN_RST |
+			    PCF2127_REG_WDG_T_TF_1HZ);
+}
+
+static int pcf2127_wdt_settimeout(unsigned int timeout)
+{
+	int err;
+
+	err = pcf2127_wdt_enable();
+	if (err)
+		return err;
+
+	err = regmap_write(save_pcf2127->regmap, PCF2127_REG_WDG_TIMVAL,
+			   timeout);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void pcf2127_wdt_ping(void)
+{
+	int ret = 0;
+
+	ret = pcf2127_wdt_settimeout(wdt_margin);
+	if (ret)
+		pr_info("WD TICK FAIL!!!!!!!!!! %i\n", ret);
+}
+
+static int pcf2127_wdt_disable(void)
+{
+	return regmap_write_bits(save_pcf2127->regmap, PCF2127_REG_WDG_TIMCTL,
+				 PCF2127_REG_WDG_TIMCTL_CD, 0x00);
+}
+
+static long pcf2127_wdt_unlocked_ioctl(struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	int new_margin, options;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user((struct watchdog_info __user *)arg,
+				    &pcf2127_wdt_info,
+				    sizeof(pcf2127_wdt_info)) ? -EFAULT : 0;
+	case WDIOC_SETOPTIONS:
+		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
+			return -EFAULT;
+
+		if (options & WDIOS_DISABLECARD) {
+			pr_info("disable watchdog\n");
+			if (pcf2127_wdt_disable())
+				return -EFAULT;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			pr_info("enable watchdog\n");
+			pcf2127_wdt_settimeout(wdt_margin);
+			pcf2127_wdt_ping();
+		}
+
+		return -EINVAL;
+	case WDIOC_KEEPALIVE:
+		pcf2127_wdt_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int __user *)arg))
+			return -EFAULT;
+
+		if (new_margin < 1 || new_margin > 255)
+			return -EINVAL;
+
+		wdt_margin = new_margin;
+		if (pcf2127_wdt_settimeout(new_margin))
+			return -EFAULT;
+		pcf2127_wdt_ping();
+		/* fallthrough */
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt_margin, (int __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static ssize_t pcf2127_wdt_write(struct file *file, const char *data,
+				 size_t len, loff_t *ppos)
+{
+	if (len) {
+		pcf2127_wdt_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static ssize_t pcf2127_wdt_read(struct file *file, char __user *data,
+				size_t len, loff_t *ppos)
+{
+	return 0;
+}
+
+static const struct file_operations pcf2127_wdt_fops = {
+	.owner = THIS_MODULE,
+	.read = pcf2127_wdt_read,
+	.unlocked_ioctl = pcf2127_wdt_unlocked_ioctl,
+	.write = pcf2127_wdt_write,
+	.llseek = no_llseek,
+};
+
+static struct miscdevice pcf2127_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &pcf2127_wdt_fops,
+};
+
+#endif
+
 /*
  * In the routines that deal directly with the pcf2127 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -175,6 +321,9 @@ static const struct rtc_class_ops pcf2127_rtc_ops = {
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 			const char *name)
 {
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+	int ret;
+#endif
 	struct pcf2127 *pcf2127;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -183,6 +332,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	if (!pcf2127)
 		return -ENOMEM;
 
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+	save_pcf2127 = pcf2127;
+#endif
+
 	pcf2127->regmap = regmap;
 
 	dev_set_drvdata(dev, pcf2127);
@@ -190,7 +343,22 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	pcf2127->rtc = devm_rtc_device_register(dev, name, &pcf2127_rtc_ops,
 						THIS_MODULE);
 
-	return PTR_ERR_OR_ZERO(pcf2127->rtc);
+	if (IS_ERR(pcf2127->rtc))
+		return PTR_ERR_OR_ZERO(pcf2127->rtc);
+
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+	if (!of_device_is_compatible(dev->of_node, "nxp,pcf2127"))
+		return 0;
+
+	if (of_property_read_bool(dev->of_node, "watchdog")) {
+		ret = misc_register(&pcf2127_wdt_miscdev);
+		if (ret)
+			return ret;
+	}
+	pcf2127_wdt_settimeout(32);
+#endif
+
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -427,6 +595,10 @@ static void __exit pcf2127_exit(void)
 {
 	pcf2127_spi_unregister_driver();
 	pcf2127_i2c_unregister_driver();
+
+#ifdef CONFIG_RTC_DRV_PCF2127_WDT
+	misc_deregister(&pcf2127_wdt_miscdev);
+#endif
 }
 module_exit(pcf2127_exit)
 
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
