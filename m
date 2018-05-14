Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:48668 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeENN2y (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 14 May 2018 09:28:54 -0400
Date: Mon, 14 May 2018 15:28:42 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh+dt@kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] dt-bindings: rtc-2123: Make the node name generic
Message-ID: <20180514132842.GX10960@piout.net>
References: <1525489831-23871-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525489831-23871-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 05/05/2018 00:10:31-0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to Devicetree Specification v0.2 document:
> 
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model."
> 
> Do as suggested in the binding example.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
