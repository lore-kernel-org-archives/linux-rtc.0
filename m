Return-Path: <SRS0=iFAC=MQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2896C64EB8
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCE42083F
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCE42083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJEBbm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:31:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49331 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbeJEBbm (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 4 Oct 2018 21:31:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3EA020802; Thu,  4 Oct 2018 20:37:09 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C74AE20703;
        Thu,  4 Oct 2018 20:36:59 +0200 (CEST)
Date:   Thu, 4 Oct 2018 20:37:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Christian Svensson <christian@cmd.nu>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 1/2] rtc: Add ASPEED RTC driver
Message-ID: <20181004183700.GA5626@piout.net>
References: <20181003133155.27494-1-joel@jms.id.au>
 <20181003133155.27494-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003133155.27494-2-joel@jms.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 03/10/2018 15:31:54+0200, Joel Stanley wrote:
> +static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
> +	unsigned int cent, year, mon, day, hour, min, sec;
> +	unsigned long flags;
> +	u32 reg1, reg2;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	do {
> +		reg2 = readl(rtc->base + RTC_YEAR);
> +		reg1 = readl(rtc->base + RTC_TIME);
> +	} while (reg2 != readl(rtc->base + RTC_YEAR));
> +
> +	day  = (reg1 >> 24) & 0x1f;
> +	hour = (reg1 >> 16) & 0x1f;
> +	min  = (reg1 >>  8) & 0x3f;
> +	sec  = (reg1 >>  0) & 0x3f;
> +	cent = (reg2 >> 16) & 0x1f;
> +	year = (reg2 >>  8) & 0x7f;
> +	/*
> +	 * Month is 1-12 in hardware, and 0-11 in struct rtc_time, however we
> +	 * are using mktime64 which is 1-12, so no adjustment is necessary
> +	 */
> +	mon  = (reg2 >>  0) & 0x0f;
> +
> +	rtc_time64_to_tm(mktime64(cent * 100 + year, mon, day, hour, min, sec),
> +			tm);
> +

This is quite wasteful. You already have the broken out time. Why don't
you directly fill the tm struct?

> +static int aspeed_rtc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct aspeed_rtc *rtc;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rtc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc->base))
> +		return PTR_ERR(rtc->base);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> +						&aspeed_rtc_ops, THIS_MODULE);
> +

Please use devm_rtc_allocate_device to allocate the rtc and then
register it with rtc_register_device. Please also fill
rtc->range_{min,max} before the registration.

> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	spin_lock_init(&rtc->lock);
> +
> +	/* Enable RTC and clear the unlock bit */
> +	writel(RTC_ENABLE, rtc->base + RTC_CTRL);
> +

Maybe this should only be done in set_time so you can know whether the
time that is read in read_time has a chance to be valid.

For example you could return -EINVAL when RTC_ENABLE is not set if this
bit is readable.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
