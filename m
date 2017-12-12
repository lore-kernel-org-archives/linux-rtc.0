Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46965 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdLLWYB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Dec 2017 17:24:01 -0500
Date: Tue, 12 Dec 2017 23:23:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Colin King <colin.king@canonical.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: ensure rtc is kfree'd on error
Message-ID: <20171212222359.GM8318@piout.net>
References: <20171122171618.2460-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171122171618.2460-1-colin.king@canonical.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 22/11/2017 at 17:16:18 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error return path on clk_data allocation failure does not kfree
> the allocated rtc object. Fix this with a kfree of rtc on the error
> exit path.
> 
> Detected by CoverityScan, CID#1452264 ("Resource Leak")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
