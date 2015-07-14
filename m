Return-Path: <rtc-linux+bncBAABB24VSSWQKGQEUUN4LEA@googlegroups.com>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com. [193.109.254.115])
        by gmr-mx.google.com with ESMTPS id eo3si556801wib.0.2015.07.14.06.13.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:13:15 -0700 (PDT)
Message-ID: <b3c74ac91cce63d6906c1c87b3bed98f36400752.1436879270.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1436879270.git.stwiss.opensource@diasemi.com>
References: <cover.1436879270.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 14 Jul 2015 14:07:50 +0100
Subject: [rtc-linux] [PATCH RFC V1 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
To: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss
	<stwiss.opensource@diasemi.com>
CC: David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "Support
 Opensource" <support.opensource@diasemi.com>
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
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 da9062.txt                total: 0 errors, 0 warnings, 97 lines checked
This patch applies against linux-next and next-20150708 


 Documentation/devicetree/bindings/mfd/da9062.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 5765ed9..7752093 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -5,6 +5,7 @@ DA9062 consists of a large and varied group of sub-devices:
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9062-regulator        :               : LDOs & BUCKs
+da9062-onkey            :               : On Key
 da9062-watchdog         :               : Watchdog Timer
 
 ======
@@ -41,6 +42,18 @@ Sub-nodes:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
 
+- onkey : This node defines the OnKey settings for controlling the key
+  functionality of the device. The node should contain the compatible property
+  with the value "dlg,da9063-onkey".
+
+  Optional onkey properties:
+
+  - dlg,disable-key-power : Disable power-down using a long key-press. If this
+    entry exists the OnKey driver will remove support for the KEY_POWER key
+    press. If this entry does not exist then by default the key-press
+    triggered power down is enabled and the OnKey will support both KEY_POWER
+    and KEY_SLEEP.
+
 - watchdog: This node defines the settings for the watchdog driver associated
   with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
   if a node is created.
@@ -59,6 +72,11 @@ Example:
 			compatible = "dlg,da9062-watchdog";
 		};
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			dlg,disable-key-power;
+		};
+
 		regulators {
 			DA9062_BUCK1: buck1 {
 				regulator-name = "BUCK1";
-- 
end-of-patch for PATCH RFC V1

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
