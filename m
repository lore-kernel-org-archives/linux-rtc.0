Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604BC43381
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1031218E2
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 06:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCVGXw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:23:52 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38599 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVGXw (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 02:23:52 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3AE5E240005;
        Fri, 22 Mar 2019 06:23:48 +0000 (UTC)
Date:   Fri, 22 Mar 2019 07:23:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] rtc: x1205: Add DT bindings
Message-ID: <20190322062343.GW29054@piout.net>
References: <20190319074014.20616-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319074014.20616-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 19/03/2019 08:40:13+0100, Linus Walleij wrote:
> This adds device tree bindings for the Xircom X1205 RTC found
> in the Linksys NSLU2.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebase on v5.1-rc1
> - Resend
> ---
>  .../devicetree/bindings/rtc/xircom,x1205.txt         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xircom,x1205.txt
> 

Both applied (this time), thanks!

I've moved the doc to rtc.txt as this is a trivial rtc.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
