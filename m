Return-Path: <rtc-linux+bncBDEKVJM7XAHRBI7E52YAKGQEHFYJMAI@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id q6si478937wif.2.2015.10.12.06.14.11
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2015 06:14:11 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [rtc-linux] [PATCH] rtc: davinci: remove incorrect reference to probe function
Date: Mon, 12 Oct 2015 15:14:05 +0200
Message-ID: <5677325.oZsHpDNL2Z@wuerfel>
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

The davinci rtc driver uses the module_platform_driver_probe()
helper to call the probe function and mark it as __init, but
it also puts a reference into its davinci_rtc_driver function.

This will crash if we ever get a deferred probe and the probe
function is called again after the init section has been removed.
kbuild warns about this:

WARNING: vmlinux.o(.data+0x1aa2b4): Section mismatch in reference from the variable davinci_rtc_driver to the function .init.text:davinci_rtc_probe()
The variable davinci_rtc_driver references
the function __init davinci_rtc_probe()

This patch removes the .probe callback from the platform driver,
which avoids those problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index c84f46168a52..c5432bf64e1c 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -546,7 +546,6 @@ static int __exit davinci_rtc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver davinci_rtc_driver = {
-	.probe		= davinci_rtc_probe,
 	.remove		= __exit_p(davinci_rtc_remove),
 	.driver		= {
 		.name = "rtc_davinci",

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
