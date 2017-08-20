Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:36254 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753039AbdHTPki (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 20 Aug 2017 11:40:38 -0400
Date: Sun, 20 Aug 2017 17:40:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>
Subject: Re: [RFC 2/3] rtc: Add Realtek RTD1295
Message-ID: <20170820154017.GD24150@lunn.ch>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170820013632.18375-3-afaerber@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

> +static void rtd119x_rtc_set_enabled(struct device *dev, bool enable)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	val = readl_relaxed(data->base + RTD_RTCEN);
> +	dev_info(dev, "%s: rtcen = 0x%08x\n", __func__, val);

dev_dbg()?

> +static int rtd119x_rtc_open(struct device *dev)
> +{
> +	struct rtd119x_rtc *data = dev_get_drvdata(dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
> +
> +	val = readl_relaxed(data->base + RTD_RTCACR);
> +	dev_info(dev, "rtcacr = 0x%08x\n", val);

dev_dbg()?

	Andrew
