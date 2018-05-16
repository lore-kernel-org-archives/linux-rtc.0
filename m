Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeEPN2f (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 May 2018 09:28:35 -0400
Date: Wed, 16 May 2018 14:28:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: simplify procfs code for seq_file instances V3
Message-ID: <20180516132801.GO30522@ZenIV.linux.org.uk>
References: <20180516094346.20506-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:04AM +0200, Christoph Hellwig wrote:
> We currently have hundreds of proc files that implement plain, read-only
> seq_file based interfaces.  This series consolidates them using new
> procfs helpers that take the seq_operations or simple show callback
> directly.
> 
> A git tree is available at:
> 
>     git://git.infradead.org/users/hch/misc.git proc_create.3

Pulled, but the last bit is a bleeding atrocity in need of followup
cleanup.
