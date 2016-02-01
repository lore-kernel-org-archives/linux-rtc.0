Return-Path: <rtc-linux+bncBDNZNK75ZIKRB3FQX22QKGQE5HEUS7I@googlegroups.com>
MIME-Version: 1.0
From: Andre Przywara <andre.przywara@arm.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-sunxi@googlegroups.com
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 03/11] drivers: rtc: allow compilation of sun6i
 RTC for all sunxi SoCs
Date: Mon,  1 Feb 2016 17:39:22 +0000
Message-Id: <1454348370-3816-4-git-send-email-andre.przywara@arm.com>
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
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

At the moment the "sun6i" RTC drivers depends on having two specific
SoC families selected.
The Allwinner A64 SoC has the same RTC, so extend the Kconfig option
to allow inclusion of the driver for all Allwinner SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/rtc/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f..526eaf4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1360,10 +1360,11 @@ config RTC_DRV_SUN4V
 
 config RTC_DRV_SUN6I
 	tristate "Allwinner A31 RTC"
-	depends on MACH_SUN6I || MACH_SUN8I
+	default MACH_SUN6I || MACH_SUN8I
+	depends on ARCH_SUNXI
 	help
-	  If you say Y here you will get support for the RTC found on
-	  Allwinner A31.
+	  If you say Y here you will get support for the RTC found in
+	  some Allwinner SoCs like the A31 or the A64.
 
 config RTC_DRV_SUNXI
 	tristate "Allwinner sun4i/sun7i RTC"
-- 
2.6.4

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
