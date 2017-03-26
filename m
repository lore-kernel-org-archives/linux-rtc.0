Return-Path: <rtc-linux+bncBC4IFTUFXEFBBZ5G37DAKGQE35PKGBI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x232.google.com (mail-wr0-x232.google.com. [2a00:1450:400c:c0c::232])
        by gmr-mx.google.com with ESMTPS id e72si783859wma.0.2017.03.26.07.42.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:47 -0700 (PDT)
Received: by mail-wr0-x232.google.com with SMTP id u1so22272177wra.2
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:47 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 4/5] vfio: platform: Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:53 +0800
Message-Id: <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
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

This patch also renames amba_id structure, the old code used some code
which directly copied from other driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/vfio/platform/vfio_amba.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index 31372fb..433db1f 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -53,15 +53,14 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	struct vfio_platform_device *vdev;
 	int ret;
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	vdev = devm_kzalloc(&adev->dev, sizeof(*vdev), GFP_KERNEL);
 	if (!vdev)
 		return -ENOMEM;
 
-	vdev->name = kasprintf(GFP_KERNEL, "vfio-amba-%08x", adev->periphid);
-	if (!vdev->name) {
-		kfree(vdev);
+	vdev->name = devm_kasprintf(&adev->dev, GFP_KERNEL,
+				    "vfio-amba-%08x", adev->periphid);
+	if (!vdev->name)
 		return -ENOMEM;
-	}
 
 	vdev->opaque = (void *) adev;
 	vdev->flags = VFIO_DEVICE_FLAGS_AMBA;
@@ -71,11 +70,6 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 	vdev->reset_required = false;
 
 	ret = vfio_platform_probe_common(vdev, &adev->dev);
-	if (ret) {
-		kfree(vdev->name);
-		kfree(vdev);
-	}
-
 	return ret;
 }
 
@@ -84,25 +78,22 @@ static int vfio_amba_remove(struct amba_device *adev)
 	struct vfio_platform_device *vdev;
 
 	vdev = vfio_platform_remove_common(&adev->dev);
-	if (vdev) {
-		kfree(vdev->name);
-		kfree(vdev);
+	if (vdev)
 		return 0;
-	}
 
 	return -EINVAL;
 }
 
-static struct amba_id pl330_ids[] = {
+static struct amba_id vfio_ids[] = {
 	{ 0, 0 },
 };
 
-MODULE_DEVICE_TABLE(amba, pl330_ids);
+MODULE_DEVICE_TABLE(amba, vfio_ids);
 
 static struct amba_driver vfio_amba_driver = {
 	.probe = vfio_amba_probe,
 	.remove = vfio_amba_remove,
-	.id_table = pl330_ids,
+	.id_table = vfio_ids,
 	.drv = {
 		.name = "vfio-amba",
 		.owner = THIS_MODULE,
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
