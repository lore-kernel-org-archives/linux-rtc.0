Return-Path: <rtc-linux+bncBAABB47LT65QKGQE3MGSXQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from arcturus.kleine-koenig.org (arcturus.kleine-koenig.org. [2a01:4f8:d12:1f44::2])
        by gmr-mx.google.com with ESMTPS id f4si453028wmg.0.2016.06.20.06.56.03
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 06:56:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	=?UTF-8?q?Manuel=20R=C3=B6der?= <manuel_roeder@gmx.de>
Subject: [rtc-linux] [PATCH 5/5] rtc: fix a typo and reduce three empty lines
 to one
Date: Mon, 20 Jun 2016 15:55:53 +0200
Message-Id: <1466430953-18659-6-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1466430953-18659-1-git-send-email-uwe@kleine-koenig.org>
References: <1466430953-18659-1-git-send-email-uwe@kleine-koenig.org>
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
 drivers/rtc/interface.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 99475908e556..c803364ad4ce 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -393,7 +393,7 @@ int rtc_initialize_alarm(struct rtc_device *rtc, struct=
 rtc_wkalrm *alarm)
 	rtc->aie_timer.node.expires =3D rtc_tm_to_ktime(alarm->time);
 	rtc->aie_timer.period =3D ktime_set(0, 0);
=20
-	/* Alarm has to be enabled & in the futrure for us to enqueue it */
+	/* Alarm has to be enabled & in the future for us to enqueue it */
 	if (alarm->enabled && (rtc_tm_to_ktime(now).tv64 <
 			 rtc->aie_timer.node.expires.tv64)) {
=20
@@ -405,8 +405,6 @@ int rtc_initialize_alarm(struct rtc_device *rtc, struct=
 rtc_wkalrm *alarm)
 }
 EXPORT_SYMBOL_GPL(rtc_initialize_alarm);
=20
-
-
 int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
 	int err =3D mutex_lock_interruptible(&rtc->ops_lock);
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
