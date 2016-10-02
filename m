Return-Path: <rtc-linux+bncBAABBAHKYW7QKGQEKU7IBMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id um12si6681938pab.2.2016.10.02.13.58.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 13:58:40 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 3/4] rtc: Enable compile testing for Maxim and
 Samsung drivers
Date: Sun,  2 Oct 2016 22:58:16 +0200
Message-Id: <1475441897-15730-4-git-send-email-krzk@kernel.org>
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

max8907, max77686 and s5m RTC drivers can be compile tested to increase
build coverage.  The s5m-rtc uses REGMAP_IRQ so add this as explicit
dependency.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d148aba9..988053664125 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -303,7 +303,7 @@ config RTC_DRV_MAX6900
 
 config RTC_DRV_MAX8907
 	tristate "Maxim MAX8907"
-	depends on MFD_MAX8907
+	depends on MFD_MAX8907 || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the
 	  RTC of Maxim MAX8907 PMIC.
@@ -343,7 +343,7 @@ config RTC_DRV_MAX8997
 
 config RTC_DRV_MAX77686
 	tristate "Maxim MAX77686"
-	depends on MFD_MAX77686 || MFD_MAX77620
+	depends on MFD_MAX77686 || MFD_MAX77620 || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the
 	  RTC of Maxim MAX77686/MAX77620/MAX77802 PMIC.
@@ -602,7 +602,8 @@ config RTC_DRV_RV8803
 
 config RTC_DRV_S5M
 	tristate "Samsung S2M/S5M series"
-	depends on MFD_SEC_CORE
+	depends on MFD_SEC_CORE || COMPILE_TEST
+	select REGMAP_IRQ
 	help
 	  If you say yes here you will get support for the
 	  RTC of Samsung S2MPS14 and S5M PMIC series.
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
