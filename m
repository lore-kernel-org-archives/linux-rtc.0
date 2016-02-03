Return-Path: <rtc-linux+bncBD2OLRXW4ABBB64WY62QKGQENUGUXIQ@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si768336pac.1.2016.02.03.01.42.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:42:19 -0800 (PST)
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>
CC: <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, Laxman Dewangan <ldewangan@nvidia.com>
Subject: [rtc-linux] [PATCH V2 4/5] mfd: max77686: do not set i2c client data
 for rtc i2c client
Date: Wed, 3 Feb 2016 15:00:47 +0530
Message-ID: <1454491848-26551-5-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

There is different RTC I2C address for RTC block in MAX77686.
Driver is creating dummy i2c client for this address to access
the register of this IP block.

As there is no need to get any data from this rtc i2c client,
it is not required to set client data for this i2c client.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@osg.samsung.com>

---
This is new in this series based on review comment from V1.

 drivers/mfd/max77686.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index d959ebb..bda6fd7 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -277,7 +277,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 				"Failed to allocate I2C device for RTC\n");
 			return -ENODEV;
 		}
-		i2c_set_clientdata(max77686->rtc, max77686);
 
 		max77686->rtc_regmap =
 			devm_regmap_init_i2c(max77686->rtc,
-- 
2.1.4

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
