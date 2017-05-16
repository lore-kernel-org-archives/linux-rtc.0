Return-Path: <rtc-linux+bncBCOML4NU3EDRBO7Q5PEAKGQEOVGIJ4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id n5si165312wmg.0.2017.05.16.06.01.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 06:01:46 -0700 (PDT)
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Chao Xie <chao.xie@marvell.com>,
 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [rtc-linux] [PATCH] rtc-88pm80x: Delete an error message for a failed
 memory allocation in pm80x_rtc_probe()
Message-ID: <79e5d766-2e58-4cea-7812-ea45995873ac@users.sourceforge.net>
Date: Tue, 16 May 2017 15:01:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 14:54:13 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/rtc/rtc-88pm80x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 466bf7f9a285..ae0e2561ecfa 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -266,10 +266,8 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 
 	if (!pdata) {
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&pdev->dev, "failed to allocate memory\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
 	}
 
 	info =
-- 
2.13.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
