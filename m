Return-Path: <rtc-linux+bncBDKNBMNKRMJRBTVQS7FQKGQEGZOE2SI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id j203si426280wmg.1.2017.07.12.01.05.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 01:05:33 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id 77so22548680wrb.1
        for <rtc-linux@googlegroups.com>; Wed, 12 Jul 2017 01:05:33 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v2 15/22] rtc: rs5c348: stop using rtc deprecated functions
Date: Wed, 12 Jul 2017 10:04:35 +0200
Message-Id: <1499846682-14093-16-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/rtc/rtc-rs5c348.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 9a30698..f82c0bc 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -137,7 +137,7 @@ struct rs5c348_plat_data {
 
 	if (rtc_valid_tm(tm) < 0) {
 		dev_err(&spi->dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, tm);
+		rtc_time64_to_tm(0, tm);
 	}
 
 	return 0;
@@ -183,7 +183,7 @@ static int rs5c348_probe(struct spi_device *spi)
 			dev_warn(&spi->dev, "voltage-low detected.\n");
 		if (ret & RS5C348_BIT_XSTP)
 			dev_warn(&spi->dev, "oscillator-stop detected.\n");
-		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
+		rtc_time64_to_tm(0, &tm);	/* 1970/1/1 */
 		ret = rs5c348_rtc_set_time(&spi->dev, &tm);
 		if (ret < 0)
 			goto kfree_exit;
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
