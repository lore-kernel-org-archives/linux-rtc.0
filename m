Return-Path: <rtc-linux+bncBDULZYNR2QMRBKGTQW6QKGQELKKTVTY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id f6si419343ywh.1.2016.08.02.20.48.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 20:48:56 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id r9so16067158ywg.2
        for <rtc-linux@googlegroups.com>; Tue, 02 Aug 2016 20:48:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@free-electrons.com
Cc: grimaldi.ivan@gmail.com,
	rtc-linux@googlegroups.com,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [rtc-linux] [PATCH] rtc: ds1390: Fix the SPI chip select number
Date: Wed,  3 Aug 2016 00:48:22 -0300
Message-Id: <1470196102-23713-1-git-send-email-festevam@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Fabio Estevam <fabio.estevam@nxp.com>

The number after the '@' symbol should be the SPI chip select
number associated with the ds1390 and it should match the 'reg'
field.

So change it the address to zero, to make it consistent.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/rtc/dallas,ds1390.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
index 8e76f26..9882b81 100644
--- a/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
+++ b/Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
@@ -11,7 +11,7 @@ Optional properties:
 - trickle-diode-disable : Do not use internal trickle charger diode
 	Should be given if internal trickle charger diode should be disabled
 Example:
-	ds1390: rtc@68 {
+	ds1390: rtc@0 {
 		compatible = "dallas,ds1390";
 		trickle-resistor-ohms = <250>;
 		reg = <0>;
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
