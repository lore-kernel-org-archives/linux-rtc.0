Return-Path: <rtc-linux+bncBAABBBEN5XCQKGQEQTC5K4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g82si685406pfb.5.2017.03.04.14.58.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Mar 2017 14:58:12 -0800 (PST)
To: Hans Verkuil <hansverk@cisco.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Olof Johansson <olof@lixom.net>, Doug Ledford <dledford@redhat.com>,
 Sean Hefty <sean.hefty@intel.com>, Hal Rosenstock
 <hal.rosenstock@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Haggai Eran <haggaie@mellanox.com>, Parav Pandit <pandit.parav@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
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
 Boaz Harrosh <ooo@electrozaur.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Stephen Bates <stephen.bates@microsemi.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <1488091097-12328-1-git-send-email-logang@deltatee.com>
 <1488091097-12328-12-git-send-email-logang@deltatee.com>
 <8eff8408-1681-a59d-3b61-8fd5dab73af1@cisco.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-mtd@lists.infradead.org,
 linux-media@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil@xs4all.nl>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9941530f-c36a-3fa0-6f5b-87d779f5988c@deltatee.com>
Date: Sat, 4 Mar 2017 15:57:40 -0700
MIME-Version: 1.0
In-Reply-To: <8eff8408-1681-a59d-3b61-8fd5dab73af1@cisco.com>
Content-Type: text/plain; charset=UTF-8
Subject: [rtc-linux] Re: [PATCH v2 11/16] media: utilize new cdev_device_add
 helper function
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 27/02/17 02:02 AM, Hans Verkuil wrote:
> FYI: this patch series didn't turn up at the linux-media mailinglist for
> some reason.

Strange my mail logs show success (see below) but none of the lists at
vger.kernel.org picked up either v1 or v2. I don't know what to do about
that. My previous other patch series doesn't have an issue and I'm using
the exact same setup. Maybe I'm sending to too many lists at once with
this series? I'm not really sure.

Logan


2017-02-25 23:40:37 1chsTZ-0004fx-8Y => linux-pci@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-scsi@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-media@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-iio@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-rdma@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-gpio@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-input@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-fsdevel@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"
2017-02-25 23:40:37 1chsTZ-0004fx-8Y -> linux-kernel@vger.kernel.org
R=dnslookup T=remote_smtp H=vger.kernel.org [209.132.180.67] C="250
2.7.1 Looks like Linux source DIFF email.. BF:<H 0>; S1751779AbdBZGki"

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
