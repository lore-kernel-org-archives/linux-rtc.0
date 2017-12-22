Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36499 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbdLVOrG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Dec 2017 09:47:06 -0500
Message-ID: <1513954023.1940.16.camel@googlemail.com>
Subject: Re: rtc: m41t80rtc: recent v4.15 changes ready for stable branch
 4.14
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-rtc@vger.kernel.org, stable@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Fri, 22 Dec 2017 15:47:03 +0100
In-Reply-To: <20171222130533.GE18255@piout.net>
References: <1513947027.1940.13.camel@googlemail.com>
         <20171222130533.GE18255@piout.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Greg

On Fri, 2017-12-22 at 14:05 +0100, Alexandre Belloni wrote:
> On 22/12/2017 at 13:50:27 +0100, Christoph Fritz wrote:
> > Hey Troy and Alexandre,
> > 
> >  any objections asking Greg to add following recent v4.15 changes into
> > stable branch 4.14?
> > 
> 
> No objection, they can be safely backported.

@Greg: Could you queue the following commits for 4.14.9 ?

> > 05a03bf rtc: m41t80: remove unneeded checks from m41t80_sqw_set_rate
> > 13bb1d7 rtc: m41t80: avoid i2c read in m41t80_sqw_is_prepared
> > 2cb90ed rtc: m41t80: avoid i2c read in m41t80_sqw_recalc_rate
> > c8384bb rtc: m41t80: fix m41t80_sqw_round_rate return value
> > de6042d rtc: m41t80: m41t80_sqw_set_rate should return 0 on success
> > 
> > Without these patches, deadlock warnings showing up in 4.14:
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.14.8-00011-gd203938 #11 Not tainted
> > ------------------------------------------------------

<snip>

Thanks
 -- Christoph
