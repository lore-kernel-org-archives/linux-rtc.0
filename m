Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbeEPJ6U (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 16 May 2018 05:58:20 -0400
Date: Wed, 16 May 2018 11:58:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 41/42] tty: replace ->proc_fops with ->proc_show
Message-ID: <20180516095802.GA16090@kroah.com>
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-42-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516094346.20506-42-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:45AM +0200, Christoph Hellwig wrote:
> Just set up the show callback in the tty_operations, and use
> proc_create_single_data to create the file without additional
> boilerplace code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
