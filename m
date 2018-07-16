Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47113 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeGPWG0 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 16 Jul 2018 18:06:26 -0400
Date: Mon, 16 Jul 2018 23:37:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 2/4] rtc: ds1307: support m41t11 variant
Message-ID: <20180716213707.GC2751@piout.net>
References: <20180516210842.5874-1-giulio.benetti@micronovasrl.com>
 <20180516210842.5874-2-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516210842.5874-2-giulio.benetti@micronovasrl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 16/05/2018 23:08:40+0200, Giulio Benetti wrote:
> The m41t11 variant is very similar to the already supported m41t00 and
> m41t0, but it has also 56 bytes of NVRAM.
> 
> Add it to driver taking into account NVRAM section.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +
>  drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
