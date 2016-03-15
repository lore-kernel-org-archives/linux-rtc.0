Return-Path: <rtc-linux+bncBAABBE4ZUC3QKGQEKFM4FTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.visioncatalog.com. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id c140si916987wmh.1.2016.03.15.06.22.27
        for <rtc-linux@googlegroups.com>;
        Tue, 15 Mar 2016 06:22:27 -0700 (PDT)
From: Stefan Christ <s.christ@phytec.de>
To: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it
Subject: [rtc-linux] [PATCH v2] drivers/rtc/rtc-m41t80.c: avoid out of range
 year values
Date: Tue, 15 Mar 2016 14:22:26 +0100
Message-Id: <1458048146-13820-1-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Avoid saving an out of range year value to the RTC. Reading that value
from the RTC again returns a totally wrong time value. For Example

    $ timedatectl set-ntp no
    $ timedatectl set-time "1990-01-01 12:12:00"
    # Reboot
    rtc-m41t80 0-0068: setting system clock to 2090-01-01 12:12:35 UTC (3786955955)

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
v2: fix checkpatch warning in if
v2: align arguments in dev_err call
---
 drivers/rtc/rtc-m41t80.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index a82937e..d107a8e 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -176,7 +176,13 @@ static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 		bin2bcd(tm->tm_mday) | (buf[M41T80_REG_DAY] & ~0x3f);
 	buf[M41T80_REG_MON] =
 		bin2bcd(tm->tm_mon + 1) | (buf[M41T80_REG_MON] & ~0x1f);
+
 	/* assume 20YY not 19YY */
+	if (tm->tm_year < 100 || tm->tm_year > 199) {
+		dev_err(&client->dev, "Year must be between 2000 and 2099. It's %d.\n",
+			tm->tm_year + 1900);
+		return -EINVAL;
+	}
 	buf[M41T80_REG_YEAR] = bin2bcd(tm->tm_year % 100);
 
 	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
-- 
1.9.1

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
