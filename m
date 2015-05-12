Return-Path: <rtc-linux+bncBDEKVJM7XAHRBKXAZGVAKGQEIKKBUFA@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id ec7si164415wib.3.2015.05.12.14.27.06
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 14:27:06 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: pfc8563: fix uninitialized variable warning
Date: Tue, 12 May 2015 23:27:02 +0200
Message-ID: <2293546.ekQV1ek12O@wuerfel>
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

Gcc is unable to prove that alm_pending is always initialized
when it is used, so it prints a harmless warning:

drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_probe':
drivers/rtc/rtc-pcf8563.c:449:5: warning: 'alm_pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

This uses the same conditional expression that is used inside of
the pcf8563_get_alarm_mode() function, to help gcc figure it out
and shut up that warning, and make the ARM defconfigs build again
with no warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a45d528aab8b ("rtc: pcf8563: clear expired alarm at boot time")

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0ba7e59929be..8e52c029cf1a 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -437,7 +437,7 @@ static int pcf8563_probe(struct i2c_client *client,
 	}
 
 	err = pcf8563_get_alarm_mode(client, NULL, &alm_pending);
-	if (err < 0) {
+	if (err) {
 		dev_err(&client->dev, "%s: read error\n", __func__);
 		return err;
 	}

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
