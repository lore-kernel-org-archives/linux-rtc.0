Return-Path: <rtc-linux+bncBDA7X7F2WUEBB57RY6VAKGQEBXBJZRQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by gmr-mx.google.com with ESMTPS id p9si88234wiz.3.2015.05.12.05.58.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:31 -0700 (PDT)
Received: by mail-wi0-f174.google.com with SMTP id mc15so53471378wic.1
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:31 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 04/12] clocksource: bindings: Provide bindings
 for ST's LPC Clocksource device
Date: Tue, 12 May 2015 13:58:12 +0100
Message-Id: <1431435500-22899-5-git-send-email-lee.jones@linaro.org>
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
