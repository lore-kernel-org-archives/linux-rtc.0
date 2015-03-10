Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [v2,2/4] pcf85063 is not a trivial device
From: =?utf-8?q?S=C3=B8ren_Andersen?= <san@rosetechnology.dk>
Message-Id: <1426020272.5476.27.camel@sanws1.rosetechnology.dk>
Cc: rtc-linux@googlegroups.com
Date: Tue, 10 Mar 2015 21:44:32 +0100
List-ID: <rtc-linux.googlegroups.com>

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index aaa8325..3b1a3c5 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -76,7 +76,6 @@ nuvoton,npct501		i2c trusted platform module (TPM)
 nxp,pca9556		Octal SMBus and I2C registered interface
 nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
 nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
 plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
