Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFEC05027
	for <linux-rtc@archiver.kernel.org>; Thu,  9 Feb 2023 22:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBIWuC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjBIWt5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 9 Feb 2023 17:49:57 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE62823C;
        Thu,  9 Feb 2023 14:49:47 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 77FACFF805;
        Thu,  9 Feb 2023 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675982986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lnvtyk9aeHwFjeMnZfCC53dWohWwbHsKqzFVtpNGRYY=;
        b=B+TTLo7qiAp2HGaN2AVJrlbifCRg1l7HsMHwDVeSx5Iwx3s9v6hzut3xSOnTfWHn6CYy/n
        jbRIzx1Y2kkEqiwnmGtqI/45a3BA1JNHvsPT4DG+ATjvCCsUdtyxF27LKIDCDXlO8syEGX
        CjG7OTrCV7LewTmAsP58jI7Y70ONtv4NptspdDdBmnoKSpPjpCwEoy+sDHzr3tZShC3/oJ
        fdW4EB3fwfQPYS2UOzmgbIr2EtjJpEtGJfgV/QYW3AbA9BsxJJYKKqp/CzGrCJ9hhnnmNk
        E3I52P7/9Q2x4D3W7QUC9Y6Phq118ifkXHyCYA0bLJAcde7ootsmrXpdJ7F9WQ==
Date:   Thu, 9 Feb 2023 23:49:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
Message-ID: <Y+V4iMaZ7WzCWzSc@mail.local>
References: <20221229184011.62925-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229184011.62925-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

What should I do with this series, I'm not sure you came to an
agreement.
Also, 2/2 doesn't apply so you'd have to rebase.

On 29/12/2022 12:40:10-0600, Samuel Holland wrote:
> If there is more than one parent clock in the devicetree, the
> driver sets .num_parents to a larger value than the number of array
> elements, which causes an out-of-bounds read in the clock framework.
> 
> Fix this by coercing the parent count to a Boolean value, like the
> driver expects.
> 
> Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index ed5516089e9a..a22358a44e32 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>  
>  	init.parent_names = parents;
>  	/* ... number of clock parents will be 1. */
> -	init.num_parents = of_clk_get_parent_count(node) + 1;
> +	init.num_parents = !!of_clk_get_parent_count(node) + 1;
>  	of_property_read_string_index(node, "clock-output-names", 0,
>  				      &init.name);
>  
> -- 
> 2.37.4
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
