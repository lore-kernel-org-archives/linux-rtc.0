Return-Path: <rtc-linux+bncBDAYD2P3QYGRBTMT5XAAKGQE4J35AXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x22b.google.com (mail-lf0-x22b.google.com. [2a00:1450:4010:c07::22b])
        by gmr-mx.google.com with ESMTPS id 18si2735818wmr.1.2016.11.03.07.29.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 07:29:33 -0700 (PDT)
Received: by mail-lf0-x22b.google.com with SMTP id b81so39960842lfe.1
        for <rtc-linux@googlegroups.com>; Thu, 03 Nov 2016 07:29:33 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com,
	carlo@caione.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	rtc-linux@googlegroups.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [RFC PATCH 3/3] ARM64: dts: meson-gxbb: Add support for
 PM and Virtual RTC
Date: Thu,  3 Nov 2016 15:29:25 +0100
Message-Id: <1478183365-23708-4-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 2d69a3b..6c08d21 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -56,6 +56,10 @@
 		};
 	};
 
+	system-suspend {
+		compatible = "amlogic,meson-gx-pm";
+	};
+
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
 		#address-cells = <1>;
@@ -355,6 +359,11 @@
 		#reset-cells = <1>;
 	};
 
+	vrtc: rtc@0a8 {
+		compatible = "amlogic,meson-vrtc";
+		reg = <0x0 0x000a8 0x0 0x4>;
+	};
+
 	ir: ir@580 {
 		compatible = "amlogic,meson-gxbb-ir";
 		reg = <0x0 0x00580 0x0 0x40>;
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
