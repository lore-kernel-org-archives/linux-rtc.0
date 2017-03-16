Return-Path: <rtc-linux+bncBCUJ7YGL3QFBB246VHDAKGQESZ6HDTQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id c123si772329pfa.4.2017.03.16.01.40.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 01:40:10 -0700 (PDT)
Date: Thu, 16 Mar 2017 17:39:55 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>, linux-scsi@vger.kernel.org,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-rdma@vger.kernel.org,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Linux Input <linux-input@vger.kernel.org>,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [rtc-linux] [PATCH v3 05/16] gpiolib: utilize new cdev_device_add
 helper function
Message-ID: <20170316083955.GA18265@kroah.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
 <1488783873-2614-6-git-send-email-logang@deltatee.com>
 <CACRpkdaNW+kexYNOZiVTRywHpwndKLbXmP1NXDjOifKY3JUURQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CACRpkdaNW+kexYNOZiVTRywHpwndKLbXmP1NXDjOifKY3JUURQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Mar 14, 2017 at 04:28:28PM +0100, Linus Walleij wrote:
> On Mon, Mar 6, 2017 at 8:04 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> > Replace the open coded registration of the cdev and dev with the
> > new device_add_cdev() helper. The helper replaces a common pattern by
> > taking the proper reference against the parent device and adding both
> > the cdev and the device.
> >
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please inform me if you plan to merge this into the device core
> tree or similar, or whether I should apply it for like v4.13 after merging
> the core patch or so.

I'll take this through my tree, no need to bother you with it.

thanks,

greg k-h

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
