Return-Path: <SRS0=ug2M=OB=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26220C43441
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D971E206B2
	for <linux-rtc@archiver.kernel.org>; Thu, 22 Nov 2018 17:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D971E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbeKWD6j (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:58:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35469 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389522AbeKWD6j (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 22 Nov 2018 22:58:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1FFB920D31; Thu, 22 Nov 2018 18:18:20 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB07920726;
        Thu, 22 Nov 2018 18:18:19 +0100 (CET)
Date:   Thu, 22 Nov 2018 18:18:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: dt-binding: abx80x: fix resistance scale
Message-ID: <20181122171819.GK12656@piout.net>
References: <03de7e5c04091b69c550be82420c6a8ce5bbb71f.1542630842.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03de7e5c04091b69c550be82420c6a8ce5bbb71f.1542630842.git.baruch@tkos.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 19/11/2018 14:34:02+0200, Baruch Siach wrote:
> The abracon,tc-resistor property value is in KOhm.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/devicetree/bindings/rtc/abracon,abx80x.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> index be789685a1c2..e668b5f65314 100644
> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
> @@ -27,4 +27,4 @@ and valid to enable charging:
>  
>   - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
>   - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
> -                          resistor, the other values are in ohm.
> +                          resistor, the other values are in KOhm.

The correct SI prefix is k so this should be kOhm. If you agree, I can
fix this up.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
