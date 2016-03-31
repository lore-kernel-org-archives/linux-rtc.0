Return-Path: <rtc-linux+bncBDS7HNEFSALRBTPG6S3QKGQEDCEOX6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si513297wml.0.2016.03.31.07.25.17
        for <rtc-linux@googlegroups.com>;
        Thu, 31 Mar 2016 07:25:17 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: remove useless DRV_VERSION
Date: Thu, 31 Mar 2016 16:25:14 +0200
Message-Id: <1459434314-23392-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Many drivers are defining a DRV_VERSION. This is often only used for
MODULE_VERSION and sometimes to print an info message at probe time. This
is kind of pointless as they are all versionned with the kernel anyway.
Also the core will print a message when a new rtc is found.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1216.c   | 3 ---
 drivers/rtc/rtc-ds1286.c   | 3 ---
 drivers/rtc/rtc-ds1302.c   | 2 --
 drivers/rtc/rtc-ds1343.c   | 2 --
 drivers/rtc/rtc-ds1511.c   | 3 ---
 drivers/rtc/rtc-ds1553.c   | 3 ---
 drivers/rtc/rtc-ds1672.c   | 5 -----
 drivers/rtc/rtc-ds1685.c   | 3 ---
 drivers/rtc/rtc-ds1742.c   | 3 ---
 drivers/rtc/rtc-ep93xx.c   | 3 ---
 drivers/rtc/rtc-gemini.c   | 1 -
 drivers/rtc/rtc-isl12022.c | 5 -----
 drivers/rtc/rtc-isl1208.c  | 6 ------
 drivers/rtc/rtc-m48t35.c   | 3 ---
 drivers/rtc/rtc-m48t86.c   | 4 ----
 drivers/rtc/rtc-max6900.c  | 5 -----
 drivers/rtc/rtc-pcf2123.c  | 4 ----
 drivers/rtc/rtc-pcf8563.c  | 5 -----
 drivers/rtc/rtc-rs5c313.c  | 2 --
 drivers/rtc/rtc-rs5c348.c  | 4 ----
 drivers/rtc/rtc-rs5c372.c  | 6 +-----
 drivers/rtc/rtc-rx8581.c   | 5 -----
 drivers/rtc/rtc-sh.c       | 2 --
 drivers/rtc/rtc-stk17ta8.c | 3 ---
 drivers/rtc/rtc-x1205.c    | 5 -----
 25 files changed, 1 insertion(+), 89 deletions(-)

diff --git a/drivers/rtc/rtc-ds1216.c b/drivers/rtc/rtc-ds1216.c
index 12dbd70859ae..9c82b1da2d45 100644
--- a/drivers/rtc/rtc-ds1216.c
+++ b/drivers/rtc/rtc-ds1216.c
@@ -11,8 +11,6 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 
-#define DRV_VERSION "0.2"
-
 struct ds1216_regs {
 	u8 tsec;
 	u8 sec;
@@ -176,5 +174,4 @@ module_platform_driver_probe(ds1216_rtc_platform_driver, ds1216_rtc_probe);
 MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_DESCRIPTION("DS1216 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-ds1216");
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 8247a29a4eb4..756e509f6ed2 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -20,8 +20,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#define DRV_VERSION		"1.0"
-
 struct ds1286_priv {
 	struct rtc_device *rtc;
 	u32 __iomem *rtcregs;
@@ -363,5 +361,4 @@ module_platform_driver(ds1286_platform_driver);
 MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_DESCRIPTION("DS1286 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-ds1286");
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 5cdc0f201b34..7811b357ed70 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -19,7 +19,6 @@
 #include <linux/spi/spi.h>
 
 #define DRV_NAME	"rtc-ds1302"
-#define DRV_VERSION	"1.0.0"
 
 #define	RTC_CMD_READ	0x81		/* Read command */
 #define	RTC_CMD_WRITE	0x80		/* Write command */
@@ -216,6 +215,5 @@ static struct spi_driver ds1302_driver = {
 module_spi_driver(ds1302_driver);
 
 MODULE_DESCRIPTION("Dallas DS1302 RTC driver");
-MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR("Paul Mundt, David McCullough");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 3d389bd8a289..23fa9f0cb5e3 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -24,7 +24,6 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 
-#define DS1343_DRV_VERSION	"01.00"
 #define DALLAS_MAXIM_DS1343	0
 #define DALLAS_MAXIM_DS1344	1
 
@@ -747,4 +746,3 @@ MODULE_DESCRIPTION("DS1343 RTC SPI Driver");
 MODULE_AUTHOR("Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>,"
 		"Ankur Srivastava <sankurece@gmail.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION(DS1343_DRV_VERSION);
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index da3d04ce83bd..1b2dcb58c0ab 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -25,8 +25,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.6"
-
 enum ds1511reg {
 	DS1511_SEC = 0x0,
 	DS1511_MIN = 0x1,
@@ -537,4 +535,3 @@ module_platform_driver(ds1511_rtc_driver);
 MODULE_AUTHOR("Andrew Sharp <andy.sharp@lsi.com>");
 MODULE_DESCRIPTION("Dallas DS1511 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 38422ab4ec5a..9961ec646fd2 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -20,8 +20,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.3"
-
 #define RTC_REG_SIZE		0x2000
 #define RTC_OFFSET		0x1ff0
 
@@ -359,4 +357,3 @@ module_platform_driver(ds1553_rtc_driver);
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("Dallas DS1553 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 92b1cbf2c4a7..5c18ac7394c4 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -13,8 +13,6 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.4"
-
 /* Registers */
 
 #define DS1672_REG_CNT_BASE	0
@@ -165,8 +163,6 @@ static int ds1672_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	rtc = devm_rtc_device_register(&client->dev, ds1672_driver.driver.name,
 				  &ds1672_rtc_ops, THIS_MODULE);
 
@@ -213,4 +209,3 @@ module_i2c_driver(ds1672_driver);
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("Dallas/Maxim DS1672 timekeeper driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 1e6cfc84b1f6..2698d8ffe4fd 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -32,8 +32,6 @@
 #include <linux/proc_fs.h>
 #endif
 
-#define DRV_VERSION	"0.42.0"
-
 
 /* ----------------------------------------------------------------------- */
 /* Standard read/write functions if platform does not provide overrides */
@@ -2224,5 +2222,4 @@ MODULE_AUTHOR("Joshua Kinard <kumba@gentoo.org>");
 MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd-electronics.com>");
 MODULE_DESCRIPTION("Dallas/Maxim DS1685/DS1687-series RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-ds1685");
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index c5168b3bcf1a..3abf1cbfb8ce 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -24,8 +24,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.4"
-
 #define RTC_SIZE		8
 
 #define RTC_CONTROL		0
@@ -239,5 +237,4 @@ module_platform_driver(ds1742_rtc_driver);
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("Dallas DS1742 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-ds1742");
diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index a1628adf9f52..694038208745 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -28,8 +28,6 @@
 #define  EP93XX_RTC_SWCOMP_INT_MASK	 0x0000ffff
 #define  EP93XX_RTC_SWCOMP_INT_SHIFT	 0
 
-#define DRV_VERSION "0.3"
-
 /*
  * struct device dev.platform_data is used to store our private data
  * because struct rtc_device does not have a variable to hold it.
@@ -184,5 +182,4 @@ module_platform_driver(ep93xx_rtc_driver);
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("EP93XX RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:ep93xx-rtc");
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index f46b6d46a51b..b57505efadbc 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -28,7 +28,6 @@
 #include <linux/module.h>
 
 #define DRV_NAME        "rtc-gemini"
-#define DRV_VERSION     "0.2"
 
 MODULE_AUTHOR("Hans Ulli Kroll <ulli.kroll@googlemail.com>");
 MODULE_DESCRIPTION("RTC driver for Gemini SoC");
diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 839d1fd63cd7..38586a024ee8 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -20,8 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#define DRV_VERSION "0.1"
-
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
 #define ISL12022_REG_MN		0x01
@@ -258,8 +256,6 @@ static int isl12022_probe(struct i2c_client *client,
 	if (!isl12022)
 		return -ENOMEM;
 
-	dev_dbg(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	i2c_set_clientdata(client, isl12022);
 
 	isl12022->rtc = devm_rtc_device_register(&client->dev,
@@ -299,4 +295,3 @@ module_i2c_driver(isl12022_driver);
 MODULE_AUTHOR("roman.fietze@telemotive.de");
 MODULE_DESCRIPTION("ISL 12022 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index b57a304ff62c..2893785f0eba 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -15,8 +15,6 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 
-#define DRV_VERSION "0.3"
-
 /* Register map */
 /* rtc section */
 #define ISL1208_REG_SC  0x00
@@ -632,9 +630,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
 
-	dev_info(&client->dev,
-		 "chip found, driver version " DRV_VERSION "\n");
-
 	if (client->irq > 0) {
 		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					       isl1208_rtc_interrupt,
@@ -706,4 +701,3 @@ module_i2c_driver(isl1208_driver);
 MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
 MODULE_DESCRIPTION("Intersil ISL1208 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index c62b51217ecf..810f4ea481e4 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -22,8 +22,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
-#define DRV_VERSION		"1.0"
-
 struct m48t35_rtc {
 	u8	pad[0x7ff8];    /* starts at 0x7ff8 */
 	u8	control;
@@ -190,5 +188,4 @@ module_platform_driver(m48t35_platform_driver);
 MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_DESCRIPTION("M48T35 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-m48t35");
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index a17b7a3ceece..f72b91f2501f 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -39,9 +39,6 @@
 #define M48T86_REG_B_SET	(1 << 7)
 #define M48T86_REG_D_VRT	(1 << 7)
 
-#define DRV_VERSION "0.1"
-
-
 static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char reg;
@@ -178,5 +175,4 @@ module_platform_driver(m48t86_rtc_platform_driver);
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("M48T86 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:rtc-m48t86");
diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index b2a76077bbfa..48b6b411f8b2 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -17,8 +17,6 @@
 #include <linux/rtc.h>
 #include <linux/delay.h>
 
-#define DRV_VERSION "0.2"
-
 /*
  * register indices
  */
@@ -218,8 +216,6 @@ max6900_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	rtc = devm_rtc_device_register(&client->dev, max6900_driver.driver.name,
 					&max6900_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc))
@@ -249,4 +245,3 @@ module_i2c_driver(max6900_driver);
 MODULE_DESCRIPTION("Maxim MAX6900 RTC driver");
 MODULE_AUTHOR("Dale Farnsworth <dale@farnsworth.org>");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index da27738b1242..f22e060709e5 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -46,8 +46,6 @@
 #include <linux/module.h>
 #include <linux/sysfs.h>
 
-#define DRV_VERSION "0.6"
-
 /* REGISTERS */
 #define PCF2123_REG_CTRL1	(0x00)	/* Control Register 1 */
 #define PCF2123_REG_CTRL2	(0x01)	/* Control Register 2 */
@@ -395,7 +393,6 @@ static int pcf2123_probe(struct spi_device *spi)
 		}
 	}
 
-	dev_info(&spi->dev, "chip found, driver version " DRV_VERSION "\n");
 	dev_info(&spi->dev, "spiclk %u KHz.\n",
 			(spi->max_speed_hz + 500) / 1000);
 
@@ -474,4 +471,3 @@ module_spi_driver(pcf2123_driver);
 MODULE_AUTHOR("Chris Verges <chrisv@cyberswitching.com>");
 MODULE_DESCRIPTION("NXP PCF2123 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index c8f95b8e463a..d5e6ed96b748 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -23,8 +23,6 @@
 #include <linux/of.h>
 #include <linux/err.h>
 
-#define DRV_VERSION "0.4.4"
-
 #define PCF8563_REG_ST1		0x00 /* status */
 #define PCF8563_REG_ST2		0x01
 #define PCF8563_BIT_AIE		(1 << 1)
@@ -580,8 +578,6 @@ static int pcf8563_probe(struct i2c_client *client,
 	if (!pcf8563)
 		return -ENOMEM;
 
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	i2c_set_clientdata(client, pcf8563);
 	pcf8563->client = client;
 	device_set_wakeup_capable(&client->dev, 1);
@@ -662,4 +658,3 @@ module_i2c_driver(pcf8563_driver);
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("Philips PCF8563/Epson RTC8564 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index 5f48167c802a..89f38e3e917d 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -50,7 +50,6 @@
 #include <linux/io.h>
 
 #define DRV_NAME	"rs5c313"
-#define DRV_VERSION	"1.13"
 
 #ifdef CONFIG_SH_LANDISK
 /*****************************************************/
@@ -407,7 +406,6 @@ static void __exit rs5c313_rtc_exit(void)
 module_init(rs5c313_rtc_init);
 module_exit(rs5c313_rtc_exit);
 
-MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR("kogiidena , Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
 MODULE_DESCRIPTION("Ricoh RS5C313 RTC device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 1162fecab8cf..9a306983aaba 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -25,8 +25,6 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.2"
-
 #define RS5C348_REG_SECS	0
 #define RS5C348_REG_MINS	1
 #define RS5C348_REG_HOURS	2
@@ -171,7 +169,6 @@ static int rs5c348_probe(struct spi_device *spi)
 		goto kfree_exit;
 	}
 
-	dev_info(&spi->dev, "chip found, driver version " DRV_VERSION "\n");
 	dev_info(&spi->dev, "spiclk %u KHz.\n",
 		 (spi->max_speed_hz + 500) / 1000);
 
@@ -230,5 +227,4 @@ module_spi_driver(rs5c348_driver);
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("Ricoh RS5C348 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("spi:rtc-rs5c348");
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 28871cd7e3b5..12270c789088 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -16,9 +16,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.6"
-
-
 /*
  * Ricoh has a family of I2C based RTCs, which differ only slightly from
  * each other.  Differences center on pinout (e.g. how many interrupts,
@@ -640,7 +637,7 @@ static int rs5c372_probe(struct i2c_client *client,
 	if (rs5c372_get_datetime(client, &tm) < 0)
 		dev_warn(&client->dev, "clock needs to be set\n");
 
-	dev_info(&client->dev, "%s found, %s, driver version " DRV_VERSION "\n",
+	dev_info(&client->dev, "%s found, %s\n",
 			({ char *s; switch (rs5c372->type) {
 			case rtc_r2025sd:	s = "r2025sd"; break;
 			case rtc_r2221tl:	s = "r2221tl"; break;
@@ -696,4 +693,3 @@ MODULE_AUTHOR(
 		"Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("Ricoh RS5C372 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 161e25d016c3..0c362a3d1f17 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -18,8 +18,6 @@
 #include <linux/rtc.h>
 #include <linux/log2.h>
 
-#define DRV_VERSION "0.1"
-
 #define RX8581_REG_SC		0x00 /* Second in BCD */
 #define RX8581_REG_MN		0x01 /* Minute in BCD */
 #define RX8581_REG_HR		0x02 /* Hour in BCD */
@@ -292,8 +290,6 @@ static int rx8581_probe(struct i2c_client *client,
 		rx8581->write_block_data = rx8581_write_block_data;
 	}
 
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	rx8581->rtc = devm_rtc_device_register(&client->dev,
 		rx8581_driver.driver.name, &rx8581_rtc_ops, THIS_MODULE);
 
@@ -325,4 +321,3 @@ module_i2c_driver(rx8581_driver);
 MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com>");
 MODULE_DESCRIPTION("Epson RX-8581 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 2b81dd4baf17..a45845a571e5 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -30,7 +30,6 @@
 #include <asm/rtc.h>
 
 #define DRV_NAME	"sh-rtc"
-#define DRV_VERSION	"0.2.3"
 
 #define RTC_REG(r)	((r) * rtc_reg_size)
 
@@ -790,7 +789,6 @@ static struct platform_driver sh_rtc_platform_driver = {
 module_platform_driver_probe(sh_rtc_platform_driver, sh_rtc_probe);
 
 MODULE_DESCRIPTION("SuperH on-chip RTC driver");
-MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>, "
 	      "Jamie Lenehan <lenehan@twibble.org>, "
 	      "Angelo Castello <angelo.castello@st.com>");
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index ba6a83b5b5c9..a456cb6177ea 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -23,8 +23,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#define DRV_VERSION "0.1"
-
 #define RTC_REG_SIZE		0x20000
 #define RTC_OFFSET		0x1fff0
 
@@ -366,4 +364,3 @@ module_platform_driver(stk17ta8_rtc_driver);
 MODULE_AUTHOR("Thomas Hommel <thomas.hommel@ge.com>");
 MODULE_DESCRIPTION("Simtek STK17TA8 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
index 5638b7ba8b06..f08f18e4fcdf 100644
--- a/drivers/rtc/rtc-x1205.c
+++ b/drivers/rtc/rtc-x1205.c
@@ -24,8 +24,6 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 
-#define DRV_VERSION "1.0.8"
-
 /* offsets into CCR area */
 
 #define CCR_SEC			0
@@ -634,8 +632,6 @@ static int x1205_probe(struct i2c_client *client,
 	if (x1205_validate_client(client) < 0)
 		return -ENODEV;
 
-	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
-
 	rtc = devm_rtc_device_register(&client->dev, x1205_driver.driver.name,
 					&x1205_rtc_ops, THIS_MODULE);
 
@@ -693,4 +689,3 @@ MODULE_AUTHOR(
 	"Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_DESCRIPTION("Xicor/Intersil X1205 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRV_VERSION);
-- 
2.8.0.rc3

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
