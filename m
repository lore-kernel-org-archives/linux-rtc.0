Return-Path: <rtc-linux+bncBC4IFTUFXEFBBUVG37DAKGQE6WWQYIQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wr0-x233.google.com (mail-wr0-x233.google.com. [2a00:1450:400c:c0c::233])
        by gmr-mx.google.com with ESMTPS id x188si437092wmx.0.2017.03.26.07.42.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 07:42:25 -0700 (PDT)
Received: by mail-wr0-x233.google.com with SMTP id w11so10663938wrc.3
        for <rtc-linux@googlegroups.com>; Sun, 26 Mar 2017 07:42:25 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 0/5] Convert to use devm_*() for amba attached modules
Date: Sun, 26 Mar 2017 22:41:49 +0800
Message-Id: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

When review device driver modules which attach to amba bus, found
several modules are not using devm_*() apis to manage resource. As
result, some drivers have memory leakage or missing iomem unmapping
when rmmod module. And the code has many "goto" tags to handle
different failures.

So this patch series is to convert to use devm_*() for moudules which
are attached to amba bus to manage resource and get more robust and
neat code.

Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
verified on 96boards Hikey. Other patches can pass building but have
not really tested on hardware.


Leo Yan (5):
  Input: ambakmi - Convert to use devm_*()
  drivers/rtc/rtc-pl030.c: Convert to use devm_*()
  drivers/rtc/rtc-pl031.c: Convert to use devm_*()
  vfio: platform: Convert to use devm_*()
  ALSA: AACI: Convert to use devm_ioremap_resource()

 drivers/input/serio/ambakmi.c     | 44 +++++++----------------------
 drivers/rtc/rtc-pl030.c           | 49 ++++++++------------------------
 drivers/rtc/rtc-pl031.c           | 59 ++++++++++-----------------------------
 drivers/vfio/platform/vfio_amba.c | 25 ++++++-----------
 sound/arm/aaci.c                  | 21 ++++----------
 5 files changed, 51 insertions(+), 147 deletions(-)

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
