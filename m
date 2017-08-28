Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34128 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdH1Syv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 14:54:51 -0400
Date: Mon, 28 Aug 2017 20:54:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: core: let rtc_set_time properly populate element
 wday
Message-ID: <20170828185439.7jd4ogjuj6htl5c2@piout.net>
References: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
 <20170826195607.s6p7u7vr3hxhwwqs@piout.net>
 <20170826195947.jnipgyuxg3ceqie4@piout.net>
 <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
 <7da740e6-b1e0-0a58-8b54-2e5e3e2f6c54@gmail.com>
 <20170828075458.4cdi7pet3yxeskqc@piout.net>
 <9a11b823-abe0-6611-9d97-75e2a2ec7745@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9a11b823-abe0-6611-9d97-75e2a2ec7745@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 28/08/2017 at 20:13:25 +0200, Heiner Kallweit wrote:
> Am 28.08.2017 um 09:54 schrieb Alexandre Belloni:
> > On 27/08/2017 at 21:35:34 +0200, Heiner Kallweit wrote:
> >> When having a look at the MCP794XX datasheet it became clear why the
> >> mentioned weekday-related patch was submitted. This chip is quite
> >> strange regarding the possible alarm match conditions:
> >>
> >> ALMxMSK<2:0>: Alarm Mask bits
> >> 000 = Seconds match
> >> 001 = Minutes match
> >> 010 = Hours match (logic takes into account 12-/24-hour operation)
> >> 011 = Day of week match
> >> 100 = Date match
> >> 101 = Reserved; do not use
> >> 110 = Reserved; do not use
> >> 111 = Seconds, Minutes, Hour, Day of Week, Date and Month
> >>
> >> When not having a proper weekday you get only either seconds or
> >> minutes or hours or date match.
> >>
> >> So it's best to ensure that the weekday is properly populated.
> >> However we can do this in the driver and don't have to touch the core.
> >>
> > 
> > Can you do that only for mcp794xx? I received one earlier this month and
> > I'll separate the driver from rtc-ds1307.c at some point.
> > 
> Sure, I'll submit a patch for this. Separating the driver for mcp794xx may
> not be needed as it is not that different from the other chips supported
> by this driver. Once I have my patch series proposal towards a ds1307_lib
> in a little more clean state this should become clearer.
> 

I would like to find a better name than that but I didn't come up with
anything yet... feel free to get creative ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
