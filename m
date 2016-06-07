Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBANM3S5AKGQE65DXSUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f69si372004wmf.3.2016.06.07.11.44.17
        for <rtc-linux@googlegroups.com>;
        Tue, 07 Jun 2016 11:44:17 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: rv8803: broaden workaround
Date: Tue,  7 Jun 2016 20:44:05 +0200
Message-Id: <1465325045-774-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The previous workaround may still fail as there are actually 4 retries to
be done to ensure the communication succeed. Also, some I2C adapter drivers
may return -EIO instead of -ENXIO.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rv8803.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 82ab41074156..533ca5bcaa96 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -68,7 +68,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
 	do {
 		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
 		try++;
-	} while ((flags == -ENXIO) && (try < 3));
+	} while (((flags == -ENXIO) || (flags == -EIO)) && (try < 4));
 	if (flags <= 0) {
 		spin_unlock(&rv8803->flags_lock);
 		return IRQ_NONE;
@@ -455,7 +455,7 @@ static int rv8803_probe(struct i2c_client *client,
 	do {
 		flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
 		try++;
-	} while ((flags == -ENXIO) && (try < 3));
+	} while (((flags == -ENXIO) || (flags == -EIO)) && (try < 4));
 
 	if (flags < 0)
 		return flags;
@@ -496,7 +496,7 @@ static int rv8803_probe(struct i2c_client *client,
 		err = i2c_smbus_write_byte_data(rv8803->client, RV8803_EXT,
 						RV8803_EXT_WADA);
 		try++;
-	} while ((err == -ENXIO) && (try < 3));
+	} while (((err == -ENXIO) || (flags == -EIO)) && (try < 4));
 	if (err)
 		return err;
 
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
