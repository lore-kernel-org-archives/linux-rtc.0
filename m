Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754997AbeDYPvQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Apr 2018 11:51:16 -0400
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
Subject: [PATCH 32/40] netfilter/x_tables: switch to proc_create_seq_private
Date: Wed, 25 Apr 2018 17:48:19 +0200
Message-Id: <20180425154827.32251-33-hch@lst.de>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 344dd01a5027..0e314f95a4a3 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1648,22 +1648,6 @@ static const struct seq_operations xt_match_seq_ops = {
 	.show	= xt_match_seq_show,
 };
 
-static int xt_match_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_match_ops = {
-	.open	 = xt_match_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 static void *xt_target_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	return xt_mttg_seq_start(seq, pos, true);
@@ -1698,22 +1682,6 @@ static const struct seq_operations xt_target_seq_ops = {
 	.show	= xt_target_seq_show,
 };
 
-static int xt_target_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_target_ops = {
-	.open	 = xt_target_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 #define FORMAT_TABLES	"_tables_names"
 #define	FORMAT_MATCHES	"_tables_matches"
 #define FORMAT_TARGETS 	"_tables_targets"
@@ -1787,8 +1755,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_match_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
+			(void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_tables;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
@@ -1796,8 +1765,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_target_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
+			 (void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_matches;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
-- 
2.17.0
