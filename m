Return-Path: <rtc-linux+bncBDKNBMNKRMJRBS5QS7FQKGQEYZF74UY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x229.google.com (mail-wr0-x229.google.com. [2a00:1450:400c:c0c::229])
        by gmr-mx.google.com with ESMTPS id 2si383618wms.6.2017.07.12.01.05.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:30 -0700 (PDT)
Received: by mail-wr0-x229.google.com with SMTP id r103so22428407wrb.0
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:30 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 13/22] rtc: omap: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:33 +0200
Message-Id: <1499846682-14093-14-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
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

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 13f7cd1..8aa3957 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -432,7 +432,7 @@ static void omap_rtc_power_off(void)
 {
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
-	unsigned long now;
+	unsigned long long now;
 	u32 val;
 
 	rtc->type->unlock(rtc);
@@ -443,8 +443,8 @@ static void omap_rtc_power_off(void)
 	/* set alarm two seconds from now */
 	omap_rtc_read_time_raw(rtc, &tm);
 	bcd2tm(&tm);
-	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
+	now = rtc_tm_to_time64(&tm);
+	rtc_time64_to_tm(now + 2, &tm);
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
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
