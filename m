Return-Path: <rtc-linux+bncBDS7HNEFSALRB5V25WUAKGQEJDVHA6A@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i8si36380wif.1.2015.03.31.19.52.38
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Mar 2015 19:52:38 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Philippe De Muyter <phdm@macqel.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: [rtc-linux] [PATCH v2 1/2] Documentation: bindings: add abracon,abx80x
Date: Wed,  1 Apr 2015 04:52:22 +0200
Message-Id: <1427856743-26625-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427856743-26625-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Document the bindings for abracon,abx80x and related compatibles.

Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
new file mode 100644
index 000000000000..6f0d3b2cdd89
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
@@ -0,0 +1,32 @@
+Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
+ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
+is the superset of ab180x.
+
+Required properties:
+
+ - "compatible": should one of:
+        "abracon,abx80x"
+        "abracon,ab0801"
+        "abracon,ab0803"
+        "abracon,ab0804"
+        "abracon,ab0805"
+        "abracon,ab1801"
+        "abracon,ab1803"
+        "abracon,ab1804"
+        "abracon,ab1805"
+	Using "abracon,abx80x" will enable chip autodetection.
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+The abx804 and abx805 have a trickle charger that is able to charge the
+connected battery or supercap. Both the following properties have to be defined
+and valid to enable charging:
+
+ - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
+ - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
+                          resistor, the other values are in ohm.
+
+
-- 
2.1.0

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
