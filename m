Return-Path: <rtc-linux+bncBDS7HNEFSALRBSUTQKXAKGQEX7H7DEY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hm7si54171wib.0.2015.08.04.02.45.45
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:45 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 06/15] rtc: rx8025: only handle dates between 2000
 and 2099
Date: Tue,  4 Aug 2015 11:45:25 +0200
Message-Id: <1438681534-12027-7-git-send-email-alexandre.belloni@free-electrons.com>
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

The hardware is only capable of handling dates between 2000 and 2099,
enforce that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 52683eda1da2..3612362b65ac 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -188,10 +188,7 @@ static int rx8025_get_time(struct device *dev, struct rtc_time *dt)
 
 	dt->tm_mday = bcd2bin(date[RX8025_REG_MDAY] & 0x3f);
 	dt->tm_mon = bcd2bin(date[RX8025_REG_MONTH] & 0x1f) - 1;
-	dt->tm_year = bcd2bin(date[RX8025_REG_YEAR]);
-
-	if (dt->tm_year < 70)
-		dt->tm_year += 100;
+	dt->tm_year = bcd2bin(date[RX8025_REG_YEAR]) + 100;
 
 	dev_dbg(dev, "%s: date %ds %dm %dh %dmd %dm %dy\n", __func__,
 		dt->tm_sec, dt->tm_min, dt->tm_hour,
@@ -205,11 +202,8 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
 	u8 date[7];
 
-	/*
-	 * BUG: The HW assumes every year that is a multiple of 4 to be a leap
-	 * year.  Next time this is wrong is 2100, which will not be a leap
-	 * year.
-	 */
+	if ((dt->tm_year < 100) || (dt->tm_year > 199))
+		return -EINVAL;
 
 	/*
 	 * Here the read-only bits are written as "0".  I'm not sure if that
@@ -226,7 +220,7 @@ static int rx8025_set_time(struct device *dev, struct rtc_time *dt)
 	date[RX8025_REG_WDAY] = bin2bcd(dt->tm_wday);
 	date[RX8025_REG_MDAY] = bin2bcd(dt->tm_mday);
 	date[RX8025_REG_MONTH] = bin2bcd(dt->tm_mon + 1);
-	date[RX8025_REG_YEAR] = bin2bcd(dt->tm_year % 100);
+	date[RX8025_REG_YEAR] = bin2bcd(dt->tm_year - 100);
 
 	dev_dbg(dev,
 		"%s: write 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
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
