Return-Path: <rtc-linux+bncBD66BCOYSQBBBOOQQO5QKGQE3BOBQ7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id d127si480030ite.1.2016.06.14.22.31.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 14 Jun 2016 22:31:37 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <alexandre.belloni@free-electrons.com>, <a.zummo@towertech.it>
CC: <rtc-linux@googlegroups.com>, <j-keerthy@ti.com>, <Russ.Dill@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] [PATCH] RTC: Add functionality to read/write rtc scratch registers
Date: Wed, 15 Jun 2016 11:00:41 +0530
Message-ID: <1465968641-8080-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Russ Dill <Russ.Dill@ti.com> 

Many RTCs provide scratch registers that are maintained so long as the RTC
has power. Provide a generic method to access these registers.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/interface.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-omap.c  | 35 ++++++++++++++++++++++++++++++++++
 include/linux/rtc.h     |  7 +++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7cafd4d..d5a7ee2 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1018,3 +1018,53 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	mutex_unlock(&rtc->ops_lock);
 	return ret;
 }
+
+/* rtc_read_scratch - Read from RTC scratch register
+ * @ rtc: rtc device to be used
+ * @ index: index of scratch register
+ * @ value: returned value read
+ *
+ * Kernel interface read from an RTC scratch register
+ */
+int rtc_read_scratch(struct rtc_device *rtc, unsigned int index, u32 *value)
+{
+	int err;
+
+	mutex_lock(&rtc->ops_lock);
+	if (!rtc->ops)
+		err = -ENODEV;
+	else if (index >= rtc->ops->scratch_size || !rtc->ops->read_scratch)
+		err = -EINVAL;
+	else
+		err = rtc->ops->read_scratch(rtc->dev.parent, index, value);
+	mutex_unlock(&rtc->ops_lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtc_read_scratch);
+
+/* rtc_write_scratch - Write to RTC scratch register
+ * @ rtc: rtc device to be used
+ * @ index: index of scratch register
+ * @ value: value to write
+ *
+ * Kernel interface write to an RTC scratch register
+ */
+int rtc_write_scratch(struct rtc_device *rtc, unsigned int index, u32 value)
+{
+	int err;
+
+	mutex_lock(&rtc->ops_lock);
+
+	if (!rtc->ops)
+		err = -ENODEV;
+	else if (index >= rtc->ops->scratch_size ||
+		 !rtc->ops->write_scratch)
+		err = -EINVAL;
+	else
+		err = rtc->ops->write_scratch(rtc->dev.parent, index, value);
+
+	mutex_unlock(&rtc->ops_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtc_write_scratch);
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ec2e9c5..d00ca11 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -66,6 +66,10 @@
 #define OMAP_RTC_COMP_MSB_REG		0x50
 #define OMAP_RTC_OSC_REG		0x54
 
+#define OMAP_RTC_SCRATCH0_REG		0x60
+#define OMAP_RTC_SCRATCH1_REG		0x64
+#define OMAP_RTC_SCRATCH2_REG		0x68
+
 #define OMAP_RTC_KICK0_REG		0x6c
 #define OMAP_RTC_KICK1_REG		0x70
 
@@ -405,6 +409,34 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static struct omap_rtc *omap_rtc_power_off_rtc;
 
+static const u32 omap_rtc_scratch_regs[] = {
+	OMAP_RTC_SCRATCH0_REG,
+	OMAP_RTC_SCRATCH1_REG,
+	OMAP_RTC_SCRATCH2_REG,
+};
+
+static int omap_rtc_read_scratch(struct device *dev, unsigned int index,
+				 u32 *value)
+{
+	*value = readl(omap_rtc_power_off_rtc->base +
+		       omap_rtc_scratch_regs[index]);
+
+	return 0;
+}
+
+static int omap_rtc_write_scratch(struct device *dev, unsigned int index,
+				  u32 value)
+{
+	struct omap_rtc *rtc = dev_get_drvdata(dev);
+
+	rtc->type->unlock(rtc);
+	writel(value, omap_rtc_power_off_rtc->base +
+	       omap_rtc_scratch_regs[index]);
+	rtc->type->lock(rtc);
+
+	return 0;
+}
+
 /*
  * omap_rtc_poweroff: RTC-controlled power off
  *
@@ -475,6 +507,9 @@ static struct rtc_class_ops omap_rtc_ops = {
 	.read_alarm	= omap_rtc_read_alarm,
 	.set_alarm	= omap_rtc_set_alarm,
 	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
+	.read_scratch	= omap_rtc_read_scratch,
+	.write_scratch	= omap_rtc_write_scratch,
+	.scratch_size	= ARRAY_SIZE(omap_rtc_scratch_regs),
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index b693ada..da5e003 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -91,6 +91,10 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	int (*read_scratch)(struct device *, unsigned int, u32*);
+	int (*write_scratch)(struct device *, unsigned int, u32);
+
+	unsigned int scratch_size;
 };
 
 #define RTC_DEVICE_NAME_SIZE 20
@@ -214,6 +218,9 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset);
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
 
+int rtc_read_scratch(struct rtc_device *rtc, unsigned int index, u32 *value);
+int rtc_write_scratch(struct rtc_device *rtc, unsigned int index, u32 value);
+
 static inline bool is_leap_year(unsigned int year)
 {
 	return (!(year % 4) && (year % 100)) || !(year % 400);
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
