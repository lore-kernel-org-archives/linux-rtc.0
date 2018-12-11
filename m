Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249BC5CFFE
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AD420811
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AD420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLKLPs (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:15:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKLPs (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 11 Dec 2018 06:15:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D788420C4D; Tue, 11 Dec 2018 12:15:45 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A88AF207B8;
        Tue, 11 Dec 2018 12:15:35 +0100 (CET)
Date:   Tue, 11 Dec 2018 12:15:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Message-ID: <20181211111535.GP8952@piout.net>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544182066-31528-3-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 07/12/2018 11:27:43+0000, Biju Das wrote:
> The pcf85263 RTC is compatible with the pcf85363 RTC.
> 
> The difference between the pcf85263 and pcf85363 RTC is that the latter has
> 64 bytes more RAM. This renders them incompatible from a DT point of view.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V1-->V2
> 	* Incorporated Simon's review comment.
> V2-->V3
> 	* No Change.
> V3-->V4
> 	* No Change.
> ---
>  Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
