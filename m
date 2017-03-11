Return-Path: <rtc-linux+bncBCDY7V7TLQIKDWETYYCRUBD443QVS@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com. [2607:f8b0:400e:c05::243])
        by gmr-mx.google.com with ESMTPS id g82si2554985pfb.5.2017.03.11.22.35.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Mar 2017 22:35:13 -0800 (PST)
Received: by mail-pg0-x243.google.com with SMTP id 25so14781932pgy.3
        for <rtc-linux@googlegroups.com>; Sat, 11 Mar 2017 22:35:13 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: patches@opensource.wolfsonmicro.com,
	rtc-linux@googlegroups.com,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [rtc-linux] [PATCH] rtc: rtc-wm8350: Remove unused to_wm8350_from_rtc_dev
Date: Sat, 11 Mar 2017 15:42:13 +0900
Message-Id: <20170311064213.30752-1-iwamatsu@nigauri.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The to_wm8350_from_rtc_dev macro is not used by anything in the
rtc-wm8350 driver.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-wm8350.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index fa247deb9cf4..483c7993516b 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -30,8 +30,6 @@
 #define WM8350_SET_TIME_RETRIES	5
 #define WM8350_GET_TIME_RETRIES	5
 
-#define to_wm8350_from_rtc_dev(d) container_of(d, struct wm8350, rtc.pdev.dev)
-
 /*
  * Read current time and date in RTC
  */
-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
