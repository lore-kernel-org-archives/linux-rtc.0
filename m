Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59538 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757818AbeDXORe (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 24 Apr 2018 10:17:34 -0400
Date: Tue, 24 Apr 2018 16:19:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        linux-ide@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180424141902.GD26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419124140.9309-4-hch@lst.de> <20180419141818.pjys7at4xmz2h6ho@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419141818.pjys7at4xmz2h6ho@mwanda>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 05:18:18PM +0300, Dan Carpenter wrote:
> > -static const struct file_operations cio_ignore_proc_fops = {
> > -	.open    = cio_ignore_proc_open,
> > -	.read    = seq_read,
> > -	.llseek  = seq_lseek,
> > -	.release = seq_release_private,
> > -	.write   = cio_ignore_write,
>                    ^^^^^^^^^^^^^^^^
> The cio_ignore_write() function isn't used any more so compilers will
> complain.

No compiler in the buildboot farm complained, but neverless this
