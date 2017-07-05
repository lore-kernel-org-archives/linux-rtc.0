Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36234 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbdGEUyR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 16:54:17 -0400
Date: Wed, 5 Jul 2017 22:54:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rtc: ds1307: factor out century bit handling
Message-ID: <20170705205416.afyhe5uw27szd6af@piout.net>
References: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
 <cec62c55-1a12-9804-e589-0014eb482ca1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cec62c55-1a12-9804-e589-0014eb482ca1@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/06/2017 at 17:57:33 +0200, Heiner Kallweit wrote:
> The driver has lots of places with chip-specific code what doesn't
> necessarily facilitate maintenance.
> 
> Let's describe chip-specific differences in century bit handling
> in struct chip_desc to improve this.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
> - no changes
> v3:
> - add Reviewed-by
> ---
>  drivers/rtc/rtc-ds1307.c | 70 ++++++++++++++++++------------------------------
>  1 file changed, 26 insertions(+), 44 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
