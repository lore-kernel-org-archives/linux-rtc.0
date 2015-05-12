Return-Path: <rtc-linux+bncBDA7X7F2WUEBB7HRY6VAKGQETVYTRSI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com. [74.125.82.51])
        by gmr-mx.google.com with ESMTPS id t6si110736wiz.0.2015.05.12.05.58.35
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 05:58:35 -0700 (PDT)
Received: by mail-wg0-f51.google.com with SMTP id d10so6359630wgn.2
        for <rtc-linux@googlegroups.com>; Tue, 12 May 2015 05:58:35 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 07/12] rtc: st: Update IP layout information to
 include Clocksource
Date: Tue, 12 May 2015 13:58:15 +0100
Message-Id: <1431435500-22899-8-git-send-email-lee.jones@linaro.org>
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
trivial patch is required to update the comment in the RTC driver to
encompass Clocksource.

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/rtc/rtc-st-lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 3f9d0ac..74c0a33 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -208,7 +208,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* LPC can either run in RTC or WDT mode */
+	/* LPC can either run as a Clocksource or in RTC or WDT mode */
 	if (mode != ST_LPC_MODE_RTC)
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
