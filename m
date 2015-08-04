Return-Path: <rtc-linux+bncBDS7HNEFSALRBTETQKXAKGQE4KWQEWI@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si37237wib.3.2015.08.04.02.45.48
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:48 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 07/15] rtc: rx8025: fix transfer mode
Date: Tue,  4 Aug 2015 11:45:26 +0200
Message-Id: <1438681534-12027-8-git-send-email-alexandre.belloni@free-electrons.com>
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

The datasheet specifies that transfer mode must be 0 for write and either
0x4 (simplified read) or 0 (standard read). 0x8 is not specified, use
standard mode.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rx8025.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 3612362b65ac..771558602409 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -77,7 +77,7 @@ struct rx8025_data {
 
 static int rx8025_read_reg(struct i2c_client *client, int number, u8 *value)
 {
-	int ret = i2c_smbus_read_byte_data(client, (number << 4) | 0x08);
+	int ret = i2c_smbus_read_byte_data(client, number << 4);
 
 	if (ret < 0) {
 		dev_err(&client->dev, "Unable to read register #%d\n", number);
@@ -91,7 +91,7 @@ static int rx8025_read_reg(struct i2c_client *client, int number, u8 *value)
 static int rx8025_read_regs(struct i2c_client *client,
 			    int number, u8 length, u8 *values)
 {
-	int ret = i2c_smbus_read_i2c_block_data(client, (number << 4) | 0x08,
+	int ret = i2c_smbus_read_i2c_block_data(client, number << 4,
 						length, values);
 
 	if (ret != length) {
@@ -117,7 +117,7 @@ static int rx8025_write_reg(struct i2c_client *client, int number, u8 value)
 static int rx8025_write_regs(struct i2c_client *client,
 			     int number, u8 length, u8 *values)
 {
-	int ret = i2c_smbus_write_i2c_block_data(client, (number << 4) | 0x08,
+	int ret = i2c_smbus_write_i2c_block_data(client, number << 4,
 						 length, values);
 
 	if (ret)
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
