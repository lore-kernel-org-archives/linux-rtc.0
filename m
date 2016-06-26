Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBI5CYG5QKGQERXOPV7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x70si108936wmf.1.2016.06.26.15.03.14
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 15:03:15 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 5/5] rtc: v3020: move rtc-v3020.h to platform_data
Date: Mon, 27 Jun 2016 00:03:03 +0200
Message-Id: <1466978583-13310-5-git-send-email-alexandre.belloni@free-electrons.com>
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

rtc-v3020.h belongs to include/linux/platform_data/

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org
 arch/arm/mach-pxa/cm-x270.c                   | 2 +-
 arch/arm/mach-pxa/cm-x300.c                   | 2 +-
 arch/arm/mach-pxa/em-x270.c                   | 2 +-
 drivers/rtc/rtc-v3020.c                       | 2 +-
 include/linux/{ => platform_data}/rtc-v3020.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{ => platform_data}/rtc-v3020.h (100%)

diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index fa5f51d633a3..be4a66166d61 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <video/mbxfb.h>
 
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 5f5ac7c8faf0..868448d2cd82 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -25,7 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/dm9000.h>
 #include <linux/leds.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 6e0268deec43..03354c21e1f2 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 
 #include <linux/dm9000.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
index 7a0436329d6c..1f3117b5a83c 100644
--- a/drivers/rtc/rtc-v3020.c
+++ b/drivers/rtc/rtc-v3020.c
@@ -25,7 +25,7 @@
 #include <linux/rtc.h>
 #include <linux/types.h>
 #include <linux/bcd.h>
-#include <linux/rtc-v3020.h>
+#include <linux/platform_data/rtc-v3020.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
diff --git a/include/linux/rtc-v3020.h b/include/linux/platform_data/rtc-v3020.h
similarity index 100%
rename from include/linux/rtc-v3020.h
rename to include/linux/platform_data/rtc-v3020.h
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
