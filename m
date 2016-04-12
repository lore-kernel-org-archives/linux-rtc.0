Return-Path: <rtc-linux+bncBAABBC6OWO4AKGQEHD4CBVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on0077.outbound.protection.outlook.com. [104.47.36.77])
        by gmr-mx.google.com with ESMTPS id im4si1035634igb.2.2016.04.12.05.16.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 05:16:11 -0700 (PDT)
From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>, <soren.brinkmann@xilinx.com>
CC: Michal Simek <michal.simek@xilinx.com>, <rtc-linux@googlegroups.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>, Anirudha Sarangi
	<anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, "Anurag Kumar
 Vulisha" <anuragku@xilinx.com>
Subject: [rtc-linux] [PATCH 1/3] RTC: Enable RTC switching to battery power
 when VCC_PSAUX is N/A
Date: Tue, 12 Apr 2016 17:45:44 +0530
Message-ID: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

In order to conserve battery energy, during the PS operation,
it is expected that the supply for the battery-powered domain
to be switched from the battery (VCC_PSBATT) to (VCC_PSAUX) and
automatically be switched back to battery when VCC_PSAUX voltage
drops below a limit, doing so prevents the logic within
the battery-powered domain from functioning incorrectly.

This patch enables that feature.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/rtc/rtc-zynqmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 8b28762..6adb603 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -45,6 +45,7 @@
 #define RTC_INT_SEC		BIT(0)
 #define RTC_INT_ALRM		BIT(1)
 #define RTC_OSC_EN		BIT(24)
+#define RTC_BATT_EN		BIT(31)
 
 #define RTC_CALIB_DEF		0x198233
 #define RTC_CALIB_MASK		0x1FFFFF
@@ -122,6 +123,13 @@ static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval)
 {
+	u32 rtc_ctrl;
+
+	/* Enable RTC switch to battery when VCC_PSAUX is not available */
+	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
+	rtc_ctrl |= RTC_BATT_EN;
+	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
+
 	/*
 	 * Based on crystal freq of 33.330 KHz
 	 * set the seconds counter and enable, set fractions counter
-- 
2.1.2

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
