Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58262 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdH1QQ3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 12:16:29 -0400
Date: Mon, 28 Aug 2017 18:16:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roc He <hepeng@zidoo.tv>,
        =?utf-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>
Subject: Re: [PATCH v3 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170828161627.4vndoeucudh3rfto@piout.net>
References: <20170828111041.17946-1-afaerber@suse.de>
 <20170828111041.17946-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170828111041.17946-3-afaerber@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

Seems fine to me, one small comment:

On 28/08/2017 at 13:10:40 +0200, Andreas Färber wrote:
> +static int rtd119x_rtc_remove(struct platform_device *pdev)
> +{
> +	struct rtd119x_rtc *data = platform_get_drvdata(pdev);
> +
> +	rtd119x_rtc_set_enabled(&pdev->dev, false);
> +
> +	clk_disable_unprepare(data->clk);

Missing clk_put ?

> +
> +	return 0;
> +}
> +
> +static struct platform_driver rtd119x_rtc_driver = {
> +	.probe = rtd119x_rtc_probe,
> +	.remove = rtd119x_rtc_remove,
> +	.driver = {
> +		.name = "rtd1295-rtc",
> +		.of_match_table	= rtd119x_rtc_dt_ids,
> +	},
> +};
> +builtin_platform_driver(rtd119x_rtc_driver);
> -- 
> 2.12.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
