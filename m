Return-Path: <rtc-linux+bncBDKZNNNLXAHBBEOJU2VAKGQEWVDLYLI@googlegroups.com>
MIME-Version: 1.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id ye6si2688879pbc.2.2015.05.05.22.20.17
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 22:20:17 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNW00JFWXHOE570@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 06 May 2015 06:20:12 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Sangbeom Kim <sbkim73@samsung.com>, Mike Turquette <mturquette@linaro.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [rtc-linux] [PATCH] MAINTAINERS: Extend Samsung MFD drivers entry and
 add myself
Date: Wed, 06 May 2015 14:19:36 +0900
Message-id: <1430889576-7779-1-git-send-email-k.kozlowski@samsung.com>
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

Extend the entry for Samsung MFD drivers for PMIC devices (Power
Management Integrated Circuit) with bindings documentation, clock
(clk-s2mps11.c) and RTC drivers (rtc-s5m.c).

These PMIC devices are used on many Exynos-based boards like Arndale
Octa (S2MPS11), Gear 2 (S2MPS14).

Add myself as a supporter for reviewing them.
I am not the author of these drivers. However I have recently
contributed to most of them and I have access to datasheets and hardware.

Cc: Sangbeom Kim <sbkim73@samsung.com>
CC: Mike Turquette <mturquette@linaro.org>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Lee Jones <lee.jones@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Mark Brown <broonie@kernel.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e278814388f7..fc01dc9f96af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8533,14 +8533,20 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/s3c-fb.c
 
-SAMSUNG MULTIFUNCTION DEVICE DRIVERS
+SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Sangbeom Kim <sbkim73@samsung.com>
+M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
 L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	drivers/mfd/sec*.c
 F:	drivers/regulator/s2m*.c
 F:	drivers/regulator/s5m*.c
+F:	drivers/clk/clk-s2mps11.c
+F:	drivers/rtc/rtc-s5m.c
 F:	include/linux/mfd/samsung/
+F:	Documentation/devicetree/bindings/regulator/s5m8767-regulator.txt
+F:	Documentation/devicetree/bindings/mfd/s2mp*.txt
 
 SAMSUNG S5P/EXYNOS4 SOC SERIES CAMERA SUBSYSTEM DRIVERS
 M:	Kyungmin Park <kyungmin.park@samsung.com>
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
