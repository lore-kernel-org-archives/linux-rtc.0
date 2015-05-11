Return-Path: <rtc-linux+bncBD62P6P6EQIKNYGEVICRUBAXZY7JY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com. [2607:f8b0:4003:c01::236])
        by gmr-mx.google.com with ESMTPS id g4si115635igc.3.2015.05.11.15.41.41
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 15:41:41 -0700 (PDT)
Received: by mail-ob0-x236.google.com with SMTP id us9so81712767obc.2
        for <rtc-linux@googlegroups.com>; Mon, 11 May 2015 15:41:41 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@arm.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Daniel Mack <daniel@zonque.org>
Subject: [rtc-linux] [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
Date: Mon, 11 May 2015 17:41:26 -0500
Message-Id: <1431384089-28367-2-git-send-email-robh@kernel.org>
In-Reply-To: <1431384089-28367-1-git-send-email-robh@kernel.org>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
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
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
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
