Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52677 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdJLWDf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 18:03:35 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] rtc: ds1305: use generic nvmem
Date: Fri, 13 Oct 2017 00:03:23 +0200
Message-Id: <20171012220323.7515-2-alexandre.belloni@free-electrons.com>
In-Reply-To: <20171012220323.7515-1-alexandre.belloni@free-electrons.com>
References: <20171012220323.7515-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Instead of adding a binary sysfs attribute from the driver (which suffers
from a race condition as the attribute appears after the device), use the
core to register an nvmem device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-ds1305.c | 59 +++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index c3232c818e65..d8df2e9e14ad 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -514,56 +514,43 @@ static void msg_init(struct spi_message *m, struct spi_transfer *x,
 	spi_message_add_tail(x, m);
 }
 
-static ssize_t
-ds1305_nvram_read(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int ds1305_nvram_read(void *priv, unsigned int off, void *buf,
+			     size_t count)
 {
-	struct spi_device	*spi;
+	struct ds1305		*ds1305 = priv;
+	struct spi_device	*spi = ds1305->spi;
 	u8			addr;
 	struct spi_message	m;
 	struct spi_transfer	x[2];
-	int			status;
-
-	spi = to_spi_device(kobj_to_dev(kobj));
 
 	addr = DS1305_NVRAM + off;
 	msg_init(&m, x, &addr, count, NULL, buf);
 
-	status = spi_sync(spi, &m);
-	if (status < 0)
-		dev_err(&spi->dev, "nvram %s error %d\n", "read", status);
-	return (status < 0) ? status : count;
+	return spi_sync(spi, &m);
 }
 
-static ssize_t
-ds1305_nvram_write(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
-		char *buf, loff_t off, size_t count)
+static int ds1305_nvram_write(void *priv, unsigned int off, void *buf,
+			      size_t count)
 {
-	struct spi_device	*spi;
+	struct ds1305		*ds1305 = priv;
+	struct spi_device	*spi = ds1305->spi;
 	u8			addr;
 	struct spi_message	m;
 	struct spi_transfer	x[2];
-	int			status;
-
-	spi = to_spi_device(kobj_to_dev(kobj));
 
 	addr = (DS1305_WRITE | DS1305_NVRAM) + off;
 	msg_init(&m, x, &addr, count, buf, NULL);
 
-	status = spi_sync(spi, &m);
-	if (status < 0)
-		dev_err(&spi->dev, "nvram %s error %d\n", "write", status);
-	return (status < 0) ? status : count;
+	return spi_sync(spi, &m);
 }
 
-static struct bin_attribute nvram = {
-	.attr.name	= "nvram",
-	.attr.mode	= S_IRUGO | S_IWUSR,
-	.read		= ds1305_nvram_read,
-	.write		= ds1305_nvram_write,
-	.size		= DS1305_NVRAM_LEN,
+static struct nvmem_config ds1305_nvmem_cfg = {
+	.name = "ds1305_nvram",
+	.word_size = 1,
+	.stride = 1,
+	.size = DS1305_NVRAM_LEN,
+	.reg_read = ds1305_nvram_read,
+	.reg_write = ds1305_nvram_write,
 };
 
 /*----------------------------------------------------------------------*/
@@ -715,6 +702,10 @@ static int ds1305_probe(struct spi_device *spi)
 
 	ds1305->rtc->ops = &ds1305_ops;
 
+	ds1305_nvmem_cfg.priv = ds1305;
+	ds1305->rtc->nvmem_config = &ds1305_nvmem_cfg;
+	ds1305->rtc->nvram_old_abi = true;
+
 	status = rtc_register_device(ds1305->rtc);
 	if (status) {
 		dev_dbg(&spi->dev, "register rtc --> %d\n", status);
@@ -739,12 +730,6 @@ static int ds1305_probe(struct spi_device *spi)
 		}
 	}
 
-	/* export NVRAM */
-	status = sysfs_create_bin_file(&spi->dev.kobj, &nvram);
-	if (status < 0) {
-		dev_err(&spi->dev, "register nvram --> %d\n", status);
-	}
-
 	return 0;
 }
 
@@ -752,8 +737,6 @@ static int ds1305_remove(struct spi_device *spi)
 {
 	struct ds1305 *ds1305 = spi_get_drvdata(spi);
 
-	sysfs_remove_bin_file(&spi->dev.kobj, &nvram);
-
 	/* carefully shut down irq and workqueue, if present */
 	if (spi->irq) {
 		set_bit(FLAG_EXITING, &ds1305->flags);
-- 
2.14.2
