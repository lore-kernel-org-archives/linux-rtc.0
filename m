Return-Path: <rtc-linux+bncBDZJXP7F6YLRBMMRSG2AKGQENHI74AI@googlegroups.com>
MIME-Version: 1.0
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id ti5si923225igb.2.2015.12.30.13.12.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 13:12:17 -0800 (PST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: kernel-janitors@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: rtc-ds2404: constify ds2404_chip_ops structures
Date: Wed, 30 Dec 2015 21:59:34 +0100
Message-Id: <1451509174-6343-1-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The ds2404_chip_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/rtc/rtc-ds2404.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 7885edd..16310fe 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -48,7 +48,7 @@ struct ds2404_gpio {
 
 struct ds2404 {
 	struct ds2404_gpio *gpio;
-	struct ds2404_chip_ops *ops;
+	const struct ds2404_chip_ops *ops;
 	struct rtc_device *rtc;
 };
 
@@ -95,7 +95,7 @@ static void ds2404_gpio_unmap(struct ds2404 *chip)
 		gpio_free(ds2404_gpio[i].gpio);
 }
 
-static struct ds2404_chip_ops ds2404_gpio_ops = {
+static const struct ds2404_chip_ops ds2404_gpio_ops = {
 	.map_io		= ds2404_gpio_map,
 	.unmap_io	= ds2404_gpio_unmap,
 };

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
