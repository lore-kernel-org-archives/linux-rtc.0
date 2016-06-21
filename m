Return-Path: <rtc-linux+bncBDKOBWPM5ABRBYOWUO5QKGQEJLX2F7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com. [2607:f8b0:400e:c03::241])
        by gmr-mx.google.com with ESMTPS id un17si5444521pab.0.2016.06.21.00.23.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 00:23:13 -0700 (PDT)
Received: by mail-pa0-x241.google.com with SMTP id fg1so738933pad.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 00:23:13 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: rtc-linux@googlegroups.com
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	cphealy@gmail.com
Subject: [rtc-linux] [PATCH v2 17/17] RTC: rtctest: Change no IRQ detection
 for RTC_IRQP_SET
Date: Tue, 21 Jun 2016 00:22:50 -0700
Message-Id: <1466493770-11895-16-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493770-11895-1-git-send-email-andrew.smirnov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

A call to ioctl(..., RTC_IRQP_SET, ...) should never result in
ENOTTY. All new style RTC drivers implement it and all of the old style
drivers return EINVAL when they don't support periodic IRQs.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 tools/testing/selftests/timers/rtctest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index 97beadf..4230d30 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -218,7 +218,7 @@ test_PIE:
 		retval = ioctl(fd, RTC_IRQP_SET, tmp);
 		if (retval == -1) {
 			/* not all RTCs can change their periodic IRQ rate */
-			if (errno == ENOTTY) {
+			if (errno == EINVAL) {
 				fprintf(stderr,
 					"\n...Periodic IRQ rate is fixed\n");
 				goto done;
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
