Return-Path: <rtc-linux+bncBCWOL4E62AORBR6AWPCQKGQETH77R4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from quartz.orcorp.ca (quartz.orcorp.ca. [184.70.90.242])
        by gmr-mx.google.com with ESMTPS id n127si2103673ita.3.2017.02.21.16.50.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 16:50:15 -0800 (PST)
Date: Tue, 21 Feb 2017 17:48:23 -0700
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
Message-ID: <20170222004823.GB11487@obsidianresearch.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-8-git-send-email-logang@deltatee.com>
 <20170221190905.GD13138@obsidianresearch.com>
 <c7d34394-a9e8-fc9f-92f5-42c56a73ad1f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <c7d34394-a9e8-fc9f-92f5-42c56a73ad1f@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Feb 21, 2017 at 04:54:05PM -0700, Logan Gunthorpe wrote:

> Is that true? Once device_register or device_add is called then you need
> to use put_device.

General rule is once kref_init has been called then you should use
kref_put and not kfree.

device_initialize ultimately calls kref_init..

Reasoning that you don't 'need' to use put_device until device_add is
just too hard.

For instance, there is still another bug in ib_ucm_add_one:

	if (device_add(&ucm_dev->dev))
		goto err_cdev;

	if (device_create_file(&ucm_dev->dev, &dev_attr_ibdev))
		goto err_dev;
[....]
err_dev:
	device_unregister(&ucm_dev->dev);
err_cdev:
	ib_ucm_cdev_del(ucm_dev);
err:
	kfree(ucm_dev);
	return;
}

If we go down the err_dev path then device_unregister will probably
kfree ucm_dev - the argument is not guarenteed valid after
device_unregister returns - this is what makes it different from
device_del.

The simplest fix is to change the unwind into:

err_dev:
	device_del(&ucm_dev->dev);
err_cdev:
	ib_ucm_cdev_del(ucm_dev);
err:
	put_device(&ucm_dev->dev);
	return;
}

And the only way to keep our idiomatic goto unwind working is if all
'goto errs' can call put_device - which requires the device_initialize
be done before any errors are possible.

> In fact device_add is what does the first get_device so this doesn't
> add up to me.

Not quite, kref_init creates a kref with a count of 1 - eg the caller
owns the ref, and that ref must be put to trigger kref release.

Thus good kref usage should always pair a kref_put with the kref_init.

The get_device at the start of device_add pairs with the put_device at
the end of device_del and the kref_init pairs with the put_device at
the end of device_unregister. (notice that device_unregister ends up
calling put_device twice in a row..)

I'll send you a clean patch for your v2.

> I know the DAX code only uses put_device after device_add.

Looks to me like that code fails to call cdev_del if device_add fails?

This approach is problematic because it is trying do the ida removals
in the release function. That is not necessary and has the side effect
of making the release function uncallable until too late in the
process.

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
