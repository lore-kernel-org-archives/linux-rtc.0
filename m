Return-Path: <rtc-linux+bncBC4IFTUFXEFBB3WY4GWQKGQE5KWON2Q@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com. [209.85.220.44])
        by gmr-mx.google.com with ESMTPS id x3si3937060pdh.2.2015.07.28.23.02.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 23:02:22 -0700 (PDT)
Received: by pabkd10 with SMTP id kd10so82126922pab.2
        for <rtc-linux@googlegroups.com>; Tue, 28 Jul 2015 23:02:22 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Deepak Saxena <dsaxena@plexity.net>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in init flow
Date: Wed, 29 Jul 2015 14:02:01 +0800
Message-Id: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
the data register (DR) will read back as value zero. So the suspend
test code will set the match register (MR) for 10 seconds' timeout; But
there have chance later will read back some random values from DR
register; So finally miss with match value and will not trigger
waken up event anymore.

This issue can be dismissed by reset registers in initialization flow;
And this code have no harm for ST's variant.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..01768de 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -345,6 +345,12 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
 	dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
 
+	/* Init registers */
+	writel(0x0, ldata->base + RTC_LR);
+	writel(0x0, ldata->base + RTC_DR);
+	writel(0x0, ldata->base + RTC_IMSC);
+	writel(RTC_BIT_AI, ldata->base + RTC_ICR);
+
 	data = readl(ldata->base + RTC_CR);
 	/* Enable the clockwatch on ST Variants */
 	if (vendor->clockwatch)
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
