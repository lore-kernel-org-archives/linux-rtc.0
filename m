Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeDSMoG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 08:44:06 -0400
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
Subject: [PATCH 29/39] neigh: switch to proc_create_seq_data
Date: Thu, 19 Apr 2018 14:41:30 +0200
Message-Id: <20180419124140.9309-30-hch@lst.de>
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And use proc private data directly instead of doing a detour
through seq->private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/core/neighbour.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7b7a14abba28..cbfb6d71b8be 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -58,7 +58,7 @@ static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
 static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 
 #ifdef CONFIG_PROC_FS
-static const struct file_operations neigh_stat_seq_fops;
+static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
 /*
@@ -1550,8 +1550,8 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		panic("cannot create neighbour cache statistics");
 
 #ifdef CONFIG_PROC_FS
-	if (!proc_create_data(tbl->id, 0, init_net.proc_net_stat,
-			      &neigh_stat_seq_fops, tbl))
+	if (!proc_create_seq_data(tbl->id, 0, init_net.proc_net_stat,
+			      &neigh_stat_seq_ops, tbl))
 		panic("cannot create neighbour proc dir entry");
 #endif
 
@@ -2774,7 +2774,7 @@ EXPORT_SYMBOL(neigh_seq_stop);
 
 static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	if (*pos == 0)
@@ -2791,7 +2791,7 @@ static void *neigh_stat_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *neigh_stat_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	int cpu;
 
 	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
@@ -2810,7 +2810,7 @@ static void neigh_stat_seq_stop(struct seq_file *seq, void *v)
 
 static int neigh_stat_seq_show(struct seq_file *seq, void *v)
 {
-	struct neigh_table *tbl = seq->private;
+	struct neigh_table *tbl = PDE_DATA(file_inode(seq->file));
 	struct neigh_statistics *st = v;
 
 	if (v == SEQ_START_TOKEN) {
@@ -2849,25 +2849,6 @@ static const struct seq_operations neigh_stat_seq_ops = {
 	.stop	= neigh_stat_seq_stop,
 	.show	= neigh_stat_seq_show,
 };
-
-static int neigh_stat_seq_open(struct inode *inode, struct file *file)
-{
-	int ret = seq_open(file, &neigh_stat_seq_ops);
-
-	if (!ret) {
-		struct seq_file *sf = file->private_data;
-		sf->private = PDE_DATA(inode);
-	}
-	return ret;
-};
-
-static const struct file_operations neigh_stat_seq_fops = {
-	.open 	 = neigh_stat_seq_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release,
-};
-
 #endif /* CONFIG_PROC_FS */
 
 static inline size_t neigh_nlmsg_size(void)
-- 
2.17.0
