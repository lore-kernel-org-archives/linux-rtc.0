Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFEZS26AKGQEBLOYUXY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si339686wmg.1.2016.07.12.17.34.28
        for <rtc-linux@googlegroups.com>;
        Tue, 12 Jul 2016 17:34:28 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: ds1307: fix century bit support
Date: Wed, 13 Jul 2016 02:34:24 +0200
Message-Id: <1468370064-19255-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add an option to properly support the century bit of ds1337 and compatibles
and ds1340.
Because the driver had a bug until now, it is not possible to switch users
to the fixed code directly as RTCs in the field will wrongly have the
century bit set.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Arnaud, do you mind testing that patch, I still don't have the necessary
hardware but I think this is the proper course of action.

 drivers/rtc/Kconfig      | 14 ++++++++++++++
 drivers/rtc/rtc-ds1307.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8526f1cded08..f47c2f5ff70d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -224,6 +224,20 @@ config RTC_DRV_DS1307_HWMON
 	  Say Y here if you want to expose temperature sensor data on
 	  rtc-ds1307 (only DS3231)
 
+config RTC_DRV_DS1307_CENTURY
+	bool "Century bit support for rtc-ds1307"
+	depends on RTC_DRV_DS1307
+	default n
+	help
+	  The DS1307 driver suffered from a bug where it was enabling the
+	  century bit inconditionnally but never used it when reading the time.
+	  It made the driver unable to support dates beyond 2099.
+	  Setting this option will add proper support for the century bit but if
+	  the time was previously set using a kernel predating this option,
+	  reading the date will return a date in the next century.
+	  To solve that, you could boot a kernel without this option set, set
+	  the RTC date and then boot a kernel with this option set.
+
 config RTC_DRV_DS1374
 	tristate "Dallas/Maxim DS1374"
 	help
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8e1c5cb6ece6..4c5890864d9c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -382,10 +382,25 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	t->tm_mday = bcd2bin(ds1307->regs[DS1307_REG_MDAY] & 0x3f);
 	tmp = ds1307->regs[DS1307_REG_MONTH] & 0x1f;
 	t->tm_mon = bcd2bin(tmp) - 1;
-
-	/* assume 20YY not 19YY, and ignore DS1337_BIT_CENTURY */
 	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;
 
+#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
+	switch (ds1307->type) {
+	case ds_1337:
+	case ds_1339:
+	case ds_3231:
+		if (ds1307->regs[DS1307_REG_MONTH] && DS1337_BIT_CENTURY)
+			t->tm_year += 100;
+		break;
+	case ds_1340:
+		if (ds1307->regs[DS1307_REG_HOUR] && DS1340_BIT_CENTURY)
+			t->tm_year += 100;
+		break;
+	default:
+		break;
+	}
+#endif
+
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
 		"read", t->tm_sec, t->tm_min,
@@ -409,6 +424,27 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
+#ifdef CONFIG_RTC_DRV_DS1307_CENTURY
+	if (t->tm_year < 100)
+		return -EINVAL;
+
+	switch (ds1307->type) {
+	case ds_1337:
+	case ds_1339:
+	case ds_3231:
+	case ds_1340:
+		if (t->tm_year > 299)
+			return -EINVAL;
+	default:
+		if (t->tm_year > 199)
+			return -EINVAL;
+		break;
+	}
+#else
+	if (t->tm_year < 100 || t->tm_year > 199)
+		return -EINVAL;
+#endif
+
 	buf[DS1307_REG_SECS] = bin2bcd(t->tm_sec);
 	buf[DS1307_REG_MIN] = bin2bcd(t->tm_min);
 	buf[DS1307_REG_HOUR] = bin2bcd(t->tm_hour);
@@ -424,11 +460,13 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	case ds_1337:
 	case ds_1339:
 	case ds_3231:
-		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
+		if (t->tm_year > 199)
+			buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
 		break;
 	case ds_1340:
-		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
-				| DS1340_BIT_CENTURY;
+		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN;
+		if (t->tm_year > 199)
+			buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY;
 		break;
 	case mcp794xx:
 		/*
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
