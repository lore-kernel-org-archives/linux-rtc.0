Return-Path: <rtc-linux+bncBDKNBMNKRMJRBWOZUPFAKGQERUNJICA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22e.google.com (mail-wr0-x22e.google.com. [2a00:1450:400c:c0c::22e])
        by gmr-mx.google.com with ESMTPS id f136si2017996wmf.6.2017.06.20.02.37.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:28 -0700 (PDT)
Received: by mail-wr0-x22e.google.com with SMTP id c11so32926708wrc.3
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:28 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Baruch Siach <baruch@tkos.co.il>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 17/51] rtc: digicolor: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:25 +0200
Message-Id: <1497951359-13334-18-git-send-email-benjamin.gaignard@linaro.org>
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
CC: Baruch Siach <baruch@tkos.co.il>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/rtc/rtc-digicolor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index b253bf1..01b0fe8 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -106,7 +106,7 @@ static int dc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int dc_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int dc_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
 	struct dc_rtc *rtc = dev_get_drvdata(dev);
 
@@ -161,7 +161,7 @@ static int dc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static const struct rtc_class_ops dc_rtc_ops = {
 	.read_time		= dc_rtc_read_time,
-	.set_mmss		= dc_rtc_set_mmss,
+	.set_mmss64		= dc_rtc_set_mmss64,
 	.read_alarm		= dc_rtc_read_alarm,
 	.set_alarm		= dc_rtc_set_alarm,
 	.alarm_irq_enable	= dc_rtc_alarm_irq_enable,
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
