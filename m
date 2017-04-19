Return-Path: <rtc-linux+bncBDEKVJM7XAHRBLOI33DQKGQER253V7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id b84si364887wmh.2.2017.04.19.10.53.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 10:53:49 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Brandt <chris.brandt@renesas.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: sh: mark PM functions as unused
Date: Wed, 19 Apr 2017 19:52:43 +0200
Message-Id: <20170419175346.37122-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The sh_rtc_set_irq_wake() function is only called from the suspend/resume handlers
that may be hidden, causing a harmless warning:

drivers/rtc/rtc-sh.c:724:13: error: 'sh_rtc_set_irq_wake' defined but not used [-Werror=unused-function]
 static void sh_rtc_set_irq_wake(struct device *dev, int enabled)

The most reliable way to avoid the warning is to remove the existing #ifdef
and mark the two functions as __maybe_unused so the compiler can silently
drop all three when there is no reference.

Fixes: dab5aec64bf5 ("rtc: sh: add support for rza series")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-sh.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 00b396e96cbe..6c2d3989f967 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -734,8 +734,7 @@ static void sh_rtc_set_irq_wake(struct device *dev, int enabled)
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sh_rtc_suspend(struct device *dev)
+static int __maybe_unused sh_rtc_suspend(struct device *dev)
 {
 	if (device_may_wakeup(dev))
 		sh_rtc_set_irq_wake(dev, 1);
@@ -743,14 +742,13 @@ static int sh_rtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int sh_rtc_resume(struct device *dev)
+static int __maybe_unused sh_rtc_resume(struct device *dev)
 {
 	if (device_may_wakeup(dev))
 		sh_rtc_set_irq_wake(dev, 0);
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(sh_rtc_pm_ops, sh_rtc_suspend, sh_rtc_resume);
 
-- 
2.9.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
