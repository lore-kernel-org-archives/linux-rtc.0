Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57814 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752965AbeERIxc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 18 May 2018 04:53:32 -0400
Date: Fri, 18 May 2018 10:58:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
Subject: Re: [PATCH 38/42] isdn: replace ->proc_fops with ->proc_show
Message-ID: <20180518085812.GB24387@lst.de>
References: <20180516094346.20506-1-hch@lst.de> <20180516094346.20506-39-hch@lst.de> <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, May 18, 2018 at 10:43:46AM +0200, Paul Bolle wrote:
> >  	iif->ctr.release_appl  = gigaset_release_appl;
> >  	iif->ctr.send_message  = gigaset_send_message;
> > -	iif->ctr.procinfo      = gigaset_procinfo;
> 
> Is this intentional? You didn't touch the procinfo method in the other ISDN
> drivers, as far as I can see.
> 
> (If it was intentional, gigaset_procinfo() can of course be removed.)

Already fixed in the branch in Als tree.
