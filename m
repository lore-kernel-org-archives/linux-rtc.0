Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753811AbeD3NTa (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 30 Apr 2018 09:19:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-5-hch@lst.de>
References: <20180425154827.32251-5-hch@lst.de> <20180425154827.32251-1-hch@lst.de>
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
Subject: Re: [PATCH 04/40] proc: introduce proc_create_seq{,_data}
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Apr 2018 14:19:25 +0100
Message-ID: <26540.1525094365@warthog.procyon.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Christoph Hellwig <hch@lst.de> wrote:

> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> ...
> +EXPORT_SYMBOL(proc_create_seq_data);

Please add documentation comments to exported functions when you add them.

David
