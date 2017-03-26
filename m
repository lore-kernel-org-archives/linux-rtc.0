Return-Path: <rtc-linux+bncBC4IFTUFXEFBB3FG37DAKGQEOQWQKEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x232.google.com (mail-wr0-x232.google.com. [2a00:1450:400c:c0c::232])
        by gmr-mx.google.com with ESMTPS id e72si783859wma.0.2017.03.26.07.42.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:52 -0700 (PDT)
Received: by mail-wr0-x232.google.com with SMTP id u1so22272177wra.2
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:52 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 5/5] ALSA: AACI: Convert to use devm_ioremap_resource()
Date: Sun, 26 Mar 2017 22:41:54 +0800
Message-Id: <1490539314-9681-6-git-send-email-leo.yan@linaro.org>
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

Convert to use devm_ioremap_resource() in probe function, otherwise it's
missed to unremap this region if probe failed or rmmod module.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 sound/arm/aaci.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..2078568 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -990,19 +990,13 @@ static int aaci_probe(struct amba_device *dev,
 	struct aaci *aaci;
 	int ret, i;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
 	aaci = aaci_init_card(dev);
-	if (!aaci) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!aaci)
+		return -ENOMEM;
 
-	aaci->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!aaci->base) {
-		ret = -ENOMEM;
+	aaci->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(aaci->base)) {
+		ret = PTR_ERR(aaci->base);
 		goto out;
 	}
 
@@ -1064,9 +1058,7 @@ static int aaci_probe(struct amba_device *dev,
 	}
 
  out:
-	if (aaci)
-		snd_card_free(aaci->card);
-	amba_release_regions(dev);
+	snd_card_free(aaci->card);
 	return ret;
 }
 
@@ -1079,7 +1071,6 @@ static int aaci_remove(struct amba_device *dev)
 		writel(0, aaci->base + AACI_MAINCR);
 
 		snd_card_free(card);
-		amba_release_regions(dev);
 	}
 
 	return 0;
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
