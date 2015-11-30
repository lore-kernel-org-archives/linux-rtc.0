Return-Path: <rtc-linux+bncBDKLR6HU7IIBBIXR6GZAKGQEDI7HZCA@googlegroups.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com. [195.59.15.196])
        by gmr-mx.google.com with ESMTP id b62si424610wmc.0.2015.11.30.08.26.09
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 08:26:09 -0800 (PST)
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>
CC: Paul Burton <paul.burton@imgtec.com>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, <rtc-linux@googlegroups.com>,
	Alessandro Zummo <a.zummo@towertech.it>, <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] [PATCH 16/28] rtc: m41t80: add devicetree probe support
Date: Mon, 30 Nov 2015 16:21:41 +0000
Message-ID: <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Allow the m41t80 RTC driver to be probed via devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/rtc/rtc-m41t80.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index a82937e..d3b29fc 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -85,6 +86,14 @@ static const struct i2c_device_id m41t80_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, m41t80_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id m41t80_of_match[] = {
+	{ .compatible = "st,m41t81s", .name = "m41t81s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, m41t80_of_match);
+#endif
+
 struct m41t80_data {
 	u8 features;
 	struct rtc_device *rtc;
@@ -637,6 +646,22 @@ static int m41t80_probe(struct i2c_client *client,
 	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
 	struct m41t80_data *clientdata = NULL;
+	const struct of_device_id *of_id;
+
+	if (!id && client->dev.of_node) {
+		of_id = of_match_node(of_match_ptr(m41t80_of_match),
+				      client->dev.of_node);
+		for (id = m41t80_id; id->name[0]; id++) {
+			if (strcmp(of_id->name, id->name) == 0)
+				break;
+		}
+		if (!id->name[0])
+			id = NULL;
+	}
+	if (!id) {
+		dev_err(&client->dev, "No i2c_device_id found\n");
+		return -EINVAL;
+	}
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
 				     | I2C_FUNC_SMBUS_BYTE_DATA))
@@ -728,6 +753,7 @@ static int m41t80_remove(struct i2c_client *client)
 static struct i2c_driver m41t80_driver = {
 	.driver = {
 		.name = "rtc-m41t80",
+		.of_match_table = of_match_ptr(m41t80_of_match),
 	},
 	.probe = m41t80_probe,
 	.remove = m41t80_remove,
-- 
2.6.2

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
