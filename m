Return-Path: <rtc-linux+bncBD5O5IWPJMIJZPUWVQCRUBHKN26ZC@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com. [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id bk2si370648wib.1.2015.06.20.10.12.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 10:12:59 -0700 (PDT)
Received: by mail-wi0-x22a.google.com with SMTP id gi11so42333037wic.0
        for <rtc-linux@googlegroups.com>; Sat, 20 Jun 2015 10:12:59 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Philippe Reynes <tremyfr@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] [PATCH v3 5/6] dt-binding: document the binding for mxc rtc
Date: Sat, 20 Jun 2015 19:12:39 +0200
Message-Id: <1434820360-21935-6-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
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

This adds documentation of device tree bindings for the
mxc rtc.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 +++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
new file mode 100644
index 0000000..5505493
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
@@ -0,0 +1,27 @@
+* Real Time Clock of the i.MX SoCs
+
+RTC controller for the i.MX SoCs
+
+Required properties:
+- compatible: Should be "fsl,imx1-rtc" or "fsl,imx21-rtc".
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the RTC.
+- clocks: should contain two entries:
+  * one for the input reference
+  * one for the the SoC RTC
+- clock-names: should contain:
+  * "rtc" for the input reference clock
+  * "ipg" for the SoC RTC clock
+
+Example:
+
+rtc@10007000 {
+	compatible = "fsl,imx21-rtc";
+	reg = <0x10007000 0x1000>;
+	interrupts = <22>;
+	clocks = <&clks IMX27_CLK_CKIL>,
+	       	 <&clks IMX27_CLK_RTC_IPG_GATE>;
+	clock-names = "rtc, "ipg";
+	status = "disabled";
+};
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
