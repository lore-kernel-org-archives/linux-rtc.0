Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45254 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdH0D2A (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 26 Aug 2017 23:28:00 -0400
Date: Sun, 27 Aug 2017 05:27:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Roc He <hepeng@zidoo.tv>,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170827032745.GC13622@lunn.ch>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sun, Aug 27, 2017 at 04:30:08AM +0200, Andreas Färber wrote:
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

Hi Andreas

I suspect you will have problems if you enable spin lock debug code,
like CONFIG_DEBUG_SPINLOCK.

     Andrew
