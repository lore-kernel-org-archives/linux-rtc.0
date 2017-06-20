Return-Path: <rtc-linux+bncBDKNBMNKRMJRBJG2UPFAKGQELD3BVLA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22f.google.com (mail-wr0-x22f.google.com. [2a00:1450:400c:c0c::22f])
        by gmr-mx.google.com with ESMTPS id m189si2689823wma.6.2017.06.20.02.38.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:43 -0700 (PDT)
Received: by mail-wr0-x22f.google.com with SMTP id y25so49021371wrd.2
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:43 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 51/51] power: suspend test: stop using rtc
 deprecated functions
Date: Tue, 20 Jun 2017 11:35:59 +0200
Message-Id: <1497951359-13334-52-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Pavel Machek <pavel@ucw.cz>
CC: Len Brown <len.brown@intel.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 kernel/power/suspend_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index 5db2170..334a893 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -71,7 +71,7 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 	static char info_test[] __initdata =
 		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
 
-	unsigned long		now;
+	unsigned long long		now;
 	struct rtc_wkalrm	alm;
 	int			status;
 
@@ -82,10 +82,10 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 		printk(err_readtime, dev_name(&rtc->dev), status);
 		return;
 	}
-	rtc_tm_to_time(&alm.time, &now);
+	now = rtc_tm_to_time64(&alm.time);
 
 	memset(&alm, 0, sizeof alm);
-	rtc_time_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
+	rtc_time64_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
 	alm.enabled = true;
 
 	status = rtc_set_alarm(rtc, &alm);
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
