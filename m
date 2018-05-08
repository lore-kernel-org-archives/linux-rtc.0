Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45688 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeEHQIx (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 8 May 2018 12:08:53 -0400
Date: Tue, 8 May 2018 11:08:51 -0500
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] dt-bindings: rtc-2123: Make the node name generic
Message-ID: <20180508160851.GA23232@rob-hp-laptop>
References: <1525489831-23871-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525489831-23871-1-git-send-email-festevam@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, May 05, 2018 at 12:10:31AM -0300, Fabio Estevam wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
