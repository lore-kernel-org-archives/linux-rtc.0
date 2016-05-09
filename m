Return-Path: <rtc-linux+bncBAABBJMGYS4QKGQERJY3N4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id r72si904373wmd.2.2016.05.09.14.37.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 14:37:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Byron Bradley <byron.bbradley@gmail.com>,
	Tim Ellis <tim@ngndg.com>
Subject: [rtc-linux] [PATCH 2/2] rtc: make rtc_time64_to_tm save to use for
 dates before 1970
Date: Mon,  9 May 2016 23:37:34 +0200
Message-Id: <1462829854-789-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1462829854-789-1-git-send-email-uwe@kleine-koenig.org>
References: <1462829854-789-1-git-send-email-uwe@kleine-koenig.org>
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

When the time parameter to rtc_time64_to_tm is negative and so
represents a date before 1970 several outputs were calculated wrongly.
A comment in the code signaled that the code doesn't handle negative
times but that didn't stop __rtc_read_alarm to still pass negative
values.

For example with time=3D-2208565980 (1900-01-05 21:27 UTC) the days variabl=
e
was assigned a negative value (-25562) which was then used to calculate

	secs =3D time - (unsigned int) days * 86400;

resulting in an overflow in both the multiplication and the subtraction
yielding secs =3D 4294958116 which is then used to calculate
tm_hour =3D 1193043; tm_min =3D 55; tm_sec =3D 16.

With the changes in this patch the time stamp from the example above is
converted correctly.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-lib.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index e6bfb9c42a10..0140ce7088ac 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -53,15 +53,20 @@ EXPORT_SYMBOL(rtc_year_days);
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
 	unsigned int month, year;
-	unsigned long secs;
+	s32 secs
 	int days;
=20
-	/* time must be positive */
-	days =3D div_s64(time, 86400);
-	secs =3D time - (unsigned int) days * 86400;
+	days =3D div_s64_rem(time, 86400, &secs);
+
+	if (secs < 0) {
+		secs +=3D 86400;
+		days -=3D 1;
+	}
=20
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday =3D (days + 4) % 7;
+	if (tm->tm_wday < 0)
+		tm->tm_wday +=3D 7;
=20
 	year =3D 1970 + days / 365;
 	days -=3D (year - 1970) * 365
--=20
2.8.1

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
