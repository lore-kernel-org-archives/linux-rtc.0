Return-Path: <rtc-linux+bncBDKNBMNKRMJRBE62UPFAKGQEWPRBM5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id o27si2850455wmi.4.2017.06.20.02.38.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:26 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id x70so15789124wme.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:26 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 41/51] rtc: stk17ta8: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:49 +0200
Message-Id: <1497951359-13334-42-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-stk17ta8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index a456cb6..5a0dca9 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -131,7 +131,7 @@ static int stk17ta8_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	if (rtc_valid_tm(tm) < 0) {
 		dev_err(dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, tm);
+		rtc_time64_to_tm(0, tm);
 	}
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
