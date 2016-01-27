Return-Path: <rtc-linux+bncBAABBX7WUC2QKGQEYE4SNMI@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si473272pac.2.2016.01.26.19.37.02
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Jan 2016 19:37:02 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Andi Shyti <andi.shyti@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH v4 00/10] rtc: max77686: Extend driver and add
 max77802 support
Date: Wed, 27 Jan 2016 00:36:36 -0300
Message-Id: <1453865806-4661-1-git-send-email-javier@osg.samsung.com>
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

This is a v4 of a series that do this, that address issues pointed out
in the latest version. The v1, v2 and v3 can be found at [1], [2], [3].

I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
a max77802 PMIC and the RTC was working correctly. Krzysztof Kozlowski
tested v3 on an max77686 but this version only has cosmetic changes so
it should not cause any functionality changes.

[0]: http://www.spinics.net/lists/devicetree/msg110348.html
[1]: https://lwn.net/Articles/672568/
[2]: https://lkml.org/lkml/2016/1/25/767
[3]: https://lkml.org/lkml/2016/1/26/787

Changes in v4:
- Add Andi Shyti's Reviewed-by to patch #1.
- Add Andi Shyti's Reviewed-by to patch #2.
- Add Andi Shyti's Reviewed-by to patch #3.
- Add Andi Shyti's Reviewed-by to patch #4.
- Add Krzysztof Kozlowski's Reviewed-by and Tested-by tags to patch #4.
- Add Krzysztof Kozlowski's Reviewed-by and Tested-by tags to patch #5.
- Add Krzysztof Kozlowski's Tested-by tag to patch #6.
- Add Andi Shyti's Reviewed-by tag to patch #6.
- Reverse alarm enable reg check logic. Suggeted by Krzysztof Kozlowski.
- Return early to avoid an else statement. Suggested by Andi Shyti.
- Use dev_err() instead of dev_warn() and change message.
  Suggested by Krzysztof Kozlowski and Andi Shyti.
- Change subject line and commit message of patch #7.
- Removed Laxman Dewangan's Acked-by tag since the patch changed.
- Add Krzysztof Kozlowski's Tested-by tag to patch #8.
- Add Andi Shyti's Reviewed-by tag to patch #8.

Changes in v3:
- Add Krzysztof Kozlowski's Reviewed-by and Tested-by to patch #1.
- Add Laxman Dewangan's Acked-by tag to patch #1.
- Add Krzysztof Kozlowski's Tested-by tag to patch #2.
- Add Laxman Dewangan's Acked-by tag to patch #2.
- Use ARRAY_SIZE() in all places. Suggested by Laxman Dewangan.
- Add Krzysztof Kozlowski's Tested-by tag to patch #3.
- Add Laxman Dewangan's Acked-by tag to patch #3.
- Fix max77686 delay. Suggested by Krzysztof Kozlowski.
- Assign mask to u8 instead of int. Suggested by Krzysztof Kozlowski.
- Add Laxman Dewangan's Acked-by tag to patch #4.
- Add Laxman Dewangan's Acked-by tag to patch #5.
- Add Laxman Dewangan's Acked-by tag to patch #6.
- Add Laxman Dewangan's Acked-by tag to patch #7.
- Add Laxman Dewangan's Acked-by tag to patch #8.

Changes in v2:
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #2.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #3.
- Fix typo error in changelog. Suggested by Krzysztof Kozlowski.
- Add a max77686 prefix to rtc_driver_data. Suggested by Krzysztof Kozlowski.
- Comment about the .delay and .mask fields. Suggested by Krzysztof Kozlowski.
- Change .mask type to u8. Suggested by Krzysztof Kozlowski.
- Make .drv_data field const. Suggested by Krzysztof Kozlowski.
- Don't cast to drop const on .drv_data asign. Suggested by Krzysztof Kozlowski.
- Use platform_get_device_id() macro. Suggested by Krzysztof Kozlowski.
- Rename rtc_reg to max77686_rtc_reg_offset. Suggested by Krzysztof Kozlowski.
- Comment what's mapped by max77686_map. Suggested by Krzysztof Kozlowski.
- Use max77686_map array indexes in init. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_UPDATE1 since is not used by neither max77686 nor max77802.
- Add a MAX77802 prefix to ALARM_ENABLE_VALUE. Suggested by Krzysztof Kozlowski.
- Rename .rtcae to .alarm_enable_reg and .rtcrm to .separate_i2c_addr.
  Suggested by Krzysztof Kozlowski.
- Don't use func and LINE in error messages. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_AE2 since is not used by neither max77686 nor max77802.
- Check if REG_RTC_AE1 has a valid address before accessing it.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #8.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #9.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #10.

Javier Martinez Canillas (10):
  rtc: max77686: Fix max77686_rtc_read_alarm() return value
  rtc: max77686: Use ARRAY_SIZE() instead of current array length
  rtc: max77686: Use usleep_range() instead of msleep()
  rtc: max77686: Use a driver data struct instead hard-coded values
  rtc: max77686: Add an indirection level to access RTC registers
  rtc: max77686: Add max77802 support
  rtc: max77686: Fix unsupported year message
  rtc: Remove Maxim 77802 driver
  ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
  ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol

 arch/arm/configs/exynos_defconfig   |   1 -
 arch/arm/configs/multi_v7_defconfig |   1 -
 drivers/rtc/Kconfig                 |  10 -
 drivers/rtc/Makefile                |   1 -
 drivers/rtc/rtc-max77686.c          | 325 ++++++++++++++++++-----
 drivers/rtc/rtc-max77802.c          | 502 ------------------------------------
 6 files changed, 264 insertions(+), 576 deletions(-)
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
