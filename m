Return-Path: <rtc-linux+bncBDS7HNEFSALRBL4YYC3QKGQECOC3N2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si468433wmd.1.2016.03.21.07.58.55
        for <rtc-linux@googlegroups.com>;
        Mon, 21 Mar 2016 07:58:55 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rv8803: workaround i2c HW issue
Date: Mon, 21 Mar 2016 15:58:38 +0100
Message-Id: <1458572318-13184-1-git-send-email-alexandre.belloni@free-electrons.com>
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

The rv8803 has a 60=C2=B5s window where it will not answer on the i2c bus.
It also means there will be no ack for the communication. Make sure
communication is tried multiple times when this happens (the i2c subsystem
mandates -ENXIO is that case but the number of retries is host specific).
The critical parts are the probe function and the alarm callback so make
sure we handle the failure there.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-rv8803.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 7155c0816aa6..82ab41074156 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -61,11 +61,14 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev=
_id)
 	struct i2c_client *client =3D dev_id;
 	struct rv8803_data *rv8803 =3D i2c_get_clientdata(client);
 	unsigned long events =3D 0;
-	int flags;
+	int flags, try =3D 0;
=20
 	spin_lock(&rv8803->flags_lock);
=20
-	flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	do {
+		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		try++;
+	} while ((flags =3D=3D -ENXIO) && (try < 3));
 	if (flags <=3D 0) {
 		spin_unlock(&rv8803->flags_lock);
 		return IRQ_NONE;
@@ -428,7 +431,7 @@ static int rv8803_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
 	struct rv8803_data *rv8803;
-	int err, flags;
+	int err, flags, try =3D 0;
=20
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -444,7 +447,16 @@ static int rv8803_probe(struct i2c_client *client,
 	rv8803->client =3D client;
 	i2c_set_clientdata(client, rv8803);
=20
-	flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+	/*=20
+	 * There is a 60=C2=B5s window where the RTC may not reply on the i2c bus=
 in
+	 * that case, the transfer is not ACKed. In that case, ensure there are
+	 * multiple attempts.
+	 */
+	do {
+		flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);
+		try++;
+	} while ((flags =3D=3D -ENXIO) && (try < 3));
+
 	if (flags < 0)
 		return flags;
=20
@@ -479,8 +491,12 @@ static int rv8803_probe(struct i2c_client *client,
 		return PTR_ERR(rv8803->rtc);
 	}
=20
-	err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_EXT,
-					RV8803_EXT_WADA);
+	try =3D 0;
+	do {
+		err =3D i2c_smbus_write_byte_data(rv8803->client, RV8803_EXT,
+						RV8803_EXT_WADA);
+		try++;
+	} while ((err =3D=3D -ENXIO) && (try < 3));
 	if (err)
 		return err;
=20
--=20
2.7.0

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
