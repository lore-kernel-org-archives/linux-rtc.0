Return-Path: <rtc-linux+bncBDSJR27JS4DBB7GNYK6AKGQEH3S74VQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp77.register.it. [195.110.122.162])
        by gmr-mx.google.com with ESMTPS id p199si12237wmd.1.2016.07.21.03.42.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 03:42:04 -0700 (PDT)
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Subject: [rtc-linux] [PATCH 5/6] rtc: rv8803: Stop the clock while setting the time
Date: Thu, 21 Jul 2016 12:41:31 +0200
Message-Id: <1469097692-103146-5-git-send-email-benoit@wsystem.com>
In-Reply-To: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
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

According to the application manual of the RX8900, the RESET bit must be
set to 1 to prevent a timer update while setting the time. This also
resets the subsecond counter. The application manual of the RV-8803 does
not mention such a requirement, and it says that the 100th Seconds
register is cleared when writing to the Seconds register, but using the
RESET bit for the RV-8803 too should not be an issue and is probably
safer.

This change also ensures that the RESET bit is initialized properly in
all cases. Indeed, all the registers must be initialized if the voltage
has been lower than VLOW2 (triggering V2F), but not low enough to
trigger a POR.

Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
---
 drivers/rtc/rtc-rv8803.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 09ab5cb..24c688e 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -223,11 +223,21 @@ static int rv8803_set_time(struct device *dev, struct=
 rtc_time *tm)
 {
 	struct rv8803_data *rv8803 =3D dev_get_drvdata(dev);
 	u8 date[7];
-	int flags, ret;
+	int ctrl, flags, ret;
=20
 	if ((tm->tm_year < 100) || (tm->tm_year > 199))
 		return -EINVAL;
=20
+	ctrl =3D rv8803_read_reg(rv8803->client, RV8803_CTRL);
+	if (ctrl < 0)
+		return ctrl;
+
+	/* Stop the clock */
+	ret =3D rv8803_write_reg(rv8803->client, RV8803_CTRL,
+			       ctrl | RV8803_CTRL_RESET);
+	if (ret)
+		return ret;
+
 	date[RV8803_SEC]   =3D bin2bcd(tm->tm_sec);
 	date[RV8803_MIN]   =3D bin2bcd(tm->tm_min);
 	date[RV8803_HOUR]  =3D bin2bcd(tm->tm_hour);
@@ -240,6 +250,12 @@ static int rv8803_set_time(struct device *dev, struct =
rtc_time *tm)
 	if (ret)
 		return ret;
=20
+	/* Restart the clock */
+	ret =3D rv8803_write_reg(rv8803->client, RV8803_CTRL,
+			       ctrl & ~RV8803_CTRL_RESET);
+	if (ret)
+		return ret;
+
 	mutex_lock(&rv8803->flags_lock);
=20
 	flags =3D rv8803_read_reg(rv8803->client, RV8803_FLAG);
--=20
2.5.0

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
