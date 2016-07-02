Return-Path: <rtc-linux+bncBAABBE53365QKGQEBYJNOUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [2a01:4f8:d12:1f44::2])
        by gmr-mx.google.com with ESMTPS id x70si239117wmf.1.2016.07.02.08.28.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2016 08:28:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH v2 1/5] rtc: s35390a: fix reading out alarm
Date: Sat,  2 Jul 2016 17:28:08 +0200
Message-Id: <1467473292-26371-2-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
References: <1467473292-26371-1-git-send-email-uwe@kleine-koenig.org>
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

There are several issues fixed in this patch:

 - When alarm isn't enabled, set .enabled to zero instead of returning
   -EINVAL.
 - Ignore how IRQ1 is configured when determining if IRQ2 is on.
 - The three alarm registers have an enable flag which must be
   evaluated.
 - The chip always triggers when the seconds register gets 0.

Note that the rtc framework however doesn't handle the result correctly
because it doesn't check wday being initialized and so interprets an
alarm being set for 10:00 AM in three days as 10:00 AM tomorrow (or
today if that's not over yet).

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-s35390a.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index f40afdd0e5f5..6507a01cf9ad 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -242,6 +242,8 @@ static int s35390a_set_alarm(struct i2c_client *client,=
 struct rtc_wkalrm *alm)
=20
 	if (alm->time.tm_wday !=3D -1)
 		buf[S35390A_ALRM_BYTE_WDAY] =3D bin2bcd(alm->time.tm_wday) | 0x80;
+	else
+		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
=20
 	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
 			alm->time.tm_hour) | 0x80;
@@ -269,23 +271,43 @@ static int s35390a_read_alarm(struct i2c_client *clie=
nt, struct rtc_wkalrm *alm)
 	if (err < 0)
 		return err;
=20
-	if (bitrev8(sts) !=3D S35390A_INT2_MODE_ALARM)
-		return -EINVAL;
+	if ((bitrev8(sts) & S35390A_INT2_MODE_MASK) !=3D S35390A_INT2_MODE_ALARM)=
 {
+		/*
+		 * When the alarm isn't enabled, the register to configure
+		 * the alarm time isn't accessible.
+		 */
+		alm->enabled =3D 0;
+		return 0;
+	} else {
+		alm->enabled =3D 1;
+	}
=20
 	err =3D s35390a_get_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(buf))=
;
 	if (err < 0)
 		return err;
=20
 	/* This chip returns the bits of each byte in reverse order */
-	for (i =3D 0; i < 3; ++i) {
+	for (i =3D 0; i < 3; ++i)
 		buf[i] =3D bitrev8(buf[i]);
-		buf[i] &=3D ~0x80;
-	}
=20
-	alm->time.tm_wday =3D bcd2bin(buf[S35390A_ALRM_BYTE_WDAY]);
-	alm->time.tm_hour =3D s35390a_reg2hr(s35390a,
-						buf[S35390A_ALRM_BYTE_HOURS]);
-	alm->time.tm_min =3D bcd2bin(buf[S35390A_ALRM_BYTE_MINS]);
+	/*
+	 * B0 of the three matching registers is an enable flag. Iff it is set
+	 * the configured value is used for matching.
+	 */
+	if (buf[S35390A_ALRM_BYTE_WDAY] & 0x80)
+		alm->time.tm_wday =3D
+			bcd2bin(buf[S35390A_ALRM_BYTE_WDAY] & ~0x80);
+
+	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
+		alm->time.tm_hour =3D
+			s35390a_reg2hr(s35390a,
+				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
+
+	if (buf[S35390A_ALRM_BYTE_MINS] & 0x80)
+		alm->time.tm_min =3D bcd2bin(buf[S35390A_ALRM_BYTE_MINS] & ~0x80);
+
+	/* alarm triggers always at s=3D0 */
+	alm->time.tm_sec =3D 0;
=20
 	dev_dbg(&client->dev, "%s: alm is mins=3D%d, hours=3D%d, wday=3D%d\n",
 			__func__, alm->time.tm_min, alm->time.tm_hour,
--=20
2.8.1

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
