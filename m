Return-Path: <rtc-linux+bncBDEKVJM7XAHRBNGG764AKGQE5NS5LTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id k143si171272wmg.1.2016.04.26.14.52.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 14:52:52 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	geert@linux-m68k.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au,
	dalias@libc.org,
	dhowells@redhat.com,
	linux-alpha@vger.kernel.org,
	a.zummo@towertech.it,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 6/6] rtc: generic: remove get_rtc_time/set_rtc_time
 wrappers
Date: Tue, 26 Apr 2016 23:52:31 +0200
Message-Id: <1461707551-1337971-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

All architectures using this driver are now converted to
provide their own operations, so this one can be turned
into a trivial stub driver relying on its platform data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-generic.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index d726c6aa96a8..1bf5d2347928 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,44 +9,10 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
-    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
-#include <asm/rtc.h>
-
-static int generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned int ret = get_rtc_time(tm);
-
-	if (ret & RTC_BATT_BAD)
-		return -EOPNOTSUPP;
-
-	return rtc_valid_tm(tm);
-}
-
-static int generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	if (set_rtc_time(tm) < 0)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops generic_rtc_ops = {
-	.read_time = generic_get_time,
-	.set_time = generic_set_time,
-};
-#else
-#define generic_rtc_ops *(struct rtc_class_ops*)NULL
-#endif
-
 static int __init generic_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
-	const struct rtc_class_ops *ops;
-
-	ops = dev_get_platdata(&dev->dev);
-	if (!ops)
-		ops = &generic_rtc_ops;
+	const struct rtc_class_ops *ops = dev_get_platdata(&dev->dev);
 
 	rtc = devm_rtc_device_register(&dev->dev, "rtc-generic",
 					ops, THIS_MODULE);
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
