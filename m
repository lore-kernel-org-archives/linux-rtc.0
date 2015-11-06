Return-Path: <rtc-linux+bncBAABB2NO6OYQKGQEZF3TX2Q@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id s134si157486wmb.3.2015.11.06.08.38.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Nov 2015 08:38:01 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	kernel@pengutronix.de
Subject: [rtc-linux] [PATCH] rtc: pcf8523: refuse to write dates later than 2099
Date: Fri,  6 Nov 2015 17:37:56 +0100
Message-Id: <1446827876-31613-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

When the chip increments the YEAR register and it already holds
bin2bcd(99) it reads as 0 afterwards. With this behaviour the last valid
day (without trickery) that has a representation is 2099-12-31 23:59:59.
So refuse to write later dates.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

When setting the YEAR register to bin2bcd(100) =3D=3D 0xa0 it increments
just fine up to bin2bcd(159) =3D=3D 0xf9 but these values are forbidden in
the manual. But this doesn't help to expand (or shift) the range of
supported dates.

An alternative to this patch would be to save tm_year % 100 because
that's what happens when waiting long enough anyhow. Would that be
better? Do we already care at all for year-2100-problems?

Best regards
Uwe

 drivers/rtc/rtc-pcf8523.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 4cdb64be061b..261d65e67c8b 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -219,6 +219,17 @@ static int pcf8523_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
 	u8 regs[8];
 	int err;
=20
+	/*
+	 * The hardware can only store values between 0 and 99 in it's YEAR
+	 * register (with 99 overflowing to 0 on increment).
+	 * After 2100-02-28 we could start interpreting the year to be in the
+	 * interval [2100, 2199], but there is no path to switch in a smooth way
+	 * because the chip handles YEAR=3D0x00 (and the out-of-spec
+	 * YEAR=3D0xa0) as a leap year, but 2100 isn't.
+	 */
+	if (tm->tm_year < 100 || tm->tm_year >=3D 200)
+		return -EINVAL;
+
 	err =3D pcf8523_stop_rtc(client);
 	if (err < 0)
 		return err;
--=20
2.6.1

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
