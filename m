Return-Path: <rtc-linux+bncBAABBFEU5TBAKGQEU64L3DQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from botnar.kaiser.cx (botnar.kaiser.cx. [176.28.20.183])
        by gmr-mx.google.com with ESMTPS id f71si1654042wmf.2.2016.12.21.15.02.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 15:02:44 -0800 (PST)
From: Martin Kaiser <martin@kaiser.cx>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Juergen Borleis <jbe@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin Kaiser <martin@kaiser.cx>
Subject: [rtc-linux] [PATCH 2/2 v2] ARM: i.MX25: add the optional security
 violation irq
Date: Thu, 22 Dec 2016 00:01:16 +0100
Message-Id: <1482361276-12475-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
References: <1479560614-19293-1-git-send-email-martin@kaiser.cx>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add the security violation irq as an optional entry to rtc-imxdi's
device tree bindings and to i.MX25's dtsi file.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
  - clarify that the security violation interrupt is optional
  - use the same syntax as everwhere else for lists of interrupt numbers

 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt |    5 ++++-
 arch/arm/boot/dts/imx25.dtsi                        |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
index c9d80d7..323cf26 100644
--- a/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
@@ -8,10 +8,13 @@ Required properties:
   region.
 - interrupts: rtc alarm interrupt
 
+Optional properties:
+- interrupts: dryice security violation interrupt
+
 Example:
 
 rtc@80056000 {
 	compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
 	reg = <0x80056000 2000>;
-	interrupts = <29>;
+	interrupts = <29 56>;
 };
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 831d09a..331d1e1 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -560,7 +560,7 @@
 				reg = <0x53ffc000 0x4000>;
 				clocks = <&clks 81>;
 				clock-names = "ipg";
-				interrupts = <25>;
+				interrupts = <25 56>;
 			};
 		};
 
-- 
1.7.10.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
