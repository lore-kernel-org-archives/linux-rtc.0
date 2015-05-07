Return-Path: <rtc-linux+bncBDA7X7F2WUEBB4OVVWVAKGQEWEVG2TY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com. [74.125.82.52])
        by gmr-mx.google.com with ESMTPS id g5si270591wix.1.2015.05.07.06.38.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 06:38:57 -0700 (PDT)
Received: by mail-wg0-f52.google.com with SMTP id o15so43893984wgy.2
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 06:38:57 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [rtc-linux] [PATCH 04/12] clocksource: bindings: Provide bindings for
 ST's LPC Clocksource device
Date: Thu,  7 May 2015 14:38:36 +0100
Message-Id: <1431005924-21777-5-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
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

On current ST platforms the LPC controls a number of functions including
Watchdog and Real Time Clock.  This patch provides the bindings used to
configure LPC in Clocksource mode.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/timer/st,stih407-lpc       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stih407-lpc

diff --git a/Documentation/devicetree/bindings/timer/st,stih407-lpc b/Documentation/devicetree/bindings/timer/st,stih407-lpc
new file mode 100644
index 0000000..72acb48
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,stih407-lpc
@@ -0,0 +1,28 @@
+STMicroelectronics Low Power Controller (LPC) - Clocksource
+===========================================================
+
+LPC currently supports Watchdog OR Real Time Clock OR Clocksource
+functionality.
+
+[See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
+[See: ../rtc/rtc-st-lpc.txt for RTC options]
+
+Required properties
+
+- compatible   : Must be: "st,stih407-lpc"
+- reg          : LPC registers base address + size
+- interrupts   : LPC interrupt line number and associated flags
+- clocks       : Clock used by LPC device (See: ../clock/clock-bindings.txt)
+- st,lpc-mode  : The LPC can run either one of three modes:
+                  ST_LPC_MODE_RTC    [0]
+                  ST_LPC_MODE_WDT    [1]
+                  ST_LPC_MODE_CLKSRC [2]
+		 One (and only one) mode must be selected.
+
+Example:
+       lpc@fde05000 {
+               compatible      = "st,stih407-lpc";
+               reg             = <0xfde05000 0x1000>;
+               clocks          = <&clk_s_d3_flexgen CLK_LPC_0>;
+               st,lpc-mode     = <ST_LPC_MODE_CLKSRC>;
+       };
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
