Return-Path: <jy0922.shim@samsung.com>
From: Joonyoung Shim <jy0922.shim@samsung.com>
To: rtc-linux@googlegroups.com
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, alexandre.belloni@free-electrons.com,
 a.zummo@towertech.it, sbkim73@samsung.com, k.kozlowski@samsung.com,
 jy0922.shim@samsung.com
Subject: [PATCH v2] rtc: s5m: fix to update ctrl register
Date: Fri, 21 Aug 2015 18:43:41 +0900
Message-id: <1440150221-2609-1-git-send-email-jy0922.shim@samsung.com>
List-ID: <rtc-linux.googlegroups.com>

According to datasheet, the S2MPS13X and S2MPS14X should update write
buffer via setting WUDR bit to high after ctrl register is written.

If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
tools/testing/selftests/timers/rtctest.c test program and hour format is
used to 12 hour mode in Odroid-XU3 board.

One more issue is the RTC doesn't keep time on Odroid-XU3 board when i
turn on board after power off even if RTC battery is connected. It can
be solved as setting WUDR & RUDR bits to high at the same time after
RTC_CTRL register is written. It's same with condition of only writing
ALARM registers, so this is for only S2MPS14 and we should set WUDR &
A_UDR bits to high on S2MPS13.

I can't find any reasonable description about this like fix from
datasheet, but can find similar codes from rtc driver source of
hardkernel kernel and vender kernel.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: <stable@vger.kernel.org> # v3.16
---
Changelog for v2:
- update commit description and code to fix time keeping problem
- update the stable tag with the kernel version

 drivers/rtc/rtc-s5m.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 8c70d78..646bf45 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -635,6 +635,16 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 	case S2MPS13X:
 		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
 		ret = regmap_write(info->regmap, info->regs->ctrl, data[0]);
+		if (ret < 0)
+			break;
+
+		/*
+		 * Should set WUDR & (RUDR or AUDR) bits to high after writing
+		 * RTC_CTRL register like writing Alarm registers. We can't find
+		 * the description from datasheet but vender code does that
+		 * really.
+		 */
+		ret = s5m8767_rtc_set_alarm_reg(info);
 		break;
 
 	default:
-- 
1.9.1
