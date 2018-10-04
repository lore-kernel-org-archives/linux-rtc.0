Return-Path: <SRS0=iFAC=MQ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC84DC64EBC
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946CB2083F
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Oct 2018 18:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946CB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJEBcR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:32:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49367 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbeJEBcQ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 4 Oct 2018 21:32:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C20FE208F4; Thu,  4 Oct 2018 20:37:44 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 916F4208B5;
        Thu,  4 Oct 2018 20:37:34 +0200 (CEST)
Date:   Thu, 4 Oct 2018 20:37:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Christian Svensson <christian@cmd.nu>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: Add ASPEED description
Message-ID: <20181004183735.GB5626@piout.net>
References: <20181003133155.27494-1-joel@jms.id.au>
 <20181003133155.27494-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003133155.27494-3-joel@jms.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

I think this patch should come first.

On 03/10/2018 15:31:55+0200, Joel Stanley wrote:
> Describe the RTC as used in the ASPEED ast2400 and ast2500 SoCs.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/rtc/rtc-aspeed.txt     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> new file mode 100644
> index 000000000000..d31a4d24c75f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
> @@ -0,0 +1,18 @@
> +ASPEED BMC RTC
> +==============
> +
> +Required properties:
> + - compatible: should be one of the following
> +   * aspeed,ast2400-rtc for the ast2400
> +   * aspeed,ast2500-rtc for the ast2500
> +
> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +   rtc@1e781000 {
> +           compatible = "aspeed,ast2400-rtc";
> +           reg = <0x1e781000 0x18>;
> +           status = "disabled";
> +   };
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
