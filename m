Return-Path: <rtc-linux+bncBDA7X7F2WUEBB3GVVWVAKGQEJI4C6LY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com. [209.85.212.171])
        by gmr-mx.google.com with ESMTPS id bc3si263859wib.2.2015.05.07.06.38.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 06:38:52 -0700 (PDT)
Received: by mail-wi0-f171.google.com with SMTP id di4so242728524wid.0
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 06:38:52 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 01/12] mfd: dt-bindings: Provide human readable
 define for Clocksource mode
Date: Thu,  7 May 2015 14:38:33 +0100
Message-Id: <1431005924-21777-2-git-send-email-lee.jones@linaro.org>
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

ST's Low Power Controller can now operate in three supported modes;
Watchdog, Real Time Clock and most recently as a Clocksource.  This new
define will allow the LPC IP to be configured for Clocksource from DT.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/mfd/st-lpc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/st-lpc.h b/include/dt-bindings/mfd/st-lpc.h
index e3e6c75..d05894a 100644
--- a/include/dt-bindings/mfd/st-lpc.h
+++ b/include/dt-bindings/mfd/st-lpc.h
@@ -11,5 +11,6 @@
 
 #define ST_LPC_MODE_RTC		0
 #define ST_LPC_MODE_WDT		1
+#define ST_LPC_MODE_CLKSRC	2
 
 #endif /* __DT_BINDINGS_ST_LPC_H__ */
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
