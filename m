Return-Path: <rtc-linux+bncBC4IFTUFXEFBBYVG37DAKGQE6FFS3CA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22c.google.com (mail-wr0-x22c.google.com. [2a00:1450:400c:c0c::22c])
        by gmr-mx.google.com with ESMTPS id e72si784629wma.0.2017.03.26.07.42.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:41 -0700 (PDT)
Received: by mail-wr0-x22c.google.com with SMTP id w43so11057061wrb.0
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:41 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [rtc-linux] [PATCH 3/5] drivers/rtc/rtc-pl031.c: Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:52 +0800
Message-Id: <1490539314-9681-4-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Convert driver to use devm_*() APIs so rely on driver model core layer
to manage resources. This eliminates error path boilerplate and makes
code neat.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 59 +++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e1..1699a17 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -304,15 +304,8 @@ static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int pl031_remove(struct amba_device *adev)
 {
-	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
-
 	dev_pm_clear_wake_irq(&adev->dev);
 	device_init_wakeup(&adev->dev, false);
-	free_irq(adev->irq[0], ldata);
-	rtc_device_unregister(ldata->rtc);
-	iounmap(ldata->base);
-	kfree(ldata);
-	amba_release_regions(adev);
 
 	return 0;
 }
@@ -325,23 +318,15 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	struct rtc_class_ops *ops = &vendor->ops;
 	unsigned long time, data;
 
-	ret = amba_request_regions(adev, NULL);
-	if (ret)
-		goto err_req;
+	ldata = devm_kzalloc(&adev->dev, sizeof(*ldata), GFP_KERNEL);
+	if (!ldata)
+		return -ENOMEM;
 
-	ldata = kzalloc(sizeof(struct pl031_local), GFP_KERNEL);
-	if (!ldata) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	ldata->vendor = vendor;
 
-	ldata->base = ioremap(adev->res.start, resource_size(&adev->res));
-
-	if (!ldata->base) {
-		ret = -ENOMEM;
-		goto out_no_remap;
-	}
+	ldata->base = devm_ioremap_resource(&adev->dev, &adev->res);
+	if (IS_ERR(ldata->base))
+		return PTR_ERR(ldata->base);
 
 	amba_set_drvdata(adev, ldata);
 
@@ -374,32 +359,18 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	device_init_wakeup(&adev->dev, true);
-	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
-					THIS_MODULE);
-	if (IS_ERR(ldata->rtc)) {
-		ret = PTR_ERR(ldata->rtc);
-		goto out_no_rtc;
-	}
+	ldata->rtc = devm_rtc_device_register(&adev->dev, "pl031", ops,
+					      THIS_MODULE);
+	if (IS_ERR(ldata->rtc))
+		return PTR_ERR(ldata->rtc);
+
+	ret = devm_request_irq(&adev->dev, adev->irq[0], pl031_interrupt,
+			       vendor->irqflags, "rtc-pl031", ldata);
+	if (ret)
+		return ret;
 
-	if (request_irq(adev->irq[0], pl031_interrupt,
-			vendor->irqflags, "rtc-pl031", ldata)) {
-		ret = -EIO;
-		goto out_no_irq;
-	}
 	dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	return 0;
-
-out_no_irq:
-	rtc_device_unregister(ldata->rtc);
-out_no_rtc:
-	iounmap(ldata->base);
-out_no_remap:
-	kfree(ldata);
-out:
-	amba_release_regions(adev);
-err_req:
-
-	return ret;
 }
 
 /* Operations for the original ARM version */
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
