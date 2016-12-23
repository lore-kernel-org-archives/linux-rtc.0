Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBB4P6TBAKGQEEERLC4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id e134si2427752wmd.3.2016.12.23.03.16.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Dec 2016 03:16:22 -0800 (PST)
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v3 2/2] drivers: rtc: rtc-tps65910: use 'unsigned
 int' instead of 'unsigned' in arguments
Date: Fri, 23 Dec 2016 13:15:59 +0200
Message-Id: <1482491759-39335-3-git-send-email-vesa.jaaskelainen@vaisala.com>
In-Reply-To: <1482491759-39335-1-git-send-email-vesa.jaaskelainen@vaisala.com>
References: <1482491759-39335-1-git-send-email-vesa.jaaskelainen@vaisala.com>
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

Fixes checkpatch.pl warning:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisala.=
com>
---
 drivers/rtc/rtc-tps65910.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 9dd1db9..d0244d7 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -47,7 +47,8 @@ struct tps65910_rtc {
 /* Multiplier for ppb conversions */
 #define PPB_MULT	(1000000000LL)
=20
-static int tps65910_rtc_alarm_irq_enable(struct device *dev, unsigned enab=
led)
+static int tps65910_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
 {
 	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
 	u8 val =3D 0;
--=20
2.1.4

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
