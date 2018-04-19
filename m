Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeDSMnd (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 08:43:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Corey Minyard <minyard@acm.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-ide@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/39] bonding: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:28 +0200
Message-Id: <20180419124140.9309-28-hch@lst.de>
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/bonding/bond_procfs.c | 36 ++++++-------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 01059f1a7bca..9f7d83e827c3 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -10,7 +10,7 @@
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	loff_t off = 0;
@@ -29,7 +29,7 @@ static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *bond_info_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	struct list_head *iter;
 	struct slave *slave;
 	bool found = false;
@@ -56,7 +56,7 @@ static void bond_info_seq_stop(struct seq_file *seq, void *v)
 
 static void bond_info_show_master(struct seq_file *seq)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
 	int i;
@@ -167,7 +167,7 @@ static void bond_info_show_master(struct seq_file *seq)
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
-	struct bonding *bond = seq->private;
+	struct bonding *bond = PDE_DATA(file_inode(seq->file));
 
 	seq_printf(seq, "\nSlave Interface: %s\n", slave->dev->name);
 	seq_printf(seq, "MII Status: %s\n", bond_slave_link_status(slave->link));
@@ -257,38 +257,14 @@ static const struct seq_operations bond_info_seq_ops = {
 	.show  = bond_info_seq_show,
 };
 
-static int bond_info_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int res;
-
-	res = seq_open(file, &bond_info_seq_ops);
-	if (!res) {
-		/* recover the pointer buried in proc_dir_entry data */
-		seq = file->private_data;
-		seq->private = PDE_DATA(inode);
-	}
-
-	return res;
-}
-
-static const struct file_operations bond_info_fops = {
-	.owner   = THIS_MODULE,
-	.open    = bond_info_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 void bond_create_proc_entry(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
 	struct bond_net *bn = net_generic(dev_net(bond_dev), bond_net_id);
 
 	if (bn->proc_dir) {
-		bond->proc_entry = proc_create_data(bond_dev->name,
-						    0444, bn->proc_dir,
-						    &bond_info_fops, bond);
+		bond->proc_entry = proc_create_seq_data(bond_dev->name, 0444,
+				bn->proc_dir, &bond_info_seq_ops, bond);
 		if (bond->proc_entry == NULL)
 			netdev_warn(bond_dev, "Cannot create /proc/net/%s/%s\n",
 				    DRV_NAME, bond_dev->name);
-- 
2.17.0
