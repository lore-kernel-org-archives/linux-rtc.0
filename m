Return-Path: <rtc-linux+bncBDA7X7F2WUEBB66VVWVAKGQEDDRDTXQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com. [209.85.212.173])
        by gmr-mx.google.com with ESMTPS id gt9si130893wib.2.2015.05.07.06.39.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 06:39:07 -0700 (PDT)
Received: by mail-wi0-f173.google.com with SMTP id k4so243068635wiz.1
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 06:39:07 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 10/12] ARM: STi: DT: STih407: Switch LPC mode from
 RTC to Clocksource
Date: Thu,  7 May 2015 14:38:42 +0100
Message-Id: <1431005924-21777-11-git-send-email-lee.jones@linaro.org>
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

This aligns with the internal configuration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 2b2315d..bf1c7f5 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -354,7 +354,7 @@
 			reg = <0x8788000 0x1000>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
-			st,lpc-mode = <ST_LPC_MODE_RTC>;
+			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 	};
 };
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
