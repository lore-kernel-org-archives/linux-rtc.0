Return-Path: <rtc-linux+bncBAABBBHKYW7QKGQEPAEY4NI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id ua1si2014958pac.1.2016.10.02.13.58.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2016 13:58:44 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH 4/4] mfd: Enable compile testing for max77620 and max77686
Date: Sun,  2 Oct 2016 22:58:17 +0200
Message-Id: <1475441897-15730-5-git-send-email-krzk@kernel.org>
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

The OF is not a strict build-time dependency so max77620 and max77686
can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c6df6442ba2b..ccea26943746 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -563,7 +563,7 @@ config MFD_MAX14577
 config MFD_MAX77620
 	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
 	depends on I2C=y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
@@ -578,7 +578,7 @@ config MFD_MAX77620
 config MFD_MAX77686
 	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
 	depends on I2C
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
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
