Return-Path: <rtc-linux+bncBCWOL4E62AORB6FO2HCQKGQERYBEL6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from quartz.orcorp.ca (quartz.orcorp.ca. [184.70.90.242])
        by gmr-mx.google.com with ESMTPS id b188si1480860ite.3.2017.02.27.08.44.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 08:44:40 -0800 (PST)
Date: Mon, 27 Feb 2017 09:42:09 -0700
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
	Leon Romanovsky <leon@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
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
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-mtd@lists.infradead.org, linux-media@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 06/16] tpm-chip: utilize new
 cdev_device_add helper function
Message-ID: <20170227164209.GD5891@obsidianresearch.com>
References: <1488091097-12328-1-git-send-email-logang@deltatee.com>
 <1488091097-12328-7-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1488091097-12328-7-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Feb 25, 2017 at 11:38:07PM -0700, Logan Gunthorpe wrote:
> Replace the open coded registration of the cdev and dev with the
> new device_add_cdev() helper. The helper replaces a common pattern by
> taking the proper reference against the parent device and adding both
> the cdev and the device.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/char/tpm/tpm-chip.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index a77262d..933f96e 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -187,7 +187,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *dev,
>  
>  	cdev_init(&chip->cdev, &tpm_fops);
>  	chip->cdev.owner = THIS_MODULE;
> -	chip->cdev.kobj.parent = &chip->dev.kobj;
>  
>  	return chip;
>  
> @@ -230,27 +229,16 @@ static int tpm_add_char_device(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> -	rc = cdev_add(&chip->cdev, chip->dev.devt, 1);
> +	rc = cdev_device_add(&chip->cdev, &chip->dev);
>  	if (rc) {
>  		dev_err(&chip->dev,
> -			"unable to cdev_add() %s, major %d, minor %d, err=%d\n",
> +			"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
>  			dev_name(&chip->dev), MAJOR(chip->dev.devt),
>  			MINOR(chip->dev.devt), rc);
>  
>  		return rc;
>  	}
>  
> -	rc = device_add(&chip->dev);
> -	if (rc) {
> -		dev_err(&chip->dev,
> -			"unable to device_register() %s, major %d, minor %d, err=%d\n",
> -			dev_name(&chip->dev), MAJOR(chip->dev.devt),
> -			MINOR(chip->dev.devt), rc);
> -
> -		cdev_del(&chip->cdev);
> -		return rc;
> -	}

This will collide with the patch I sent:

https://patchwork.kernel.org/patch/9589001/

Jarkko: The resolution will be to continue to call tpm_del_char_device
from the cdev_device_add error path and drop all calls to cdev_del

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
