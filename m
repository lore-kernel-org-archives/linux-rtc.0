Return-Path: <rtc-linux+bncBAABBKOO5C3QKGQETXK3A7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m9si389563wma.3.2016.03.28.23.56.41
        for <rtc-linux@googlegroups.com>;
        Mon, 28 Mar 2016 23:56:41 -0700 (PDT)
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
To: alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	mylene.josserand@free-electrons.com
Subject: [rtc-linux] [PATCH 3/8] rtc: m41t80: replace i2c functions to smbus ones
Date: Tue, 29 Mar 2016 08:56:00 +0200
Message-Id: <2e10527a2f44d6b3b11c873ccc0ce071ccb5dda6.1459233897.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459188215.git.mylene.josserand@free-electrons.com>
References: <cover.1459188215.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1459233897.git.mylene.josserand@free-electrons.com>
References: <cover.1459233897.git.mylene.josserand@free-electrons.com>
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

The driver used i2c_transfer methods to read and set date/time.
The smbus methods should be used.

This commit replaces i2c_transfer functions by i2c_smbus_XX_i2c_block_data
for reading and setting the datetime.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/rtc/rtc-m41t80.c | 134 ++++++++++++++++---------------------------=
----
 1 file changed, 44 insertions(+), 90 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index cc8b93d..1a76927 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -32,21 +32,21 @@
 #include <linux/watchdog.h>
 #endif
=20
-#define M41T80_REG_SSEC	0
-#define M41T80_REG_SEC	1
-#define M41T80_REG_MIN	2
-#define M41T80_REG_HOUR	3
-#define M41T80_REG_WDAY	4
-#define M41T80_REG_DAY	5
-#define M41T80_REG_MON	6
-#define M41T80_REG_YEAR	7
-#define M41T80_REG_ALARM_MON	0xa
-#define M41T80_REG_ALARM_DAY	0xb
-#define M41T80_REG_ALARM_HOUR	0xc
-#define M41T80_REG_ALARM_MIN	0xd
-#define M41T80_REG_ALARM_SEC	0xe
-#define M41T80_REG_FLAGS	0xf
-#define M41T80_REG_SQW	0x13
+#define M41T80_REG_SSEC		0x00
+#define M41T80_REG_SEC		0x01
+#define M41T80_REG_MIN		0x02
+#define M41T80_REG_HOUR		0x03
+#define M41T80_REG_WDAY		0x04
+#define M41T80_REG_DAY		0x05
+#define M41T80_REG_MON		0x06
+#define M41T80_REG_YEAR		0x07
+#define M41T80_REG_ALARM_MON	0x0a
+#define M41T80_REG_ALARM_DAY	0x0b
+#define M41T80_REG_ALARM_HOUR	0x0c
+#define M41T80_REG_ALARM_MIN	0x0d
+#define M41T80_REG_ALARM_SEC	0x0e
+#define M41T80_REG_FLAGS	0x0f
+#define M41T80_REG_SQW		0x13
=20
 #define M41T80_DATETIME_REG_SIZE	(M41T80_REG_YEAR + 1)
 #define M41T80_ALARM_REG_SIZE	\
@@ -93,24 +93,13 @@ struct m41t80_data {
 static int m41t80_get_datetime(struct i2c_client *client,
 			       struct rtc_time *tm)
 {
-	u8 buf[M41T80_DATETIME_REG_SIZE], dt_addr[1] =3D { M41T80_REG_SEC };
-	struct i2c_msg msgs[] =3D {
-		{
-			.addr	=3D client->addr,
-			.flags	=3D 0,
-			.len	=3D 1,
-			.buf	=3D dt_addr,
-		},
-		{
-			.addr	=3D client->addr,
-			.flags	=3D I2C_M_RD,
-			.len	=3D M41T80_DATETIME_REG_SIZE - M41T80_REG_SEC,
-			.buf	=3D buf + M41T80_REG_SEC,
-		},
-	};
+	unsigned char buf[8];
+	int err;
=20
-	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
+	err =3D i2c_smbus_read_i2c_block_data(client, M41T80_REG_SSEC,
+					    sizeof(buf), buf);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to read date\n");
 		return -EIO;
 	}
=20
@@ -129,67 +118,29 @@ static int m41t80_get_datetime(struct i2c_client *cli=
ent,
 /* Sets the given date and time to the real time clock. */
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time =
*tm)
 {
-	u8 wbuf[1 + M41T80_DATETIME_REG_SIZE];
-	u8 *buf =3D &wbuf[1];
-	u8 dt_addr[1] =3D { M41T80_REG_SEC };
-	struct i2c_msg msgs_in[] =3D {
-		{
-			.addr	=3D client->addr,
-			.flags	=3D 0,
-			.len	=3D 1,
-			.buf	=3D dt_addr,
-		},
-		{
-			.addr	=3D client->addr,
-			.flags	=3D I2C_M_RD,
-			.len	=3D M41T80_DATETIME_REG_SIZE - M41T80_REG_SEC,
-			.buf	=3D buf + M41T80_REG_SEC,
-		},
-	};
-	struct i2c_msg msgs[] =3D {
-		{
-			.addr	=3D client->addr,
-			.flags	=3D 0,
-			.len	=3D 1 + M41T80_DATETIME_REG_SIZE,
-			.buf	=3D wbuf,
-		 },
-	};
+	unsigned char buf[8];
+	int err;
=20
-	/* Read current reg values into buf[1..7] */
-	if (i2c_transfer(client->adapter, msgs_in, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
-		return -EIO;
-	}
+	if (tm->tm_year < 100 || tm->tm_year > 199)
+		return -EINVAL;
=20
-	wbuf[0] =3D 0; /* offset into rtc's regs */
-	/* Merge time-data and register flags into buf[0..7] */
 	buf[M41T80_REG_SSEC] =3D 0;
-	buf[M41T80_REG_SEC] =3D
-		bin2bcd(tm->tm_sec) | (buf[M41T80_REG_SEC] & ~0x7f);
-	buf[M41T80_REG_MIN] =3D
-		bin2bcd(tm->tm_min) | (buf[M41T80_REG_MIN] & ~0x7f);
-	buf[M41T80_REG_HOUR] =3D
-		bin2bcd(tm->tm_hour) | (buf[M41T80_REG_HOUR] & ~0x3f);
-	buf[M41T80_REG_WDAY] =3D
-		(tm->tm_wday & 0x07) | (buf[M41T80_REG_WDAY] & ~0x07);
-	buf[M41T80_REG_DAY] =3D
-		bin2bcd(tm->tm_mday) | (buf[M41T80_REG_DAY] & ~0x3f);
-	buf[M41T80_REG_MON] =3D
-		bin2bcd(tm->tm_mon + 1) | (buf[M41T80_REG_MON] & ~0x1f);
-
-	/* assume 20YY not 19YY */
-	if (tm->tm_year < 100 || tm->tm_year > 199) {
-		dev_err(&client->dev, "Year must be between 2000 and 2099. It's %d.\n",
-			tm->tm_year + 1900);
-		return -EINVAL;
+	buf[M41T80_REG_SEC] =3D bin2bcd(tm->tm_sec);
+	buf[M41T80_REG_MIN] =3D bin2bcd(tm->tm_min);
+	buf[M41T80_REG_HOUR] =3D bin2bcd(tm->tm_hour);
+	buf[M41T80_REG_DAY] =3D bin2bcd(tm->tm_mday);
+	buf[M41T80_REG_MON] =3D bin2bcd(tm->tm_mon + 1);
+	buf[M41T80_REG_YEAR] =3D bin2bcd(tm->tm_year - 100);
+	buf[M41T80_REG_WDAY] =3D tm->tm_wday;
+
+	err =3D i2c_smbus_write_i2c_block_data(client, M41T80_REG_SSEC,
+					     sizeof(buf), buf);
+	if (err < 0) {
+		dev_err(&client->dev, "Unable to write to date registers\n");
+		return err;
 	}
-	buf[M41T80_REG_YEAR] =3D bin2bcd(tm->tm_year % 100);
=20
-	if (i2c_transfer(client->adapter, msgs, 1) !=3D 1) {
-		dev_err(&client->dev, "write error\n");
-		return -EIO;
-	}
-	return 0;
+	return err;
 }
=20
 static int m41t80_rtc_proc(struct device *dev, struct seq_file *seq)
@@ -631,14 +582,17 @@ static void m41t80_remove_sysfs_group(void *_dev)
 static int m41t80_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
 	int rc =3D 0;
 	struct rtc_device *rtc =3D NULL;
 	struct rtc_time tm;
 	struct m41t80_data *clientdata =3D NULL;
=20
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
-				     | I2C_FUNC_SMBUS_BYTE_DATA))
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C_F=
UNC_SMBUS_I2C_BLOCK\n");
 		return -ENODEV;
+	}
=20
 	clientdata =3D devm_kzalloc(&client->dev, sizeof(*clientdata),
 				GFP_KERNEL);
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
