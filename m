Return-Path: <rtc-linux+bncBAABBTNGRW6AKGQE36UF66I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id f10si41648wmg.2.2016.07.11.01.05.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 01:05:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ben Hutchings <benh@debian.org>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 1/2] rtc: explicitly set tm_sec = 0 for drivers
 with minute accurancy
Date: Mon, 11 Jul 2016 10:05:27 +0200
Message-Id: <1468224328-7391-2-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1468224328-7391-1-git-send-email-uwe@kleine-koenig.org>
References: <1468224328-7391-1-git-send-email-uwe@kleine-koenig.org>
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

Since all time members of the alarm data is initialized to -1 the drivers
are responsible to set the tm_sec member to 0.

Fixes: d68778b80dd7 ("rtc: initialize output parameter for read alarm to "u=
ninitialized"")
Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
Hello,

while going through all .read_alarm functions I wondered about rtc-sa1100
which only sets .enabled and .pending but no time.

Best regards
Uwe
---
 drivers/rtc/rtc-da9052.c  | 1 +
 drivers/rtc/rtc-da9055.c  | 1 +
 drivers/rtc/rtc-davinci.c | 2 ++
 drivers/rtc/rtc-pcf8563.c | 1 +
 drivers/rtc/rtc-rc5t583.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index a20bcf0e33cd..4273377562ec 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -85,6 +85,7 @@ static int da9052_read_alarm(struct da9052_rtc *rtc, stru=
ct rtc_time *rtc_tm)
 			rtc_tm->tm_mday =3D v[0][2] & DA9052_RTC_DAY;
 			rtc_tm->tm_hour =3D v[0][1] & DA9052_RTC_HOUR;
 			rtc_tm->tm_min  =3D v[0][0] & DA9052_RTC_MIN;
+			rtc_tm->tm_sec =3D 0;
=20
 			ret =3D rtc_valid_tm(rtc_tm);
 			return ret;
diff --git a/drivers/rtc/rtc-da9055.c b/drivers/rtc/rtc-da9055.c
index 7ec0872d5e3b..678af8648c45 100644
--- a/drivers/rtc/rtc-da9055.c
+++ b/drivers/rtc/rtc-da9055.c
@@ -74,6 +74,7 @@ static int da9055_read_alarm(struct da9055 *da9055, struc=
t rtc_time *rtc_tm)
 	rtc_tm->tm_mday =3D v[2] & DA9055_RTC_ALM_DAY;
 	rtc_tm->tm_hour =3D v[1] & DA9055_RTC_ALM_HOUR;
 	rtc_tm->tm_min  =3D v[0] & DA9055_RTC_ALM_MIN;
+	rtc_tm->tm_sec =3D 0;
=20
 	return rtc_valid_tm(rtc_tm);
 }
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index c5432bf64e1c..dba60c1dfce2 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -388,6 +388,8 @@ static int davinci_rtc_read_alarm(struct device *dev, s=
truct rtc_wkalrm *alm)
 	u8 day0, day1;
 	unsigned long flags;
=20
+	alm->time.tm_sec =3D 0;
+
 	spin_lock_irqsave(&davinci_rtc_lock, flags);
=20
 	davinci_rtcss_calendar_wait(davinci_rtc);
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 26091a48925f..1227ceab61ee 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -341,6 +341,7 @@ static int pcf8563_rtc_read_alarm(struct device *dev, s=
truct rtc_wkalrm *tm)
 		"%s: raw data is min=3D%02x, hr=3D%02x, mday=3D%02x, wday=3D%02x\n",
 		__func__, buf[0], buf[1], buf[2], buf[3]);
=20
+	tm->time.tm_sec =3D 0;
 	tm->time.tm_min =3D bcd2bin(buf[0] & 0x7F);
 	tm->time.tm_hour =3D bcd2bin(buf[1] & 0x3F);
 	tm->time.tm_mday =3D bcd2bin(buf[2] & 0x3F);
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
index f28d57788951..68ce77414bdc 100644
--- a/drivers/rtc/rtc-rc5t583.c
+++ b/drivers/rtc/rtc-rc5t583.c
@@ -128,6 +128,7 @@ static int rc5t583_rtc_read_alarm(struct device *dev, s=
truct rtc_wkalrm *alm)
 		return ret;
 	}
=20
+	alm->time.tm_sec =3D 0;
 	alm->time.tm_min =3D bcd2bin(alarm_data[0]);
 	alm->time.tm_hour =3D bcd2bin(alarm_data[1]);
 	alm->time.tm_mday =3D bcd2bin(alarm_data[2]);
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
