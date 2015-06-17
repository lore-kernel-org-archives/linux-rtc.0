Return-Path: <rtc-linux+bncBCMNZUWXYYORB4EHQ6WAKGQES5QVVGA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com. [209.85.192.175])
        by gmr-mx.google.com with ESMTPS id fl5si663678pad.0.2015.06.17.12.01.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 12:01:04 -0700 (PDT)
Received: by mail-pd0-f175.google.com with SMTP id ki1so46712991pdb.1
        for <rtc-linux@googlegroups.com>; Wed, 17 Jun 2015 12:01:04 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	lee.jones@linaro.org,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] [PATCH-v2 1/3] mfd: 88pm800: Add device tree support
Date: Thu, 18 Jun 2015 00:28:05 +0530
Message-Id: <1434567488-6477-2-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Add DT support to the 88pm800 driver, along with compatible
field for it's sub-devices (rtc, onkey and regulator)

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 841717a..059f01a 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm80x.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 /* Interrupt Registers */
 #define PM800_INT_STATUS1		(0x05)
@@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
+static const struct of_device_id pm80x_of_match_table[] = {
+	{ .compatible = "marvell,88pm800", },
+	{},
+};
+
 static struct resource rtc_resources[] = {
 	{
 	 .name = "88pm80x-rtc",
@@ -133,6 +139,7 @@ static struct resource rtc_resources[] = {
 static struct mfd_cell rtc_devs[] = {
 	{
 	 .name = "88pm80x-rtc",
+	 .of_compatible = "marvell,88pm80x-rtc",
 	 .num_resources = ARRAY_SIZE(rtc_resources),
 	 .resources = &rtc_resources[0],
 	 .id = -1,
@@ -151,6 +158,7 @@ static struct resource onkey_resources[] = {
 static const struct mfd_cell onkey_devs[] = {
 	{
 	 .name = "88pm80x-onkey",
+	 .of_compatible = "marvell,88pm80x-onkey",
 	 .num_resources = 1,
 	 .resources = &onkey_resources[0],
 	 .id = -1,
@@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] = {
 static const struct mfd_cell regulator_devs[] = {
 	{
 	 .name = "88pm80x-regulator",
+	 .of_compatible = "marvell,88pm80x-regulator",
 	 .id = -1,
 	},
 };
@@ -544,8 +553,23 @@ static int pm800_probe(struct i2c_client *client,
 	int ret = 0;
 	struct pm80x_chip *chip;
 	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device_node *np = client->dev.of_node;
 	struct pm80x_subchip *subchip;
 
+	if (!pdata && !np) {
+		dev_err(&client->dev,
+			"pm80x requires platform data or of_node\n");
+		return -EINVAL;
+	}
+
+	if (!pdata) {
+		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&client->dev, "failed to allocaate memory\n");
+			return -ENOMEM;
+		}
+	}
+
 	ret = pm80x_init(client);
 	if (ret) {
 		dev_err(&client->dev, "pm800_init fail\n");
@@ -611,6 +635,7 @@ static struct i2c_driver pm800_driver = {
 		.name = "88PM800",
 		.owner = THIS_MODULE,
 		.pm = &pm80x_pm_ops,
+		.of_match_table	= pm80x_of_match_table,
 		},
 	.probe = pm800_probe,
 	.remove = pm800_remove,
-- 
1.9.1

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
