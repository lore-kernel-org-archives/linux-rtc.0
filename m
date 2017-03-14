Return-Path: <rtc-linux+bncBDE6RCFOWIARBHMYUDDAKGQEJMA6KUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x232.google.com (mail-io0-x232.google.com. [2607:f8b0:4001:c06::232])
        by gmr-mx.google.com with ESMTPS id f73si22233ita.1.2017.03.14.08.28.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 08:28:29 -0700 (PDT)
Received: by mail-io0-x232.google.com with SMTP id z13so1667674iof.2
        for <rtc-linux@googlegroups.com>; Tue, 14 Mar 2017 08:28:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488783873-2614-6-git-send-email-logang@deltatee.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com> <1488783873-2614-6-git-send-email-logang@deltatee.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Mar 2017 16:28:28 +0100
Message-ID: <CACRpkdaNW+kexYNOZiVTRywHpwndKLbXmP1NXDjOifKY3JUURQ@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH v3 05/16] gpiolib: utilize new cdev_device_add
 helper function
To: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexandre Courbot <gnurou@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Olof Johansson <olof@lixom.net>,
	Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Haggai Eran <haggaie@mellanox.com>, Parav Pandit <pandit.parav@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>,
	Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@atmel.com>, Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>, Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>, Lorenzo Stoakes <lstoakes@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boaz Harrosh <ooo@electrozaur.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Stephen Bates <stephen.bates@microsemi.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>, linux-scsi@vger.kernel.org,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-rdma@vger.kernel.org,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Mar 6, 2017 at 8:04 AM, Logan Gunthorpe <logang@deltatee.com> wrote:

> Replace the open coded registration of the cdev and dev with the
> new device_add_cdev() helper. The helper replaces a common pattern by
> taking the proper reference against the parent device and adding both
> the cdev and the device.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please inform me if you plan to merge this into the device core
tree or similar, or whether I should apply it for like v4.13 after merging
the core patch or so.

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
