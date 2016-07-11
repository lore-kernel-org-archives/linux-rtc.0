Return-Path: <rtc-linux+bncBAABBTVGRW6AKGQE5HHRJKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [78.47.169.190])
        by gmr-mx.google.com with ESMTPS id f4si1066562wmg.0.2016.07.11.01.05.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2016 01:05:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ben Hutchings <benh@debian.org>,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH 2/2] rtc: hym8563: in .read_alarm set .tm_sec to 0
 to signal minute accuracy
Date: Mon, 11 Jul 2016 10:05:28 +0200
Message-Id: <1468224328-7391-3-git-send-email-uwe@kleine-koenig.org>
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

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 drivers/rtc/rtc-hym8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 795a3f517cd0..e5ad527cb75e 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -198,7 +198,7 @@ static int hym8563_rtc_read_alarm(struct device *dev, s=
truct rtc_wkalrm *alm)
 		return ret;
=20
 	/* The alarm only has a minute accuracy */
-	alm_tm->tm_sec =3D -1;
+	alm_tm->tm_sec =3D 0;
=20
 	alm_tm->tm_min =3D (buf[0] & HYM8563_ALM_BIT_DISABLE) ?
 					-1 :
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
