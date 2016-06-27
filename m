Return-Path: <rtc-linux+bncBCEPJZEDQIBBBXNPYW5QKGQEKQGYDQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id r10si418945wmf.0.2016.06.27.09.44.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jun 2016 09:44:13 -0700 (PDT)
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
Subject: [rtc-linux] [PATCH v2 2/4] meson-rtc: add device-tree binding
Date: Mon, 27 Jun 2016 17:44:07 +0100
Message-Id: <1467045849-495-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add documentation for the AMLogic Meson RTC.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 .../devicetree/bindings/rtc/rtc-amlogic.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-amlogic.txt b/Documentation/devicetree/bindings/rtc/rtc-amlogic.txt
new file mode 100644
index 0000000..efc7672
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-amlogic.txt
@@ -0,0 +1,21 @@
+* AMlogic Meson RTC
+
+Required properties:
+- compatible: should be one of the following describing the hardware:
+	* "amlogic,meson6-rtc"
+	* "amlogic,meson8-rtc"
+	* "amlogic,meson8b-rtc"
+
+- reg: physical register space for the controller's memory mapped registers.
+
+Optional properties:
+- resets: reset controller reference to allow reset of the controller
+- interrupts: single interrupt reference if interrupt support needed
+
+Example:
+
+	rtc: rtc@c8100740 {
+		compatible = "amlogic,meson6-rtc";
+		reg = <0xc8100740 0x14>;
+		status = "disabled";
+	};
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
