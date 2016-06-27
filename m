Return-Path: <rtc-linux+bncBCEPJZEDQIBBBNH3YS5QKGQE4PARFTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id q124si118025wme.3.2016.06.27.07.52.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jun 2016 07:52:36 -0700 (PDT)
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk,
	rtc-linux@googlegroups.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org
Cc: robh+dt@kernel.org,
	frowand.list@gmail.com,
	linux-amlogic@lists.infradead.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [rtc-linux] [PATCH 3/4] ARM: dts: amlogic: add rtc node for meson8b
Date: Mon, 27 Jun 2016 15:52:14 +0100
Message-Id: <1467039135-26588-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add the DT node for the RTC support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 2bfe401..ff97aa8 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -149,6 +149,13 @@
 			status = "disabled";
 		};
 
+		rtc: rtc@c8100740 {
+			compatible = "amlogic,meson8b-rtc";
+			reg = <0xc8100740 0x14>;
+			resets = <&reset RESET_RTC>;
+			status = "disabled";
+		};
+
 		clkc: clock-controller@c1104000 {
 			#clock-cells = <1>;
 			compatible = "amlogic,meson8b-clkc";
-- 
2.8.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
