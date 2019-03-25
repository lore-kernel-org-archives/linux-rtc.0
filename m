Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB1C4360F
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D82075C
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfCYO77 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:59 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60665 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYO77 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 10:59:59 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 45D48240015;
        Mon, 25 Mar 2019 14:59:55 +0000 (UTC)
Date:   Mon, 25 Mar 2019 15:59:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
Message-ID: <20190325145954.GM30105@piout.net>
References: <20190325133159.10653-1-joel@jms.id.au>
 <20190325133159.10653-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325133159.10653-3-joel@jms.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

This seems mostly good to me.

On 26/03/2019 00:01:59+1030, Joel Stanley wrote:
> +	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> +			1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +

We now have %ptR, could you use that?

> +	rtc->rtc_dev->ops = &aspeed_rtc_ops;
> +	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
> +	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
> +

I'm curious how many RTC have been properly designed, could you run
rtc-range?

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c

Thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
