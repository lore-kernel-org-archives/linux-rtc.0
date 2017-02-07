Return-Path: <rtc-linux+bncBCPM5SUWUYIRB3GD5DCAKGQEPRHHISQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id h130si223795pfe.1.2017.02.07.11.37.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 11:37:15 -0800 (PST)
Received: by mail-pf0-x241.google.com with SMTP id f144so9898890pfa.2
        for <rtc-linux@googlegroups.com>; Tue, 07 Feb 2017 11:37:15 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Heiko Schocher <hs@denx.de>,
	Rob Herring <robh@kernel.org>
Subject: [rtc-linux] [PATCH] bindings: rtc: correct wrong reference in
 required properties
Date: Wed,  8 Feb 2017 04:36:53 +0900
Message-Id: <1486496213-11790-1-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

There are currently two broken bindings descriptions for RTC:

maxim,ds3231.txt
pcf8563.txt

They broke because of a improper RST documentation conversion with
commit 8c27ceff3604b2 ("docs: fix locations of several documents that got
moved") and now reference to a non-existing file:

Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst

However, the original reference to i2c/trivial-devices should have never
been made in the first place.

This change fixes this issue by replacing with correct descriptions.

Reported-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Heiko Schocher <hs@denx.de>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/devicetree/bindings/rtc/maxim,ds3231.txt | 3 ++-
 Documentation/devicetree/bindings/rtc/pcf8563.txt      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt b/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
index 1ad4c1c..85be53a 100644
--- a/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
+++ b/Documentation/devicetree/bindings/rtc/maxim,ds3231.txt
@@ -1,7 +1,8 @@
 * Maxim DS3231 Real Time Clock
 
 Required properties:
-see: Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
+- compatible: Should contain "maxim,ds3231".
+- reg: I2C address for chip.
 
 Optional property:
 - #clock-cells: Should be 1.
diff --git a/Documentation/devicetree/bindings/rtc/pcf8563.txt b/Documentation/devicetree/bindings/rtc/pcf8563.txt
index 086c998..36984ac 100644
--- a/Documentation/devicetree/bindings/rtc/pcf8563.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf8563.txt
@@ -3,7 +3,8 @@
 Philips PCF8563/Epson RTC8564 Real Time Clock
 
 Required properties:
-see: Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
+- compatible: Should contain "nxp,pcf8563".
+- reg: I2C address for chip.
 
 Optional property:
 - #clock-cells: Should be 0.
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
