Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:46823 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756396AbeDYSZu (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 25 Apr 2018 14:25:50 -0400
Date: Wed, 25 Apr 2018 20:25:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-ide@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/40] rtc/proc: switch to proc_create_single_data
Message-ID: <20180425182537.GG4813@piout.net>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425154827.32251-28-hch@lst.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 25/04/2018 17:48:14+0200, Christoph Hellwig wrote:
> And stop trying to get a reference on the submodule, procfs code deals
> with release after and unloaded module and thus removed proc entry.
small typo here        ^

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> ---
>  drivers/rtc/rtc-proc.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
> index 31e7e23cc5be..a9dd9218fae2 100644
> --- a/drivers/rtc/rtc-proc.c
> +++ b/drivers/rtc/rtc-proc.c
> @@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
>  	return 0;
>  }
>  
> -static int rtc_proc_open(struct inode *inode, struct file *file)
> -{
> -	int ret;
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	if (!try_module_get(rtc->owner))
> -		return -ENODEV;
> -
> -	ret = single_open(file, rtc_proc_show, rtc);
> -	if (ret)
> -		module_put(rtc->owner);
> -	return ret;
> -}
> -
> -static int rtc_proc_release(struct inode *inode, struct file *file)
> -{
> -	int res = single_release(inode, file);
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	module_put(rtc->owner);
> -	return res;
> -}
> -
> -static const struct file_operations rtc_proc_fops = {
> -	.open		= rtc_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= rtc_proc_release,
> -};
> -
>  void rtc_proc_add_device(struct rtc_device *rtc)
>  {
>  	if (is_rtc_hctosys(rtc))
> -		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
> +		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
> +				rtc);
>  }
>  
>  void rtc_proc_del_device(struct rtc_device *rtc)
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
