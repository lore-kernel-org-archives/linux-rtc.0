Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42146 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbeEOOIP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 May 2018 10:08:15 -0400
Date: Tue, 15 May 2018 16:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH 34/40] atm: simplify procfs code
Message-ID: <20180515141232.GD31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de> <20180425154827.32251-35-hch@lst.de> <87r2mq2rll.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2mq2rll.fsf@xmission.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, May 05, 2018 at 07:51:18AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Use remove_proc_subtree to remove the whole subtree on cleanup, and
> > unwind the registration loop into individual calls.  Switch to use
> > proc_create_seq where applicable.
> 
> Can you please explain why you are removing the error handling when
> you are unwinding the registration loop?

Because there is no point in handling these errors.  The code work
perfectly fine without procfs, or without given proc files and the
removal works just fine if they don't exist either.  This is a very
common patter in various parts of the kernel already.

I'll document it better in the changelog.
