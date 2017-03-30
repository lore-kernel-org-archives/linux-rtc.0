Return-Path: <rtc-linux+bncBDKLR6HU7IIBB3PN6XDAKGQEDBEJX6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com. [195.59.15.196])
        by gmr-mx.google.com with ESMTP id a126si16736wmd.2.2017.03.30.14.21.49
        for <rtc-linux@googlegroups.com>;
        Thu, 30 Mar 2017 14:21:49 -0700 (PDT)
From: Paul Burton <paul.burton@imgtec.com>
To: <rtc-linux@googlegroups.com>
CC: Paul Burton <paul.burton@imgtec.com>, Alessandro Zummo
	<a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
	<mylene.josserand@free-electrons.com>, "# v4 . 7+" <stable@vger.kernel.org>
Subject: [rtc-linux] [PATCH] rtc: m41t80: Clear oscillator failure bit on probe
Date: Thu, 30 Mar 2017 14:21:30 -0700
Message-ID: <20170330212130.30548-1-paul.burton@imgtec.com>
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

The oscillator failure bit of the flags register defaults to 1 when the
m41t80 RTC device is powered up. If we don't clear it as the manual says
we should then the bit remains set permanently and since commit
05a7f27a889f ("rtc: m41t80: handle oscillator failure bit") we spam the
kernel console with an error message on every attempt to read the RTC,
for example:

  Welcome to Buildroot
  mips64r6-n32-le-hf-soak login: [   15.534459] rtc-m41t80 0-0068:
  Oscillator failure, data is invalid.
  [   16.526308] rtc-m41t80 0-0068: Oscillator failure, data is invalid.
  [   19.534342] rtc-m41t80 0-0068: Oscillator failure, data is invalid.
  [   20.526327] rtc-m41t80 0-0068: Oscillator failure, data is invalid.

Fix this by clearing the OF flag during probe, as the m41t80 manual
says we ought to.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 05a7f27a889f ("rtc: m41t80: handle oscillator failure bit")
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Cc: <stable@vger.kernel.org> # v4.7+

---

 drivers/rtc/rtc-m41t80.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 58698d21c2c3..33be6e4694f6 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -813,6 +813,17 @@ static int m41t80_probe(struct i2c_client *client,
=20
 	m41t80_data->rtc =3D rtc;
=20
+	/* Clear the OF (Oscillator failure) bit, which is 1 on power up */
+	rc =3D i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
+	if (rc < 0) {
+		dev_warn(&client->dev, "unable to read flags");
+	} else if (rc & M41T80_FLAGS_OF) {
+		rc &=3D ~M41T80_FLAGS_OF;
+		rc =3D i2c_smbus_write_byte_data(client, M41T80_REG_FLAGS, rc);
+		if (rc)
+			dev_warn(&client->dev, "unable to clear OF flag");
+	}
+
 	/* Make sure HT (Halt Update) bit is cleared */
 	rc =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
=20
--=20
2.12.1

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
