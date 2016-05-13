Return-Path: <rtc-linux+bncBCO7J6GN7ELBBH642W4QKGQEW2SQXTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com. [2607:f8b0:400e:c03::242])
        by gmr-mx.google.com with ESMTPS id xo2si3060162pab.0.2016.05.12.23.03.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2016 23:03:11 -0700 (PDT)
Received: by mail-pa0-x242.google.com with SMTP id i5so7815421pag.3
        for <rtc-linux@googlegroups.com>; Thu, 12 May 2016 23:03:11 -0700 (PDT)
From: venkat.prashanth2498@gmail.com
To: a.zummo@towertech.it
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	alexandre.belloni@free-electrons.com,
	marcus.folkesson@gmail.com,
	venkat-prashanth <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: add support for Maxim rtc max6916 v3.0
Date: Thu, 12 May 2016 23:02:53 -0700
Message-Id: <1463119373-3187-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: venkat-prashanth <venkat.prashanth2498@gmail.com>

                     [PATCH] rtc: add support to maxim rtc max6916

                     #Change Log: from v2.0 to v3.0

                     - fixed the out-of-tree Makefile and suitably added
                       the modifications in the Makefile

                     - fixed the bad indented Kconfig file

                     -used a define instead of 0x1B as follows
		                #define MAX6916_REG_MAP_ADDRESS 0x1B

                     -moved and placed the test at the begining of the function
                      after the range is properly enforced
		               if (dt->tm_year < 100 || dt->tm_year > 199) {
                      dev_err(&spi->dev,"Year must be between 2000 and 2099.
                      It's %d.\n", dt->tm_year + 1900);
                      return -EINVAL;
                      }

                     - A magic number is a direct usage of a number
                       in the code,instead has been refactored in  the
                       current version v3.0 which use defines as follows:-
                     -max6916_read_reg(&spi->dev,
                      int MAX6916_CONTROL_REG = 0x08, &data);
                     -max6916_write_reg(&spi->dev,
                      int MAX6916_CONTROL_REG= 0x08, data);
                     -max6916_write_reg(&spi->dev,
                      int MAX6916_STATUS_REG = 0x0C, data);
                     -max6916_read_reg(&spi->dev,
                      int MAX6916_CONTROL_REG = 0x08, &data);
		               -max6916_read_reg(&spi->dev,
                      int MAX6916_STATUS_REG  = 0X0C,  &data);
                     -Unnecessary test function if(dt->tm_year >= 100)
                                                  dt->tm_year -= 100;
                      is deleted after the range is properly enforced.
                     -seperated logical code sections with an empty line
                      and used indentation after if-statements.
---
---
 Kconfig       |   9 ++++
 Makefile      |   1 +
 rtc-max6916.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/driver/rtc/Kconfig b/driver/rtc/Kconfig
index fcf87da..5321e8f 100644
--- a/driver/rtc/Kconfig
+++ b/driver/rtc/Kconfig
@@ -699,6 +699,15 @@
  
               This driver can also be built as a module. If so, the module
               will be called rtc-max6902.
+    config RTC_DRV_MAX6916
+            tristate "Maxim MAX6916"
+            help
+              If you say yes here you will get support for the
+              Maxim MAX6916 SPI RTC chip.
+
+              This driver can also be built as a module. If so, the module
+              will be called rtc-max6916.
+
  
     config RTC_DRV_R9701
             tristate "Epson RTC-9701JE"
diff --git a/driver/rtc/Makefile b/driver/rtc/Makefile
index 9421959..0b3fded 100644
--- a/driver/rtc/Makefile
+++ b/driver/rtc/Makefile
@@ -85,6 +85,7 @@
     obj-$(CONFIG_RTC_DRV_M48T86)    += rtc-m48t86.o
     obj-$(CONFIG_RTC_DRV_MAX6900)   += rtc-max6900.o
     obj-$(CONFIG_RTC_DRV_MAX6902)   += rtc-max6902.o
    +obj-$(CONFIG_RTC_DRV_MAX6916)   += rtc-max6916.o
     obj-$(CONFIG_RTC_DRV_MAX77686)  += rtc-max77686.o
     obj-$(CONFIG_RTC_DRV_MAX77802)  += rtc-max77802.o
     obj-$(CONFIG_RTC_DRV_MAX8907)   += rtc-max8907.o
diff --git a/driver/rtc/rtc-max6916.c b/driver/rtc/rtc-max6916.c
index e69de29..ced341a 100644
--- a/driver/rtc/rtc-max6916.c
+++ b/driver/rtc/rtc-max6916.c
@@ -0,0 +1,162 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/spi/spi.h>
+#include <linux/bcd.h>
+
+/* Registers in max6916 rtc */
+
+#define MAX6916_SECONDS_REG          0x01
+#define MAX6916_MINUTES_REG          0x02
+#define MAX6916_HOURS_REG            0x03
+#define MAX6916_DATE_REG             0x04
+#define MAX6916_MONTH_REG            0x05
+#define MAX6916_DAY_REG              0x06
+#define MAX6916_YEAR_REG             0x07
+#define MAX6916_CONTROL_REG          0x08
+#define MAX6916_STATUS_REG           0x0C
+#define MAX6916_CLOCK_BURST          0x3F
+#define MAX6916_REG_MAP_ADDRESS      0x1B
+
+static int max6916_read_reg(struct device *dev, unsigned char address, unsigned char *data)
+
+{
+			struct spi_device *spi = to_spi_device(dev);
+
+			*data = address | 0x80;
+
+			return spi_write_then_read(spi, data, 1, data, 1);
+}
+
+static int max6916_write_reg(struct device *dev, unsigned char address, unsigned char data)
+
+{
+			struct spi_device *spi = to_spi_device(dev);
+			unsigned char buf[2];
+
+			buf[0] = address&0x7F;
+			buf[1] = data;
+
+			return spi_write_then_read(spi, buf, 2, NULL, 0);
+}
+
+static int max6916_read_time(struct device *dev, struct rtc_time *dt)
+{
+			struct spi_device *spi = to_spi_device(dev);
+			int err;
+			unsigned char buf[8];
+
+			buf[0] = MAX6916_CLOCK_BURST | 0x80;
+
+err = spi_write_then_read(spi, buf, 1, buf, 8);
+			if (err)
+			return err;
+
+			dt->tm_sec = bcd2bin(buf[0]);
+			dt->tm_min = bcd2bin(buf[1]);
+			dt->tm_hour = bcd2bin(buf[2] & 0x3F);
+			dt->tm_mday = bcd2bin(buf[3]);
+			dt->tm_mon = bcd2bin(buf[4]) - 1;
+			dt->tm_wday = bcd2bin(buf[5]) - 1;
+			dt->tm_year = bcd2bin(buf[6]) + 100;
+
+			return rtc_valid_tm(dt);
+}
+
+static int max6916_set_time(struct device *dev, struct rtc_time *dt)
+{
+			struct spi_device *spi = to_spi_device(dev);
+			unsigned char buf[9];
+
+			if (dt->tm_year < 100 || dt->tm_year > 199) {
+				dev_err(&spi->dev, "Year must be between 2000 and 2099.It's %d.\n", dt->tm_year+1900);
+			return -EINVAL;
+}
+
+			buf[0] = MAX6916_CLOCK_BURST & 0x7F;
+			buf[1] = bin2bcd(dt->tm_sec);
+			buf[2] = bin2bcd(dt->tm_min);
+			buf[3] = (bin2bcd(dt->tm_hour) & 0X3F);
+			buf[4] = bin2bcd(dt->tm_mday);
+			buf[5] = bin2bcd(dt->tm_mon + 1);
+			buf[6] = bin2bcd(dt->tm_wday + 1);
+			buf[7] = bin2bcd(dt->tm_year % 100);
+			buf[8] = bin2bcd(0x00);
+
+			/* write the rtc settings */
+			return spi_write_then_read(spi, buf, 9, NULL, 0);
+}
+
+static const struct rtc_class_ops max6916_rtc_ops = {
+			.read_time = max6916_read_time,
+			.set_time = max6916_set_time,
+};
+
+static int max6916_probe(struct spi_device *spi)
+{
+			struct rtc_device *rtc;
+			unsigned char data;
+			int res;
+
+			/* spi setup with max6916 in mode 3 and bits per word as 8 */
+			spi->mode = SPI_MODE_3;
+			spi->bits_per_word = 8;
+			spi_setup(spi);
+
+			/* RTC Settings */
+			res = max6916_read_reg(&spi->dev, MAX6916_SECONDS_REG, &data);
+
+			if (res)
+				return res;
+
+			/* Disable the write protect of rtc */
+			max6916_read_reg(&spi->dev, int  MAX6916_CONTROL_REG = 0x08, &data);
+			data = data & ~(1<<7);
+			max6916_write_reg(&spi->dev, int MAX6916_CONTROL_REG = 0x08, data);
+
+			/*Enable the oscillator,disable the oscillator stop flag, and glitch filter to reduce current consumption*/
+			max6916_read_reg(&spi->dev, int MAX6916_STATUS_REG = 0X0C, &data);
+			data = data & MAX6916_REG_MAP_ADDRESS;
+			max6916_write_reg(&spi->dev, int MAX6916_STATUS_REG = 0x0C, data);
+
+			/* display the settings */
+			max6916_read_reg(&spi->dev, int MAX6916_CONTROL_REG = 0x08, &data);
+			dev_info(&spi->dev, "MAX6916 RTC CTRL Reg = 0x%02x\n", data);
+
+			max6916_read_reg(&spi->dev, int MAX6916_STATUS_REG = 0X0C, &data);
+			dev_info(&spi->dev, "MAX6916 RTC Status Reg = 0x%02x\n", data);
+
+			rtc = devm_rtc_device_register(&spi->dev, "max6916", &max6916_rtc_ops, THIS_MODULE);
+
+
+			if (IS_ERR(rtc))
+			return PTR_ERR(rtc);
+
+			spi_set_drvdata(spi, rtc);
+
+			return 0;
+}
+
+static struct spi_driver max6916_driver = {
+			.driver = {
+			.name = "max6916",
+			},
+			.probe = max6916_probe,
+};
+
+module_spi_driver(max6916_driver);
+
+MODULE_DESCRIPTION("MAX6916 SPI RTC DRIVER");
+MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
+MODULE_LICENSE("GPL v2");
+
+
+
+
+
+
+
+
+
-- 
1.9.2

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
