Return-Path: <rtc-linux+bncBC4IFTUFXEFBBXFG37DAKGQEEA5WEYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x22c.google.com (mail-wr0-x22c.google.com. [2a00:1450:400c:c0c::22c])
        by gmr-mx.google.com with ESMTPS id e72si784629wma.0.2017.03.26.07.42.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:36 -0700 (PDT)
Received: by mail-wr0-x22c.google.com with SMTP id w43so11057061wrb.0
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:36 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:51 +0800
Message-Id: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
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
 drivers/rtc/rtc-pl030.c | 49 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a9..372b1fd 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -102,49 +102,30 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	struct pl030_rtc *rtc;
 	int ret;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		goto err_req;
-
 	rtc = devm_kzalloc(&dev->dev, sizeof(*rtc), GFP_KERNEL);
-	if (!rtc) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	if (!rtc)
+		return -ENOMEM;
 
-	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!rtc->base) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	rtc->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
 
 	__raw_writel(0, rtc->base + RTC_CR);
 	__raw_writel(0, rtc->base + RTC_EOI);
 
 	amba_set_drvdata(dev, rtc);
 
-	ret = request_irq(dev->irq[0], pl030_interrupt, 0,
-			  "rtc-pl030", rtc);
+	ret = devm_request_irq(&dev->dev, dev->irq[0], pl030_interrupt, 0,
+			       "rtc-pl030", rtc);
 	if (ret)
-		goto err_irq;
+		return ret;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
-		goto err_reg;
-	}
+	rtc->rtc = devm_rtc_device_register(&dev->dev, "pl030", &pl030_ops,
+					    THIS_MODULE);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	return 0;
-
- err_reg:
-	free_irq(dev->irq[0], rtc);
- err_irq:
-	iounmap(rtc->base);
- err_rtc:
-	amba_release_regions(dev);
- err_req:
-	return ret;
 }
 
 static int pl030_remove(struct amba_device *dev)
@@ -152,12 +133,6 @@ static int pl030_remove(struct amba_device *dev)
 	struct pl030_rtc *rtc = amba_get_drvdata(dev);
 
 	writel(0, rtc->base + RTC_CR);
-
-	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
-	iounmap(rtc->base);
-	amba_release_regions(dev);
-
 	return 0;
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
