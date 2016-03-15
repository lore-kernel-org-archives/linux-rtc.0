Return-Path: <rtc-linux+bncBDEKVJM7XAHRBVMEUK3QKGQECPT6ZYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.74])
        by gmr-mx.google.com with ESMTPS id f75si761388wme.3.2016.03.15.14.44.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2016 14:44:53 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Oleksij Rempel <linux@rempel-privat.de>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: asm9260: remove incorrect __init/__exit annotations
Date: Tue, 15 Mar 2016 22:44:31 +0100
Message-Id: <1458078287-586232-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The probe and remove callbacks of the platform driver are marked __init
and __exit, respectively. However, this is not a correct way to annotate
them, as it will result in those sections to be discarded at link time
or after boot, while we can actually call them again based on manual
unbinding, or deferred probing.

Kbuild warns about the problem:

WARNING: drivers/rtc/rtc-asm9260.o(.data+0x0): Section mismatch in reference from the variable asm9260_rtc_driver to the function .init.text:asm9260_rtc_probe()

This removes the annotations, so we no longer branch into missing
code and avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 125e550fd257 ("rtc: add Alphascale asm9260 driver")
---
 drivers/rtc/rtc-asm9260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 14e08c4c1a01..355fdb97a006 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -255,7 +255,7 @@ static const struct rtc_class_ops asm9260_rtc_ops = {
 	.alarm_irq_enable	= asm9260_alarm_irq_enable,
 };
 
-static int __init asm9260_rtc_probe(struct platform_device *pdev)
+static int asm9260_rtc_probe(struct platform_device *pdev)
 {
 	struct asm9260_rtc_priv *priv;
 	struct device *dev = &pdev->dev;
@@ -323,7 +323,7 @@ err_return:
 	return ret;
 }
 
-static int __exit asm9260_rtc_remove(struct platform_device *pdev)
+static int asm9260_rtc_remove(struct platform_device *pdev)
 {
 	struct asm9260_rtc_priv *priv = platform_get_drvdata(pdev);
 
-- 
2.7.0

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
