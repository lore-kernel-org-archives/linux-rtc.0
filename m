Return-Path: <rtc-linux+bncBDRYNGFX7EDBBC7L2HAAKGQEUXJXDEQ@googlegroups.com>
MIME-Version: 1.0
Received: from bombadil.infradead.org (bombadil.infradead.org. [2001:1868:205::9])
        by gmr-mx.google.com with ESMTPS id z76si4287251pff.1.2016.10.29.03.10.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2016 03:10:18 -0700 (PDT)
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mark Godfrey <mark.godfrey@stericsson.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 1/2] ABI: rtc-ab8500: fix rtc_calibration documentation
Date: Sat, 29 Oct 2016 08:10:02 -0200
Message-Id: <364a36215c44e0c2785911e9d9259cd866283cb9.1477735797.git.mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The "What:" field at the ABI should describe the location of
the ABI, e. g. the position under a mounted sysfs.

Fix it.

Cc: Mark Godfrey <mark.godfrey@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: rtc-linux@googlegroups.com
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 .../ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration b/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
index 4cf1e72222d9..ec950c93e5c6 100644
--- a/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
+++ b/Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-rtc_calibration
@@ -1,8 +1,9 @@
-What:           Attribute for calibrating ST-Ericsson AB8500 Real Time Clock
+What:           /sys/class/rtc/rtc0/device/rtc_calibration
 Date:           Oct 2011
 KernelVersion:  3.0
 Contact:        Mark Godfrey <mark.godfrey@stericsson.com>
-Description:    The rtc_calibration attribute allows the userspace to
+Description:    Attribute for calibrating ST-Ericsson AB8500 Real Time Clock
+		The rtc_calibration attribute allows the userspace to
                 calibrate the AB8500.s 32KHz Real Time Clock.
                 Every 60 seconds the AB8500 will correct the RTC's value
                 by adding to it the value of this attribute.
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
