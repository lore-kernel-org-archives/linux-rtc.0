Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [V2] rtc: rtc-v3020: use gpio_request_array()
From: Jingoo Han <jg1.han@samsung.com>
Message-Id: <008a01ce10a3$02d28db0$0877a910$%han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Alessandro Zummo' <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com, 'Igor Grinberg' <grinberg@compulab.co.il>,
 'Jingoo Han' <jg1.han@samsung.com>
Date: Fri, 22 Feb 2013 11:19:15 +0900
List-ID: <rtc-linux.googlegroups.com>

Using gpio_request_array()/gpio_free_array() can make the code
simpler because it can set the direction and initial value
in one shot and the for loop is unnecessary.

Also, struct v3020_gpio is removed, because the struct v3020_gpio
is replaced with struct gpio.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- Replace gpio_request_one() with gpio_request_array()

 drivers/rtc/rtc-v3020.c |   37 ++++++++++++-------------------------
 1 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
index bca5d67..600798c 100644
--- a/drivers/rtc/rtc-v3020.c
+++ b/drivers/rtc/rtc-v3020.c
@@ -49,18 +49,13 @@ struct v3020_chip_ops {
 #define V3020_RD	2
 #define V3020_IO	3
 
-struct v3020_gpio {
-	const char *name;
-	unsigned int gpio;
-};
-
 struct v3020 {
 	/* MMIO access */
 	void __iomem *ioaddress;
 	int leftshift;
 
 	/* GPIO access */
-	struct v3020_gpio *gpio;
+	struct gpio *gpio;
 
 	struct v3020_chip_ops *ops;
 
@@ -107,48 +102,40 @@ static struct v3020_chip_ops v3020_mmio_ops = {
 	.write_bit	= v3020_mmio_write_bit,
 };
 
-static struct v3020_gpio v3020_gpio[] = {
-	{ "RTC CS", 0 },
-	{ "RTC WR", 0 },
-	{ "RTC RD", 0 },
-	{ "RTC IO", 0 },
+static struct gpio v3020_gpio[] = {
+	{ 0, GPIOF_OUT_INIT_HIGH, "RTC CS"},
+	{ 0, GPIOF_OUT_INIT_HIGH, "RTC WR"},
+	{ 0, GPIOF_OUT_INIT_HIGH, "RTC RD"},
+	{ 0, GPIOF_OUT_INIT_HIGH, "RTC IO"},
 };
 
 static int v3020_gpio_map(struct v3020 *chip, struct platform_device *pdev,
 			  struct v3020_platform_data *pdata)
 {
-	int i, err;
+	int err;
 
 	v3020_gpio[V3020_CS].gpio = pdata->gpio_cs;
 	v3020_gpio[V3020_WR].gpio = pdata->gpio_wr;
 	v3020_gpio[V3020_RD].gpio = pdata->gpio_rd;
 	v3020_gpio[V3020_IO].gpio = pdata->gpio_io;
 
-	for (i = 0; i < ARRAY_SIZE(v3020_gpio); i++) {
-		err = gpio_request(v3020_gpio[i].gpio, v3020_gpio[i].name);
-		if (err)
-			goto err_request;
-
-		gpio_direction_output(v3020_gpio[i].gpio, 1);
-	}
+	err = gpio_request_array(v3020_gpio, ARRAY_SIZE(v3020_gpio));
+	if (err)
+		goto err_request;
 
 	chip->gpio = v3020_gpio;
 
 	return 0;
 
 err_request:
-	while (--i >= 0)
-		gpio_free(v3020_gpio[i].gpio);
+	gpio_free_array(v3020_gpio, ARRAY_SIZE(v3020_gpio));
 
 	return err;
 }
 
 static void v3020_gpio_unmap(struct v3020 *chip)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(v3020_gpio); i++)
-		gpio_free(v3020_gpio[i].gpio);
+	gpio_free_array(v3020_gpio, ARRAY_SIZE(v3020_gpio));
 }
 
 static void v3020_gpio_write_bit(struct v3020 *chip, unsigned char bit)
