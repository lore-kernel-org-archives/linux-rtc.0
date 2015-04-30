Return-Path: <rtc-linux+bncBD62P6P6EQIIBJMKVICRUBBWEXQMY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com. [2607:f8b0:4003:c01::232])
        by gmr-mx.google.com with ESMTPS id f17si217674igt.0.2015.04.30.13.37.20
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 13:37:20 -0700 (PDT)
Received: by mail-ob0-x232.google.com with SMTP id e9so53378775obf.1
        for <rtc-linux@googlegroups.com>; Thu, 30 Apr 2015 13:37:20 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH v2 1/4] ARM: pxa: add memory resource to RTC device
Date: Thu, 30 Apr 2015 15:37:10 -0500
Message-Id: <1430426233-7461-2-git-send-email-robh@kernel.org>
In-Reply-To: <1430426233-7461-1-git-send-email-robh@kernel.org>
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Add the memory resource for the sa1100-rtc device. Since the memory
resource is already present in the pxa_rtc_resources, that makes
sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
pxa_rtc_resources for both devices and remove the duplicate
sa1100_rtc_resources.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
v2:
- Rebase to v4.1-rc1

 arch/arm/mach-pxa/devices.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 3543466..b598db6 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -439,25 +439,11 @@ struct platform_device pxa_device_rtc = {
 	.resource       = pxa_rtc_resources,
 };

-static struct resource sa1100_rtc_resources[] = {
-	{
-		.start  = IRQ_RTC1Hz,
-		.end    = IRQ_RTC1Hz,
-		.name	= "rtc 1Hz",
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.start  = IRQ_RTCAlrm,
-		.end    = IRQ_RTCAlrm,
-		.name	= "rtc alarm",
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
 struct platform_device sa1100_device_rtc = {
 	.name		= "sa1100-rtc",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(sa1100_rtc_resources),
-	.resource	= sa1100_rtc_resources,
+	.num_resources  = ARRAY_SIZE(pxa_rtc_resources),
+	.resource       = pxa_rtc_resources,
 };

 static struct resource pxa_ac97_resources[] = {
--
2.1.0

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
