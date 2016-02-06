Return-Path: <rtc-linux+bncBD2OLRXW4ABBBYUP3C2QKGQEB3UFKIY@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si2806107pac.1.2016.02.06.06.49.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2016 06:49:06 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>, <broonie@kernel.org>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V4 0/6] rtc: max77686: make max77686 rtc driver as
 IP driver
Date: Sat, 6 Feb 2016 20:07:21 +0530
Message-ID: <1454769447-785-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Based on discussion on patch series of MAX77620 when adding separate
driver for max77620 RTC, it is discussed to reuse the max77686 driver
for all CHips MAX77802, MAX77686 and MAX77620. For this, the rtc-max77686
need to make as IP driver independent of their MFD parent driver.

This series makes the rtc-max77686 as independent driver from its 
parent. Required information is passed through the device parent
which is generic and does not depends on any max77686 specific
header ifnromation.

CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>

Changes from V1: 
- Added reviewed/tested by tag which we got from V1.
- Remove changes from Kconfig.
- Maintain all register definition in max77686 private header and remove
  the movement to rtc driver.
- Taken care of all comments on V1 from Krzysztof and Javier.

Changes from V2: 
- Fix the issue of crash in unbind.

Changes from V3:
- Fix suspend-resume after unbind/bind by unmapping virq in remove callback.

Laxman Dewangan (6):
  regmap: irq: add apis to unmap the mapped irq
  rtc: max77686: fix checkpatch error
  rtc: max77686: use rtc regmap to access RTC registers
  rtc: max77686: avoid reference of parent device info multiple places
  mfd: max77686: do not set i2c client data for rtc i2c client
  rtc: max77686: move initialisation of rtc regmap, irq chip locally

 drivers/base/regmap/regmap-irq.c     |  14 +++
 drivers/mfd/max77686.c               |  86 +-------------
 drivers/rtc/rtc-max77686.c           | 215 ++++++++++++++++++++++++++---------
 include/linux/mfd/max77686-private.h |   3 -
 include/linux/regmap.h               |   1 +
 5 files changed, 177 insertions(+), 142 deletions(-)

-- 
2.1.4

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
