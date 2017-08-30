Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57202 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdH3HxE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 30 Aug 2017 03:53:04 -0400
Date: Wed, 30 Aug 2017 09:52:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean.nyekjaer@prevas.dk>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH 1/2] rtc: pcf2127: add support for pcf2127
 watchdog functionality
Message-ID: <20170830075252.bska2yik2tnxq25y@piout.net>
References: <20170120123644.118612-1-sean.nyekjaer@prevas.dk>
 <20170829150739.apyt4lxguypebkbm@piout.net>
 <4294cb1e-a01f-66db-8b64-eb4d5e68569e@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4294cb1e-a01f-66db-8b64-eb4d5e68569e@prevas.dk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 30/08/2017 at 09:45:06 +0200, Sean Nyekjær wrote:
> 
> 
> On 2017-08-29 17:07, Alexandre Belloni wrote:
> > Hi Sean,
> > 
> > I know this patch is 7 months old but I never had the time to write a
> > proper reply.
> > 
> > This is using a pretty old API. Can you register a proper watchdog using
> > the watchdog subsystem (see drivers/watchdog)? Also, please copy the
> > watchdog maintainers.
> > 
> > I understand this will require a significant rewrite effort but the
> > final code will be quite cleaner.
> Hi Alexandre
> 
> I unfortunately don't have access to the hardware anymore...
> I think it would be very risky to rewrite the whole code without testing it
> :-)
> 

Ok, too bad. :(

> Yes this driver is quite hacky in some ways. It could be nice if the
> watchdog part for this could be in the driver/watchdog and the rtc part
> here. Maybe we could have 2 entries in the devicetree that shared the same
> i2c device address.
> 

If you want to go that route, the proper way is to use the MFD
subsystem.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
