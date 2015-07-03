Return-Path: <rtc-linux+bncBD5O5IWPJMIKRL64VQCRUBDTDB2NU@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id q10si569243wiz.0.2015.07.03.16.15.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2015 16:15:52 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id r9so142362160wia.1
        for <rtc-linux@googlegroups.com>; Fri, 03 Jul 2015 16:15:52 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Philippe Reynes <tremyfr@gmail.com>
Subject: [rtc-linux] [PATCH v4 6/7] imx27: dt: add support of internal rtc
Date: Sat,  4 Jul 2015 01:15:19 +0200
Message-Id: <1435965320-1478-7-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
References: <1435965320-1478-1-git-send-email-tremyfr@gmail.com>
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

Add support of internal rtc on imx27.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b69be5c..38e6e84 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -144,6 +144,16 @@
 				clock-names = "ipg", "per";
 			};
 
+			rtc: rtc@10007000 {
+				compatible = "fsl,imx21-rtc";
+				reg = <0x10007000 0x1000>;
+				interrupts = <22>;
+				clocks = <&clks IMX27_CLK_CKIL>,
+					 <&clks IMX27_CLK_RTC_IPG_GATE>;
+				clock-names = "rtc", "ipg";
+				status = "disabled";
+			};
+
 			kpp: kpp@10008000 {
 				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
 				reg = <0x10008000 0x1000>;
-- 
1.7.4.4

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
