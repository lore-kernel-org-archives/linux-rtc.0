Return-Path: <rtc-linux+bncBAABBRU3QO6AKGQE52YB54A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from kozue.soulik.info (kozue.soulik.info. [2001:19f0:7000:8404:5054:ff:fe75:428f])
        by gmr-mx.google.com with ESMTPS id i135si215683pfe.0.2016.07.09.02.24.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jul 2016 02:24:27 -0700 (PDT)
From: Randy Li <ayaka@soulik.info>
To: k.kozlowski@samsung.com
Cc: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Randy Li <ayaka@soulik.info>
Subject: [rtc-linux] [PATCH 3/3] ARM: dts: exynos: correct the rtc compatible
 value for exynos5
Date: Sat,  9 Jul 2016 17:23:46 +0800
Message-Id: <1468056226-19128-4-git-send-email-ayaka@soulik.info>
In-Reply-To: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Those platforms are reported to use the same rtc IP core
as exynos3250's.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 arch/arm/boot/dts/exynos5.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 62f3dcd..cdd69a0 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -208,7 +208,7 @@
 		};
 
 		rtc: rtc@10070000 {
-			compatible = "samsung,s3c6410-rtc";
+			compatible = "samsung,exynos3250-rtc";
 			reg = <0x10070000 0x100>;
 			interrupts = <0 73 0>, <0 74 0>;
 			interrupt-parent = <&pmu_system_controller>;
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index d5c0f18..71a1ad2 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -88,7 +88,7 @@
 	};
 
 	rtc: rtc@101E0000 {
-		compatible = "samsung,s3c6410-rtc";
+		compatible = "samsung,exynos3250-rtc";
 		reg = <0x101E0000 0x100>;
 		interrupts = <0 43 0>, <0 44 0>;
 		status = "disabled";
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
