Return-Path: <rtc-linux+bncBCL5RYHM6ECRBB6C7XDQKGQENRW7NOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x233.google.com (mail-wr0-x233.google.com. [2a00:1450:400c:c0c::233])
        by gmr-mx.google.com with ESMTPS id b84si1201422wmh.2.2017.04.25.07.45.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 07:45:27 -0700 (PDT)
Received: by mail-wr0-x233.google.com with SMTP id l50so36385243wrc.3
        for <rtc-linux@googlegroups.com>; Tue, 25 Apr 2017 07:45:27 -0700 (PDT)
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Gary Bisson <gary.bisson@boundarydevices.com>
Subject: [rtc-linux] [PATCH 2/4] rtc: m41t80: fix SQW dividers override when
 setting a date
Date: Tue, 25 Apr 2017 16:45:15 +0200
Message-Id: <20170425144517.15962-3-gary.bisson@boundarydevices.com>
In-Reply-To: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
References: <20170425144517.15962-1-gary.bisson@boundarydevices.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This patch is only relevant for RTC with the SQ_ALT feature which
means the clock output frequency divider is stored in the weekday
register.

Current implementation discards the previous dividers value and clear
them as soon as the time is set.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 drivers/rtc/rtc-m41t80.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 93684ab293f2..0c142653c309 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -168,6 +168,7 @@ static int m41t80_get_datetime(struct i2c_client *client,
 /* Sets the given date and time to the real time clock. */
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
+	struct m41t80_data *clientdata = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -183,6 +184,17 @@ static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[M41T80_REG_YEAR] = bin2bcd(tm->tm_year - 100);
 	buf[M41T80_REG_WDAY] = tm->tm_wday;
 
+	/* If the square wave output is controlled in the weekday register */
+	if (clientdata->features & M41T80_FEATURE_SQ_ALT) {
+		int val;
+
+		val = i2c_smbus_read_byte_data(client, M41T80_REG_WDAY);
+		if (val < 0)
+			return val;
+
+		buf[M41T80_REG_WDAY] |= (val & 0xf0);
+	}
+
 	err = i2c_smbus_write_i2c_block_data(client, M41T80_REG_SSEC,
 					     sizeof(buf), buf);
 	if (err < 0) {
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
