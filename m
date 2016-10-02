Return-Path: <rtc-linux+bncBAABB7HJYW7QKGQEXVWLYVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id z73si1058961pfa.1.2016.10.02.13.58.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 13:58:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [rtc-linux] [PATCH 2/4] regulator: Enable compile testing for Maxim
 and Samsung PMIC drivers
Date: Sun,  2 Oct 2016 22:58:15 +0200
Message-Id: <1475441897-15730-3-git-send-email-krzk@kernel.org>
In-Reply-To: <1475441897-15730-1-git-send-email-krzk@kernel.org>
References: <1475441897-15730-1-git-send-email-krzk@kernel.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Most of Maxim and Samsung PMIC/MUIC regulator drivers can be compile
tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 936f7ccc9736..1ce7e3633b63 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -379,7 +379,7 @@ config REGULATOR_MAX1586
 
 config REGULATOR_MAX77620
 	tristate "Maxim 77620/MAX20024 voltage regulator"
-	depends on MFD_MAX77620
+	depends on MFD_MAX77620 || COMPILE_TEST
 	help
 	  This driver controls Maxim MAX77620 voltage output regulator
 	  via I2C bus. The provided regulator is suitable for Tegra
@@ -453,7 +453,7 @@ config REGULATOR_MAX8998
 
 config REGULATOR_MAX77686
 	tristate "Maxim 77686 regulator"
-	depends on MFD_MAX77686
+	depends on MFD_MAX77686 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77686 regulator
 	  via I2C bus. The provided regulator is suitable for
@@ -461,7 +461,7 @@ config REGULATOR_MAX77686
 
 config REGULATOR_MAX77693
 	tristate "Maxim 77693/77843 regulator"
-	depends on (MFD_MAX77693 || MFD_MAX77843)
+	depends on MFD_MAX77693 || MFD_MAX77843 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77693/77843 regulators via I2C bus.
 	  The regulators include two LDOs, 'SAFEOUT1', 'SAFEOUT2'
@@ -470,7 +470,7 @@ config REGULATOR_MAX77693
 
 config REGULATOR_MAX77802
 	tristate "Maxim 77802 regulator"
-	depends on MFD_MAX77686
+	depends on MFD_MAX77686 || COMPILE_TEST
 	help
 	  This driver controls a Maxim 77802 regulator
 	  via I2C bus. The provided regulator is suitable for
@@ -669,14 +669,14 @@ config REGULATOR_RT5033
 
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver controls Samsung S2MPA01 voltage output regulator
 	 via I2C bus. S2MPA01 has 10 Bucks and 26 LDO outputs.
 
 config REGULATOR_S2MPS11
 	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
 	 output regulator via I2C bus. The chip is comprised of high efficient
@@ -685,7 +685,7 @@ config REGULATOR_S2MPS11
 
 config REGULATOR_S5M8767
 	tristate "Samsung S5M8767A voltage regulator"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
 	help
 	 This driver supports a Samsung S5M8767A voltage output regulator
 	 via I2C bus. S5M8767A have 9 Bucks and 28 LDOs output and
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
