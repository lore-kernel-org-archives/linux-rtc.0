Return-Path: <rtc-linux+bncBCNJ5VGR4ANRB7G447CAKGQERMCNDEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com. [192.185.145.182])
        by gmr-mx.google.com with ESMTPS id b188si506071ite.3.2017.02.07.07.57.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 07:57:48 -0800 (PST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
	by gateway32.websitewelcome.com (Postfix) with ESMTP id E273E121E4
	for <rtc-linux@googlegroups.com>; Tue,  7 Feb 2017 09:57:46 -0600 (CST)
From: Guy Shapiro <guy.shapiro@mobi-wize.com>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/2] ARM: dts: imx: update snvs-poweroff mask
Date: Tue,  7 Feb 2017 17:56:06 +0200
Message-Id: <1486482966-4497-2-git-send-email-guy.shapiro@mobi-wize.com>
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Make the syscon-poweroff driver change only the shutdown bits on the
SNVS_LP control register.

This change fixes an issue with the RTC wakeup alarm, that was
previously disabled during power off.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..06984b1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -757,6 +757,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..58717d3 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -644,6 +644,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..be142ed5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -698,6 +698,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 39845a7..505d24e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -606,6 +606,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 8ff2cbdd..aadb1134 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -529,6 +529,7 @@
 					compatible = "syscon-poweroff";
 					regmap = <&snvs>;
 					offset = <0x38>;
+					value = <0x60>;
 					mask = <0x60>;
 				};
 
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
