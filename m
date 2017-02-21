Return-Path: <rtc-linux+bncBCWOL4E62AORBLVBWLCQKGQEQ64GQRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from quartz.orcorp.ca (quartz.orcorp.ca. [184.70.90.242])
        by gmr-mx.google.com with ESMTPS id e196si2086313itc.2.2017.02.21.11.10.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 11:10:38 -0800 (PST)
Date: Tue, 21 Feb 2017 12:09:05 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Marcel Selhorst <tpmdd@selhorst.net>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Olof Johansson <olof@lixom.net>, Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Parav Pandit <pandit.parav@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
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
	Joe Perches <joe@perches.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	Benny Halevy <bhalevy@primarydata.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-mtd@lists.infradead.org,
	linux-media@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-rdma@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 07/14] infiniband: utilize new device_add_cdev
 helper function
Message-ID: <20170221190905.GD13138@obsidianresearch.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-8-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487653253-11497-8-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 20, 2017 at 10:00:46PM -0700, Logan Gunthorpe wrote:
> This patch updates core/ucm.c which didn't originally use the
> cdev.kobj.parent with it's parent device. I did not look heavily into
> whether this was a bug or not, but it seems likely to me there would
> be a use before free.

Hum, is probably safe - ib_ucm_remove_one can only happen on module
unload and the cdev holds the module lock while open.

Even so device_add_cdev should be used anyhow.

> I also took a look at core/uverbs_main.c, core/user_mad.c and
> hw/hfi1/device.c which utilize cdev.kobj.parent but because the
> infiniband core seems to use kobjs internally instead of struct devices
> they could not be converted to use the new helper API and still
> directly manipulate the internals of the kobj.

Yes, and hfi1 had the same use-afte-free bug when it was first
submitted as well. IHMO cdev should have a helper entry for this style
of use case as well.

> diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
> index e0a995b..38ea316 100644
> +++ b/drivers/infiniband/core/ucm.c
> @@ -1283,18 +1283,20 @@ static void ib_ucm_add_one(struct ib_device *device)
>  		set_bit(devnum, dev_map);
>  	}
>  
> +	device_initialize(&ucm_dev->dev);

Ah, this needs more help. Once device_initialize is called put_device
should be the error-unwind, can you use something more like this?

>From ac7a35ea98066c9a9e3f3e54557c0ccda44b0ffc Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Tue, 21 Feb 2017 12:07:55 -0700
Subject: [PATCH] infiniband: utilize new device_add_cdev helper

The use after free is not triggerable here because the cdev holds
the module lock and the only device_unregister is only triggered by
module ouload, however make the change for consistency.

To make this work the cdev_del needs to move out of the struct device
release function.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/infiniband/core/ucm.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index 7713ef089c3ccc..acda8d941381f3 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -1202,12 +1202,16 @@ static void ib_ucm_release_dev(struct device *dev)
 	struct ib_ucm_device *ucm_dev;
 
 	ucm_dev = container_of(dev, struct ib_ucm_device, dev);
+	kfree(ucm_dev);
+}
+
+static void ib_ucm_cdev_del(struct ib_ucm_device *ucm_dev)
+{
 	cdev_del(&ucm_dev->cdev);
 	if (ucm_dev->devnum < IB_UCM_MAX_DEVICES)
 		clear_bit(ucm_dev->devnum, dev_map);
 	else
 		clear_bit(ucm_dev->devnum - IB_UCM_MAX_DEVICES, overflow_map);
-	kfree(ucm_dev);
 }
 
 static const struct file_operations ucm_fops = {
@@ -1263,6 +1267,7 @@ static void ib_ucm_add_one(struct ib_device *device)
 	if (!ucm_dev)
 		return;
 
+	device_initialize(&ucm_dev->dev);
 	ucm_dev->ib_dev = device;
 
 	devnum = find_first_zero_bit(dev_map, IB_UCM_MAX_DEVICES);
@@ -1280,18 +1285,19 @@ static void ib_ucm_add_one(struct ib_device *device)
 		set_bit(devnum, dev_map);
 	}
 
+	ucm_dev->dev.devt = base;
+	ucm_dev->dev.release = ib_ucm_release_dev;
+
 	cdev_init(&ucm_dev->cdev, &ucm_fops);
 	ucm_dev->cdev.owner = THIS_MODULE;
 	kobject_set_name(&ucm_dev->cdev.kobj, "ucm%d", ucm_dev->devnum);
-	if (cdev_add(&ucm_dev->cdev, base, 1))
+	if (device_add_cdev(&ucm_dev->dev, &ucm_dev->cdev))
 		goto err;
 
 	ucm_dev->dev.class = &cm_class;
 	ucm_dev->dev.parent = device->dma_device;
-	ucm_dev->dev.devt = ucm_dev->cdev.dev;
-	ucm_dev->dev.release = ib_ucm_release_dev;
 	dev_set_name(&ucm_dev->dev, "ucm%d", ucm_dev->devnum);
-	if (device_register(&ucm_dev->dev))
+	if (device_add(&ucm_dev->dev))
 		goto err_cdev;
 
 	if (device_create_file(&ucm_dev->dev, &dev_attr_ibdev))
@@ -1303,13 +1309,9 @@ static void ib_ucm_add_one(struct ib_device *device)
 err_dev:
 	device_unregister(&ucm_dev->dev);
 err_cdev:
-	cdev_del(&ucm_dev->cdev);
-	if (ucm_dev->devnum < IB_UCM_MAX_DEVICES)
-		clear_bit(devnum, dev_map);
-	else
-		clear_bit(devnum, overflow_map);
+	ib_ucm_cdev_del(ucm_dev);
 err:
-	kfree(ucm_dev);
+	put_device(&ucm_dev->dev);
 	return;
 }
 
@@ -1320,6 +1322,7 @@ static void ib_ucm_remove_one(struct ib_device *device, void *client_data)
 	if (!ucm_dev)
 		return;
 
+	ib_ucm_cdev_del(ucm_dev);
 	device_unregister(&ucm_dev->dev);
 }
 
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
