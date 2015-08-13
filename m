Return-Path: <rtc-linux+bncBDEZ72H55YIBBFNUWGXAKGQEBPCG4EQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id eq2si153620pbb.2.2015.08.13.01.49.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Aug 2015 01:49:25 -0700 (PDT)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NT0025XPJ6AL710@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 13 Aug 2015 17:49:22 +0900 (KST)
From: Joonyoung Shim <jy0922.shim@samsung.com>
To: rtc-linux@googlegroups.com
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, sbkim73@samsung.com,
 k.kozlowski@samsung.com, jy0922.shim@samsung.com
Subject: [rtc-linux] [PATCH] rtc: s5m: fix to update ctrl register
Date: Thu, 13 Aug 2015 17:49:24 +0900
Message-id: <1439455764-23526-1-git-send-email-jy0922.shim@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

According to datasheet, the S2MPS13X and S2MPS14X should update write
buffer via setting WUDR bit to high after ctrl register is updated.

If not, ALARM interrupt of rtc-s5m doesn't happen first time when i use
tools/testing/selftests/timers/rtctest.c test program and hour format is
used to 12 hour mode in Odroid-XU3 board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: <stable@vger.kernel.org>
---
 drivers/rtc/rtc-s5m.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 8c70d78..03828bb 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -635,6 +635,18 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 	case S2MPS13X:
 		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
 		ret = regmap_write(info->regmap, info->regs->ctrl, data[0]);
+		if (ret < 0)
+			break;
+
+		ret = regmap_update_bits(info->regmap,
+				info->regs->rtc_udr_update,
+				info->regs->rtc_udr_mask,
+				info->regs->rtc_udr_mask);
+		if (ret < 0)
+			break;
+
+		ret = s5m8767_wait_for_udr_update(info);
+
 		break;
 
 	default:
-- 
1.9.1

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
