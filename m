Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB26MWDCQKGQECQVZOKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f7si1067931wmg.3.2017.02.21.03.37.14
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 03:37:14 -0800 (PST)
Date: Tue, 21 Feb 2017 12:37:04 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 02/14] device-dax: utilize new device_add_cdev
 helper function
Message-ID: <20170221113704.ibwkk2vuc5imkmae@piout.net>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-3-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487653253-11497-3-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

A small comment, you must always have a commit message. Even if it is
small.

On 20/02/2017 at 22:00:41 -0700, Logan Gunthorpe wrote:
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dax/dax.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/dax.c b/drivers/dax/dax.c
> index ed758b7..0d24822 100644
> --- a/drivers/dax/dax.c
> +++ b/drivers/dax/dax.c
> @@ -701,12 +701,12 @@ struct dax_dev *devm_create_dax_dev(struct dax_region *dax_region,
>  
>  	/* device_initialize() so cdev can reference kobj parent */
>  	device_initialize(dev);
> +	dev->devt = dev_t;
>  
>  	cdev = &dax_dev->cdev;
>  	cdev_init(cdev, &dax_fops);
>  	cdev->owner = parent->driver->owner;
> -	cdev->kobj.parent = &dev->kobj;
> -	rc = cdev_add(&dax_dev->cdev, dev_t, 1);
> +	rc = device_add_cdev(dev, cdev);
>  	if (rc)
>  		goto err_cdev;
>  
> @@ -716,7 +716,6 @@ struct dax_dev *devm_create_dax_dev(struct dax_region *dax_region,
>  	dax_dev->region = dax_region;
>  	kref_get(&dax_region->kref);
>  
> -	dev->devt = dev_t;
>  	dev->class = dax_class;
>  	dev->parent = parent;
>  	dev->groups = dax_attribute_groups;
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
