Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:41553 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935676AbeCHJtV (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 8 Mar 2018 04:49:21 -0500
Date: Thu, 8 Mar 2018 10:49:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: remove VLA usage
Message-ID: <20180308094919.GD20370@piout.net>
References: <20180308022756.GA28733@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308022756.GA28733@embeddedor.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/03/2018 at 20:27:56 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> From a security viewpoint, the use of Variable Length Arrays can be
> a vector for stack overflow attacks. Also, in general, as the code
> evolves it is easy to lose track of how big a VLA can get. Thus, we
> can end up having segfaults that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 

That is a good description, thanks

> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> Changes in v2:
>  - Update changelog as per Alexandre Belloni request.
>  - Update the code for rtc-bq32k driver based on Alexandre's feedback.
> 
>  drivers/rtc/rtc-bq32k.c  | 6 +++++-
>  drivers/rtc/rtc-mcp795.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
Applied.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
