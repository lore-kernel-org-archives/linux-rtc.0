Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbdH0CaM (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 26 Aug 2017 22:30:12 -0400
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de> <20170827020501.GB13622@lunn.ch>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
Date: Sun, 27 Aug 2017 04:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170827020501.GB13622@lunn.ch>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
> n Sun, Aug 27, 2017 at 02:33:27AM +0200, Andreas Färber wrote:
>> +struct rtd119x_rtc {
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	struct rtc_device *rtcdev;
>> +	unsigned base_year;
>> +	spinlock_t lock;
> 
> Where is this lock initialised? I would expect a call to
> spin_lock_init() somewhere.

Hm, the spinlock in my irq mux series doesn't have that call either; my
reset driver did have it. The zero initialization appears to work OK,
but you're probably right that it should be there.

> I also wonder what this lock is protecting, which rtc->ops_lock does
> not protect?

By that same argument we could ask why so many drivers (and mine, too)
are calling rtc_valid_tm() when __rtc_read_time() calls it again...

The downstream code is locking inside individual functions such as
check_acr or set_enabled; I adopted it for whole operations only, but
you're right that so far it matches the RTC class ops granularity, so I
can drop it again. The latching discussion had reminded me of locking.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
