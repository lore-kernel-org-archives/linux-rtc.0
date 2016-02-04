Return-Path: <Dirk.Behme@de.bosch.com>
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <rtc-linux@googlegroups.com>, <alexandre.belloni@free-electrons.com>
CC: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [PATCH] rtc: rv8803: convert spin_lock to mutex_lock
Date: Thu, 4 Feb 2016 13:45:20 +0100
Message-ID: <1454589920-32738-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <rtc-linux.googlegroups.com>

From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>

Fix a scheduling while atomic issue caused by rv8803_set_time()
holding a spinlock during the call to i2c_smbus_read_byte_data().

Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
---
 drivers/rtc/rtc-rv8803.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 33c7e2a..38621ff 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -52,7 +52,7 @@
 struct rv8803_data {
 	struct i2c_client *client;
 	struct rtc_device *rtc;
-	spinlock_t flags_lock;
+	struct mutex flags_lock;
 	u8 ctrl;
 };
 
@@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 	unsigned long events = 0;
 	u8 flags;
 
-	spin_lock(&rv8803->flags_lock);
+	mutex_lock(&rv8803->flags_lock);
 
 	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
 	if (flags <= 0) {
-		spin_unlock(&rv8803->flags_lock);
+		mutex_unlock(&rv8803->flags_lock);
 		return IRQ_NONE;
 	}
 
@@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 					  rv8803->ctrl);
 	}
 
-	spin_unlock(&rv8803->flags_lock);
+	mutex_unlock(&rv8803->flags_lock);
 
 	return IRQ_HANDLED;
 }
@@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
 	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
 	u8 date[7];
 	int flags, ret;
-	unsigned long irqflags;
 
 	if ((tm->tm_year < 100) || (tm->tm_year > 199))
 		return -EINVAL;
@@ -173,18 +172,18 @@ static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+	mutex_lock(&rv8803->flags_lock);
 
 	flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
 	if (flags < 0) {
-		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		mutex_unlock(&rv8803->flags_lock);
 		return flags;
 	}
 
 	ret = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG,
 					flags & ~RV8803_FLAG_V2F);
 
-	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+	mutex_unlock(&rv8803->flags_lock);
 
 	return ret;
 }
@@ -226,7 +225,7 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u8 alarmvals[3];
 	u8 ctrl[2];
 	int ret, err;
-	unsigned long alarm_time, irqflags;
+	unsigned long alarm_time;
 
 	/* The alarm has no seconds, round up to nearest minute */
 	if (alrm->time.tm_sec) {
@@ -236,11 +235,11 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		rtc_time_to_tm(alarm_time, &alrm->time);
 	}
 
-	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+	mutex_lock(&rv8803->flags_lock);
 
 	ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
 	if (ret != 2) {
-		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		mutex_unlock(&rv8803->flags_lock);
 		return ret < 0 ? ret : -EIO;
 	}
 
@@ -253,14 +252,14 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		err = i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
 						rv8803->ctrl);
 		if (err) {
-			spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+			mutex_unlock(&rv8803->flags_lock);
 			return err;
 		}
 	}
 
 	ctrl[1] &= ~RV8803_FLAG_AF;
 	err = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, ctrl[1]);
-	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+	mutex_unlock(&rv8803->flags_lock);
 	if (err)
 		return err;
 
@@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
 	int ctrl, flags, err;
-	unsigned long irqflags;
 
 	ctrl = rv8803->ctrl;
 
@@ -305,15 +303,15 @@ static int rv8803_alarm_irq_enable(struct device *dev, unsigned int enabled)
 			ctrl &= ~RV8803_CTRL_AIE;
 	}
 
-	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+	mutex_lock(&rv8803->flags_lock);
 	flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
 	if (flags < 0) {
-		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		mutex_unlock(&rv8803->flags_lock);
 		return flags;
 	}
 	flags &= ~(RV8803_FLAG_AF | RV8803_FLAG_UF);
 	err = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
-	spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+	mutex_unlock(&rv8803->flags_lock);
 	if (err)
 		return err;
 
@@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct rv8803_data *rv8803 = dev_get_drvdata(dev);
 	int flags, ret = 0;
-	unsigned long irqflags;
 
 	switch (cmd) {
 	case RTC_VL_READ:
@@ -355,16 +352,16 @@ static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		return 0;
 
 	case RTC_VL_CLR:
-		spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+		mutex_lock(&rv8803->flags_lock);
 		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
 		if (flags < 0) {
-			spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+			mutex_unlock(&rv8803->flags_lock);
 			return flags;
 		}
 
 		flags &= ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F);
 		ret = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
-		spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+		mutex_unlock(&rv8803->flags_lock);
 		if (ret < 0)
 			return ret;
 
@@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client *client,
 	if (!rv8803)
 		return -ENOMEM;
 
+	mutex_init(&rv8803->flags_lock);
 	rv8803->client = client;
 	i2c_set_clientdata(client, rv8803);
 
-- 
2.5.0
