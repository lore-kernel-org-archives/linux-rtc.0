Return-Path: <rtc-linux+bncBAABBJNAWPCQKGQE4AJRAEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 23si3556773pfw.4.2017.02.21.15.41.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 15:41:25 -0800 (PST)
To: Dan Williams <dan.j.williams@intel.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-2-git-send-email-logang@deltatee.com>
 <20170221053522.GA1466@dtor-ws>
 <17f32963-1d0e-5d17-64c9-742b05415722@deltatee.com>
 <CAPcyv4jOWDxjQoBdZ8GQ+yhcAcL2gOBoEEHE-02beopXKFmGQA@mail.gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
 osd-dev@open-osd.org, linux-scsi <linux-scsi@vger.kernel.org>,
 rtc-linux@googlegroups.com, linux-mtd@lists.infradead.org,
 "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 linux-iio@vger.kernel.org, linux-rdma@vger.kernel.org,
 tpmdd-devel@lists.sourceforge.net, linux-gpio@vger.kernel.org,
 linux-input@vger.kernel.org,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0f24273d-028c-9fa3-3fe7-975d2b0540f8@deltatee.com>
Date: Tue, 21 Feb 2017 16:41:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jOWDxjQoBdZ8GQ+yhcAcL2gOBoEEHE-02beopXKFmGQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [rtc-linux] Re: [PATCH 01/14] chardev: add helper function to
 register char devs with a struct device
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hey,

Ok, I'll do a v2 later this week with some of the feedback and tags?

Logan

On 21/02/17 11:18 AM, Dan Williams wrote:
> On Mon, Feb 20, 2017 at 10:35 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>> On 20/02/17 10:35 PM, Dmitry Torokhov wrote:
>>> My only objection is to this statement. There is absolutely nothing that
>>> prevents from calling device_unregister() first and cdev_del() later.
>>> Refcounting will sort it all out.
>>
>> Yeah, I was really trying to warn people against calling cdev_del within
>> the release function of the device. If you do that, then the cdev
>> reference will block the device from ever getting released.
>>
>> Certainly, you could call device_unregister followed by cdev_del. I
>> could reword this if you feel it necessary.
> 
> I agree with Dmitry, just delete the statement in parenthesis and the
> rest is fine. If you're modifying this patch it might be good to take
> the opportunity to add a WARN_ON(!parent->kobj.state_initialized) to
> catch attempts to call device_add_cdev() with an uninitialized device.
> 
> You can also add:
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
