Return-Path: <rtc-linux+bncBD7I3CGX5IPRBZ6W2GZAKGQEKS5PV2I@googlegroups.com>
MIME-Version: 1.0
Received: from mail-lf0-x22e.google.com (mail-lf0-x22e.google.com. [2a00:1450:4010:c07::22e])
        by gmr-mx.google.com with ESMTPS id ea7si499429lbc.0.2015.11.24.05.51.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 05:51:35 -0800 (PST)
Received: by mail-lf0-x22e.google.com with SMTP id u14so20887540lff.1
        for <rtc-linux@googlegroups.com>; Tue, 24 Nov 2015 05:51:35 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 2/2] drivers/rtc/rtc-ds1685.c: don't try to
 micromanage sysfs output size
Date: Tue, 24 Nov 2015 14:51:24 +0100
Message-Id: <1448373085-6353-2-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1448373085-6353-1-git-send-email-linux@rasmusvillemoes.dk>
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

...and don't do it wrong.

"not ok or N/A" has length 13. Add the trailing newline, and the
snprintf return value will be 14. However, we lied to snprintf and
told it that only 13 bytes were available. Hence snprintf has only
written "not ok or N/" and a trailing '\0' to the buffer. Next we
continue lying, this time to the upper sysfs layer, claiming that we
wrote 14 meaningful bytes to the buffer. That'll make the upper layer
copy "not ok or N/" plus two nul bytes to user space (one nul byte
from snprintf, the other since sysfs takes care to clear the buffer
before giving it to the ->show method).

In the other cases, the claimed buffer size is closer to sufficient,
but we'll still get a nul byte instead of a newline written to user
space.  There's absolutely no reason to try to predict the output
size, and there's plenty of room in the buffer, so just use sprintf.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-ds1685.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 5038122aa8de..535050fc5e9f 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1114,7 +1114,7 @@ ds1685_rtc_sysfs_battery_show(struct device *dev,
 
 	ctrld = rtc->read(rtc, RTC_CTRL_D);
 
-	return snprintf(buf, 13, "%s\n",
+	return sprintf(buf, "%s\n",
 			(ctrld & RTC_CTRL_D_VRT) ? "ok" : "not ok or N/A");
 }
 static DEVICE_ATTR(battery, S_IRUGO, ds1685_rtc_sysfs_battery_show, NULL);
@@ -1137,7 +1137,7 @@ ds1685_rtc_sysfs_auxbatt_show(struct device *dev,
 	ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return snprintf(buf, 13, "%s\n",
+	return sprintf(buf, "%s\n",
 			(ctrl4a & RTC_CTRL_4A_VRT2) ? "ok" : "not ok or N/A");
 }
 static DEVICE_ATTR(auxbatt, S_IRUGO, ds1685_rtc_sysfs_auxbatt_show, NULL);
@@ -1160,9 +1160,7 @@ ds1685_rtc_sysfs_serial_show(struct device *dev,
 	ds1685_rtc_get_ssn(rtc, ssn);
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return snprintf(buf, 24, "%8phC\n", ssn);
-
-	return 0;
+	return sprintf(buf, "%8phC\n", ssn);
 }
 static DEVICE_ATTR(serial, S_IRUGO, ds1685_rtc_sysfs_serial_show, NULL);
 
@@ -1285,7 +1283,7 @@ ds1685_rtc_sysfs_ctrl_regs_show(struct device *dev,
 	tmp = rtc->read(rtc, reg_info->reg) & reg_info->bit;
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	return snprintf(buf, 2, "%d\n", (tmp ? 1 : 0));
+	return sprintf(buf, "%d\n", (tmp ? 1 : 0));
 }
 
 /**
@@ -1621,7 +1619,7 @@ ds1685_rtc_sysfs_time_regs_show(struct device *dev,
 	tmp = ds1685_rtc_bcd2bin(rtc, tmp, bcd_reg_info->mask,
 				 bin_reg_info->mask);
 
-	return snprintf(buf, 4, "%d\n", tmp);
+	return sprintf(buf, "%d\n", tmp);
 }
 
 /**
-- 
2.6.1

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
