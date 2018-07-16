Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeGPWGF (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 16 Jul 2018 18:06:05 -0400
Date: Mon, 16 Jul 2018 23:36:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 1/4] rtc: ds1307: fix data pointer to m41t0
Message-ID: <20180716213646.GB2751@piout.net>
References: <20180516210842.5874-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516210842.5874-1-giulio.benetti@micronovasrl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 16/05/2018 23:08:39+0200, Giulio Benetti wrote:
> data field points to m41t00, instead it should point to m41t0.
> Driver works correctly because on both cases(m41t0 and m41t00) chip_desc
> are equal.
> 
> Point to right enum m41t0 instead of m41t00.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
