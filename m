Return-Path: <rtc-linux+bncBAABBOE56TCQKGQEPPB42OY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id r66si1216808pfb.7.2017.03.05.23.24.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 23:24:40 -0800 (PST)
Date: Mon, 6 Mar 2017 09:24:54 +0200
From: Leon Romanovsky <leon@kernel.org>
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Olof Johansson <olof@lixom.net>, Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Parav Pandit <pandit.parav@gmail.com>,
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
Subject: [rtc-linux] Re: [PATCH v3 08/16] IB/ucm: utilize new cdev_device_add
 helper function
Message-ID: <20170306072454.GO14379@mtr-leonro.local>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
 <1488783873-2614-9-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
In-Reply-To: <1488783873-2614-9-git-send-email-logang@deltatee.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Mar 06, 2017 at 12:04:24AM -0700, Logan Gunthorpe wrote:
> From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>
> The use after free is not triggerable here because the cdev holds
> the module lock and the only device_unregister is only triggered by
> module unload, however make the change for consistency.
>
> To make this work the cdev_del needs to move out of the struct device
> release function.
>
> This cleans up the error path significantly and thus also fixes a minor
> bug where the devnum would not be released if cdev_add failed.
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAli9DsUACgkQ5GN7iDZy
WKfeDA/+LWy91DyEkMjdR+KX3aTKX/G4GD0Db7Md9hfiApMfYgs799aMb8HDklRv
63PSzGFLFG8xxUDl10DgzDj9xK2+6e7m4X9E6G6fISQlQuRhuKmKk4YO0Dtl0H+Z
Mh7jEAWxQkwwyl1DM2R9BA5ObKDC0LENpGYfFnWZRYCQaQt5GE+bulio8YLprVTM
qb30tmhpUVRTcAvLfJsvGo7V6qO7GZGi2WlaXiCjBuZFcv5yXUND1z2LeTSZAkrn
hmqZslp/akY0zbqoo98/W3tBa3qtKC2TrYQtqWZOyD7VlrcZ/5HL4kGg+hF1tKEJ
6i8UXtRGL7/IiXDN+C1GEq1IApRSG/2lxbrNWNlCJrYPGfH3jgMSSkGbqesLtazR
d3cjUTVRAHtyMcCn2jhlBx7d36Lz86X3+7U8j8k/pQ7txOPFb4U/f1PK2WStf/Kt
2MtsHSQwUddwPlngEAfiUMz1TyUUnYdunoN7kEMx78QOTh7lJs80GRpWkuyadS+p
U275++T5UELgev2l6GLEqNbaAsaS94ES2BRMS5zxZEV+XOTQraqkv/Xir1Cp+LB9
Q6nqcjVFyH2xyywBm5mOfQZzbWStqiOLWvT6SrDKkYtYAJD0yXgHsaNrLo2e67sL
5BFyBpa5YoCqAelTgeVLFx+xFLyH3wYC+qChrDNbrwOE+8Fm7vY=
=O0p7
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--
