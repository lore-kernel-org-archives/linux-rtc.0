Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40075 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeDSSlN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 14:41:13 -0400
Date: Thu, 19 Apr 2018 21:41:06 +0300
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
Subject: Re: [PATCH 02/39] proc: introduce proc_create_seq{,_data}
Message-ID: <20180419184106.GA2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180419124140.9309-3-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:03PM +0200, Christoph Hellwig wrote:
> Variants of proc_create{,_data} that directly take a struct seq_operations
> argument and drastically reduces the boilerplate code in the callers.

> +static int proc_seq_open(struct inode *inode, struct file *file)
> +{
> +	struct proc_dir_entry *de = PDE(inode);
> +
> +	return seq_open(file, de->seq_ops);
> +}
> +
> +static const struct file_operations proc_seq_fops = {
> +	.open		= proc_seq_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> +	struct proc_dir_entry *p;
> +
> +	p = proc_create_data(name, mode, parent, &proc_seq_fops, data);
> +	if (p)
> +		p->seq_ops = ops;
> +	return p;
> +}

Should be oopsable.
Once proc_create_data() returns, entry is live, ->open can be called.

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -44,6 +44,7 @@ struct proc_dir_entry {
>  	struct completion *pde_unload_completion;
>  	const struct inode_operations *proc_iops;
>  	const struct file_operations *proc_fops;
> +	const struct seq_operations *seq_ops;
>  	void *data;
>  	unsigned int low_ino;
>  	nlink_t nlink;

"struct proc_dir_entry is 192/128 bytes now.
If someone knows how to pad array to certain size without union
please tell.
