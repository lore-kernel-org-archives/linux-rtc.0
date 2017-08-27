Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45409 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdH0NiY (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 27 Aug 2017 09:38:24 -0400
Date: Sun, 27 Aug 2017 15:37:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Roc He <hepeng@zidoo.tv>,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170827133751.GD13622@lunn.ch>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827091301.wbuzxkh7opz4blrc@piout.net>
 <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

> >> +static inline int rtd119x_rtc_year_days(int year)
> >> +{
> >> +	return rtc_year_days(1, 12, year);
> > 
> > I'm not sure it is worth wrapping rtc_year_days
> [snip]
> 
> Well, I found your rtc_year_days rather confusing and had to play with
> the arguments until I got it working as expected, so I wanted an inline
> function (or macro) as abstraction from my three callers.

I agree with that. I was wondering why 1st December was being used. I
would say this API does not do too well on Rusty's API Design
Manifesto.

It does at least get the day/month/year in the right order ;-)

	Andrew
