Return-Path: <rtc-linux+bncBDKNBMNKRMJRBT5QS7FQKGQEOBYAEAQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id r131si415853wmg.3.2017.07.12.01.05.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:35 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id k67so22299460wrc.2
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:35 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 16/22] rtc: sh: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:36 +0200
Message-Id: <1499846682-14093-17-git-send-email-benjamin.gaignard@linaro.org>
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

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 6c2d398..f65da1e 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -694,7 +694,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 
 	/* reset rtc to epoch 0 if time is invalid */
 	if (rtc_read_time(rtc->rtc_dev, &r) < 0) {
-		rtc_time_to_tm(0, &r);
+		rtc_time64_to_tm(0, &r);
 		rtc_set_time(rtc->rtc_dev, &r);
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
