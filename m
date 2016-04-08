Return-Path: <rtc-linux+bncBD7N3SEV2QCRBHGKTW4AKGQETCOX67A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from vk1046.megiteam.com.pl (2780.rev.megiteam.pl. [91.227.39.128])
        by gmr-mx.google.com with ESMTP id 71si80901wmp.0.2016.04.08.01.00.28
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Apr 2016 01:00:28 -0700 (PDT)
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Tony Lindgren <tony@atomide.com>,
	Keerthy <j-keerthy@ti.com>,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [rtc-linux] [PATCH v3] rtc: omap: Support ext_wakeup configuration
Date: Fri,  8 Apr 2016 09:58:15 +0200
Message-Id: <1460102296-23304-1-git-send-email-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This is third approach for adding support of ext_wakeup configuration
in OMAP RTC.
Developed and tested on ChiliBoard (am335x) using v4.6-rc2.

Changes v2 -> v3:
 * Use gpiochip_request_own_desc() instead of gpiod_get_array() to make
   it possible to rmmod and insmod module (as suggested by Grygorii
   Strashko)
 * Go a little lower level, so the gpio number and active_low flag
   (present in device-tree bindings) are not hidden by gpiolib
   implementation

Changes v1 -> v2:
 * Use gpiochip implementation to utilize existing device-tree bindings
   (as suggested by Tony Lindgren)

Marcin Niestroj (1):
  rtc: omap: Support ext_wakeup configuration

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  18 +-
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-omap.c                             | 187 ++++++++++++++++++++-
 3 files changed, 204 insertions(+), 3 deletions(-)

-- 
2.8.0

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
