Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42096 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753984AbeEON7I (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 May 2018 09:59:08 -0400
Date: Tue, 15 May 2018 16:03:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: simplify procfs code for seq_file instances V2
Message-ID: <20180515140326.GC31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de> <20180506171948.GA769@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180506171948.GA769@avx2>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sun, May 06, 2018 at 08:19:49PM +0300, Alexey Dobriyan wrote:
> On Wed, Apr 25, 2018 at 05:47:47PM +0200, Christoph Hellwig wrote:
> > Changes since V1:
> >  - open code proc_create_data to avoid setting not fully initialized
> >    entries live
> >  - use unsigned int for state_size
> 
> Need this to maintain sizeof(struct proc_dir_entry):

I'll fold your changes into the relevant patches.

> Otherwise ACK fs/proc/ part.

I'll take this as a formal ACK-ed by for all patches touching
procfs.  If I was wrong please scream.
