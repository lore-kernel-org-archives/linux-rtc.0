Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeDSMna (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 08:43:30 -0400
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
Subject: [PATCH 26/39] rtc/proc: switch to proc_create_single_data
Date: Thu, 19 Apr 2018 14:41:27 +0200
Message-Id: <20180419124140.9309-27-hch@lst.de>
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

And stop trying to get a reference on the submodule, procfs code deals
with release after and unloaded module and thus removed proc entry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/rtc/rtc-proc.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index 31e7e23cc5be..a9dd9218fae2 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int rtc_proc_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	if (!try_module_get(rtc->owner))
-		return -ENODEV;
-
-	ret = single_open(file, rtc_proc_show, rtc);
-	if (ret)
-		module_put(rtc->owner);
-	return ret;
-}
-
-static int rtc_proc_release(struct inode *inode, struct file *file)
-{
-	int res = single_release(inode, file);
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	module_put(rtc->owner);
-	return res;
-}
-
-static const struct file_operations rtc_proc_fops = {
-	.open		= rtc_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= rtc_proc_release,
-};
-
 void rtc_proc_add_device(struct rtc_device *rtc)
 {
 	if (is_rtc_hctosys(rtc))
-		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
+		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
+				rtc);
 }
 
 void rtc_proc_del_device(struct rtc_device *rtc)
-- 
2.17.0
