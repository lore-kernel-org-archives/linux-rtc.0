Return-Path: <SRS0=rvV4=QO=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C41AC282C2
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624252080F
	for <linux-rtc@archiver.kernel.org>; Thu,  7 Feb 2019 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBGUmR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:42:17 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42541 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfBGUmR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 7 Feb 2019 15:42:17 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0B93520003;
        Thu,  7 Feb 2019 20:42:14 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:42:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] rtx: x1205: Add DT bindings
Message-ID: <20190207204214.GI4719@piout.net>
References: <20190131150642.26289-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131150642.26289-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 31/01/2019 16:06:41+0100, Linus Walleij wrote:
> This adds device tree bindings for the Xircom X1205 RTC found
> in the Linksys NSLU2.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/rtc/xircom,x1205.txt         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xircom,x1205.txt
> 

I chose to not apply that one and instead amend your following patch to
add the compatible with the trivial RTCs in rtc.txt

> diff --git a/Documentation/devicetree/bindings/rtc/xircom,x1205.txt b/Documentation/devicetree/bindings/rtc/xircom,x1205.txt
> new file mode 100644
> index 000000000000..3e3102a32728
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/xircom,x1205.txt
> @@ -0,0 +1,12 @@
> +* Xircom X1205 I2C RTC
> +
> +Required properties:
> +- compatible: Should be "xircom,x1205"
> +- reg: I2C address
> +
> +Example:
> +
> +rtc@6f {
> +	compatible = "xicor,x1205";
> +	reg = <0x6f>;
> +};
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
