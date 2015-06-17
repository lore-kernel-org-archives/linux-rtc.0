Return-Path: <rtc-linux+bncBCMNZUWXYYORB74HQ6WAKGQESDNBAPA@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com. [209.85.192.175])
        by gmr-mx.google.com with ESMTPS id fl5si663678pad.0.2015.06.17.12.01.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 12:01:19 -0700 (PDT)
Received: by mail-pd0-f175.google.com with SMTP id ki1so46712991pdb.1
        for <rtc-linux@googlegroups.com>; Wed, 17 Jun 2015 12:01:19 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	lee.jones@linaro.org,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [rtc-linux] [PATCH-v2 3/3] mfd: devicetree: bindings: Add new 88pm800
 mfd binding
Date: Thu, 18 Jun 2015 00:28:08 +0530
Message-Id: <1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
In-Reply-To: <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
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

With addition of DT support to 88pm800 mfd driver, this patch
adds new DT binding documentation along with respective properties.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mfd/88pm800.txt | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
new file mode 100644
index 0000000..b8e72df
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
@@ -0,0 +1,60 @@
+* Marvell 88PM8xx Power Management IC
+
+Required parent device properties:
+- compatible : "marvell,88pm800", "marvell,88pm805", "marvell,88pm860"
+- reg : the I2C slave address for the 88pm8xx chip
+- interrupts : IRQ line for the 88pm8xx chip
+- interrupt-controller: describes the 88pm8xx as an interrupt controller
+- #interrupt-cells : should be 1.
+		- The cell is the 88pm8xx local IRQ number
+
+Optional parent device properties:
+- marvell,irq-clr-on-write: indicates whether interrupt status is cleared
+  by write or read.
+  If enabled, interrupt is cleared by write else just read would do.
+
+88pm8xx family of devices consists of varied group of sub-devices:
+
+Device		 	Supply Names	 Description
+------		 	------------	 -----------
+88pm80x-onkey		:		: On key
+88pm80x-rtc		:		: RTC
+88pm80x-regulator	:		: Regulators
+
+Note: More device list will follow
+
+Example:
+
+	pmic: 88pm800@30 {
+		compatible = "marvell,88pm800";
+		reg = <0x30>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		marvell,irq-clr-on-write;
+
+		regulators {
+			compatible = "marvell,88pm80x-regulator";
+
+			buck1a: BUCK1A {
+				regulator-compatible = "88PM800-BUCK1A";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			ldo1: LDO1 {
+				regulator-compatible = "88PM800-LDO1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+
+		rtc {
+			compatible = "marvell,88pm80x-rtc";
+		};
+	};
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
