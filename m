Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60099 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeDXQFY (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 24 Apr 2018 12:05:24 -0400
Date: Tue, 24 Apr 2018 18:06:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
Message-ID: <20180424160652.GA28483@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2> <20180424142304.GE26136@lst.de> <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Apr 24, 2018 at 08:19:16AM -0700, Andrew Morton wrote:
> > > I want to ask if it is time to start using poorman function overloading
> > > with _b_c_e(). There are millions of allocation functions for example,
> > > all slightly difference, and people will add more. Seeing /proc interfaces
> > > doubled like this is painful.
> > 
> > Function overloading is totally unacceptable.
> > 
> > And I very much disagree with a tradeoff that keeps 5000 lines of 
> > code vs a few new helpers.
> 
> OK, the curiosity and suspense are killing me.  What the heck is
> "function overloading with _b_c_e()"?

The way I understood Alexey was to use have a proc_create macro
that can take different ops types.  Although the short cut for
__builtin_types_compatible_p would be _b_t_c or similar, so maybe
I misunderstood him.
