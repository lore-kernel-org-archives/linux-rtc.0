Return-Path: <rtc-linux+bncBAABBUUB762AKGQE3G2G7BA@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id jg4si680012pac.2.2016.01.20.09.16.02
        for <rtc-linux@googlegroups.com>;
        Wed, 20 Jan 2016 09:16:02 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>,
	rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-samsung-soc@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [rtc-linux] [PATCH 7/8] ARM: exynos_defconfig: Remove MAX77802 RTC
 Kconfig symbol
Date: Wed, 20 Jan 2016 14:14:47 -0300
Message-Id: <1453310088-29985-8-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
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

The driver has been removed so the Kconfig symbol is not valid anymore.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 24dcd2bb1215..cdbe6dbc6e75 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -193,7 +193,6 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX8997=y
 CONFIG_RTC_DRV_MAX77686=y
-CONFIG_RTC_DRV_MAX77802=y
 CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
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
