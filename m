Return-Path: <rtc-linux+bncBDM47J4M6QEBBIUHSLCQKGQEDJHYVTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from dukecmmtar03.coxmail.com (dukecmmtar03.coxmail.com. [68.99.120.44])
        by gmr-mx.google.com with ESMTP id h130si317703pfe.1.2017.02.15.08.36.50
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Feb 2017 08:36:50 -0800 (PST)
From: H Hartley Sweeten <hsweeten@visionengravers.com>
To: rtc-linux@googlegroups.com
Cc: alex@digriz.org.uk,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 2/5] ARM: Orion5x: ts78xx: remove RTC detection
Date: Wed, 15 Feb 2017 09:35:24 -0700
Message-Id: <20170215163527.5697-3-hsweeten@visionengravers.com>
In-Reply-To: <20170215163527.5697-1-hsweeten@visionengravers.com>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The rtc-m48t86 driver now handles the RTC detection. Remove the
redundant code from the platform.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c | 51 +++++++++---------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 8d59726..cb4c374 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -109,50 +109,23 @@ static struct platform_device ts78xx_ts_rtc_device = {
 	.num_resources	= 0,
 };
 
-/*
- * TS uses some of the user storage space on the RTC chip so see if it is
- * present; as it's an optional feature at purchase time and not all boards
- * will have it present
- *
- * I've used the method TS use in their rtc7800.c example for the detection
- *
- * TODO: track down a guinea pig without an RTC to see if we can work out a
- *		better RTC detection routine
- */
 static int ts78xx_ts_rtc_load(void)
 {
 	int rc;
-	unsigned char tmp_rtc0, tmp_rtc1;
-
-	tmp_rtc0 = ts78xx_ts_rtc_readbyte(126);
-	tmp_rtc1 = ts78xx_ts_rtc_readbyte(127);
-
-	ts78xx_ts_rtc_writebyte(0x00, 126);
-	ts78xx_ts_rtc_writebyte(0x55, 127);
-	if (ts78xx_ts_rtc_readbyte(127) == 0x55) {
-		ts78xx_ts_rtc_writebyte(0xaa, 127);
-		if (ts78xx_ts_rtc_readbyte(127) == 0xaa
-				&& ts78xx_ts_rtc_readbyte(126) == 0x00) {
-			ts78xx_ts_rtc_writebyte(tmp_rtc0, 126);
-			ts78xx_ts_rtc_writebyte(tmp_rtc1, 127);
-
-			if (ts78xx_fpga.supports.ts_rtc.init == 0) {
-				rc = platform_device_register(&ts78xx_ts_rtc_device);
-				if (!rc)
-					ts78xx_fpga.supports.ts_rtc.init = 1;
-			} else
-				rc = platform_device_add(&ts78xx_ts_rtc_device);
-
-			if (rc)
-				pr_info("RTC could not be registered: %d\n",
-					rc);
-			return rc;
-		}
+
+	if (ts78xx_fpga.supports.ts_rtc.init == 0) {
+		rc = platform_device_register(&ts78xx_ts_rtc_device);
+		if (!rc)
+			ts78xx_fpga.supports.ts_rtc.init = 1;
+	} else {
+		rc = platform_device_add(&ts78xx_ts_rtc_device);
 	}
 
-	pr_info("RTC not found\n");
-	return -ENODEV;
-};
+	if (rc)
+		pr_info("RTC could not be registered: %d\n", rc);
+
+	return rc;
+}
 
 static void ts78xx_ts_rtc_unload(void)
 {
-- 
2.10.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
