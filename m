Return-Path: <rtc-linux+bncBDKZNNNLXAHBBPWR7WWAKGQE7CQCFCI@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id tq2si813484pbc.0.2015.07.09.23.39.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 23:39:58 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NR90025OEIIA640@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 10 Jul 2015 07:39:54 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [PATCH 1/2] rtc: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:39:50 +0900
Message-id: <1436510391-6001-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
References: <1436510391-6001-1-git-send-email-k.kozlowski@samsung.com>
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

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 1 -
 drivers/rtc/rtc-bq32k.c      | 1 -
 drivers/rtc/rtc-ds1307.c     | 1 -
 drivers/rtc/rtc-ds1374.c     | 1 -
 drivers/rtc/rtc-ds3232.c     | 1 -
 drivers/rtc/rtc-fm3130.c     | 1 -
 drivers/rtc/rtc-hym8563.c    | 1 -
 drivers/rtc/rtc-isl12057.c   | 1 -
 drivers/rtc/rtc-pcf2127.c    | 1 -
 drivers/rtc/rtc-pcf85063.c   | 1 -
 drivers/rtc/rtc-pcf8523.c    | 1 -
 drivers/rtc/rtc-pcf8563.c    | 1 -
 drivers/rtc/rtc-pcf8583.c    | 1 -
 drivers/rtc/rtc-rx8025.c     | 1 -
 drivers/rtc/rtc-rx8581.c     | 1 -
 15 files changed, 15 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index b5cbc1bf5a3e..0fb1d767afa9 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -1020,7 +1020,6 @@ MODULE_DEVICE_TABLE(i2c, abb5zes3_id);
 static struct i2c_driver abb5zes3_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 		.pm = &abb5zes3_rtc_pm_ops,
 		.of_match_table = of_match_ptr(abb5zes3_dt_match),
 	},
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 92679df6d6e2..2e4068084593 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(i2c, bq32k_id);
 static struct i2c_driver bq32k_driver = {
 	.driver = {
 		.name	= "bq32k",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= bq32k_probe,
 	.id_table	= bq32k_id,
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index e16989c48a90..c51bc0a65afc 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1252,7 +1252,6 @@ static int ds1307_remove(struct i2c_client *client)
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ds1307_probe,
 	.remove		= ds1307_remove,
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 167783fa7ac1..0ed9ed97a2ba 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -709,7 +709,6 @@ static SIMPLE_DEV_PM_OPS(ds1374_pm, ds1374_suspend, ds1374_resume);
 static struct i2c_driver ds1374_driver = {
 	.driver = {
 		.name = "rtc-ds1374",
-		.owner = THIS_MODULE,
 		.pm = &ds1374_pm,
 	},
 	.probe = ds1374_probe,
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7e48e532214f..18f062f2a634 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -500,7 +500,6 @@ MODULE_DEVICE_TABLE(i2c, ds3232_id);
 static struct i2c_driver ds3232_driver = {
 	.driver = {
 		.name = "rtc-ds3232",
-		.owner = THIS_MODULE,
 		.pm	= &ds3232_pm_ops,
 	},
 	.probe = ds3232_probe,
diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index 83c3b3029fa7..576eadbba296 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -523,7 +523,6 @@ exit_free:
 static struct i2c_driver fm3130_driver = {
 	.driver = {
 		.name	= "rtc-fm3130",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= fm3130_probe,
 	.id_table	= fm3130_id,
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index e9da7959d3fe..097325d96db5 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -599,7 +599,6 @@ MODULE_DEVICE_TABLE(of, hym8563_dt_idtable);
 static struct i2c_driver hym8563_driver = {
 	.driver		= {
 		.name	= "rtc-hym8563",
-		.owner	= THIS_MODULE,
 		.pm	= &hym8563_pm_ops,
 		.of_match_table	= hym8563_dt_idtable,
 	},
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index da818d3337ce..ee3e8dbcacaf 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -659,7 +659,6 @@ MODULE_DEVICE_TABLE(i2c, isl12057_id);
 static struct i2c_driver isl12057_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 		.pm = &isl12057_rtc_pm_ops,
 		.of_match_table = of_match_ptr(isl12057_dt_match),
 	},
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 9bd842e97749..b7e1f4170ad1 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -217,7 +217,6 @@ MODULE_DEVICE_TABLE(of, pcf2127_of_match);
 static struct i2c_driver pcf2127_driver = {
 	.driver		= {
 		.name	= "rtc-pcf2127",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(pcf2127_of_match),
 	},
 	.probe		= pcf2127_probe,
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 6a12bf62c504..b6d73dd881f2 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -189,7 +189,6 @@ MODULE_DEVICE_TABLE(of, pcf85063_of_match);
 static struct i2c_driver pcf85063_driver = {
 	.driver		= {
 		.name	= "rtc-pcf85063",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(pcf85063_of_match),
 	},
 	.probe		= pcf85063_probe,
diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 4cdb64be061b..e7ebcc0b7e59 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -334,7 +334,6 @@ MODULE_DEVICE_TABLE(of, pcf8523_of_match);
 static struct i2c_driver pcf8523_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(pcf8523_of_match),
 	},
 	.probe = pcf8523_probe,
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 8bba022be946..e569243db57e 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -483,7 +483,6 @@ MODULE_DEVICE_TABLE(of, pcf8563_of_match);
 static struct i2c_driver pcf8563_driver = {
 	.driver		= {
 		.name	= "rtc-pcf8563",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(pcf8563_of_match),
 	},
 	.probe		= pcf8563_probe,
diff --git a/drivers/rtc/rtc-pcf8583.c b/drivers/rtc/rtc-pcf8583.c
index 5911a6dca291..7ca9e8871d77 100644
--- a/drivers/rtc/rtc-pcf8583.c
+++ b/drivers/rtc/rtc-pcf8583.c
@@ -309,7 +309,6 @@ MODULE_DEVICE_TABLE(i2c, pcf8583_id);
 static struct i2c_driver pcf8583_driver = {
 	.driver = {
 		.name	= "pcf8583",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= pcf8583_probe,
 	.id_table	= pcf8583_id,
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index e6298e02b400..a297542e2f8a 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -628,7 +628,6 @@ static int rx8025_remove(struct i2c_client *client)
 static struct i2c_driver rx8025_driver = {
 	.driver = {
 		.name = "rtc-rx8025",
-		.owner = THIS_MODULE,
 	},
 	.probe		= rx8025_probe,
 	.remove		= rx8025_remove,
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index de8d9c427782..161e25d016c3 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -315,7 +315,6 @@ MODULE_DEVICE_TABLE(i2c, rx8581_id);
 static struct i2c_driver rx8581_driver = {
 	.driver		= {
 		.name	= "rtc-rx8581",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= rx8581_probe,
 	.id_table	= rx8581_id,
-- 
1.9.1

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
