Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59290 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdH0T0k (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2017 15:26:40 -0400
Date: Sun, 27 Aug 2017 21:26:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Roc He <hepeng@zidoo.tv>,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170827192638.2wgkhr7k3n4vrqth@piout.net>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827091301.wbuzxkh7opz4blrc@piout.net>
 <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
 <20170827133751.GD13622@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170827133751.GD13622@lunn.ch>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/08/2017 at 15:37:51 +0200, Andrew Lunn wrote:
> > >> +static inline int rtd119x_rtc_year_days(int year)
> > >> +{
> > >> +	return rtc_year_days(1, 12, year);
> > > 
> > > I'm not sure it is worth wrapping rtc_year_days
> > [snip]
> > 
> > Well, I found your rtc_year_days rather confusing and had to play with
> > the arguments until I got it working as expected, so I wanted an inline
> > function (or macro) as abstraction from my three callers.
> 
> I agree with that. I was wondering why 1st December was being used. I
> would say this API does not do too well on Rusty's API Design
> Manifesto.
> 

It follows the convention that tm_mon is 0-11. Making it easy to read
for anyone used to the RTC subsystem. I can agree it is not the most
intuitive one. That choice predates the RTC subsystem (made in 1996), I
won't give any name ;)

> It does at least get the day/month/year in the right order ;-)
> 
> 	Andrew

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
