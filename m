Return-Path: <rtc-linux+bncBCQJP74GSUDRBPNP2W3AKGQE5BB7EDI@googlegroups.com>
Received: from michel.telenet-ops.be (michel.telenet-ops.be. [2a02:1800:110:4::f00:18])
        by gmr-mx.google.com with ESMTP id w10si742476wmw.3.2016.03.01.00.50.04
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 00:50:04 -0800 (PST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Yoichi Yuasa <yuasa@linux-mips.org>
Cc: John Stultz <john.stultz@linaro.org>,
	rtc-linux@googlegroups.com,
	linux-mips@linux-mips.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [rtc-linux] [PATCH/RFT] rtc: rtc-vr41xx: Wire up alarm_irq_enable
Date: Tue,  1 Mar 2016 09:50:01 +0100
Message-Id: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
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

drivers/rtc/rtc-vr41xx.c:229: warning: =E2=80=98vr41xx_rtc_alarm_irq_enable=
=E2=80=99 defined but not used

Apparently the conversion to alarm_irq_enable forgot to wire up the
callback.

Fixes: 16380c153a69c378 ("RTC: Convert rtc drivers to use the alarm_irq_ena=
ble method")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware
---
 drivers/rtc/rtc-vr41xx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282275b3988a..e1b86bb0106233f1 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -272,12 +272,13 @@ static irqreturn_t rtclong1_interrupt(int irq, void *=
dev_id)
 }
=20
 static const struct rtc_class_ops vr41xx_rtc_ops =3D {
-	.release	=3D vr41xx_rtc_release,
-	.ioctl		=3D vr41xx_rtc_ioctl,
-	.read_time	=3D vr41xx_rtc_read_time,
-	.set_time	=3D vr41xx_rtc_set_time,
-	.read_alarm	=3D vr41xx_rtc_read_alarm,
-	.set_alarm	=3D vr41xx_rtc_set_alarm,
+	.release		=3D vr41xx_rtc_release,
+	.ioctl			=3D vr41xx_rtc_ioctl,
+	.read_time		=3D vr41xx_rtc_read_time,
+	.set_time		=3D vr41xx_rtc_set_time,
+	.read_alarm		=3D vr41xx_rtc_read_alarm,
+	.set_alarm		=3D vr41xx_rtc_set_alarm,
+	.alarm_irq_enable	=3D vr41xx_rtc_alarm_irq_enable,
 };
=20
 static int rtc_probe(struct platform_device *pdev)
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
