Return-Path: <rtc-linux+bncBDS7HNEFSALRBS4TQKXAKGQEYFFENWA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jf3si51224wic.0.2015.08.04.02.45.47
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:47 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 15/15] rtc: rx8025: check time validity when necessary
Date: Tue,  4 Aug 2015 11:45:34 +0200
Message-Id: <1438681534-12027-16-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Check time validity when reading time as this is when we need to know.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index f3f1de26c228..24c3d69ce1b9 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -104,6 +104,31 @@ static s32 rx8025_write_regs(const struct i2c_client *client,
 					      length, values);
 }
 
+static int rx8025_check_validity(struct device *dev)
+{
+	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
+	int ctrl2;
+
+	ctrl2 = rx8025_read_reg(rx8025->client, RX8025_REG_CTRL2);
+	if (ctrl2 < 0)
+		return ctrl2;
+
+	if (ctrl2 & RX8025_BIT_CTRL2_VDET)
+		dev_warn(dev, "power voltage drop detected\n");
+
+	if (ctrl2 & RX8025_BIT_CTRL2_PON) {
+		dev_warn(dev, "power-on reset detected, date is invalid\n");
+		return -EINVAL;
+	}
+
+	if (!(ctrl2 & RX8025_BIT_CTRL2_XST)) {
+		dev_warn(dev, "crystal stopped, date is invalid\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rx8025_reset_validity(struct i2c_client *client)
 {
 	int ctrl2 = rx8025_read_reg(client, RX8025_REG_CTRL2);
@@ -154,21 +179,11 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
 	u8 date[7];
-	int ctrl, err;
-
-	ctrl = rx8025_read_reg(rx8025->client, RX8025_REG_CTRL2);
-	if (ctrl < 0)
-		return ctrl;
-
-	if (ctrl & RX8025_BIT_CTRL2_PON) {
-		dev_warn(dev, "power-on reset detected, date is invalid\n");
-		return -EINVAL;
-	}
+	int err;
 
-	if (!(ctrl & RX8025_BIT_CTRL2_XST)) {
-		dev_warn(dev, "crystal stopped, date is invalid\n");
-		return -EINVAL;
-	}
+	err = rx8025_check_validity(dev);
+	if (err)
+		return err;
 
 	err = rx8025_read_regs(rx8025->client, RX8025_REG_SEC, 7, date);
 	if (err)
@@ -250,21 +265,6 @@ static int rx8025_init_client(struct i2c_client *client)
 	/* Keep test bit zero ! */
 	rx8025->ctrl1 = ctrl[0] & ~RX8025_BIT_CTRL1_TEST;
 
-	if (ctrl[1] & RX8025_BIT_CTRL2_PON) {
-		dev_warn(&client->dev, "power-on reset was detected, "
-			 "you may have to readjust the clock\n");
-	}
-
-	if (ctrl[1] & RX8025_BIT_CTRL2_VDET) {
-		dev_warn(&client->dev, "a power voltage drop was detected, "
-			 "you may have to readjust the clock\n");
-	}
-
-	if (!(ctrl[1] & RX8025_BIT_CTRL2_XST)) {
-		dev_warn(&client->dev, "Oscillation stop was detected,"
-			 "you may have to readjust the clock\n");
-	}
-
 	if (ctrl[1] & (RX8025_BIT_CTRL2_DAFG | RX8025_BIT_CTRL2_WAFG)) {
 		dev_warn(&client->dev, "Alarm was detected\n");
 		need_clear = 1;
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
