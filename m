Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:39734 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeGLS2L (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 12 Jul 2018 14:28:11 -0400
Date: Thu, 12 Jul 2018 20:17:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: test: make array pdev static
Message-ID: <20180712181718.GG16084@piout.net>
References: <20180624103803.4606-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180624103803.4606-1-colin.king@canonical.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 24/06/2018 11:38:03+0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The array pdev is local to the source and does not need to be in
> global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'pdev' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
