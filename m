Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIVCYG5QKGQEJAZLP4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r10si205863wmf.0.2016.06.26.15.03.14
        for <rtc-linux@googlegroups.com>;
        Sun, 26 Jun 2016 15:03:14 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Alexander Clouter <alex@digriz.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
Date: Mon, 27 Jun 2016 00:03:02 +0200
Message-Id: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
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

m48t86.h belongs to include/linux/platform_data/

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org

 arch/arm/mach-ep93xx/ts72xx.c                          | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c                   | 2 +-
 drivers/rtc/rtc-m48t86.c                               | 2 +-
 include/linux/{m48t86.h => platform_data/rtc-m48t86.h} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 45b81a2bcd4b..3b39ea353d30 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 3a58a5d4a28a..8d597267d0c4 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timeriomem-rng.h>
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index f72b91f2501f..0eeb5714c00f 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
-#include <linux/m48t86.h>
+#include <linux/platform_data/rtc-m48t86.h>
 #include <linux/bcd.h>
 
 #define M48T86_REG_SEC		0x00
diff --git a/include/linux/m48t86.h b/include/linux/platform_data/rtc-m48t86.h
similarity index 100%
rename from include/linux/m48t86.h
rename to include/linux/platform_data/rtc-m48t86.h
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
