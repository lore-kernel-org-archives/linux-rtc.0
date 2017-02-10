Return-Path: <rtc-linux+bncBDM47J4M6QEBBFEF7DCAKGQECV3VMPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id u12si471517pfd.3.2017.02.10.10.12.36
        for <rtc-linux@googlegroups.com>;
        Fri, 10 Feb 2017 10:12:36 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 3/3] rtc: m48t86: add NVRAM support
Date: Fri, 10 Feb 2017 11:11:57 -0700
Message-Id: <20170210181157.6283-4-hsweeten@visionengravers.com>
In-Reply-To: <20170210181157.6283-1-hsweeten@visionengravers.com>
References: <20170210181157.6283-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This RTC has 114 bytes of NVRAM. Provide access to it via a biniary
sysfs 'nvram' attribute file.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/rtc/rtc-m48t86.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 4dcdbd2..4dc4af4 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -38,6 +38,8 @@
 #define M48T86_C		0x0c
 #define M48T86_D		0x0d
 #define M48T86_D_VRT		BIT(7)
+#define M48T86_NVRAM(x)		(0x0e + (x))
+#define M48T86_NVRAM_LEN	114
 
 struct m48t86_rtc_info {
 	void __iomem *index_reg;
@@ -170,6 +172,35 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
 	.proc		= m48t86_rtc_proc,
 };
 
+static ssize_t m48t86_nvram_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *attr,
+				 char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		buf[i] = m48t86_readb(dev, M48T86_NVRAM(off + i));
+
+	return count;
+}
+
+static ssize_t m48t86_nvram_write(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *attr,
+				  char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		m48t86_writeb(dev, buf[i], M48T86_NVRAM(off + i));
+
+	return count;
+}
+
+static BIN_ATTR(nvram, 0644, m48t86_nvram_read, m48t86_nvram_write,
+		M48T86_NVRAM_LEN);
+
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t86_rtc_info *info;
@@ -210,6 +241,15 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "battery %s\n",
 		 (reg & M48T86_D_VRT) ? "ok" : "exhausted");
 
+	if (device_create_bin_file(&pdev->dev, &bin_attr_nvram))
+		dev_err(&pdev->dev, "failed to create nvram sysfs entry\n");
+
+	return 0;
+}
+
+static int m48t86_rtc_remove(struct platform_device *pdev)
+{
+	device_remove_bin_file(&pdev->dev, &bin_attr_nvram);
 	return 0;
 }
 
@@ -218,6 +258,7 @@ static struct platform_driver m48t86_rtc_platform_driver = {
 		.name	= "rtc-m48t86",
 	},
 	.probe		= m48t86_rtc_probe,
+	.remove		= m48t86_rtc_remove,
 };
 
 module_platform_driver(m48t86_rtc_platform_driver);
-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
