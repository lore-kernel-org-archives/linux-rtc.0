Return-Path: <SRS0=dQwf=R6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D7EC43381
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49DE2075D
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfC0KhM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:37:12 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57733 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfC0KhM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Mar 2019 06:37:12 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E197A4000A;
        Wed, 27 Mar 2019 10:37:07 +0000 (UTC)
Date:   Wed, 27 Mar 2019 11:37:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add on-chip ASPEED RTC
 documentation
Message-ID: <20190327103707.GA3682@piout.net>
References: <20190327010215.10231-1-joel@jms.id.au>
 <20190327010215.10231-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327010215.10231-2-joel@jms.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 27/03/2019 11:32:14+1030, Joel Stanley wrote:
> Describe the RTC as used in the ASPEED BMC SoCs.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Add interrupts property
> ---
>  .../devicetree/bindings/rtc/rtc-aspeed.txt    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
