Return-Path: <SRS0=N1Xq=OA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3AFC43441
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E78520684
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="F7/8vDEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E78520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeKUUio (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:38:44 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41679 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeKUUio (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Nov 2018 15:38:44 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 478F825BE05;
        Wed, 21 Nov 2018 21:04:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1542794694; bh=wwVRUwF171x1ByJWujjWySi8J7BJ6v7q9p/R3LYyLUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7/8vDEoD4CfFVF1w53WzZg9QDG/Pq0r8c3gzO5EGoRNdgV4LioST8QYEgwjcgLWY
         9rB5QGw2OEdxzMDzkXde3mH+dKUSk61wLdkGBOw8YOZ2gpYXrsWClACi8/yC8oQaSq
         lhMBjecis20OirUDOqWhtIoRUJLIU4HXs8aaONM0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 7CF3594034F; Wed, 21 Nov 2018 11:04:52 +0100 (CET)
Date:   Wed, 21 Nov 2018 11:04:52 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH  1/4] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
Message-ID: <20181121100452.f4vyzuol2r6bozza@verge.net.au>
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com>
 <1542626108-61344-2-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542626108-61344-2-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, Nov 19, 2018 at 11:15:05AM +0000, Biju Das wrote:
> This patch adds binding for NXP pcf85263 real-time clock. pcf85263 rtc is
> compatible with pcf85363 rtc except that pcf85363 has 64 bytes additional
> RAM.

How about this:

This patch adds binding for the NXP pcf85263 real-time clock.

The pcf85263 RTC is compatible with the pcf85363 RTC. The difference
between the parts is except that the pcf85363 has 64 bytes more RAM.

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/rtc/pcf85363.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> index 76fdabc..94adc1c 100644
> --- a/Documentation/devicetree/bindings/rtc/pcf85363.txt
> +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> @@ -1,8 +1,8 @@
> -NXP PCF85363 Real Time Clock
> +NXP PCF85263/PCF85363 Real Time Clock
>  ============================
>  
>  Required properties:
> -- compatible: Should contain "nxp,pcf85363".
> +- compatible: Should contain "nxp,pcf85263" or "nxp,pcf85363".
>  - reg: I2C address for chip.
>  
>  Optional properties:
> -- 
> 2.7.4
> 
