Return-Path: <SRS0=dQwf=R6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490CC10F00
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685312075C
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 10:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfC0Khk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:37:40 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34929 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfC0Khj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Mar 2019 06:37:39 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7E25F240009;
        Wed, 27 Mar 2019 10:37:34 +0000 (UTC)
Date:   Wed, 27 Mar 2019 11:37:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] rtc: Add ASPEED RTC driver
Message-ID: <20190327103734.GB3682@piout.net>
References: <20190327010215.10231-1-joel@jms.id.au>
 <20190327010215.10231-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327010215.10231-3-joel@jms.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 27/03/2019 11:32:15+1030, Joel Stanley wrote:
> Read and writes the time to the non-battery backed RTC in the ASPEED BMC
> system on chip families.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>  - Use %ptR
>  - Remove spinlock, as callback happen under the rtc_device.ops_lock
> v2: Address review from Alexandre
>  - Use devm_rtc_allocate_device
>  - Fill in range_min
>  - Direcly fill in tm struct
>  - Return EINVAL when RTC is not enabled
> 
> v1: https://lore.kernel.org/linux-arm-kernel/20181003133155.27494-2-joel@jms.id.au/
> 
> Update kconfig text
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/rtc/Kconfig      |  11 ++++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-aspeed.c | 138 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/rtc/rtc-aspeed.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
