Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41638 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdH1HzA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 03:55:00 -0400
Date: Mon, 28 Aug 2017 09:54:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: core: let rtc_set_time properly populate element
 wday
Message-ID: <20170828075458.4cdi7pet3yxeskqc@piout.net>
References: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
 <20170826195607.s6p7u7vr3hxhwwqs@piout.net>
 <20170826195947.jnipgyuxg3ceqie4@piout.net>
 <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
 <7da740e6-b1e0-0a58-8b54-2e5e3e2f6c54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7da740e6-b1e0-0a58-8b54-2e5e3e2f6c54@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 27/08/2017 at 21:35:34 +0200, Heiner Kallweit wrote:
> When having a look at the MCP794XX datasheet it became clear why the
> mentioned weekday-related patch was submitted. This chip is quite
> strange regarding the possible alarm match conditions:
> 
> ALMxMSK<2:0>: Alarm Mask bits
> 000 = Seconds match
> 001 = Minutes match
> 010 = Hours match (logic takes into account 12-/24-hour operation)
> 011 = Day of week match
> 100 = Date match
> 101 = Reserved; do not use
> 110 = Reserved; do not use
> 111 = Seconds, Minutes, Hour, Day of Week, Date and Month
> 
> When not having a proper weekday you get only either seconds or
> minutes or hours or date match.
> 
> So it's best to ensure that the weekday is properly populated.
> However we can do this in the driver and don't have to touch the core.
> 

Can you do that only for mcp794xx? I received one earlier this month and
I'll separate the driver from rtc-ds1307.c at some point.

BTW, I've rebased and pushed some cleanup for this driver in:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/log/?h=rtc-ds1307

Can you base yourself on that?

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
