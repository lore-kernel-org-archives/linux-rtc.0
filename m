Return-Path: <rtc-linux+bncBD76TE7NVICBBQMDW3BAKGQETONB5TI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id o24si8099305pfj.2.2016.12.11.08.41.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Dec 2016 08:41:37 -0800 (PST)
Received: by mail-pf0-x242.google.com with SMTP id y68so3303789pfb.1
        for <rtc-linux@googlegroups.com>; Sun, 11 Dec 2016 08:41:37 -0800 (PST)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [V1] rtc:rtc-vr41xx :- Retunr error is not correct in rtc_probe
Date: Sun, 11 Dec 2016 22:11:24 +0530
Message-Id: <1481474484-1316-1-git-send-email-arvind.yadav.cs@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Here, rtc_probe is returning EBUSY at any error case.
It should return ENOMEM insted of EBUSY.

-EBUSY A resource you need is not avaialable.

-ENOMEM This is used to signify lack of memory resources.

-ENODEV This is used when no device is available.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-vr41xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index e1b86bb..e666d8e 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -292,21 +292,21 @@ static int rtc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-		return -EBUSY;
+		return -ENOMEM;
 
 	rtc1_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!rtc1_base)
-		return -EBUSY;
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
-		retval = -EBUSY;
+		retval = -ENOMEM;
 		goto err_rtc1_iounmap;
 	}
 
 	rtc2_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!rtc2_base) {
-		retval = -EBUSY;
+		retval = -ENOMEM;
 		goto err_rtc1_iounmap;
 	}
 
@@ -342,7 +342,7 @@ static int rtc_probe(struct platform_device *pdev)
 
 	pie_irq = platform_get_irq(pdev, 1);
 	if (pie_irq <= 0) {
-		retval = -EBUSY;
+		retval = -ENODEV;
 		goto err_iounmap_all;
 	}
 
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
