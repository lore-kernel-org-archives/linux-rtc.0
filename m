Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42309 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeEOOi0 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 May 2018 10:38:26 -0400
Date: Tue, 15 May 2018 16:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180515144244.GA32583@lst.de>
References: <20180425154827.32251-5-hch@lst.de> <20180425154827.32251-1-hch@lst.de> <26540.1525094365@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26540.1525094365@warthog.procyon.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:19:25PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +
> > +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> > +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> > +		void *data)
> > +{
> > ...
> > +EXPORT_SYMBOL(proc_create_seq_data);
> 
> Please add documentation comments to exported functions when you add them.

None of the base functions are document, and we really want people to not
use procfs for new code anyway.  But if I get some consensus from the
maintainers and the list I can throw in another patch to document
all proc_create* variants.
