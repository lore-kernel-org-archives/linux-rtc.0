Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdL1XQP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Dec 2017 18:16:15 -0500
Date: Thu, 28 Dec 2017 15:16:12 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Clark <robdclark@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.or,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] clk: divider: fix incorrect usage of container_of
Message-ID: <20171228231612.GX7997@codeaurora.org>
References: <20171221163054.13600-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221163054.13600-1-jbrunet@baylibre.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 12/21, Jerome Brunet wrote:
> divider_recalc_rate() is an helper function used by clock divider of
> different types, so the structure containing the 'hw' pointer is not
> always a 'struct clk_divider'
> 
> At the following line:
> > div = _get_div(table, val, flags, divider->width);
> 
> in several cases, the value of 'divider->width' is garbage as the actual
> structure behind this memory is not a 'struct clk_divider'
> 
> Fortunately, this width value is used by _get_val() only when
> CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
> far when the structure is not a 'struct clk_divider'. This is probably
> why we did not notice this bug before
> 
> Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
