Return-Path: <rtc-linux+bncBAABBDMV6TCQKGQEU3LHP7Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c123si1213323pfa.4.2017.03.05.23.06.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 23:06:52 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Sajjan Vikas C <vikas.cha.sajjan@hpe.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Marcel Selhorst <tpmdd@selhorst.net>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Olof Johansson <olof@lixom.net>,
	Doug Ledford <dledford@redhat.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Parav Pandit <pandit.parav@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
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
	Joe Perches <joe@perches.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Stephen Bates <stephen.bates@microsemi.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-mtd@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	<stable@vger.kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  6 Mar 2017 00:04:18 -0700
Message-Id: <1488783873-2614-3-git-send-email-logang@deltatee.com>
In-Reply-To: <1488783873-2614-1-git-send-email-logang@deltatee.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
Subject: [rtc-linux] [PATCH v3 02/16] device-dax: fix cdev leak
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Dan Williams <dan.j.williams@intel.com>

If device_add() fails, cleanup the cdev. Otherwise, we leak a kobj_map()
with a stale device number.

As Jason points out, there is a small possibility that userspace has
opened and mapped the device in the time between cdev_add() and the
device_add() failure. We need a new kill_dax_dev() helper to invalidate
any established mappings.

Fixes: ba09c01d2fa8 ("dax: convert to the cdev api")
Cc: <stable@vger.kernel.org>
Reported-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dax/dax.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax.c b/drivers/dax/dax.c
index 8d9829f..a5ed59a 100644
--- a/drivers/dax/dax.c
+++ b/drivers/dax/dax.c
@@ -675,13 +675,10 @@ static void dax_dev_release(struct device *dev)
 	kfree(dax_dev);
 }
 
-static void unregister_dax_dev(void *dev)
+static void kill_dax_dev(struct dax_dev *dax_dev)
 {
-	struct dax_dev *dax_dev = to_dax_dev(dev);
 	struct cdev *cdev = &dax_dev->cdev;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	/*
 	 * Note, rcu is not protecting the liveness of dax_dev, rcu is
 	 * ensuring that any fault handlers that might have seen
@@ -693,6 +690,15 @@ static void unregister_dax_dev(void *dev)
 	synchronize_rcu();
 	unmap_mapping_range(dax_dev->inode->i_mapping, 0, 0, 1);
 	cdev_del(cdev);
+}
+
+static void unregister_dax_dev(void *dev)
+{
+	struct dax_dev *dax_dev = to_dax_dev(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	kill_dax_dev(dax_dev);
 	device_unregister(dev);
 }
 
@@ -769,6 +775,7 @@ struct dax_dev *devm_create_dax_dev(struct dax_region *dax_region,
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dax_dev->id);
 	rc = device_add(dev);
 	if (rc) {
+		kill_dax_dev(dax_dev);
 		put_device(dev);
 		return ERR_PTR(rc);
 	}
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
