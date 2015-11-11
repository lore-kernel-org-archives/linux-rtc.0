Return-Path: <rtc-linux+bncBC5M7T4HYEKRBHGRRWZAKGQEWXZQZLQ@googlegroups.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com. [192.94.94.40])
        by gmr-mx.google.com with ESMTPS id lo7si310571igb.3.2015.11.11.08.11.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 11 Nov 2015 08:11:07 -0800 (PST)
From: Felipe Balbi <balbi@ti.com>
To: Alessandro Zummo <a.zummo@towertech.it>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux OMAP Mailing List
	<linux-omap@vger.kernel.org>,
        Linux ARM Kernel Mailing List
	<linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, <rtc-linux@googlegroups.com>,
        Felipe Balbi <balbi@ti.com>, Tony Lindgren
	<tony@atomide.com>,
        Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] [PATCH] rtc: ds1307: fix kernel splat due to wakeup irq handling
Date: Wed, 11 Nov 2015 10:11:01 -0600
Message-ID: <1447258261-2102-1-git-send-email-balbi@ti.com>
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

Since commit 3fffd1283927 ("i2c: allow specifying
separate wakeup interrupt in device tree") we have
automatic wakeup irq support for i2c devices. That
commit missed the fact that rtc-1307 had its own
wakeup irq handling and ended up introducing a
kernel splat for at least Beagle x15 boards.

Fix that by reverting original commit _and_ passing
correct interrupt names on DTS so i2c-core can
choose correct IRQ as wakeup.

Now that we have automatic wakeirq support, we can
revert the original commit which did it manually.

Fixes the following warning:

[   10.346582] WARNING: CPU: 1 PID: 263 at linux/drivers/base/power/wakeirq.c:43 dev_pm_attach_wake_irq+0xbc/0xd4()
[   10.359244] rtc-ds1307 2-006f: wake irq already initialized

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |  1 +
 drivers/rtc/rtc-ds1307.c                | 36 +++------------------------------
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d9ba6b879fc1..00352e761b8c 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -604,6 +604,7 @@
 		reg = <0x6f>;
 		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
 				      <&dra7_pmx_core 0x424>;
+		interrupt-names = "irq", "wakeup";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 188006c55ce0..325836818826 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -15,9 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/pm_wakeirq.h>
 #include <linux/rtc/ds1307.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -117,7 +114,6 @@ struct ds1307 {
 #define HAS_ALARM	1		/* bit 1 == irq claimed */
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
-	int			wakeirq;
 	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
 			       u8 length, u8 *values);
 	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
@@ -1146,8 +1142,6 @@ read_rtc:
 	}
 
 	if (want_irq) {
-		struct device_node *node = client->dev.of_node;
-
 		err = devm_request_threaded_irq(&client->dev,
 						client->irq, NULL, irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
@@ -1155,34 +1149,13 @@ read_rtc:
 		if (err) {
 			client->irq = 0;
 			dev_err(&client->dev, "unable to request IRQ!\n");
-			goto no_irq;
-		}
-
-		set_bit(HAS_ALARM, &ds1307->flags);
-		dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
-
-		/* Currently supported by OF code only! */
-		if (!node)
-			goto no_irq;
-
-		err = of_irq_get(node, 1);
-		if (err <= 0) {
-			if (err == -EPROBE_DEFER)
-				goto exit;
-			goto no_irq;
-		}
-		ds1307->wakeirq = err;
+		} else {
 
-		err = dev_pm_set_dedicated_wake_irq(&client->dev,
-						    ds1307->wakeirq);
-		if (err) {
-			dev_err(&client->dev, "unable to setup wakeIRQ %d!\n",
-				err);
-			goto exit;
+			set_bit(HAS_ALARM, &ds1307->flags);
+			dev_dbg(&client->dev, "got IRQ %d\n", client->irq);
 		}
 	}
 
-no_irq:
 	if (chip->nvram_size) {
 
 		ds1307->nvram = devm_kzalloc(&client->dev,
@@ -1226,9 +1199,6 @@ static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
-	if (ds1307->wakeirq)
-		dev_pm_clear_wake_irq(&client->dev);
-
 	if (test_and_clear_bit(HAS_NVRAM, &ds1307->flags))
 		sysfs_remove_bin_file(&client->dev.kobj, ds1307->nvram);
 
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
