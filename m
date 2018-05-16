Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeEPJo7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 05:44:59 -0400
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
Subject: [PATCH 05/42] proc: add a proc_create_reg helper
Date: Wed, 16 May 2018 11:43:09 +0200
Message-Id: <20180516094346.20506-6-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Common code for creating a regular file.  Factor out of proc_create_data, to
be reused by other functions soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c  | 44 +++++++++++++++++++++++++-------------------
 fs/proc/internal.h |  2 ++
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index bd8480ff0d35..ab6a321076b8 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -511,33 +511,39 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 }
 EXPORT_SYMBOL(proc_create_mount_point);
 
-struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
-					struct proc_dir_entry *parent,
-					const struct file_operations *proc_fops,
-					void *data)
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data)
 {
-	struct proc_dir_entry *pde;
+	struct proc_dir_entry *p;
+
 	if ((mode & S_IFMT) == 0)
 		mode |= S_IFREG;
-
-	if (!S_ISREG(mode)) {
-		WARN_ON(1);	/* use proc_mkdir() */
+	if ((mode & S_IALLUGO) == 0)
+		mode |= S_IRUGO;
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
+
+	p = __proc_create(parent, name, mode, 1);
+	if (p) {
+		p->proc_iops = &proc_file_inode_operations;
+		p->data = data;
 	}
+	return p;
+}
+
+struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
+		struct proc_dir_entry *parent,
+		const struct file_operations *proc_fops, void *data)
+{
+	struct proc_dir_entry *p;
 
 	BUG_ON(proc_fops == NULL);
 
-	if ((mode & S_IALLUGO) == 0)
-		mode |= S_IRUGO;
-	pde = __proc_create(&parent, name, mode, 1);
-	if (!pde)
-		goto out;
-	pde->proc_fops = proc_fops;
-	pde->data = data;
-	pde->proc_iops = &proc_file_inode_operations;
-	return proc_register(parent, pde);
-out:
-	return NULL;
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_fops = proc_fops;
+	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
  
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 488e67490312..dd1e11400b97 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,6 +162,8 @@ extern bool proc_fill_cache(struct file *, struct dir_context *, const char *, i
 /*
  * generic.c
  */
+struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
+		struct proc_dir_entry **parent, void *data);
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp);
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
-- 
2.17.0
