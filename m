Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeEPJrP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 05:47:15 -0400
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
Subject: [PATCH 42/42] proc: update SIZEOF_PDE_INLINE_NAME for the new pde fields
Date: Wed, 16 May 2018 11:43:46 +0200
Message-Id: <20180516094346.20506-43-hch@lst.de>
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This makes Alexey happy and Al groan.  Based on a patch from
Alexey Dobriyan.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 84c68508a256..a318ae5b36b4 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -62,9 +62,9 @@ struct proc_dir_entry {
 	umode_t mode;
 	u8 namelen;
 #ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-139)
+#define SIZEOF_PDE_INLINE_NAME	(192-155)
 #else
-#define SIZEOF_PDE_INLINE_NAME	(128-87)
+#define SIZEOF_PDE_INLINE_NAME	(128-95)
 #endif
 	char inline_name[SIZEOF_PDE_INLINE_NAME];
 } __randomize_layout;
-- 
2.17.0
