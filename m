Return-Path: <rtc-linux+bncBDKNBMNKRMJRBHW2UPFAKGQE2OKORGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id w136si3550808wmf.3.2017.06.20.02.38.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:38 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id d64so23691467wmf.1
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:38 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 48/51] rtc: vr41xx: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:56 +0200
Message-Id: <1497951359-13334-49-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-vr41xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index e1b86bb..db51ed6 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -138,12 +138,12 @@ static void vr41xx_rtc_release(struct device *dev)
 
 static int vr41xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 {
-	unsigned long epoch_sec, elapsed_sec;
+	unsigned long long epoch_sec, elapsed_sec;
 
 	epoch_sec = mktime(epoch, 1, 1, 0, 0, 0);
 	elapsed_sec = read_elapsed_second();
 
-	rtc_time_to_tm(epoch_sec + elapsed_sec, time);
+	rtc_time64_to_tm(epoch_sec + elapsed_sec, time);
 
 	return 0;
 }
@@ -175,7 +175,7 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 	spin_unlock_irq(&rtc_lock);
 
-	rtc_time_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
+	rtc_time64_to_tm((high << 17) | (mid << 1) | (low >> 15), time);
 
 	return 0;
 }
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
