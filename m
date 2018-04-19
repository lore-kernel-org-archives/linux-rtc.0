Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35873 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeDSSoK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 14:44:10 -0400
Date: Thu, 19 Apr 2018 21:44:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 14/39] proc: introduce proc_create_net_single
Message-ID: <20180419184404.GB2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180419124140.9309-15-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:15PM +0200, Christoph Hellwig wrote:
> Variant of proc_create_data that directly take a seq_file show

> +struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent,
> +		int (*show)(struct seq_file *, void *), void *data)
> +{
> +	struct proc_dir_entry *p;
> +
> +	p = proc_create_data(name, mode, parent, &proc_net_single_fops, data);
> +	if (p)
> +		p->single_show = show;
> +	return p;
> +}

Ditto, should be oopsable.
