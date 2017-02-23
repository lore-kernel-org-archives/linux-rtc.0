Return-Path: <rtc-linux+bncBDP6N55ZUYDRBM56XLCQKGQEX7KWXQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com. [2607:f8b0:400e:c05::243])
        by gmr-mx.google.com with ESMTPS id f7si744461pfk.5.2017.02.23.00.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 00:37:07 -0800 (PST)
Received: by mail-pg0-x243.google.com with SMTP id 1so3791721pgz.2
        for <rtc-linux@googlegroups.com>; Thu, 23 Feb 2017 00:37:07 -0800 (PST)
Date: Thu, 23 Feb 2017 00:37:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
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
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 03/14] input: utilize new device_add_cdev
 helper function
Message-ID: <20170223083703.GF18639@dtor-ws>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-4-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487653253-11497-4-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 20, 2017 at 10:00:42PM -0700, Logan Gunthorpe wrote:
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Please add some more verbage, otherwise

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


>  drivers/input/evdev.c    | 3 +--
>  drivers/input/joydev.c   | 3 +--
>  drivers/input/mousedev.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..a3407ea 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -1416,8 +1416,7 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
>  		goto err_free_evdev;
>  
>  	cdev_init(&evdev->cdev, &evdev_fops);
> -	evdev->cdev.kobj.parent = &evdev->dev.kobj;
> -	error = cdev_add(&evdev->cdev, evdev->dev.devt, 1);
> +	error = device_add_cdev(&evdev->dev, &evdev->cdev);
>  	if (error)
>  		goto err_unregister_handle;
>  
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index abd18f3..012e06f 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -905,8 +905,7 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
>  		goto err_free_joydev;
>  
>  	cdev_init(&joydev->cdev, &joydev_fops);
> -	joydev->cdev.kobj.parent = &joydev->dev.kobj;
> -	error = cdev_add(&joydev->cdev, joydev->dev.devt, 1);
> +	error = device_add_cdev(&joydev->dev, &joydev->cdev);
>  	if (error)
>  		goto err_unregister_handle;
>  
> diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> index b604564..efd8666 100644
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -901,8 +901,7 @@ static struct mousedev *mousedev_create(struct input_dev *dev,
>  	}
>  
>  	cdev_init(&mousedev->cdev, &mousedev_fops);
> -	mousedev->cdev.kobj.parent = &mousedev->dev.kobj;
> -	error = cdev_add(&mousedev->cdev, mousedev->dev.devt, 1);
> +	error = device_add_cdev(&mousedev->dev, &mousedev->cdev);
>  	if (error)
>  		goto err_unregister_handle;
>  
> -- 
> 2.1.4
> 

-- 
Dmitry

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
