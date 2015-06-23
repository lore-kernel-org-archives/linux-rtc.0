Return-Path: <rtc-linux+bncBCO3XAUMTIFRBIUMU2WAKGQEI4DY5RA@googlegroups.com>
Received: from bear.ext.ti.com (bear.ext.ti.com. [192.94.94.41])
        by gmr-mx.google.com with ESMTPS id ns5si31562igb.0.2015.06.23.09.15.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 09:15:30 -0700 (PDT)
From: Nishanth Menon <nm@ti.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <balbi@ti.com>, <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] [PATCH V2 1/5] drivers/rtc/rtc-ds1307.c: Convert to
 threaded IRQ
Date: Tue, 23 Jun 2015 11:15:10 -0500
Message-ID: <1435076114-12416-2-git-send-email-nm@ti.com>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
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

From: Felipe Balbi <balbi@ti.com>

The driver currently emulates the concept of threaded IRQ using a
workqueue, which it really does not need to. Instead, switch over to
threaded_irq handlers which is meant precisely for the same purpose.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/rtc/rtc-ds1307.c |   59 +++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 6e76de1856fc..8ea496e54a2e 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -114,7 +114,6 @@ struct ds1307 {
 #define HAS_ALARM	1		/* bit 1 == irq claimed */
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
-	struct work_struct	work;
 	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
 			       u8 length, u8 *values);
 	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
@@ -311,27 +310,17 @@ static s32 ds1307_native_smbus_read_block_data(const struct i2c_client *client,
 /*----------------------------------------------------------------------*/
 
 /*
- * The IRQ logic includes a "real" handler running in IRQ context just
- * long enough to schedule this workqueue entry.   We need a task context
- * to talk to the RTC, since I2C I/O calls require that; and disable the
- * IRQ until we clear its status on the chip, so that this handler can
- * work with any type of triggering (not just falling edge).
- *
  * The ds1337 and ds1339 both have two alarms, but we only use the first
  * one (with a "seconds" field).  For ds1337 we expect nINTA is our alarm
  * signal; ds1339 chips have only one alarm signal.
  */
-static void ds1307_work(struct work_struct *work)
+static irqreturn_t ds1307_irq(int irq, void *dev_id)
 {
-	struct ds1307		*ds1307;
-	struct i2c_client	*client;
-	struct mutex		*lock;
+	struct i2c_client	*client = dev_id;
+	struct ds1307		*ds1307 = i2c_get_clientdata(client);
+	struct mutex		*lock = &ds1307->rtc->ops_lock;
 	int			stat, control;
 
-	ds1307 = container_of(work, struct ds1307, work);
-	client = ds1307->client;
-	lock = &ds1307->rtc->ops_lock;
-
 	mutex_lock(lock);
 	stat = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
 	if (stat < 0)
@@ -352,18 +341,8 @@ static void ds1307_work(struct work_struct *work)
 	}
 
 out:
-	if (test_bit(HAS_ALARM, &ds1307->flags))
-		enable_irq(client->irq);
 	mutex_unlock(lock);
-}
-
-static irqreturn_t ds1307_irq(int irq, void *dev_id)
-{
-	struct i2c_client	*client = dev_id;
-	struct ds1307		*ds1307 = i2c_get_clientdata(client);
 
-	disable_irq_nosync(irq);
-	schedule_work(&ds1307->work);
 	return IRQ_HANDLED;
 }
 
@@ -634,13 +613,14 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
 					 MCP794XX_BIT_ALMX_C1 | \
 					 MCP794XX_BIT_ALMX_C2)
 
-static void mcp794xx_work(struct work_struct *work)
+static irqreturn_t mcp794xx_irq(int irq, void *dev_id)
 {
-	struct ds1307 *ds1307 = container_of(work, struct ds1307, work);
-	struct i2c_client *client = ds1307->client;
+	struct i2c_client       *client = dev_id;
+	struct ds1307           *ds1307 = i2c_get_clientdata(client);
+	struct mutex            *lock = &ds1307->rtc->ops_lock;
 	int reg, ret;
 
-	mutex_lock(&ds1307->rtc->ops_lock);
+	mutex_lock(lock);
 
 	/* Check and clear alarm 0 interrupt flag. */
 	reg = i2c_smbus_read_byte_data(client, MCP794XX_REG_ALARM0_CTRL);
@@ -665,9 +645,9 @@ static void mcp794xx_work(struct work_struct *work)
 	rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
 
 out:
-	if (test_bit(HAS_ALARM, &ds1307->flags))
-		enable_irq(client->irq);
-	mutex_unlock(&ds1307->rtc->ops_lock);
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
 }
 
 static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t)
@@ -896,6 +876,8 @@ static int ds1307_probe(struct i2c_client *client,
 	bool			want_irq = false;
 	unsigned char		*buf;
 	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
+	irq_handler_t	irq_handler = ds1307_irq;
+
 	static const int	bbsqi_bitpos[] = {
 		[ds_1337] = 0,
 		[ds_1339] = DS1339_BIT_BBSQI,
@@ -962,8 +944,6 @@ static int ds1307_probe(struct i2c_client *client,
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
 		if (ds1307->client->irq > 0 && chip->alarm) {
-			INIT_WORK(&ds1307->work, ds1307_work);
-
 			ds1307->regs[0] |= DS1337_BIT_INTCN
 					| bbsqi_bitpos[ds1307->type];
 			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
@@ -1053,7 +1033,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case mcp794xx:
 		rtc_ops = &mcp794xx_rtc_ops;
 		if (ds1307->client->irq > 0 && chip->alarm) {
-			INIT_WORK(&ds1307->work, mcp794xx_work);
+			irq_handler = mcp794xx_irq;
 			want_irq = true;
 		}
 		break;
@@ -1176,8 +1156,9 @@ read_rtc:
 	}
 
 	if (want_irq) {
-		err = request_irq(client->irq, ds1307_irq, IRQF_SHARED,
-			  ds1307->rtc->name, client);
+		err = request_threaded_irq(client->irq, NULL, irq_handler,
+					   IRQF_SHARED | IRQF_ONESHOT,
+					   ds1307->rtc->name, client);
 		if (err) {
 			client->irq = 0;
 			dev_err(&client->dev, "unable to request IRQ!\n");
@@ -1231,10 +1212,8 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (test_and_clear_bit(HAS_ALARM, &ds1307->flags)) {
+	if (test_and_clear_bit(HAS_ALARM, &ds1307->flags))
 		free_irq(client->irq, client);
-		cancel_work_sync(&ds1307->work);
-	}
 
 	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
 		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
-- 
1.7.9.5

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
