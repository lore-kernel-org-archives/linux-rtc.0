Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34674 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDVJmK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 22 Apr 2018 05:42:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180419124140.9309-16-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419124140.9309-16-hch@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Apr 2018 11:42:08 +0200
Message-ID: <CAJZ5v0gRw8P8KL12QKMuSjyePxWn71LB+s8ephF2a4-Ns234NQ@mail.gmail.com>
Subject: Re: [PATCH 15/39] acpi/battery: simplify procfs code
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Corey Minyard <minyard@acm.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        netfilter-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 2:41 PM, Christoph Hellwig <hch@lst.de> wrote:
> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It is OK AFAICS.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
