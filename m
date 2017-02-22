Return-Path: <rtc-linux+bncBCZ4DZNV3IDBB3EUWXCQKGQEB4CBP7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from www381.your-server.de (www381.your-server.de. [78.46.137.84])
        by gmr-mx.google.com with ESMTPS id 13si264916iti.0.2017.02.22.00.23.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 00:23:08 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 07/14] infiniband: utilize new device_add_cdev
 helper function
To: Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-8-git-send-email-logang@deltatee.com>
 <20170221190905.GD13138@obsidianresearch.com>
 <c7d34394-a9e8-fc9f-92f5-42c56a73ad1f@deltatee.com>
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
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Hans Verkuil <hans.verkuil@cisco.com>,
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
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <91c42195-a6a9-e525-43ea-7c44c0204c2c@metafoo.de>
Date: Wed, 22 Feb 2017 09:18:04 +0100
MIME-Version: 1.0
In-Reply-To: <c7d34394-a9e8-fc9f-92f5-42c56a73ad1f@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/22/2017 12:54 AM, Logan Gunthorpe wrote:
[...]
>>
>> Ah, this needs more help. Once device_initialize is called put_device
>> should be the error-unwind, can you use something more like this?
> 
> Is that true? Once device_register or device_add is called then you need
> to use put_device. [...]

device_initialize() documentation:

	NOTE: Use put_device() to give up your reference instead of freeing
	@dev directly once you have called this function.


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
