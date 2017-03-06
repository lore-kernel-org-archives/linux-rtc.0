Return-Path: <rtc-linux+bncBAABBEUV6TCQKGQESPCNHBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c123si1213360pfa.4.2017.03.05.23.06.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 23:06:58 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Marcel Selhorst <tpmdd@selhorst.net>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Olof Johansson <olof@lixom.net>,
	Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Parav Pandit <pandit.parav@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@atmel.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Bjorn Helgaas <bhelgaas@google.com>
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
Date: Mon,  6 Mar 2017 00:04:21 -0700
Message-Id: <1488783873-2614-6-git-send-email-logang@deltatee.com>
In-Reply-To: <1488783873-2614-1-git-send-email-logang@deltatee.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
Subject: [rtc-linux] [PATCH v3 05/16] gpiolib: utilize new cdev_device_add
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
---
 drivers/gpio/gpiolib.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b4d721..3ce2a27 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1035,18 +1035,14 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 
 	cdev_init(&gdev->chrdev, &gpio_fileops);
 	gdev->chrdev.owner = THIS_MODULE;
-	gdev->chrdev.kobj.parent = &gdev->dev.kobj;
 	gdev->dev.devt = MKDEV(MAJOR(gpio_devt), gdev->id);
-	status = cdev_add(&gdev->chrdev, gdev->dev.devt, 1);
-	if (status < 0)
-		chip_warn(gdev->chip, "failed to add char device %d:%d\n",
-			  MAJOR(gpio_devt), gdev->id);
-	else
-		chip_dbg(gdev->chip, "added GPIO chardev (%d:%d)\n",
-			 MAJOR(gpio_devt), gdev->id);
-	status = device_add(&gdev->dev);
+
+	status = cdev_device_add(&gdev->chrdev, &gdev->dev);
 	if (status)
-		goto err_remove_chardev;
+		return status;
+
+	chip_dbg(gdev->chip, "added GPIO chardev (%d:%d)\n",
+		 MAJOR(gpio_devt), gdev->id);
 
 	status = gpiochip_sysfs_register(gdev);
 	if (status)
@@ -1061,9 +1057,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 	return 0;
 
 err_remove_device:
-	device_del(&gdev->dev);
-err_remove_chardev:
-	cdev_del(&gdev->chrdev);
+	cdev_device_del(&gdev->chrdev, &gdev->dev);
 	return status;
 }
 
@@ -1347,8 +1341,7 @@ void gpiochip_remove(struct gpio_chip *chip)
 	 * be removed, else it will be dangling until the last user is
 	 * gone.
 	 */
-	cdev_del(&gdev->chrdev);
-	device_del(&gdev->dev);
+	cdev_device_del(&gdev->chrdev, &gdev->dev);
 	put_device(&gdev->dev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
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
