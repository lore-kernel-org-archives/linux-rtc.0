Return-Path: <rtc-linux+bncBAABBK5GWPCQKGQEPRNMXCA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u12si3576831pfd.3.2017.02.21.15.54.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 15:54:19 -0800 (PST)
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-8-git-send-email-logang@deltatee.com>
 <20170221190905.GD13138@obsidianresearch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Olof Johansson <olof@lixom.net>, Doug Ledford <dledford@redhat.com>,
 Sean Hefty <sean.hefty@intel.com>, Hal Rosenstock
 <hal.rosenstock@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Haggai Eran <haggaie@mellanox.com>, Parav Pandit <pandit.parav@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Boaz Harrosh <ooo@electrozaur.com>, Benny Halevy <bhalevy@primarydata.com>,
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c7d34394-a9e8-fc9f-92f5-42c56a73ad1f@deltatee.com>
Date: Tue, 21 Feb 2017 16:54:05 -0700
MIME-Version: 1.0
In-Reply-To: <20170221190905.GD13138@obsidianresearch.com>
Content-Type: text/plain; charset=UTF-8
Subject: [rtc-linux] Re: [PATCH 07/14] infiniband: utilize new device_add_cdev
 helper function
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 21/02/17 12:09 PM, Jason Gunthorpe wrote:
> On Mon, Feb 20, 2017 at 10:00:46PM -0700, Logan Gunthorpe wrote:
>> This patch updates core/ucm.c which didn't originally use the
>> cdev.kobj.parent with it's parent device. I did not look heavily into
>> whether this was a bug or not, but it seems likely to me there would
>> be a use before free.
> 
> Hum, is probably safe - ib_ucm_remove_one can only happen on module
> unload and the cdev holds the module lock while open.

Ah, yes looks like you are correct.

> Even so device_add_cdev should be used anyhow.

Agreed.

>> I also took a look at core/uverbs_main.c, core/user_mad.c and
>> hw/hfi1/device.c which utilize cdev.kobj.parent but because the
>> infiniband core seems to use kobjs internally instead of struct devices
>> they could not be converted to use the new helper API and still
>> directly manipulate the internals of the kobj.
> 
> Yes, and hfi1 had the same use-afte-free bug when it was first
> submitted as well. IHMO cdev should have a helper entry for this style
> of use case as well.

I agree, but I'm not sure what that api should look like. Same thing but
kobject_add_cdev???

>> diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
>> index e0a995b..38ea316 100644
>> +++ b/drivers/infiniband/core/ucm.c
>> @@ -1283,18 +1283,20 @@ static void ib_ucm_add_one(struct ib_device *device)
>>  		set_bit(devnum, dev_map);
>>  	}
>>  
>> +	device_initialize(&ucm_dev->dev);
> 
> Ah, this needs more help. Once device_initialize is called put_device
> should be the error-unwind, can you use something more like this?

Is that true? Once device_register or device_add is called then you need
to use put_device. But I didn't think that's true for device_initialize.
In fact device_add is what does the first get_device so this doesn't add
up to me. device_initialize only inits some structures it doesn't do
anything that needs to be torn down -- at least that I'm aware of.

I know the DAX code only uses put_device after device_add. [1]

Logan

[1] http://lxr.free-electrons.com/source/drivers/dax/dax.c#L713

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
