Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeADLHK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 4 Jan 2018 06:07:10 -0500
Date: Thu, 4 Jan 2018 12:07:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-rtc@vger.kernel.org, stable@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: rtc: m41t80rtc: recent v4.15 changes ready for stable branch 4.14
Message-ID: <20180104110712.GA1507@kroah.com>
References: <1513947027.1940.13.camel@googlemail.com>
 <20171222130533.GE18255@piout.net>
 <1513954023.1940.16.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513954023.1940.16.camel@googlemail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Dec 22, 2017 at 03:47:03PM +0100, Christoph Fritz wrote:
> Hi Greg
> 
> On Fri, 2017-12-22 at 14:05 +0100, Alexandre Belloni wrote:
> > On 22/12/2017 at 13:50:27 +0100, Christoph Fritz wrote:
> > > Hey Troy and Alexandre,
> > > 
> > >  any objections asking Greg to add following recent v4.15 changes into
> > > stable branch 4.14?
> > > 
> > 
> > No objection, they can be safely backported.
> 
> @Greg: Could you queue the following commits for 4.14.9 ?
> 
> > > 05a03bf rtc: m41t80: remove unneeded checks from m41t80_sqw_set_rate
> > > 13bb1d7 rtc: m41t80: avoid i2c read in m41t80_sqw_is_prepared
> > > 2cb90ed rtc: m41t80: avoid i2c read in m41t80_sqw_recalc_rate
> > > c8384bb rtc: m41t80: fix m41t80_sqw_round_rate return value
> > > de6042d rtc: m41t80: m41t80_sqw_set_rate should return 0 on success

All now queued up, sorry for the delay, been a bit busy lately :)

greg k-h
