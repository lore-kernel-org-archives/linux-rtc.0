Return-Path: <rtc-linux+bncBAABBN4B762AKGQEUV6BQOA@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id tn7si341584pac.1.2016.01.20.09.15.34
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jan 2016 09:15:34 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH 0/8] rtc: max77686: Extend driver and add max77802 support
Date: Wed, 20 Jan 2016 14:14:40 -0300
Message-Id: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello,

On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
we came to the conclusion that the max77686 and max77802 RTC are almost
the same with only a few differences so there shouldn't be two separate
drivers and is better to extend max77686 driver and delete rtc-max77802.

By making the driver more generic, other RTC IP blocks from Maxim PMICs
could be supported as well like the max77620.

Patches #1 is just a trivial cleanup.

Patch #2 allows to support RTCs that need a shorter delay when updating
the RTC.

Patch #3 adds a driver data structure to avoid hard-coding parameters
specific to a certain RTC such as the needed delay and RTC register mask.

Patch #4 changes the driver to use a mapping table instead of using the
max77686 registers offsets directly to allow supporting RTC with other
registers addresses and layout.

Patch #5 Adds support for max77802 to max77686 RTC driver and patch #6
removes the old driver since is not needed anymore.

Finally patch #7 and patch #8 removes the Kconfig symbol from defconfigs.

I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
a max77802 PMIC and the RTC was working correctly but I don't have a
machine with max77686 so I will really appreaciate if someone can test
that no regressions were introduced.

One thing that I'm not sure is how to handle bisectability, in patch #5
there will be two drivers that matches "rtc-max77802". So I don't know
if I should use a different platform_device_id name and change in the
same patch that max77802 is removed or if this is not a big deal so the
patches could stay as is.

I believe all patches should go through the RTC tree with proper acks or
wait until the RTC patches land to pick the defconfig changes.

[0]: http://www.spinics.net/lists/devicetree/msg110348.html


Javier Martinez Canillas (8):
  rtc: max77686: Use ARRAY_SIZE() instead of current array length
  rtc: max77686: Use usleep_range() instead of msleep()
  rtc: max77686: Use a driver data struct instead hard-coded values
  rtc: max77686: Add an indirection level to access RTC registers
  rtc: max77686: Add max77802 support
  rtc: Remove Maxim 77802 driver
  ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
  ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol

 arch/arm/configs/exynos_defconfig   |   1 -
 arch/arm/configs/multi_v7_defconfig |   1 -
 drivers/rtc/Kconfig                 |  10 -
 drivers/rtc/Makefile                |   1 -
 drivers/rtc/rtc-max77686.c          | 276 +++++++++++++++-----
 drivers/rtc/rtc-max77802.c          | 502 ------------------------------------
 6 files changed, 213 insertions(+), 578 deletions(-)
 delete mode 100644 drivers/rtc/rtc-max77802.c

-- 
2.5.0

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
