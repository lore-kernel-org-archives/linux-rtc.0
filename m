Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49634 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdH0I1P (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2017 04:27:15 -0400
Date: Sun, 27 Aug 2017 10:27:14 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170827082714.nya7m3movufujtjk@piout.net>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/08/2017 at 04:30:08 +0200, Andreas Färber wrote:
> Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
> > n Sun, Aug 27, 2017 at 02:33:27AM +0200, Andreas Färber wrote:
> >> +struct rtd119x_rtc {
> >> +	void __iomem *base;
> >> +	struct clk *clk;
> >> +	struct rtc_device *rtcdev;
> >> +	unsigned base_year;
> >> +	spinlock_t lock;
> > 
> > Where is this lock initialised? I would expect a call to
> > spin_lock_init() somewhere.
> 
> Hm, the spinlock in my irq mux series doesn't have that call either; my
> reset driver did have it. The zero initialization appears to work OK,
> but you're probably right that it should be there.
> 
> > I also wonder what this lock is protecting, which rtc->ops_lock does
> > not protect?
> 
> By that same argument we could ask why so many drivers (and mine, too)
> are calling rtc_valid_tm() when __rtc_read_time() calls it again...
> 

Most of them probably predates the introduction of the check in
__rtc_read_time().


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
