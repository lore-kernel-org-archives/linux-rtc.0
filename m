Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:49196 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdH3H4Y (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 30 Aug 2017 03:56:24 -0400
Subject: Re: [rtc-linux] [PATCH 1/2] rtc: pcf2127: add support for pcf2127
 watchdog functionality
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-rtc@vger.kernel.org>
References: <20170120123644.118612-1-sean.nyekjaer@prevas.dk>
 <20170829150739.apyt4lxguypebkbm@piout.net>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <4294cb1e-a01f-66db-8b64-eb4d5e68569e@prevas.dk>
Date: Wed, 30 Aug 2017 09:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170829150739.apyt4lxguypebkbm@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>



On 2017-08-29 17:07, Alexandre Belloni wrote:
> Hi Sean,
>
> I know this patch is 7 months old but I never had the time to write a
> proper reply.
>
> This is using a pretty old API. Can you register a proper watchdog using
> the watchdog subsystem (see drivers/watchdog)? Also, please copy the
> watchdog maintainers.
>
> I understand this will require a significant rewrite effort but the
> final code will be quite cleaner.
Hi Alexandre

I unfortunately don't have access to the hardware anymore...
I think it would be very risky to rewrite the whole code without testing 
it :-)

Yes this driver is quite hacky in some ways. It could be nice if the 
watchdog part for this could be in the driver/watchdog and the rtc part 
here. Maybe we could have 2 entries in the devicetree that shared the 
same i2c device address.

/Sean
