Return-Path: <rtc-linux+bncBD2OLRXW4ABBBTN4462QKGQEFCHFJRQ@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id ui7si5045149pab.0.2016.02.09.04.40.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 04:40:45 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V6 6/6] rtc: max77686: move initialisation of rtc
 regmap, irq chip locally
Date: Tue, 9 Feb 2016 17:58:27 +0530
Message-ID: <1455020907-4564-7-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

To make RTC block of MAX77686/MAX77802 as independent driver,
move the registration of i2c device, regmap for register access
and irq_chip for interrupt support inside the RTC driver.
Removed the same initialisation from MFD driver.

Having this change will allow to reuse this driver for different
PMIC/devices from Maxim Semiconductor if they kept same RTC IP on
different PMIC. Some of examples as PMIC MAX77620, MAX20024 where
same RTC IP used and hence driver for these chips will use this
driver only for RTC support.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Changes from V1:
- Remove changes from Kconfig.
- Maintain all register definition in max77686 private header and remove
  the movement to rtc driver.
- Taken care of all comments on V1 from Krzysztof and Javier.

Changes from V2:
- Taken care of missed sequence for removing the resource.
- Fix the crash when doing unbind by using requested_threaded_irq()
  instead of demv_requested_threaded_irq().

Changes from V3:
- Fix the issue of suspend-resume with unbind/bind by unmapping the
  virq.

Changes from V4:
- Dispose mapped irq in error path in probe

Changes from V5:
- Remove the new APIs from regmap as functionality added to dispose the
  virq inside the regmap_del_irq_chip().

 drivers/mfd/max77686.c               |  85 +-------------------
 drivers/rtc/rtc-max77686.c           | 148 ++++++++++++++++++++++++++++++-----
 include/linux/mfd/max77686-private.h |   3 -
 3 files changed, 130 insertions(+), 106 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index bda6fd7..98ecd13 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -35,8 +35,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 
-#define I2C_ADDR_RTC	(0x0C >> 1)
-
 static const struct mfd_cell max77686_devs[] = {
 	{ .name = "max77686-pmic", },
 	{ .name = "max77686-rtc", },
@@ -116,11 +114,6 @@ static const struct regmap_config max77686_regmap_config = {
 	.val_bits = 8,
 };
 
-static const struct regmap_config max77686_rtc_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static const struct regmap_config max77802_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -156,25 +149,6 @@ static const struct regmap_irq_chip max77686_irq_chip = {
 	.num_irqs		= ARRAY_SIZE(max77686_irqs),
 };
 
-static const struct regmap_irq max77686_rtc_irqs[] = {
-	/* RTC interrupts */
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
-	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
-};
-
-static const struct regmap_irq_chip max77686_rtc_irq_chip = {
-	.name			= "max77686-rtc",
-	.status_base		= MAX77686_RTC_INT,
-	.mask_base		= MAX77686_RTC_INTM,
-	.num_regs		= 1,
-	.irqs			= max77686_rtc_irqs,
-	.num_irqs		= ARRAY_SIZE(max77686_rtc_irqs),
-};
-
 static const struct regmap_irq_chip max77802_irq_chip = {
 	.name			= "max77802-pmic",
 	.status_base		= MAX77802_REG_INT1,
@@ -184,15 +158,6 @@ static const struct regmap_irq_chip max77802_irq_chip = {
 	.num_irqs		= ARRAY_SIZE(max77686_irqs),
 };
 
-static const struct regmap_irq_chip max77802_rtc_irq_chip = {
-	.name			= "max77802-rtc",
-	.status_base		= MAX77802_RTC_INT,
-	.mask_base		= MAX77802_RTC_INTM,
-	.num_regs		= 1,
-	.irqs			= max77686_rtc_irqs, /* same masks as 77686 */
-	.num_irqs		= ARRAY_SIZE(max77686_rtc_irqs),
-};
-
 static const struct of_device_id max77686_pmic_dt_match[] = {
 	{
 		.compatible = "maxim,max77686",
@@ -214,8 +179,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 	int ret = 0;
 	const struct regmap_config *config;
 	const struct regmap_irq_chip *irq_chip;
-	const struct regmap_irq_chip *rtc_irq_chip;
-	struct regmap **rtc_regmap;
 	const struct mfd_cell *cells;
 	int n_devs;
 
@@ -242,15 +205,11 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 	if (max77686->type == TYPE_MAX77686) {
 		config = &max77686_regmap_config;
 		irq_chip = &max77686_irq_chip;
-		rtc_irq_chip = &max77686_rtc_irq_chip;
-		rtc_regmap = &max77686->rtc_regmap;
 		cells =  max77686_devs;
 		n_devs = ARRAY_SIZE(max77686_devs);
 	} else {
 		config = &max77802_regmap_config;
 		irq_chip = &max77802_irq_chip;
-		rtc_irq_chip = &max77802_rtc_irq_chip;
-		rtc_regmap = &max77686->regmap;
 		cells =  max77802_devs;
 		n_devs = ARRAY_SIZE(max77802_devs);
 	}
@@ -270,59 +229,25 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	if (max77686->type == TYPE_MAX77686) {
-		max77686->rtc = i2c_new_dummy(i2c->adapter, I2C_ADDR_RTC);
-		if (!max77686->rtc) {
-			dev_err(max77686->dev,
-				"Failed to allocate I2C device for RTC\n");
-			return -ENODEV;
-		}
-
-		max77686->rtc_regmap =
-			devm_regmap_init_i2c(max77686->rtc,
-					     &max77686_rtc_regmap_config);
-		if (IS_ERR(max77686->rtc_regmap)) {
-			ret = PTR_ERR(max77686->rtc_regmap);
-			dev_err(max77686->dev,
-				"failed to allocate RTC regmap: %d\n",
-				ret);
-			goto err_unregister_i2c;
-		}
-	}
-
 	ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
 				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
 				  IRQF_SHARED, 0, irq_chip,
 				  &max77686->irq_data);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
-		goto err_unregister_i2c;
-	}
-
-	ret = regmap_add_irq_chip(*rtc_regmap, max77686->irq,
-				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				  IRQF_SHARED, 0, rtc_irq_chip,
-				  &max77686->rtc_irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n", ret);
-		goto err_del_irqc;
+		return ret;
 	}
 
 	ret = mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
-		goto err_del_rtc_irqc;
+		goto err_del_irqc;
 	}
 
 	return 0;
 
-err_del_rtc_irqc:
-	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
 err_del_irqc:
 	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
-err_unregister_i2c:
-	if (max77686->type == TYPE_MAX77686)
-		i2c_unregister_device(max77686->rtc);
 
 	return ret;
 }
@@ -333,12 +258,8 @@ static int max77686_i2c_remove(struct i2c_client *i2c)
 
 	mfd_remove_devices(max77686->dev);
 
-	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
 	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
 
-	if (max77686->type == TYPE_MAX77686)
-		i2c_unregister_device(max77686->rtc);
-
 	return 0;
 }
 
diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index ab1f2cd..45d6396 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/rtc.h>
 #include <linux/delay.h>
@@ -22,6 +23,9 @@
 #include <linux/irqdomain.h>
 #include <linux/regmap.h>
 
+#define MAX77686_I2C_ADDR_RTC		(0x0C >> 1)
+#define MAX77686_INVALID_I2C_ADDR	(-1)
+
 /* RTC Control Register */
 #define BCD_EN_SHIFT			0
 #define BCD_EN_MASK			BIT(BCD_EN_SHIFT)
@@ -68,8 +72,10 @@ struct max77686_rtc_driver_data {
 	const unsigned int	*map;
 	/* Has a separate alarm enable register? */
 	bool			alarm_enable_reg;
-	/* Has a separate I2C regmap for the RTC? */
-	bool			separate_i2c_addr;
+	/* I2C address for RTC block */
+	int			rtc_i2c_addr;
+	/* RTC IRQ CHIP for regmap */
+	const struct regmap_irq_chip *rtc_irq_chip;
 };
 
 struct max77686_rtc_info {
@@ -82,7 +88,9 @@ struct max77686_rtc_info {
 	struct regmap		*rtc_regmap;
 
 	const struct max77686_rtc_driver_data *drv_data;
+	struct regmap_irq_chip_data *rtc_irq_data;
 
+	int rtc_irq;
 	int virq;
 	int rtc_24hr_mode;
 };
@@ -153,12 +161,32 @@ static const unsigned int max77686_map[REG_RTC_END] = {
 	[REG_RTC_AE1]	     = REG_RTC_NONE,
 };
 
+static const struct regmap_irq max77686_rtc_irqs[] = {
+	/* RTC interrupts */
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC60S_MSK, },
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA1_MSK, },
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTCA2_MSK, },
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_SMPL_MSK, },
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_RTC1S_MSK, },
+	{ .reg_offset = 0, .mask = MAX77686_RTCINT_WTSR_MSK, },
+};
+
+static const struct regmap_irq_chip max77686_rtc_irq_chip = {
+	.name		= "max77686-rtc",
+	.status_base	= MAX77686_RTC_INT,
+	.mask_base	= MAX77686_RTC_INTM,
+	.num_regs	= 1,
+	.irqs		= max77686_rtc_irqs,
+	.num_irqs	= ARRAY_SIZE(max77686_rtc_irqs),
+};
+
 static const struct max77686_rtc_driver_data max77686_drv_data = {
 	.delay = 16000,
 	.mask  = 0x7f,
 	.map   = max77686_map,
 	.alarm_enable_reg  = false,
-	.separate_i2c_addr = true,
+	.rtc_i2c_addr = MAX77686_I2C_ADDR_RTC,
+	.rtc_irq_chip = &max77686_rtc_irq_chip,
 };
 
 static const unsigned int max77802_map[REG_RTC_END] = {
@@ -190,12 +218,22 @@ static const unsigned int max77802_map[REG_RTC_END] = {
 	[REG_RTC_AE1]	     = MAX77802_RTC_AE1,
 };
 
+static const struct regmap_irq_chip max77802_rtc_irq_chip = {
+	.name		= "max77802-rtc",
+	.status_base	= MAX77802_RTC_INT,
+	.mask_base	= MAX77802_RTC_INTM,
+	.num_regs	= 1,
+	.irqs		= max77686_rtc_irqs, /* same masks as 77686 */
+	.num_irqs	= ARRAY_SIZE(max77686_rtc_irqs),
+};
+
 static const struct max77686_rtc_driver_data max77802_drv_data = {
 	.delay = 200,
 	.mask  = 0xff,
 	.map   = max77802_map,
 	.alarm_enable_reg  = true,
-	.separate_i2c_addr = false,
+	.rtc_i2c_addr = MAX77686_INVALID_I2C_ADDR,
+	.rtc_irq_chip = &max77802_rtc_irq_chip,
 };
 
 static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
@@ -599,9 +637,65 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 	return ret;
 }
 
+static const struct regmap_config max77686_rtc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
+{
+	struct device *parent = info->dev->parent;
+	struct i2c_client *parent_i2c = to_i2c_client(parent);
+	int ret;
+
+	info->rtc_irq = parent_i2c->irq;
+
+	info->regmap = dev_get_regmap(parent, NULL);
+	if (!info->regmap) {
+		dev_err(info->dev, "Failed to get rtc regmap\n");
+		return -ENODEV;
+	}
+
+	if (info->drv_data->rtc_i2c_addr == MAX77686_INVALID_I2C_ADDR) {
+		info->rtc_regmap = info->regmap;
+		goto add_rtc_irq;
+	}
+
+	info->rtc = i2c_new_dummy(parent_i2c->adapter,
+				  info->drv_data->rtc_i2c_addr);
+	if (!info->rtc) {
+		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
+		return -ENODEV;
+	}
+
+	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
+						&max77686_rtc_regmap_config);
+	if (IS_ERR(info->rtc_regmap)) {
+		ret = PTR_ERR(info->rtc_regmap);
+		dev_err(info->dev, "Failed to allocate RTC regmap: %d\n", ret);
+		goto err_unregister_i2c;
+	}
+
+add_rtc_irq:
+	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
+				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+				  IRQF_SHARED, 0, info->drv_data->rtc_irq_chip,
+				  &info->rtc_irq_data);
+	if (ret < 0) {
+		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
+		goto err_unregister_i2c;
+	}
+
+	return 0;
+
+err_unregister_i2c:
+	if (info->rtc)
+		i2c_unregister_device(info->rtc);
+	return ret;
+}
+
 static int max77686_rtc_probe(struct platform_device *pdev)
 {
-	struct max77686_dev *max77686 = dev_get_drvdata(pdev->dev.parent);
 	struct max77686_rtc_info *info;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	int ret;
@@ -613,18 +707,16 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 	info->dev = &pdev->dev;
-	info->rtc = max77686->rtc;
 	info->drv_data = (const struct max77686_rtc_driver_data *)
 		id->driver_data;
 
-	info->regmap = max77686->regmap;
-	info->rtc_regmap = (info->drv_data->separate_i2c_addr) ?
-			    max77686->rtc_regmap : info->regmap;
+	ret = max77686_init_rtc_regmap(info);
+	if (ret < 0)
+		return ret;
 
 	platform_set_drvdata(pdev, info);
 
 	ret = max77686_rtc_init_reg(info);
-
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to initialize RTC reg:%d\n", ret);
 		goto err_rtc;
@@ -643,30 +735,43 @@ static int max77686_rtc_probe(struct platform_device *pdev)
 		goto err_rtc;
 	}
 
-	if (!max77686->rtc_irq_data) {
-		ret = -EINVAL;
-		dev_err(&pdev->dev, "No RTC regmap IRQ chip\n");
-		goto err_rtc;
-	}
-
-	info->virq = regmap_irq_get_virq(max77686->rtc_irq_data,
+	info->virq = regmap_irq_get_virq(info->rtc_irq_data,
 					 MAX77686_RTCIRQ_RTCA1);
 	if (!info->virq) {
 		ret = -ENXIO;
 		goto err_rtc;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
-					max77686_rtc_alarm_irq, 0,
-					"rtc-alarm1", info);
-	if (ret < 0)
+	ret = request_threaded_irq(info->virq, NULL, max77686_rtc_alarm_irq, 0,
+				   "rtc-alarm1", info);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			info->virq, ret);
+		goto err_rtc;
+	}
+
+	return 0;
 
 err_rtc:
+	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
+	if (info->rtc)
+		i2c_unregister_device(info->rtc);
+
 	return ret;
 }
 
+static int max77686_rtc_remove(struct platform_device *pdev)
+{
+	struct max77686_rtc_info *info = platform_get_drvdata(pdev);
+
+	free_irq(info->virq, info);
+	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
+	if (info->rtc)
+		i2c_unregister_device(info->rtc);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int max77686_rtc_suspend(struct device *dev)
 {
@@ -707,6 +812,7 @@ static struct platform_driver max77686_rtc_driver = {
 		.pm	= &max77686_rtc_pm_ops,
 	},
 	.probe		= max77686_rtc_probe,
+	.remove		= max77686_rtc_remove,
 	.id_table	= rtc_id,
 };
 
diff --git a/include/linux/mfd/max77686-private.h b/include/linux/mfd/max77686-private.h
index f504349..643dae7 100644
--- a/include/linux/mfd/max77686-private.h
+++ b/include/linux/mfd/max77686-private.h
@@ -437,14 +437,11 @@ enum max77686_irq {
 struct max77686_dev {
 	struct device *dev;
 	struct i2c_client *i2c; /* 0xcc / PMIC, Battery Control, and FLASH */
-	struct i2c_client *rtc; /* slave addr 0x0c */
 
 	unsigned long type;
 
 	struct regmap *regmap;		/* regmap for mfd */
-	struct regmap *rtc_regmap;	/* regmap for rtc */
 	struct regmap_irq_chip_data *irq_data;
-	struct regmap_irq_chip_data *rtc_irq_data;
 
 	int irq;
 	struct mutex irqlock;
-- 
2.1.4

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
