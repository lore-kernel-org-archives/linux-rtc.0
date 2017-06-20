Return-Path: <rtc-linux+bncBDKNBMNKRMJRBU6ZUPFAKGQEU5AFH3I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x231.google.com (mail-wr0-x231.google.com. [2a00:1450:400c:c0c::231])
        by gmr-mx.google.com with ESMTPS id j75si2789094wmj.1.2017.06.20.02.37.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:23 -0700 (PDT)
Received: by mail-wr0-x231.google.com with SMTP id r103so88485270wrb.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:23 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Support Opensource <support.opensource@diasemi.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 14/51] rtc: da9063: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:22 +0200
Message-Id: <1497951359-13334-15-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Support Opensource <support.opensource@diasemi.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-da9052.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 4273377..99a0489 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -104,17 +104,15 @@ static int da9052_read_alarm(struct da9052_rtc *rtc, struct rtc_time *rtc_tm)
 static int da9052_set_alarm(struct da9052_rtc *rtc, struct rtc_time *rtc_tm)
 {
 	struct da9052 *da9052 = rtc->da9052;
-	unsigned long alm_time;
+	unsigned long long alm_time;
 	int ret;
 	uint8_t v[3];
 
-	ret = rtc_tm_to_time(rtc_tm, &alm_time);
-	if (ret != 0)
-		return ret;
+	alm_time = rtc_tm_to_time64(rtc_tm);
 
 	if (rtc_tm->tm_sec > 0) {
 		alm_time += 60 - rtc_tm->tm_sec;
-		rtc_time_to_tm(alm_time, rtc_tm);
+		rtc_time64_to_tm(alm_time, rtc_tm);
 	}
 	BUG_ON(rtc_tm->tm_sec); /* it will cause repeated irqs if not zero */
 
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
