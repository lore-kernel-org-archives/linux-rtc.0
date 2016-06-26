Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIVCYG5QKGQEJAZLP4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a6si320178wma.1.2016.06.26.15.03.13
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 15:03:13 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [rtc-linux] [PATCH 2/5] rtc: ds1286: move header to linux/rtc
Date: Mon, 27 Jun 2016 00:03:00 +0200
Message-Id: <1466978583-13310-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Move ds1286.h to rtc specific folder.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
 arch/mips/sgi-ip22/ip22-reset.c  | 2 +-
 drivers/rtc/rtc-ds1286.c         | 2 +-
 include/linux/{ => rtc}/ds1286.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{ => rtc}/ds1286.h (100%)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 063c2dd31e72..2f45b0357021 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -7,7 +7,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/ds1286.h>
+#include <linux/rtc/ds1286.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 756e509f6ed2..ef75c349dff9 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -16,7 +16,7 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
-#include <linux/ds1286.h>
+#include <linux/rtc/ds1286.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
diff --git a/include/linux/ds1286.h b/include/linux/rtc/ds1286.h
similarity index 100%
rename from include/linux/ds1286.h
rename to include/linux/rtc/ds1286.h
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
