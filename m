Return-Path: <rtc-linux+bncBDGNBOVQQEOBBQGMVK2AKGQEWLIGI2A@googlegroups.com>
MIME-Version: 1.0
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id 5si1171306wmm.2.2016.01.04.09.05.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jan 2016 09:05:04 -0800 (PST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com,
	kernel@pengutronix.de,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [rtc-linux] [PATCH v4 1/2] Documentation: devicetree: add epson
 rx6110 binding
Date: Mon,  4 Jan 2016 18:04:34 +0100
Message-Id: <1451927075-8656-1-git-send-email-s.trumtrar@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add the binding documentation for the Epson RX6110 RTC.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---

 .../devicetree/bindings/rtc/epson,rx6110.txt       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt

diff --git a/Documentation/devicetree/bindings/rtc/epson,rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
new file mode 100644
index 000000000000..3dc313e01f77
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
@@ -0,0 +1,39 @@
+Epson RX6110 Real Time Clock
+============================
+
+The Epson RX6110 can be used with SPI or I2C busses. The kind of
+bus depends on the SPISEL pin and can not be configured via software.
+
+I2C mode
+--------
+
+Required properties:
+  - compatible: should be: "epson,rx6110"
+  - reg : the I2C address of the device for I2C
+
+Example:
+
+	rtc: rtc@32 {
+		compatible = "epson,rx6110"
+		reg = <0x32>;
+	};
+
+SPI mode
+--------
+
+Required properties:
+  - compatible: should be: "epson,rx6110"
+  - reg: chip select number
+  - spi-cs-high: RX6110 needs chipselect high
+  - spi-cpha: RX6110 works with SPI shifted clock phase
+  - spi-cpol: RX6110 works with SPI inverse clock polarity
+
+Example:
+
+	rtc: rtc@3 {
+		compatible = "epson,rx6110"
+		reg = <3>
+		spi-cs-high;
+		spi-cpha;
+		spi-cpol;
+	};
-- 
2.6.2

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
