Return-Path: <rtc-linux+bncBDA63GMRREGBBC4ZYO5QKGQE5L34QRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from marmot.wormnet.eu (marmot.wormnet.eu. [2a03:9800:10:2d:3203:b3a5:8bdc:5b68])
        by gmr-mx.google.com with ESMTPS id f70si195659wmf.0.2016.06.26.23.49.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jun 2016 23:49:46 -0700 (PDT)
Date: Mon, 27 Jun 2016 07:49:43 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
Message-ID: <20160627064943.GA5125@quatermain.digriz.org.uk>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Acked-by: Alexander Clouter <alex@digriz.org.uk>

On Mon, Jun 27, 2016 at 12:03:02AM +0200, Alexandre Belloni wrote:
>m48t86.h belongs to include/linux/platform_data/
>
>Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>---
>Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>Cc: Ryan Mallon <rmallon@gmail.com>
>Cc: Alexander Clouter <alex@digriz.org.uk>
>Cc: Jason Cooper <jason@lakedaemon.net>
>Cc: Andrew Lunn <andrew@lunn.ch>
>Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>Cc: Gregory Clement <gregory.clement@free-electrons.com>
>Cc: linux-arm-kernel@lists.infradead.org
>
> arch/arm/mach-ep93xx/ts72xx.c                          | 2 +-
> arch/arm/mach-orion5x/ts78xx-setup.c                   | 2 +-
> drivers/rtc/rtc-m48t86.c                               | 2 +-
> include/linux/{m48t86.h => platform_data/rtc-m48t86.h} | 0
> 4 files changed, 3 insertions(+), 3 deletions(-)
> rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)
>
>diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
>index 45b81a2bcd4b..3b39ea353d30 100644
>--- a/arch/arm/mach-ep93xx/ts72xx.c
>+++ b/arch/arm/mach-ep93xx/ts72xx.c
>@@ -16,7 +16,7 @@
> #include <linux/init.h>
> #include <linux/platform_device.h>
> #include <linux/io.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
>
>diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
>index 3a58a5d4a28a..8d597267d0c4 100644
>--- a/arch/arm/mach-orion5x/ts78xx-setup.c
>+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
>@@ -16,7 +16,7 @@
> #include <linux/platform_device.h>
> #include <linux/mv643xx_eth.h>
> #include <linux/ata_platform.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
> #include <linux/timeriomem-rng.h>
>diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
>index f72b91f2501f..0eeb5714c00f 100644
>--- a/drivers/rtc/rtc-m48t86.c
>+++ b/drivers/rtc/rtc-m48t86.c
>@@ -16,7 +16,7 @@
> #include <linux/module.h>
> #include <linux/rtc.h>
> #include <linux/platform_device.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/bcd.h>
>
> #define M48T86_REG_SEC		0x00
>diff --git a/include/linux/m48t86.h b/include/linux/platform_data/rtc-m48t86.h
>similarity index 100%
>rename from include/linux/m48t86.h
>rename to include/linux/platform_data/rtc-m48t86.h

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
