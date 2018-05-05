Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:34376 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEEMv3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 5 May 2018 08:51:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
References: <20180425154827.32251-1-hch@lst.de>
        <20180425154827.32251-35-hch@lst.de>
Date: Sat, 05 May 2018 07:51:18 -0500
In-Reply-To: <20180425154827.32251-35-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 25 Apr 2018 17:48:21 +0200")
Message-ID: <87r2mq2rll.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 34/40] atm: simplify procfs code
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.

Can you please explain why you are removing the error handling when
you are unwinding the registration loop?

>  int __init atm_proc_init(void)
>  {
> -	static struct atm_proc_entry *e;
> -	int ret;
> -
>  	atm_proc_root = proc_net_mkdir(&init_net, "atm", init_net.proc_net);
>  	if (!atm_proc_root)
> -		goto err_out;
> -	for (e = atm_proc_ents; e->name; e++) {
> -		struct proc_dir_entry *dirent;
> -
> -		dirent = proc_create(e->name, 0444,
> -				     atm_proc_root, e->proc_fops);
> -		if (!dirent)
> -			goto err_out_remove;
> -		e->dirent = dirent;
> -	}
> -	ret = 0;
> -out:
> -	return ret;
> -
> -err_out_remove:
> -	atm_proc_dirs_remove();
> -err_out:
> -	ret = -ENOMEM;
> -	goto out;
> +		return -ENOMEM;
> +	proc_create_seq("devices", 0444, atm_proc_root, &atm_dev_seq_ops);
> +	proc_create("pvc", 0444, atm_proc_root, &pvc_seq_fops);
> +	proc_create("svc", 0444, atm_proc_root, &svc_seq_fops);
> +	proc_create("vc", 0444, atm_proc_root, &vcc_seq_fops);
> +	return 0;
>  }

These proc entries could fail to register with -ENOMEM if for no other
reason.  Can you justify the removal of the error handling?

Can you please at least mention that removal in your change description
and explain why it is reasonable.

As it sits this is not a semantics preserving transformation, and the
difference is not documented.  Which raises red flags for me.

Eric
