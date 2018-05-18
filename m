Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56302 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeERM4C (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 18 May 2018 08:56:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so13943568wmg.5
        for <linux-rtc@vger.kernel.org>; Fri, 18 May 2018 05:56:02 -0700 (PDT)
Date: Fri, 18 May 2018 14:55:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [Drbd-dev] [PATCH 28/42] drbd: switch to proc_create_single
Message-ID: <20180518125554.GA9238@soda.linbit>
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516094346.20506-29-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:32AM +0200, Christoph Hellwig wrote:
> And stop messing with try_module_get on THIS_MODULE, which doesn't make
> any sense here.

The idea was to increase module count on /proc/drbd access.

If someone holds /proc/drbd open, previously rmmod would
"succeed" in starting the unload, but then block on remove_proc_entry,
leading to a situation where the lsmod does not show drbd anymore,
but /proc/drbd being still there (but no longer accessible).

I'd rather have rmmod fail up front in this case.
And try_module_get() seemed most appropriate.

    Lars
