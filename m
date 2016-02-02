Return-Path: <rtc-linux+bncBD2OLRXW4ABBB4G5YK2QKGQEH6S7Z4Y@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id tn7si169085pac.1.2016.02.02.05.28.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 05:28:15 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [rtc-linux] [PATCH 0/4] rtc: max77686: make max77686 rtc driver as IP driver
Date: Tue, 2 Feb 2016 18:46:48 +0530
Message-ID: <1454419012-18050-1-git-send-email-ldewangan@nvidia.com>
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

CC: Krzysztof Mazur <krzysiek@podlesie.net>
CC: Javier Martinez Canillas <javier@osg.samsung.com>

Laxman Dewangan (4):
  rtc: max77686: fix checkpatch error
  rtc: max77686: use rtc regmap to access RTC registers
  rtc: max77686: avoid reference of parent device info multiple palces
  rtc: max77686: move initialisation of rtc regmap, irq chip locally

 drivers/mfd/max77686.c               |  82 +---------
 drivers/rtc/Kconfig                  |   7 +-
 drivers/rtc/rtc-max77686.c           | 295 ++++++++++++++++++++++++++++-------
 include/linux/mfd/max77686-private.h |  16 --
 4 files changed, 244 insertions(+), 156 deletions(-)

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
