Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:57217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbeISWpB (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 18:45:01 -0400
Date: Wed, 19 Sep 2018 19:05:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
Message-ID: <20180919170556.GB2479@piout.net>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
 <20180725172605.108040-3-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725172605.108040-3-giulio.benetti@micronovasrl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 25/07/2018 19:26:04+0200, Giulio Benetti wrote:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
