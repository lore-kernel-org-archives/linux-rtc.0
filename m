Return-Path: <rtc-linux+bncBDA7X7F2WUEBB6HRY6VAKGQES2SSGDI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com. [209.85.212.181])
        by gmr-mx.google.com with ESMTPS id g5si98713wix.1.2015.05.12.05.58.32
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:32 -0700 (PDT)
Received: by mail-wi0-f181.google.com with SMTP id nf17so14256346wic.1
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:32 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 05/12] watchdog: st_wdt: Update IP layout
 information to include Clocksource
Date: Tue, 12 May 2015 13:58:13 +0100
Message-Id: <1431435500-22899-6-git-send-email-lee.jones@linaro.org>
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

Initial submission adding support for this IP only included Watchdog and
the Real-Time Clock.  Now the third (and final) device is enabled this
trivial patch is required to update the comment in the Watchdog driver
to encompass Clocksource.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/watchdog/st_lpc_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index f32be15..6785afd 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -197,7 +197,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* LPC can either run in RTC or WDT mode */
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
 	if (mode != ST_LPC_MODE_WDT)
 		return -ENODEV;
 
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
