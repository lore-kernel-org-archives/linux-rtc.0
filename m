Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeDSMoD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 08:44:03 -0400
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
Subject: [PATCH 34/39] atm: switch to proc_create_seq_private
Date: Thu, 19 Apr 2018 14:41:35 +0200
Message-Id: <20180419124140.9309-35-hch@lst.de>
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/atm/proc.c | 72 +++++++++-----------------------------------------
 1 file changed, 13 insertions(+), 59 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index f272b0f59d82..0b0495a41bbe 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -68,7 +68,6 @@ static void atm_dev_info(struct seq_file *seq, const struct atm_dev *dev)
 struct vcc_state {
 	int bucket;
 	struct sock *sk;
-	int family;
 };
 
 static inline int compare_family(struct sock *sk, int family)
@@ -106,23 +105,13 @@ static int __vcc_walk(struct sock **sock, int family, int *bucket, loff_t l)
 	return (l < 0);
 }
 
-static inline void *vcc_walk(struct vcc_state *state, loff_t l)
+static inline void *vcc_walk(struct seq_file *seq, loff_t l)
 {
-	return __vcc_walk(&state->sk, state->family, &state->bucket, l) ?
-	       state : NULL;
-}
-
-static int __vcc_seq_open(struct inode *inode, struct file *file,
-	int family, const struct seq_operations *ops)
-{
-	struct vcc_state *state;
-
-	state = __seq_open_private(file, ops, sizeof(*state));
-	if (state == NULL)
-		return -ENOMEM;
+	struct vcc_state *state = seq->private;
+	int family = (uintptr_t)(PDE_DATA(file_inode(seq->file)));
 
-	state->family = family;
-	return 0;
+	return __vcc_walk(&state->sk, family, &state->bucket, l) ?
+	       state : NULL;
 }
 
 static void *vcc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -133,7 +122,7 @@ static void *vcc_seq_start(struct seq_file *seq, loff_t *pos)
 
 	read_lock(&vcc_sklist_lock);
 	state->sk = SEQ_START_TOKEN;
-	return left ? vcc_walk(state, left) : SEQ_START_TOKEN;
+	return left ? vcc_walk(seq, left) : SEQ_START_TOKEN;
 }
 
 static void vcc_seq_stop(struct seq_file *seq, void *v)
@@ -144,9 +133,7 @@ static void vcc_seq_stop(struct seq_file *seq, void *v)
 
 static void *vcc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct vcc_state *state = seq->private;
-
-	v = vcc_walk(state, 1);
+	v = vcc_walk(seq, 1);
 	*pos += !!PTR_ERR(v);
 	return v;
 }
@@ -280,18 +267,6 @@ static const struct seq_operations pvc_seq_ops = {
 	.show	= pvc_seq_show,
 };
 
-static int pvc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, PF_ATMPVC, &pvc_seq_ops);
-}
-
-static const struct file_operations pvc_seq_fops = {
-	.open		= pvc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static int vcc_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == SEQ_START_TOKEN) {
@@ -314,18 +289,6 @@ static const struct seq_operations vcc_seq_ops = {
 	.show	= vcc_seq_show,
 };
 
-static int vcc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, 0, &vcc_seq_ops);
-}
-
-static const struct file_operations vcc_seq_fops = {
-	.open		= vcc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static int svc_seq_show(struct seq_file *seq, void *v)
 {
 	static const char atm_svc_banner[] =
@@ -349,18 +312,6 @@ static const struct seq_operations svc_seq_ops = {
 	.show	= svc_seq_show,
 };
 
-static int svc_seq_open(struct inode *inode, struct file *file)
-{
-	return __vcc_seq_open(inode, file, PF_ATMSVC, &svc_seq_ops);
-}
-
-static const struct file_operations svc_seq_fops = {
-	.open		= svc_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release_private,
-};
-
 static ssize_t proc_dev_atm_read(struct file *file, char __user *buf,
 				 size_t count, loff_t *pos)
 {
@@ -434,9 +385,12 @@ int __init atm_proc_init(void)
 	if (!atm_proc_root)
 		return -ENOMEM;
 	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
-	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
-	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
-	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
+	proc_create_seq_private("pvc", 0444, atm_proc_root, &pvc_seq_ops,
+			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMPVC);
+	proc_create_seq_private("svc", 0444, atm_proc_root, &svc_seq_ops,
+			sizeof(struct vcc_state), (void *)(uintptr_t)PF_ATMSVC);
+	proc_create_seq_private("vc", 0444, atm_proc_root, &vcc_seq_ops,
+			sizeof(struct vcc_state), NULL);
 	return 0;
 }
 
-- 
2.17.0
