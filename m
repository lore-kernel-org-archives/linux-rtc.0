Return-Path: <rtc-linux+bncBC4IFTUFXEFBBV5G37DAKGQEPDJIM5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x232.google.com (mail-wr0-x232.google.com. [2a00:1450:400c:c0c::232])
        by gmr-mx.google.com with ESMTPS id e72si783859wma.0.2017.03.26.07.42.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:30 -0700 (PDT)
Received: by mail-wr0-x232.google.com with SMTP id u1so22272177wra.2
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:30 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:50 +0800
Message-Id: <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
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

This patch also fixes the memory leakage for 'kmi->io' when remove
module.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/input/serio/ambakmi.c | 44 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index c6606ca..d4814be 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -112,19 +112,11 @@ static int amba_kmi_probe(struct amba_device *dev,
 {
 	struct amba_kmi_port *kmi;
 	struct serio *io;
-	int ret;
-
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
-	kmi = kzalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
-	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!kmi || !io) {
-		ret = -ENOMEM;
-		goto out;
-	}
 
+	kmi = devm_kzalloc(&dev->dev, sizeof(*kmi), GFP_KERNEL);
+	io  = devm_kzalloc(&dev->dev, sizeof(*io), GFP_KERNEL);
+	if (!kmi || !io)
+		return -ENOMEM;
 
 	io->id.type	= SERIO_8042;
 	io->write	= amba_kmi_write;
@@ -136,31 +128,19 @@ static int amba_kmi_probe(struct amba_device *dev,
 	io->dev.parent	= &dev->dev;
 
 	kmi->io		= io;
-	kmi->base	= ioremap(dev->res.start, resource_size(&dev->res));
-	if (!kmi->base) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	kmi->base	= devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(kmi->base))
+		return PTR_ERR(kmi->base);
 
-	kmi->clk = clk_get(&dev->dev, "KMIREFCLK");
-	if (IS_ERR(kmi->clk)) {
-		ret = PTR_ERR(kmi->clk);
-		goto unmap;
-	}
+	kmi->clk = devm_clk_get(&dev->dev, "KMIREFCLK");
+	if (IS_ERR(kmi->clk))
+		return PTR_ERR(kmi->clk);
 
 	kmi->irq = dev->irq[0];
 	amba_set_drvdata(dev, kmi);
 
 	serio_register_port(kmi->io);
 	return 0;
-
- unmap:
-	iounmap(kmi->base);
- out:
-	kfree(kmi);
-	kfree(io);
-	amba_release_regions(dev);
-	return ret;
 }
 
 static int amba_kmi_remove(struct amba_device *dev)
@@ -168,10 +148,6 @@ static int amba_kmi_remove(struct amba_device *dev)
 	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
 
 	serio_unregister_port(kmi->io);
-	clk_put(kmi->clk);
-	iounmap(kmi->base);
-	kfree(kmi);
-	amba_release_regions(dev);
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
