Return-Path: <rtc-linux+bncBAABBEFKYSWQKGQE3POADSA@googlegroups.com>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com. [195.245.231.143])
        by gmr-mx.google.com with ESMTPS id q10si298034wiz.0.2015.07.23.09.23.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 09:23:44 -0700 (PDT)
Message-ID: <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1437668261.git.stwiss.opensource@diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 23 Jul 2015 17:17:41 +0100
Subject: [rtc-linux] [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
To: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark
 Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss
	<stwiss.opensource@diasemi.com>
CC: David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Support
 Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: S Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9062 OnKey driver component

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Changes in V3:
 - Child driver specifics separated out into separate document
   in this case ../input/da9062-onkey.txt
Changes in V2:
 - No change

This patch applies against linux-next and next-20150708 


 .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
new file mode 100644
index 0000000..c936902
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
@@ -0,0 +1,36 @@
+* Dialog DA9062 OnKey Module
+
+This module is part of the DA9062. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/da9062.txt.
+
+This module provides KEY_POWER, KEY_SLEEP and events.
+
+Required properties:
+
+- compatible: should be "dlg,da9062-onkey"
+
+Nodes:
+
+- onkey : This node defines the OnKey settings for controlling the key
+  functionality of the device. The node should contain the compatible property
+  with the value "dlg,da9062-onkey".
+
+  Optional onkey properties:
+
+  - dlg,disable-key-power : Disable power-down using a long key-press. If this
+    entry exists the OnKey driver will remove support for the KEY_POWER key
+    press. If this entry does not exist then by default the key-press
+    triggered power down is enabled and the OnKey will support both KEY_POWER
+    and KEY_SLEEP.
+
+Example:
+
+	pmic0: da9062@58 {
+
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			dlg,disable-key-power;
+		};
+
+	};
+
diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 5765ed9..d2e1730 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-devices:
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9062-regulator        :               : LDOs & BUCKs
+da9062-onkey            :               : On Key
 da9062-watchdog         :               : Watchdog Timer
 
 ======
@@ -40,6 +41,8 @@ Sub-nodes:
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
+- onkey : For more details about the onkey node see
+  Documentation/devicetree/bindings/input/da9062-onkey.txt
 
 - watchdog: This node defines the settings for the watchdog driver associated
   with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
-- 
end-of-patch for PATCH V3

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
