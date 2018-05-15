Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42048 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753819AbeEONyc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 15 May 2018 09:54:32 -0400
Date: Tue, 15 May 2018 15:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 06/40] proc: introduce proc_create_single{,_data}
Message-ID: <20180515135849.GB31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de> <20180425154827.32251-7-hch@lst.de> <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Apr 26, 2018 at 11:45:50AM +1000, Finn Thain wrote:
> >  
> > -/*
> > - * /proc/nubus stuff
> > - */
> > -
> 
> I don't think that the introduction of proc_create_single{,_data} alters 
> the value of that comment. That comment and similar comments in the same 
> file do have a purpose, which is to keep separate the /proc/nubus 
> implementation is kept separate from the /proc/bus/nubus/devices 
> implementation and so on.

Added back.
