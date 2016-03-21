Return-Path: <rtc-linux+bncBAABBGWVYC3QKGQEE3YUVUI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si498877wmd.1.2016.03.21.10.08.42
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Mar 2016 10:08:42 -0700 (PDT)
From: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 2/2] rtc: abx80x: handle the oscillator failure bit
Date: Mon, 21 Mar 2016 18:06:10 +0100
Message-Id: <60a87de0ef65325fab65ecf897fc34df9641f188.1458579029.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1458579029.git.mylene.josserand@free-electrons.com>
References: <cover.1458579029.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1458579029.git.mylene.josserand@free-electrons.com>
References: <cover.1458579029.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Handle the Oscillator Failure ('OF') bit from Oscillator Status register
(0x1D). This bit is cleared on set_time function and is read each time the
date/time is read, but only in case of XT Oscillator selection.
In RC mode, this bit is always set.

Signed-off-by: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-abx80x.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 0e4c9a0..ba0d619 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -58,6 +58,7 @@
 #define ABX8XX_OSC_OSEL		BIT(7)
 
 #define ABX8XX_REG_OSS		0x1d
+#define ABX8XX_OSS_OF		BIT(1)
 #define ABX8XX_OSS_OMODE	BIT(4)
 
 #define ABX8XX_REG_CFG_KEY	0x1f
@@ -138,7 +139,23 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[8];
-	int err;
+	int err, flags, rc_mode = 0;
+
+	/* Read the Oscillator Failure only in XT mode */
+	rc_mode = abx80x_is_rc_mode(client);
+	if (rc_mode < 0)
+		return rc_mode;
+
+	if (!rc_mode) {
+		flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
+		if (flags < 0)
+			return flags;
+
+		if (flags & ABX8XX_OSS_OF) {
+			dev_err(dev, "Oscillator failure, data is invalid.\n");
+			return -EINVAL;
+		}
+	}
 
 	err = i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
 					    sizeof(buf), buf);
@@ -166,7 +183,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[8];
-	int err;
+	int err, flags;
 
 	if (tm->tm_year < 100)
 		return -EINVAL;
@@ -187,6 +204,18 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	/* Clear the OF bit of Oscillator Status Register */
+	flags = i2c_smbus_read_byte_data(client, ABX8XX_REG_OSS);
+	if (flags < 0)
+		return flags;
+
+	err = i2c_smbus_write_byte_data(client, ABX8XX_REG_OSS,
+					flags & ~ABX8XX_OSS_OF);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write oscillator status register\n");
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.7.0

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
