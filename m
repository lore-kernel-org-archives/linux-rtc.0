Return-Path: <rtc-linux+bncBCWOL4E62AORBAMUWLCQKGQEUULOLLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from quartz.orcorp.ca (quartz.orcorp.ca. [184.70.90.242])
        by gmr-mx.google.com with ESMTPS id a17si1606005itd.1.2017.02.21.10.42.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 10:42:09 -0800 (PST)
Date: Tue, 21 Feb 2017 11:39:56 -0700
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
Subject: [rtc-linux] Re: [PATCH 05/14] tpm-chip: utilize new device_add_cdev
 helper function
Message-ID: <20170221183956.GC13138@obsidianresearch.com>
References: <1487653253-11497-1-git-send-email-logang@deltatee.com>
 <1487653253-11497-6-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487653253-11497-6-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Feb 20, 2017 at 10:00:44PM -0700, Logan Gunthorpe wrote:
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/char/tpm/tpm-chip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

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
