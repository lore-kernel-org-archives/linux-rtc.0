Return-Path: <rtc-linux+bncBAABBLMLSOVQKGQE2WOQNHY@googlegroups.com>
Received: from mxadeneo.adeneo-embedded.us (vpnchicago.adeneo-embedded.us. [65.182.180.190])
        by gmr-mx.google.com with ESMTPS id xv6si1527331pab.2.2015.05.26.12.12.44
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 May 2015 12:12:44 -0700 (PDT)
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	<rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>, Jean-Baptiste
 Theou <jtheou@adeneo-embedded.us>
Subject: [rtc-linux] [PATCH 1/2] rtc-isl1208: Add device tree binding
Date: Tue, 26 May 2015 12:12:29 -0700
Message-ID: <1432667550-24272-1-git-send-email-jtheou@adeneo-embedded.us>
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

ISL 1208/1218 require a trival i2c binding

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad0c4ac..a6f6257 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -61,6 +61,8 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+isil,isl1208		Intersil ISL1208 RTC driver
+isil,isl1218		Intersil ISL1218 RTC driver
 isil,isl12057		Intersil ISL12057 I2C RTC Chip
 isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
-- 
2.4.0

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
