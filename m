Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53262 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdHUOSE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Aug 2017 10:18:04 -0400
Date: Mon, 21 Aug 2017 16:17:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: fix regmap config
Message-ID: <20170821141735.2aw55st4fo35f42v@piout.net>
References: <2061233f-1187-d03c-51dc-8d7ad2faf90e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2061233f-1187-d03c-51dc-8d7ad2faf90e@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 25/07/2017 at 18:44:04 +0200, Heiner Kallweit wrote:
> Current max_register setting breaks reading nvram on certain chips and
> also reading the standard registers on RX8130 where register map starts
> at 0x10.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Fixes: 11e5890b5342 "rtc: ds1307: convert driver to regmap"
> ---
> This fix should make it to 4.13.
> ---
>  drivers/rtc/rtc-ds1307.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
