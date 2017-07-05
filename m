Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36206 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752360AbdGEUyJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 16:54:09 -0400
Date: Wed, 5 Jul 2017 22:54:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] rtc: ds1307: use regmap_update_bits where
 applicable
Message-ID: <20170705205402.euakjjfldco33l7y@piout.net>
References: <a8dce195-b22a-47ce-992d-6437ce4e8297@gmail.com>
 <df917f73-1dfb-14db-be69-15aa52043938@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <df917f73-1dfb-14db-be69-15aa52043938@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/06/2017 at 17:57:29 +0200, Heiner Kallweit wrote:
> After the switch to regmap we can now make use of regmap_update_bits
> to simplify read/modify/write ops.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
> - no changes
> v3:
> - add Reviewed-by
> ---
>  drivers/rtc/rtc-ds1307.c | 82 ++++++++++++------------------------------------
>  1 file changed, 20 insertions(+), 62 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
