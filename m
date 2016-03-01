Return-Path: <rtc-linux+bncBC2JFQ6TUUPRB75C223AKGQESCBGJXQ@googlegroups.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com. [2607:f8b0:400e:c03::233])
        by gmr-mx.google.com with ESMTPS id ui7si4335498pab.0.2016.03.01.04.56.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 04:56:30 -0800 (PST)
Received: by mail-pa0-x233.google.com with SMTP id fy10so111662237pac.1
        for <rtc-linux@googlegroups.com>; Tue, 01 Mar 2016 04:56:30 -0800 (PST)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-vr41xx: remove unused function
Date: Tue,  1 Mar 2016 18:26:21 +0530
Message-Id: <1456836981-30999-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We were getting build warning about:
drivers/rtc/rtc-vr41xx.c:228:12: warning: =E2=80=98vr41xx_rtc_alarm_irq_ena=
ble=E2=80=99
defined but not used

The function vr41xx_rtc_alarm_irq_enable() was not used anywhere.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/112780206

 drivers/rtc/rtc-vr41xx.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282..68cb63e 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -225,24 +225,6 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsign=
ed int cmd, unsigned long
 	return 0;
 }
=20
-static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
abled)
-{
-	spin_lock_irq(&rtc_lock);
-	if (enabled) {
-		if (!alarm_enabled) {
-			enable_irq(aie_irq);
-			alarm_enabled =3D 1;
-		}
-	} else {
-		if (alarm_enabled) {
-			disable_irq(aie_irq);
-			alarm_enabled =3D 0;
-		}
-	}
-	spin_unlock_irq(&rtc_lock);
-	return 0;
-}
-
 static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev =3D (struct platform_device *)dev_id;
--=20
1.9.1

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
