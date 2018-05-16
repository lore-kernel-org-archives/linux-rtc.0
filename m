Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeEPJqI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 05:46:08 -0400
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-ide@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/42] drbd: switch to proc_create_single
Date: Wed, 16 May 2018 11:43:32 +0200
Message-Id: <20180516094346.20506-29-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And stop messing with try_module_get on THIS_MODULE, which doesn't make
any sense here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/block/drbd/drbd_main.c |  3 ++-
 drivers/block/drbd/drbd_proc.c | 34 +---------------------------------
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 06ecee1b528e..461ddec04e7c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1643,7 +1643,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 
 /* drbd_proc.c */
 extern struct proc_dir_entry *drbd_proc;
-extern const struct file_operations drbd_proc_fops;
+int drbd_seq_show(struct seq_file *seq, void *v);
 
 /* drbd_actlog.c */
 extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct drbd_interval *i);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 185f1ef00a7c..c2d154faac02 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3010,7 +3010,8 @@ static int __init drbd_init(void)
 		goto fail;
 
 	err = -ENOMEM;
-	drbd_proc = proc_create_data("drbd", S_IFREG | S_IRUGO , NULL, &drbd_proc_fops, NULL);
+	drbd_proc = proc_create_single("drbd", S_IFREG | S_IRUGO , NULL,
+			drbd_seq_show);
 	if (!drbd_proc)	{
 		pr_err("unable to register proc file\n");
 		goto fail;
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 582caeb0de86..74ef29247bb5 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -33,18 +33,7 @@
 #include <linux/drbd.h>
 #include "drbd_int.h"
 
-static int drbd_proc_open(struct inode *inode, struct file *file);
-static int drbd_proc_release(struct inode *inode, struct file *file);
-
-
 struct proc_dir_entry *drbd_proc;
-const struct file_operations drbd_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= drbd_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= drbd_proc_release,
-};
 
 static void seq_printf_with_thousands_grouping(struct seq_file *seq, long v)
 {
@@ -235,7 +224,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 	}
 }
 
-static int drbd_seq_show(struct seq_file *seq, void *v)
+int drbd_seq_show(struct seq_file *seq, void *v)
 {
 	int i, prev_i = -1;
 	const char *sn;
@@ -345,24 +334,3 @@ static int drbd_seq_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int drbd_proc_open(struct inode *inode, struct file *file)
-{
-	int err;
-
-	if (try_module_get(THIS_MODULE)) {
-		err = single_open(file, drbd_seq_show, NULL);
-		if (err)
-			module_put(THIS_MODULE);
-		return err;
-	}
-	return -ENODEV;
-}
-
-static int drbd_proc_release(struct inode *inode, struct file *file)
-{
-	module_put(THIS_MODULE);
-	return single_release(inode, file);
-}
-
-/* PROC FS stuff end */
-- 
2.17.0
