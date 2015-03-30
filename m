Return-Path: <rtc-linux+bncBDKZNNNLXAHBBFOT4WUAKGQEMLIUOUQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id pc4si1144155pac.0.2015.03.30.08.19.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-MD5 bits=128/128);
        Mon, 30 Mar 2015 08:19:48 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NM1006B06RGC290@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 30 Mar 2015 16:23:40 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Kukjin Kim <kgene@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH 2/2] ARM: dts: s3c-rtc: Use s3c6410-rtc instead of exynos3250-rtc
Date: Mon, 30 Mar 2015 17:19:33 +0200
Message-id: <1427728773-29065-3-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
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

Mark "samsung,exynos3250-rtc" compatible as deprecated because it
duplicates the "samsung,s3c6410-rtc". Use "samsung,s3c6410-rtc" on
Exynos3250 and Exynos4415 boards.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 3 ++-
 arch/arm/boot/dts/exynos3250.dtsi                 | 2 +-
 arch/arm/boot/dts/exynos4415.dtsi                 | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
index ab757b84daa7..ac2fcd6ff4b8 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
@@ -6,7 +6,8 @@ Required properties:
     * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
     * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
     * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
-    * "samsung,exynos3250-rtc" - for controllers compatible with exynos3250 rtc.
+    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
+                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: Two interrupt numbers to the cpu should be specified. First
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index e3bfb11c6ef8..8d58b550e925 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -189,7 +189,7 @@
 		};
 
 		rtc: rtc@10070000 {
-			compatible = "samsung,exynos3250-rtc";
+			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10070000 0x100>;
 			interrupts = <0 73 0>, <0 74 0>;
 			interrupt-parent = <&pmu_system_controller>;
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index 5caea996e090..186cb8465683 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -177,7 +177,7 @@
 		};
 
 		rtc: rtc@10070000 {
-			compatible = "samsung,exynos3250-rtc";
+			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10070000 0x100>;
 			interrupts = <0 73 0>, <0 74 0>;
 			status = "disabled";
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
