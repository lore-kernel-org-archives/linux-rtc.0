Return-Path: <rtc-linux+bncBCVK5RWD2QBRBI5LTHCQKGQEU3F6QXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from anchovy.45ru.net.au (anchovy1.45ru.net.au. [203.30.46.145])
        by gmr-mx.google.com with ESMTPS id z3si464324pfj.0.2017.02.16.17.45.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:45:07 -0800 (PST)
From: Phil Reid <preid@electromag.com.au>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
  akinobu.mita@gmail.com, preid@electromag.com.au, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/3] rtc: ds3232: Add regmap max_register definition.
Date: Fri, 17 Feb 2017 09:44:57 +0800
Message-Id: <1487295898-90177-3-git-send-email-preid@electromag.com.au>
In-Reply-To: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Add the max_register  to the regmap_config definition. This allows
dumping of the device's registers via the regmap debugfs interface.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/rtc/rtc-ds3232.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 67066f1..60de3a0 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -420,6 +420,7 @@ static int ds3232_i2c_probe(struct i2c_client *client,
 	static const struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
+		.max_register = 0x13,
 	};
 
 	regmap = devm_regmap_init_i2c(client, &config);
@@ -479,6 +480,7 @@ static int ds3234_probe(struct spi_device *spi)
 	static const struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
+		.max_register = 0x13,
 		.write_flag_mask = 0x80,
 	};
 	struct regmap *regmap;
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
