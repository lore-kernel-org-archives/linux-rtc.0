Return-Path: <rtc-linux+bncBDZJXP7F6YLRBWM7VSZQKGQEMOTPLTY@googlegroups.com>
MIME-Version: 1.0
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id d185si141243wmf.0.2015.12.11.10.03.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2015 10:03:05 -0800 (PST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: kernel-janitors@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: v3020: constify v3020_chip_ops structures
Date: Fri, 11 Dec 2015 18:50:50 +0100
Message-Id: <1449856250-24732-1-git-send-email-Julia.Lawall@lip6.fr>
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

The v3020_chip_ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/rtc/rtc-v3020.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
index f9f9709..7a04363 100644
--- a/drivers/rtc/rtc-v3020.c
+++ b/drivers/rtc/rtc-v3020.c
@@ -57,7 +57,7 @@ struct v3020 {
 	/* GPIO access */
 	struct gpio *gpio;
 
-	struct v3020_chip_ops *ops;
+	const struct v3020_chip_ops *ops;
 
 	struct rtc_device *rtc;
 };
@@ -95,7 +95,7 @@ static unsigned char v3020_mmio_read_bit(struct v3020 *chip)
 	return !!(readl(chip->ioaddress) & (1 << chip->leftshift));
 }
 
-static struct v3020_chip_ops v3020_mmio_ops = {
+static const struct v3020_chip_ops v3020_mmio_ops = {
 	.map_io		= v3020_mmio_map,
 	.unmap_io	= v3020_mmio_unmap,
 	.read_bit	= v3020_mmio_read_bit,
@@ -158,7 +158,7 @@ static unsigned char v3020_gpio_read_bit(struct v3020 *chip)
 	return bit;
 }
 
-static struct v3020_chip_ops v3020_gpio_ops = {
+static const struct v3020_chip_ops v3020_gpio_ops = {
 	.map_io		= v3020_gpio_map,
 	.unmap_io	= v3020_gpio_unmap,
 	.read_bit	= v3020_gpio_read_bit,

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
