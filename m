Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:38331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeECUMg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 3 May 2018 16:12:36 -0400
Date: Thu, 3 May 2018 22:12:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, broonie@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: sprd: Change to use devm_rtc_allocate_device()
Message-ID: <20180503201225.GB10960@piout.net>
References: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 26/04/2018 10:58:44+0800, Baolin Wang wrote:
> This is a preparation patch, changing to use devm_rtc_allocate_device()
> that can allow driver to set 'range_max' and 'range_min' for the RTC
> device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sc27xx.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Both applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
