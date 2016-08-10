Return-Path: <rtc-linux+bncBAABBGG5VO6QKGQESGAR2YI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.visioncatalog.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id r74si334020wme.3.2016.08.10.02.06.31
        for <rtc-linux@googlegroups.com>;
        Wed, 10 Aug 2016 02:06:31 -0700 (PDT)
From: Wadim Egorov <w.egorov@phytec.de>
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc: dianders@chromium.org, zyw@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Subject: [rtc-linux] [PATCH v7 4/4] rtc: Kconfig: Name RK818 in Kconfig for RTC_DRV_RK808
Date: Wed, 10 Aug 2016 11:05:07 +0200
Message-Id: <1470819907-11237-5-git-send-email-w.egorov@phytec.de>
In-Reply-To: <1470819907-11237-1-git-send-email-w.egorov@phytec.de>
References: <1470819907-11237-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The RK808 and RK818 PMICs are using a similar register map.
We can reuse the rtc driver for the RK818 PMIC. So let's add
the RK818 in the Kconfig description.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e215f50..1102e8f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -328,11 +328,11 @@ config RTC_DRV_MAX77686
 	  will be called rtc-max77686.
 
 config RTC_DRV_RK808
-	tristate "Rockchip RK808 RTC"
+	tristate "Rockchip RK808/RK818 RTC"
 	depends on MFD_RK808
 	help
 	  If you say yes here you will get support for the
-	  RTC of RK808 PMIC.
+	  RTC of RK808 and RK818 PMIC.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rk808-rtc.
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
