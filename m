Return-Path: <rtc-linux+bncBC2JFQ6TUUPRBO46223AKGQE7WDJ5SQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com. [2607:f8b0:400e:c03::233])
        by gmr-mx.google.com with ESMTPS id 12si4389591pfb.1.2016.03.01.04.46.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 04:46:51 -0800 (PST)
Received: by mail-pa0-x233.google.com with SMTP id fy10so111535704pac.1
        for <rtc-linux@googlegroups.com>; Tue, 01 Mar 2016 04:46:51 -0800 (PST)
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-testers@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: rtc-generic: use correct header file
Date: Tue,  1 Mar 2016 18:16:40 +0530
Message-Id: <1456836400-10102-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The allmodconfig build of m32r fails with errors like:

In file included from drivers/rtc/rtc-generic.c:12:0:
arch/m32r/include/asm/rtc.h:46:8: error: redefinition of 'struct rtc_time'

drivers/rtc/rtc-generic.c: In function 'generic_get_time':
drivers/rtc/rtc-generic.c:16:21: error: implicit declaration of function 'get_rtc_time'

drivers/rtc/rtc-generic.c:18:12: error: 'RTC_BATT_BAD' undeclared

drivers/rtc/rtc-generic.c: In function 'generic_set_time':
drivers/rtc/rtc-generic.c:26:6: error: implicit declaration of function 'set_rtc_time'

Apart from m32r, many other arch like xtensa, sparc are failing with:
drivers/rtc/rtc-generic.c:12:21: fatal error: asm/rtc.h: No such file or directory

Other rtc drivers are using asm-generic/rtc.h, so use it here.

Fixes: 2a32c792f1c9 ("rtc: enable COMPILE_TEST")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

m32r allmodconfig build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/112780210

failure with sparc and xtensa needs more work as after this patch also
they fail with error about missing file "mc146818rtc.h".

 drivers/rtc/rtc-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
index e782ebd..494dd85 100644
--- a/drivers/rtc/rtc-generic.c
+++ b/drivers/rtc/rtc-generic.c
@@ -9,7 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 
-#include <asm/rtc.h>
+#include <asm-generic/rtc.h>
 
 static int generic_get_time(struct device *dev, struct rtc_time *tm)
 {
-- 
1.9.1

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
