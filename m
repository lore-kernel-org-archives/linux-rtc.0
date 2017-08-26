Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59126 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdHZITQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 26 Aug 2017 04:19:16 -0400
Date: Sat, 26 Aug 2017 10:19:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe
 and improve ds1307_set_time
Message-ID: <20170826081904.ibsxi7crvi7qop3m@piout.net>
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

Could you explain were you are going with this because this is a lot of
churn that takes a lot of my reviewing time and this doesn't seem to end
soon.

I want that driver to stop growing, maybe by creating a library. Some of
the supported RTCs doesn't share much more than the time and date layout
and should be in a separate driver.

On 25/08/2017 at 21:30:09 +0200, Heiner Kallweit wrote:
> Final goal of the refactoring is to abstract everything that the chips
> have in common and handle it in generic code. Then we can get rid of
> all the "switch (chip)" and "if (chip == xxx)" code.
> 
> To give one example:
> A lot of chips have a bit for setting 12hr / 24hr mode. However some
> chips have this config bit in the timekeeping registers, others in
> a config register, and on some chips it's inverted.
> But the functionality of the bit is always the same.
> 
> Ultimately adding support for a chip just requires to add one config
> structure member.
> 
> The way to reach this goal is a long one and to faciliate reviewing
> the patches I'll split them into series of 5 to 10 patches.
> 
> Heiner Kallweit (5):
>   rtc: ds1307: factor out determining the chip type
>   rtc: ds1307: factor out trickle charger initialization
>   rtc: ds1307: factor out fixing the weekday
>   rtc: ds1307: introduce constants for the timekeeping register masks
>   rtc: ds1307: improve ds1307_set_time to respect config flag bits
> 
>  drivers/rtc/rtc-ds1307.c | 256 ++++++++++++++++++++++++++---------------------
>  1 file changed, 140 insertions(+), 116 deletions(-)
> 
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
