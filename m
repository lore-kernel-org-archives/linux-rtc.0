Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753996AbeD3PiY (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 30 Apr 2018 11:38:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: simplify procfs code for seq_file instances V2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Apr 2018 16:38:18 +0100
Message-ID: <15622.1525102698@warthog.procyon.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Note that your kernel hits the:

	inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
	swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
		(ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire+0x12/0x35
	{HARDIRQ-ON-W} state was registered at:
	  fs_reclaim_acquire+0x32/0x35
	  kmem_cache_alloc_node_trace+0x49/0x2cf
	  alloc_worker+0x1d/0x49
	  init_rescuer.part.7+0x19/0x8f
	  workqueue_init+0xc0/0x1fe
	  kernel_init_freeable+0xdc/0x433
	  kernel_init+0xa/0xf5
	  ret_from_fork+0x24/0x30

bug, as described here:

	https://groups.google.com/forum/#!msg/syzkaller-bugs/sJC3Y3hOM08/aO3z9JXoAgAJ

David
