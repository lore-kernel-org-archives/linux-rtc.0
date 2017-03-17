Return-Path: <rtc-linux+bncBAABBR67WDDAKGQERUBEN6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 190si100545pfv.3.2017.03.17.11.49.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 11:49:43 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-mtd@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 17 Mar 2017 12:48:13 -0600
Message-Id: <1489776503-3151-7-git-send-email-logang@deltatee.com>
In-Reply-To: <1489776503-3151-1-git-send-email-logang@deltatee.com>
References: <1489776503-3151-1-git-send-email-logang@deltatee.com>
Subject: [rtc-linux] [PATCH v5 06/16] tpm-chip: utilize new cdev_device_add
 helper function
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Replace the open coded registration of the cdev and dev with the
new device_add_cdev() helper. The helper replaces a common pattern by
taking the proper reference against the parent device and adding both
the cdev and the device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index c406343..935f0e9 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -187,7 +187,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 
 	cdev_init(&chip->cdev, &tpm_fops);
 	chip->cdev.owner = THIS_MODULE;
-	chip->cdev.kobj.parent = &chip->dev.kobj;
 
 	return chip;
 
@@ -230,27 +229,16 @@ static int tpm_add_char_device(struct tpm_chip *chip)
 {
 	int rc;
 
-	rc = cdev_add(&chip->cdev, chip->dev.devt, 1);
+	rc = cdev_device_add(&chip->cdev, &chip->dev);
 	if (rc) {
 		dev_err(&chip->dev,
-			"unable to cdev_add() %s, major %d, minor %d, err=%d\n",
+			"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
 			dev_name(&chip->dev), MAJOR(chip->dev.devt),
 			MINOR(chip->dev.devt), rc);
 
 		return rc;
 	}
 
-	rc = device_add(&chip->dev);
-	if (rc) {
-		dev_err(&chip->dev,
-			"unable to device_register() %s, major %d, minor %d, err=%d\n",
-			dev_name(&chip->dev), MAJOR(chip->dev.devt),
-			MINOR(chip->dev.devt), rc);
-
-		cdev_del(&chip->cdev);
-		return rc;
-	}
-
 	/* Make the chip available. */
 	mutex_lock(&idr_lock);
 	idr_replace(&dev_nums_idr, chip, chip->dev_num);
@@ -261,8 +249,7 @@ static int tpm_add_char_device(struct tpm_chip *chip)
 
 static void tpm_del_char_device(struct tpm_chip *chip)
 {
-	cdev_del(&chip->cdev);
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 
 	/* Make the chip unavailable. */
 	mutex_lock(&idr_lock);
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
