Return-Path: <rtc-linux+bncBDHL7L6H24MBBM7Q2OWAKGQE6JWA2ZI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com. [2607:f8b0:400e:c02::22c])
        by gmr-mx.google.com with ESMTPS id w7si528455pdq.0.2015.07.02.01.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2015 01:37:07 -0700 (PDT)
Received: by mail-pd0-x22c.google.com with SMTP id ci14so41260368pdb.2
        for <rtc-linux@googlegroups.com>; Thu, 02 Jul 2015 01:37:07 -0700 (PDT)
From: Wei-Ning Huang <wnhuang@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Wei-Ning Huang <wnhuang@google.com>,
	eddie.huang@mediatek.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH] rtc-mt6397: enable wakeup before registering rtc device
Date: Thu,  2 Jul 2015 16:36:56 +0800
Message-Id: <1435826216-11982-1-git-send-email-wnhuang@google.com>
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

rtc_sysfs_add_device checks if device can wakeup before creating the
wakealarm file in sysfs. Thus the driver must set wakeup capability
before registering the rtc device.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
---
 drivers/rtc/rtc-mt6397.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c0090b6..eab230b 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -343,6 +343,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		goto out_dispose_irq;
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
 					   &mtk_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
@@ -351,8 +353,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		goto out_free_irq;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
-
 	return 0;
 
 out_free_irq:
-- 
2.1.2

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
