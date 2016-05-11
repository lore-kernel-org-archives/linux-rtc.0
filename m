Return-Path: <rtc-linux+bncBDS7HNEFSALRB564664QKGQEE2XT6TQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c69si4940wme.2.2016.05.19.09.48.55
        for <rtc-linux@googlegroups.com>;
        Thu, 19 May 2016 09:48:55 -0700 (PDT)
Received: from localhost (unknown [88.191.26.124])
	by mail.free-electrons.com (Postfix) with ESMTPSA id CC9022E0
	for <rtc-linux@googlegroups.com>; Thu, 19 May 2016 18:48:42 +0200 (CEST)
Resent-Message-ID: <20160519164843.GK2890@piout.net>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Byron Bradley <byron.bbradley@gmail.com>,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH RESEND 1/2] rtc: initialize output parameter for
 read alarm to "uninitialized"
Date: Wed, 11 May 2016 09:11:23 +0200
Message-Id: <1462950684-3661-2-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1462950684-3661-1-git-send-email-uwe@kleine-koenig.org>
References: <1462950684-3661-1-git-send-email-uwe@kleine-koenig.org>
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

rtc drivers are supposed to set values they don't support to -1. To
simplify this for drivers and also make it harder for them to get it
wrong initialize the values to -1.

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/interface.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9ef5f6f89f98..99475908e556 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -104,7 +104,17 @@ static int rtc_read_alarm_internal(struct rtc_device *=
rtc, struct rtc_wkalrm *al
 	else if (!rtc->ops->read_alarm)
 		err =3D -EINVAL;
 	else {
-		memset(alarm, 0, sizeof(struct rtc_wkalrm));
+		alarm->enabled =3D 0;
+		alarm->pending =3D 0;
+		alarm->time.tm_sec =3D -1;
+		alarm->time.tm_min =3D -1;
+		alarm->time.tm_hour =3D -1;
+		alarm->time.tm_mday =3D -1;
+		alarm->time.tm_mon =3D -1;
+		alarm->time.tm_year =3D -1;
+		alarm->time.tm_wday =3D -1;
+		alarm->time.tm_yday =3D -1;
+		alarm->time.tm_isdst =3D -1;
 		err =3D rtc->ops->read_alarm(rtc->dev.parent, alarm);
 	}
=20
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
