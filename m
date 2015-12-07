Return-Path: <rtc-linux+bncBCC6ZWOPXENRBZ44S2ZQKGQE466VE3Y@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w187si598284wmw.1.2015.12.07.05.49.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 05:49:26 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH 1/3] RTC/PCF85063: fix time/date reading (part 1)
Date: Mon,  7 Dec 2015 14:49:32 +0100
Message-Id: <1449496174-7813-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
References: <1449496174-7813-1-git-send-email-jbe@pengutronix.de>
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

When reading the seconds register, all time/date registers are frozen
until the year register is read. So, read all time/date registers in one
turn.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/rtc/rtc-pcf85063.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 63334cb..75f2866 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -39,6 +39,38 @@ struct pcf85063 {
 	int voltage_low; /* indicates if a low_voltage was detected */
 };
 
+static int pcf85063_read_time(struct i2c_client *client, u8 *buf, u16 size)
+{
+	int rc;
+	u8 clk_ctrl = PCF85063_REG_SC;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.len = sizeof(clk_ctrl),
+			.buf = &clk_ctrl,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = size,
+			.buf = buf
+		},
+	};
+
+	/*
+	 * while reading the time/date registers are blocked and not updated
+	 * anymore until the access is finished. To not lose a second
+	 * event, the access must be finished within one second. So, read all
+	 * time/date registers in one turn.
+	 */
+	rc = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (rc != ARRAY_SIZE(msgs)) {
+		dev_err(&client->dev, "date/time register read error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * In the routines that deal directly with the pcf85063 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
-- 
2.6.2

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
