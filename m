Return-Path: <rtc-linux+bncBAABBEMV6TCQKGQE4JPWVQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y90si1226021pfa.6.2017.03.05.23.06.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2017 23:06:57 -0800 (PST)
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  6 Mar 2017 00:04:30 -0700
Message-Id: <1488783873-2614-15-git-send-email-logang@deltatee.com>
In-Reply-To: <1488783873-2614-1-git-send-email-logang@deltatee.com>
References: <1488783873-2614-1-git-send-email-logang@deltatee.com>
Subject: [rtc-linux] [PATCH v3 14/16] rtc: utilize new cdev_device_add helper function
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Mostly straightforward, but we had to remove the rtc_dev_add/del_device
functions as they split up the cdev_add and the device_add.

Doing this also revealed that there was likely another subtle bug:
seeing cdev_add was done after device_register, the cdev probably
was not ready before device_add when the uevent occurs. This would
race with userspace, if it tried to use the device directly after
the uevent. This is fixed just by using the new helper function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/rtc/class.c   | 14 ++++++++++----
 drivers/rtc/rtc-dev.c | 17 -----------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 74fd974..5fb4398 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -195,6 +195,8 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 		goto exit_ida;
 	}
 
+	device_initialize(&rtc->dev);
+
 	rtc->id = id;
 	rtc->ops = ops;
 	rtc->owner = owner;
@@ -233,14 +235,19 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 
 	rtc_dev_prepare(rtc);
 
-	err = device_register(&rtc->dev);
+	err = cdev_device_add(&rtc->char_dev, &rtc->dev);
 	if (err) {
+		dev_warn(&rtc->dev, "%s: failed to add char device %d:%d\n",
+			 rtc->name, MAJOR(rtc->dev.devt), rtc->id);
+
 		/* This will free both memory and the ID */
 		put_device(&rtc->dev);
 		goto exit;
+	} else {
+		dev_dbg(&rtc->dev, "%s: dev (%d:%d)\n", rtc->name,
+			MAJOR(rtc->dev.devt), rtc->id);
 	}
 
-	rtc_dev_add_device(rtc);
 	rtc_proc_add_device(rtc);
 
 	dev_info(dev, "rtc core: registered %s as %s\n",
@@ -271,9 +278,8 @@ void rtc_device_unregister(struct rtc_device *rtc)
 	 * Remove innards of this RTC, then disable it, before
 	 * letting any rtc_class_open() users access it again
 	 */
-	rtc_dev_del_device(rtc);
 	rtc_proc_del_device(rtc);
-	device_del(&rtc->dev);
+	cdev_device_del(&rtc->char_dev, &rtc->dev);
 	rtc->ops = NULL;
 	mutex_unlock(&rtc->ops_lock);
 	put_device(&rtc->dev);
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 6dc8f29..e81a871 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -477,23 +477,6 @@ void rtc_dev_prepare(struct rtc_device *rtc)
 
 	cdev_init(&rtc->char_dev, &rtc_dev_fops);
 	rtc->char_dev.owner = rtc->owner;
-	rtc->char_dev.kobj.parent = &rtc->dev.kobj;
-}
-
-void rtc_dev_add_device(struct rtc_device *rtc)
-{
-	if (cdev_add(&rtc->char_dev, rtc->dev.devt, 1))
-		dev_warn(&rtc->dev, "%s: failed to add char device %d:%d\n",
-			rtc->name, MAJOR(rtc_devt), rtc->id);
-	else
-		dev_dbg(&rtc->dev, "%s: dev (%d:%d)\n", rtc->name,
-			MAJOR(rtc_devt), rtc->id);
-}
-
-void rtc_dev_del_device(struct rtc_device *rtc)
-{
-	if (rtc->dev.devt)
-		cdev_del(&rtc->char_dev);
 }
 
 void __init rtc_dev_init(void)
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
