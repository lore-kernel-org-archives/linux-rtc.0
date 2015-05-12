Return-Path: <rtc-linux+bncBDA7X7F2WUEBB6XRY6VAKGQE2OZEERA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com. [209.85.212.170])
        by gmr-mx.google.com with ESMTPS id p12si105883wiv.1.2015.05.12.05.58.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:34 -0700 (PDT)
Received: by widdi4 with SMTP id di4so14294918wid.0
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:34 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [rtc-linux] [PATCH v2 06/12] watchdog: bindings: Supply knowledge of
 a third supported device - clocksource
Date: Tue, 12 May 2015 13:58:14 +0100
Message-Id: <1431435500-22899-7-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
index 388c88a..039c5ca 100644
--- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
@@ -1,9 +1,11 @@
 STMicroelectronics Low Power Controller (LPC) - Watchdog
 ========================================================
 
-LPC currently supports Watchdog OR Real Time Clock functionality.
+LPC currently supports Watchdog OR Real Time Clock OR Clocksource
+functionality.
 
 [See: ../rtc/rtc-st-lpc.txt for RTC options]
+[See: ../timer/st,stih407-lpc for Clocksource options]
 
 Required properties
 
@@ -12,9 +14,11 @@ Required properties
 - reg		: LPC registers base address + size
 - interrupts    : LPC interrupt line number and associated flags
 - clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
-- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
-		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
-		  selected.
+- st,lpc-mode	: The LPC can run either one of three modes:
+                  ST_LPC_MODE_RTC    [0]
+                  ST_LPC_MODE_WDT    [1]
+                  ST_LPC_MODE_CLKSRC [2]
+		 One (and only one) mode must be selected.
 
 Required properties [watchdog mode]
 
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
