Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:43882 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeDSOT1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Apr 2018 10:19:27 -0400
Date: Thu, 19 Apr 2018 17:18:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        linux-ide@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180419141818.pjys7at4xmz2h6ho@mwanda>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180419124140.9309-4-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 2a3f874a21d5..ad35cddcf6af 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -391,28 +391,15 @@ static const struct seq_operations cio_ignore_proc_seq_ops = {
>  	.show  = cio_ignore_proc_seq_show,
>  };
>  
> -static int
> -cio_ignore_proc_open(struct inode *inode, struct file *file)
> -{
> -	return seq_open_private(file, &cio_ignore_proc_seq_ops,
> -				sizeof(struct ccwdev_iter));
> -}
> -
> -static const struct file_operations cio_ignore_proc_fops = {
> -	.open    = cio_ignore_proc_open,
> -	.read    = seq_read,
> -	.llseek  = seq_lseek,
> -	.release = seq_release_private,
> -	.write   = cio_ignore_write,
                   ^^^^^^^^^^^^^^^^
The cio_ignore_write() function isn't used any more so compilers will
complain.

> -};
> -
>  static int
>  cio_ignore_proc_init (void)
>  {
>  	struct proc_dir_entry *entry;
>  
> -	entry = proc_create("cio_ignore", S_IFREG | S_IRUGO | S_IWUSR, NULL,
> -			    &cio_ignore_proc_fops);
> +	entry = proc_create_seq_private("cio_ignore",
> +			S_IFREG | S_IRUGO | S_IWUSR, NULL,
> +			&cio_ignore_proc_seq_ops, sizeof(struct ccwdev_iter),
> +			NULL);
>  	if (!entry)
>  		return -ENOENT;
>  	return 0;

regards,
dan carpenter
