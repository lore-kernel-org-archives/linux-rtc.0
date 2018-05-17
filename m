Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:59230 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeEQF2K (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 17 May 2018 01:28:10 -0400
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
        <20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
        <20180515145643.GA661@lst.de>
Date: Thu, 17 May 2018 00:28:01 -0500
In-Reply-To: <20180515145643.GA661@lst.de> (Christoph Hellwig's message of
        "Tue, 15 May 2018 16:56:43 +0200")
Message-ID: <871seakg0u.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Sat, May 05, 2018 at 07:37:33AM -0500, Eric W. Biederman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > The shole seq_file sequence already operates under a single RCU lock pair,
>> > so move the pid namespace lookup into it, and stop grabbing a reference
>> > and remove all kinds of boilerplate code.
>> 
>> This is wrong.
>> 
>> Move task_active_pid_ns(current) from open to seq_start actually means
>> that the results if you pass this proc file between callers the results
>> will change.  So this breaks file descriptor passing.
>> 
>> Open is a bad place to access current.  In the middle of read/write is
>> broken.
>> 
>> 
>> In this particular instance looking up the pid namespace with
>> task_active_pid_ns was a personal brain fart.  What the code should be
>> doing (with an appropriate helper) is:
>> 
>> struct pid_namespace *pid_ns = inode->i_sb->s_fs_info;
>> 
>> Because each mount of proc is bound to a pid namespace.  Looking up the
>> pid namespace from the super_block is a much better way to go.
>
> What do you have in mind for the helper?  For now I've thrown it in
> opencoded into my working tree, but I'd be glad to add a helper.
>
> struct pid_namespace *proc_pid_namespace(struct inode *inode)
> {
> 	// maybe warn on for s_magic not on procfs??
> 	return inode->i_sb->s_fs_info;
> }

That should work.  Ideally out of line for the proc_fs.h version.
Basically it should be a cousin of PDE_DATA.

Eric
