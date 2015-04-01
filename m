Return-Path: <rtc-linux+bncBAABBPMQ52UAKGQEZVVQINQ@googlegroups.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com. [192.94.94.40])
        by gmr-mx.google.com with ESMTPS id e4si1412679igt.3.2015.03.31.22.55.09
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 22:55:09 -0700 (PDT)
From: Lokesh Vutla <lokeshvutla@ti.com>
To: <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>
CC: <t-kristo@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>
Subject: [rtc-linux] [PATCH 2/3] rtc: omap: Update Kconfig for OMAP RTC
Date: Wed, 1 Apr 2015 11:24:57 +0530
Message-ID: <1427867698-1326-3-git-send-email-lokeshvutla@ti.com>
In-Reply-To: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
References: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
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

RTC is present in AM43xx and DRA7xx also. Updating the Kconfig
to depend on ARCH_OMAP or ARCH_DAVINCI

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/rtc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d..40faf56 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1121,11 +1121,11 @@ config RTC_DRV_IMXDI
 	   will be called "rtc-imxdi".
 
 config RTC_DRV_OMAP
-	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
+	tristate "TI OMAP Real Time Clock"
+	depends on ARCH_OMAP || ARCH_DAVINCI
 	help
 	  Say "yes" here to support the on chip real time clock
-	  present on TI OMAP1, AM33xx and DA8xx/OMAP-L13x.
+	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
 
 	  This driver can also be built as a module, if so, module
 	  will be called rtc-omap.
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
