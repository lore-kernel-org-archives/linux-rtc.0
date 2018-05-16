Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeEPJoV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 05:44:21 -0400
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
Subject: [PATCH 03/42] proc: don't detour through seq->private to get the inode
Date: Wed, 16 May 2018 11:43:07 +0200
Message-Id: <20180516094346.20506-4-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/array.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 911f66924d81..4a8e413bf59b 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -677,20 +677,22 @@ get_children_pid(struct inode *inode, struct pid *pid_prev, loff_t pos)
 
 static int children_seq_show(struct seq_file *seq, void *v)
 {
-	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(seq->private)));
+	struct inode *inode = file_inode(seq->file);
+
+	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode)));
 	return 0;
 }
 
 static void *children_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return get_children_pid(seq->private, NULL, *pos);
+	return get_children_pid(file_inode(seq->file), NULL, *pos);
 }
 
 static void *children_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct pid *pid;
 
-	pid = get_children_pid(seq->private, v, *pos + 1);
+	pid = get_children_pid(file_inode(seq->file), v, *pos + 1);
 	put_pid(v);
 
 	++*pos;
@@ -711,17 +713,7 @@ static const struct seq_operations children_seq_ops = {
 
 static int children_seq_open(struct inode *inode, struct file *file)
 {
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, &children_seq_ops);
-	if (ret)
-		return ret;
-
-	m = file->private_data;
-	m->private = inode;
-
-	return ret;
+	return seq_open(file, &children_seq_ops);
 }
 
 const struct file_operations proc_tid_children_operations = {
-- 
2.17.0
