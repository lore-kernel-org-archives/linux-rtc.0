Return-Path: <rtc-linux+bncBDS7HNEFSALRBSUTQKXAKGQEX7H7DEY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si48395wib.1.2015.08.04.02.45.46
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:46 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 12/15] rtc: rx8025: reset validity when setting time
Date: Tue,  4 Aug 2015 11:45:31 +0200
Message-Id: <1438681534-12027-13-git-send-email-alexandre.belloni@free-electrons.com>
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

Wait for the user to set the time to reset the validity bits. Until then,
the time may be invalid.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 22ce08d6e807..340133a5d907 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -104,6 +104,19 @@ static s32 rx8025_write_regs(const struct i2c_client *client,
 					      length, values);
 }
 
+static int rx8025_reset_validity(struct i2c_client *client)
+{
+	int ctrl2 = rx8025_read_reg(client, RX8025_REG_CTRL2);
+
+	if (ctrl2 < 0)
+		return ctrl2;
+
+	ctrl2 &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET);
+
+	return rx8025_write_reg(client, RX8025_REG_CTRL2,
+				ctrl2 | RX8025_BIT_CTRL2_XST);
+}
+
 static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
@@ -133,10 +146,6 @@ static irqreturn_t rx8025_handle_irq(int irq, void *dev_id)
 		rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
 	}
 
-	/* acknowledge IRQ */
-	rx8025_write_reg(client, RX8025_REG_CTRL2,
-			 status | RX8025_BIT_CTRL2_XST);
-
 out:
 	return IRQ_HANDLED;
 }
@@ -193,6 +202,7 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 {
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
 	u8 date[7];
+	int ret;
 
 	if ((dt->tm_year < 100) || (dt->tm_year > 199))
 		return -EINVAL;
@@ -219,7 +229,11 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 		__func__,
 		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
 
-	return rx8025_write_regs(rx8025->client, RX8025_REG_SEC, 7, date);
+	ret = rx8025_write_regs(rx8025->client, RX8025_REG_SEC, 7, date);
+	if (ret < 0)
+		return ret;
+
+	return rx8025_reset_validity(rx8025->client);
 }
 
 static int rx8025_init_client(struct i2c_client *client)
@@ -239,19 +253,16 @@ static int rx8025_init_client(struct i2c_client *client)
 	if (ctrl[1] & RX8025_BIT_CTRL2_PON) {
 		dev_warn(&client->dev, "power-on reset was detected, "
 			 "you may have to readjust the clock\n");
-		need_clear = 1;
 	}
 
 	if (ctrl[1] & RX8025_BIT_CTRL2_VDET) {
 		dev_warn(&client->dev, "a power voltage drop was detected, "
 			 "you may have to readjust the clock\n");
-		need_clear = 1;
 	}
 
 	if (!(ctrl[1] & RX8025_BIT_CTRL2_XST)) {
 		dev_warn(&client->dev, "Oscillation stop was detected,"
 			 "you may have to readjust the clock\n");
-		need_clear = 1;
 	}
 
 	if (ctrl[1] & (RX8025_BIT_CTRL2_DAFG | RX8025_BIT_CTRL2_WAFG)) {
@@ -264,10 +275,8 @@ static int rx8025_init_client(struct i2c_client *client)
 
 	if (need_clear) {
 		ctrl2 = ctrl[1];
-		ctrl2 &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET |
-			   RX8025_BIT_CTRL2_CTFG | RX8025_BIT_CTRL2_WAFG |
+		ctrl2 &= ~(RX8025_BIT_CTRL2_CTFG | RX8025_BIT_CTRL2_WAFG |
 			   RX8025_BIT_CTRL2_DAFG);
-		ctrl2 |= RX8025_BIT_CTRL2_XST;
 
 		err = rx8025_write_reg(client, RX8025_REG_CTRL2, ctrl2);
 	}
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
