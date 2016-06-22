Return-Path: <rtc-linux+bncBDCMXBNSKAINHZVIXMCRUBABWICEC@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de. [2a03:cc00:ff0:100::2])
        by gmr-mx.google.com with ESMTPS id a6si246939wma.1.2016.06.21.23.42.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 23:42:27 -0700 (PDT)
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 6B319D8009E
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:27 +0200 (CEST)
Received: from SI-HUB1001.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id 2775A2E4031B
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 08:42:27 +0200 (CEST)
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>
CC: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>, Carsten Resch
	<Carsten.Resch@de.bosch.com>, Dirk Behme <dirk.behme@de.bosch.com>
Subject: [rtc-linux] [PATCH v2 4/4] rtc: rv8803: Be able to set VDETOFF and
 SWOFF via devcie tree
Date: Wed, 22 Jun 2016 08:42:22 +0200
Message-ID: <1466577742-18824-5-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
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

From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>

There might be designs where the power supply circuit is designed
in a way that VDETOFF and SWOFF is reuqired to be set. Otherwise the
RTC detects a power loss. Add a device tree interface for this.

Signed-off-by: Carsten Resch <Carsten.Resch@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: devicetree@vger.kernel.org
---
 drivers/rtc/rtc-rv8803.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index e122b51..32a5686 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -50,6 +50,10 @@
 #define RV8803_CTRL_TIE			BIT(4)
 #define RV8803_CTRL_UIE			BIT(5)
 
+#define RX8900_BACKUP_CTRL		0x18
+#define RX8900_FLAG_SWOFF		BIT(2)
+#define RX8900_FLAG_VDETOFF		BIT(3)
+
 struct rv8803_data {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
@@ -423,6 +427,35 @@ static struct rtc_class_ops rv8803_rtc_ops = {
 	.ioctl = rv8803_ioctl,
 };
 
+static int rx8900_trickle_charger_init(struct rv8803_data *rv8803)
+{
+	struct i2c_client *client = rv8803->client;
+	struct device_node *node = client->dev.of_node;
+	int err;
+	u8 flags;
+
+	if (!node)
+		return 0;
+
+	if (!of_device_is_compatible(node, "epson,rx8900"))
+		return 0;
+
+	err = i2c_smbus_read_byte_data(rv8803->client, RX8900_BACKUP_CTRL);
+	if (err < 0)
+		return err;
+
+	flags = ~(RX8900_FLAG_VDETOFF | RX8900_FLAG_SWOFF) & (u8)err;
+
+	if (of_property_read_bool(node, "epson,vdet-disable"))
+		flags |= RX8900_FLAG_VDETOFF;
+
+	if (of_property_read_bool(node, "trickle-diode-disable"))
+		flags |= RX8900_FLAG_SWOFF;
+
+	return i2c_smbus_write_byte_data(rv8803->client, RX8900_BACKUP_CTRL,
+					 flags);
+}
+
 static int rv8803_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -498,6 +531,12 @@ static int rv8803_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
+	err = rx8900_trickle_charger_init(rv8803);
+	if (err) {
+		dev_err(&client->dev, "failed to init charger\n");
+		return err;
+	}
+
 	err = device_create_bin_file(&client->dev, &rv8803_nvram_attr);
 	if (err)
 		return err;
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
