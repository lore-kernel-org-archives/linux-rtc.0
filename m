Return-Path: <rtc-linux+bncBAABBYUQRK4QKGQE2M5CJPQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a124si18192wme.0.2016.04.28.15.02.10
        for <rtc-linux@googlegroups.com>;
        Thu, 28 Apr 2016 15:02:10 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH V2 6/6] rtc: rv3029: add alarm IRQ
Date: Fri, 29 Apr 2016 00:00:37 +0200
Message-Id: <961740ec0d6777ea098bd8f6889dcdb53f143692.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461879175.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1461879175.git.mylene.josserand@free-electrons.com>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com> <cover.1461879175.git.mylene.josserand@free-electrons.com>
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

Add the alarm IRQ functionality.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-rv3029c2.c | 114 ++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 916bbc2..c2ef64f 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -329,6 +329,47 @@ static int rv3029_eeprom_update_bits(struct device *de=
v,
 	return 0;
 }
=20
+static irqreturn_t rv3029_handle_irq(int irq, void *dev_id)
+{
+	struct device *dev =3D dev_id;
+	struct rv3029_data *rv3029 =3D dev_get_drvdata(dev);
+	struct mutex *lock =3D &rv3029->rtc->ops_lock;
+	unsigned long events =3D 0;
+	u8 flags, controls;
+	int ret;
+
+	mutex_lock(lock);
+
+	ret =3D rv3029_read_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
+	if (ret) {
+		dev_warn(dev, "Read IRQ Control Register error %d\n", ret);
+		mutex_unlock(lock);
+		return IRQ_NONE;
+	}
+
+	ret =3D rv3029_read_regs(dev, RV3029_IRQ_FLAGS, &flags, 1);
+	if (ret) {
+		dev_warn(dev, "Read IRQ Flags Register error %d\n", ret);
+		mutex_unlock(lock);
+		return IRQ_NONE;
+	}
+
+	if (flags & RV3029_IRQ_FLAGS_AF) {
+		flags &=3D ~RV3029_IRQ_FLAGS_AF;
+		controls &=3D ~RV3029_IRQ_CTRL_AIE;
+		events |=3D RTC_AF;
+	}
+
+	if (events) {
+		rtc_update_irq(rv3029->rtc, 1, events);
+		rv3029_write_regs(dev, RV3029_IRQ_FLAGS, &flags, 1);
+		rv3029_write_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
+	}
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
 static int rv3029_read_time(struct device *dev, struct rtc_time *tm)
 {
 	u8 buf[1];
@@ -376,7 +417,7 @@ static int rv3029_read_alarm(struct device *dev, struct=
 rtc_wkalrm *alarm)
 {
 	struct rtc_time *const tm =3D &alarm->time;
 	int ret;
-	u8 regs[8];
+	u8 regs[8], controls, flags;
=20
 	ret =3D rv3029_get_sr(dev, regs);
 	if (ret < 0) {
@@ -392,6 +433,17 @@ static int rv3029_read_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 		return ret;
 	}
=20
+	ret =3D rv3029_read_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
+	if (ret) {
+		dev_err(dev, "Read IRQ Control Register error %d\n", ret);
+		return ret;
+	}
+	ret =3D rv3029_read_regs(dev, RV3029_IRQ_FLAGS, &flags, 1);
+	if (ret < 0) {
+		dev_err(dev, "Read IRQ Flags Register error %d\n", ret);
+		return ret;
+	}
+
 	tm->tm_sec =3D bcd2bin(regs[RV3029_A_SC - RV3029_A_SC] & 0x7f);
 	tm->tm_min =3D bcd2bin(regs[RV3029_A_MN - RV3029_A_SC] & 0x7f);
 	tm->tm_hour =3D bcd2bin(regs[RV3029_A_HR - RV3029_A_SC] & 0x3f);
@@ -400,16 +452,30 @@ static int rv3029_read_alarm(struct device *dev, stru=
ct rtc_wkalrm *alarm)
 	tm->tm_year =3D bcd2bin(regs[RV3029_A_YR - RV3029_A_SC] & 0x7f) + 100;
 	tm->tm_wday =3D bcd2bin(regs[RV3029_A_DW - RV3029_A_SC] & 0x07) - 1;
=20
+	alarm->enabled =3D !!(controls & RV3029_IRQ_CTRL_AIE);
+	alarm->pending =3D (flags & RV3029_IRQ_FLAGS_AF) && alarm->enabled;
+
 	return 0;
 }
=20
-static int rv3029_rtc_alarm_set_irq(struct device *dev, int enable)
+static int rv3029_alarm_irq_enable(struct device *dev, unsigned int enable=
)
 {
 	int ret;
+	u8 controls;
+
+	ret =3D rv3029_read_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
+	if (ret < 0) {
+		dev_warn(dev, "Read IRQ Control Register error %d\n", ret);
+		return ret;
+	}
=20
 	/* enable/disable AIE irq */
-	ret =3D rv3029_update_bits(dev, RV3029_IRQ_CTRL, RV3029_IRQ_CTRL_AIE,
-				 (enable ? RV3029_IRQ_CTRL_AIE : 0));
+	if (enable)
+		controls |=3D RV3029_IRQ_CTRL_AIE;
+	else
+		controls &=3D ~RV3029_IRQ_CTRL_AIE;
+
+	ret =3D rv3029_write_regs(dev, RV3029_IRQ_CTRL, &controls, 1);
 	if (ret < 0) {
 		dev_err(dev, "can't update INT reg\n");
 		return ret;
@@ -459,26 +525,15 @@ static int rv3029_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alarm)
 		return ret;
=20
 	if (alarm->enabled) {
-		/* clear AF flag */
-		ret =3D rv3029_update_bits(dev, RV3029_IRQ_FLAGS,
-					 RV3029_IRQ_FLAGS_AF, 0);
-		if (ret < 0) {
-			dev_err(dev, "can't clear alarm flag\n");
-			return ret;
-		}
 		/* enable AIE irq */
-		ret =3D rv3029_rtc_alarm_set_irq(dev, 1);
+		ret =3D rv3029_alarm_irq_enable(dev, 1);
 		if (ret)
 			return ret;
-
-		dev_dbg(dev, "alarm IRQ armed\n");
 	} else {
 		/* disable AIE irq */
-		ret =3D rv3029_rtc_alarm_set_irq(dev, 0);
+		ret =3D rv3029_alarm_irq_enable(dev, 0);
 		if (ret)
 			return ret;
-
-		dev_dbg(dev, "alarm IRQ disabled\n");
 	}
=20
 	return 0;
@@ -731,11 +786,9 @@ static void rv3029_hwmon_register(struct device *dev, =
const char *name)
=20
 #endif /* CONFIG_RTC_DRV_RV3029_HWMON */
=20
-static const struct rtc_class_ops rv3029_rtc_ops =3D {
+static struct rtc_class_ops rv3029_rtc_ops =3D {
 	.read_time	=3D rv3029_read_time,
 	.set_time	=3D rv3029_set_time,
-	.read_alarm	=3D rv3029_read_alarm,
-	.set_alarm	=3D rv3029_set_alarm,
 };
=20
 static struct i2c_device_id rv3029_id[] =3D {
@@ -772,8 +825,27 @@ static int rv3029_probe(struct device *dev, struct reg=
map *regmap, int irq,
=20
 	rv3029->rtc =3D devm_rtc_device_register(dev, name, &rv3029_rtc_ops,
 					       THIS_MODULE);
+	if (IS_ERR(rv3029->rtc)) {
+		dev_err(dev, "unable to register the class device\n");
+		return PTR_ERR(rv3029->rtc);
+	}
=20
-	return PTR_ERR_OR_ZERO(rv3029->rtc);
+	if (rv3029->irq > 0) {
+		rc =3D devm_request_threaded_irq(dev, rv3029->irq,
+					       NULL, rv3029_handle_irq,
+					       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					       "rv3029", dev);
+		if (rc) {
+			dev_warn(dev, "unable to request IRQ, alarms disabled\n");
+			rv3029->irq =3D 0;
+		} else {
+			rv3029_rtc_ops.read_alarm =3D rv3029_read_alarm;
+			rv3029_rtc_ops.set_alarm =3D rv3029_set_alarm;
+			rv3029_rtc_ops.alarm_irq_enable =3D rv3029_alarm_irq_enable;
+		}
+	}
+
+	return 0;
 }
=20
 #if IS_ENABLED(CONFIG_I2C)
--=20
2.8.0.rc3

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
