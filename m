Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbeEPJoV (ORCPT
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
Subject: simplify procfs code for seq_file instances V3
Date: Wed, 16 May 2018 11:43:04 +0200
Message-Id: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

We currently have hundreds of proc files that implement plain, read-only
seq_file based interfaces.  This series consolidates them using new
procfs helpers that take the seq_operations or simple show callback
directly.

A git tree is available at:

    git://git.infradead.org/users/hch/misc.git proc_create.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/proc_create.3

Changes since V2:
 - use unsigned int for state_size everywhere
 - move state_size around in proc_dir_entry to use a struct packing hole
 - update SIZEOF_PDE_INLINE_NAME
 - added a new proc_pid_ns helper
 - improved a few changelogs
 - added back a nubus comment
 - minor typo fix
 - collected various ACKs

Changes since V1:
 - open code proc_create_data to avoid setting not fully initialized
   entries live
 - use unsigned int for state_size
 - dropped the s390/cio/blacklist hunk as it has a write method
 - dropped the IPMI patch given that IPMI proc support is scheduled for
   removal.
