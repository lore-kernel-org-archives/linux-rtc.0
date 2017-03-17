Return-Path: <rtc-linux+bncBCUJ7YGL3QFBB7GZVTDAKGQE4DDCZ4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id 2si1159885pfz.1.2017.03.16.17.25.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 17:25:32 -0700 (PDT)
Date: Fri, 17 Mar 2017 09:24:49 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
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
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 01/16] chardev: add helper function to
 register char devs with a struct device
Message-ID: <20170317002449.GA23896@kroah.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
 <1488783873-2614-2-git-send-email-logang@deltatee.com>
 <20170316132222.GA9923@kroah.com>
 <98d81155-5290-b251-4728-43781d45c23b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <98d81155-5290-b251-4728-43781d45c23b@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Mar 16, 2017 at 11:38:40AM -0600, Logan Gunthorpe wrote:
> > I don't know why kbuild didn't catch these before, but it looks like we
> > really need to include device.h in cdev.h now to fix up these build
> > warnings, right?
> 
> > I'll try that out and rebase the char-misc-testing tree in the morning
> > to see if that fixes the build problems...
> 
> 
> Yeah, I think the kbuild robot missed the series because the vger
> mailing lists were dropping this series :(
> 
> I also don't know why my kernel config didn't catch this warning but
> I reproduced and fixed it with the kbuild's config. I'll send an updated
> patch which adds a include device.h line to cdev.h momentarily.

Thanks, I've updated my tree with your new patch, let's see what breaks
this time :)

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
