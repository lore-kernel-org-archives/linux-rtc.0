Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 5/5] rtc: remove rtc_device.name
Date: Fri,  2 Jun 2017 14:21:57 +0200
Message-Id: <20170602122157.4677-5-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
References: <20170602122157.4677-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

rtc->name is only used in messages were it is superfluous. Remove it
completely from the structure.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/class.c | 7 +++----
 include/linux/rtc.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 5fb439897fe1..543c64cd3df0 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -224,7 +224,6 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	rtc->pie_timer.function = rtc_pie_update_irq;
 	rtc->pie_enabled = 0;
 
-	strlcpy(rtc->name, name, RTC_DEVICE_NAME_SIZE);
 	dev_set_name(&rtc->dev, "rtc%d", id);
 
 	/* Check to see if there is an ALARM already set in hw */
@@ -238,20 +237,20 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 	err = cdev_device_add(&rtc->char_dev, &rtc->dev);
 	if (err) {
 		dev_warn(&rtc->dev, "%s: failed to add char device %d:%d\n",
-			 rtc->name, MAJOR(rtc->dev.devt), rtc->id);
+			 name, MAJOR(rtc->dev.devt), rtc->id);
 
 		/* This will free both memory and the ID */
 		put_device(&rtc->dev);
 		goto exit;
 	} else {
-		dev_dbg(&rtc->dev, "%s: dev (%d:%d)\n", rtc->name,
+		dev_dbg(&rtc->dev, "%s: dev (%d:%d)\n", name,
 			MAJOR(rtc->dev.devt), rtc->id);
 	}
 
 	rtc_proc_add_device(rtc);
 
 	dev_info(dev, "rtc core: registered %s as %s\n",
-			rtc->name, dev_name(&rtc->dev));
+			name, dev_name(&rtc->dev));
 
 	return rtc;
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index b693adac853b..d354f56e0cf5 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -116,7 +116,6 @@ struct rtc_device {
 	struct module *owner;
 
 	int id;
-	char name[RTC_DEVICE_NAME_SIZE];
 
 	const struct rtc_class_ops *ops;
 	struct mutex ops_lock;
-- 
2.11.0
