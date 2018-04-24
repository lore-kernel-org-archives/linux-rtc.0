Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59581 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758365AbeDXOVg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 24 Apr 2018 10:21:36 -0400
Date: Tue, 24 Apr 2018 16:23:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: simplify procfs code for seq_file instances
Message-ID: <20180424142304.GE26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419185750.GD2066@avx2>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 09:57:50PM +0300, Alexey Dobriyan wrote:
> >     git://git.infradead.org/users/hch/misc.git proc_create
> 
> 
> I want to ask if it is time to start using poorman function overloading
> with _b_c_e(). There are millions of allocation functions for example,
> all slightly difference, and people will add more. Seeing /proc interfaces
> doubled like this is painful.

Function overloading is totally unacceptable.

And I very much disagree with a tradeoff that keeps 5000 lines of 
code vs a few new helpers.
