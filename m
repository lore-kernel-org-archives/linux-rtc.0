Return-Path: <rtc-linux+bncBDS7HNEFSALRBANNQ63AKGQEMVOUXFY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si455257wme.0.2016.02.15.05.45.36
        for <rtc-linux@googlegroups.com>;
        Mon, 15 Feb 2016 05:45:36 -0800 (PST)
Date: Mon, 15 Feb 2016 14:45:35 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: s3c: Document in binding that only
 s3c6410 needs a src clk
Message-ID: <20160215134535.GB15219@piout.net>
References: <1455542202-13977-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455542202-13977-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/02/2016 at 10:16:42 -0300, Javier Martinez Canillas wrote :
> Commit 43f3408261a2 ("rtc: s3c: Document required clocks in the DT

I'm pretty sure you shouldn't refer to a commit that is in linux-next.

> binding") added to the S3C binding doc the required clocks needed
> by the Real Time Clock but the S3C driver supports different HW IP
> and only the s3c6410 needs a source clock.
> 
> Fix the DT binding explaning that the second clock is only needed
          explaining ^
> by this IP block and not for the others.
> 
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 43f3408261a2 ("rtc: s3c: Document required clocks in the DT binding")
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Anyway, I'm fine with it, feel free to add my ack.

> ---
> Hello,
> 
> The mentioned commit was picked by Rob Herring so this one has to go
> through his tree again and not through the RTC tree to avoid conflicts.
> 
> Best regards,
> Javier
> 
>  Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> index 1068ffce9f91..fdde63a5419c 100644
> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> @@ -15,9 +15,10 @@ Required properties:
>    is the rtc tick interrupt. The number of cells representing a interrupt
>    depends on the parent interrupt controller.
>  - clocks: Must contain a list of phandle and clock specifier for the rtc
> -          and source clocks.
> -- clock-names: Must contain "rtc" and "rtc_src" entries sorted in the
> -               same order as the clocks property.
> +          clock and in the case of a s3c6410 compatible controller, also
> +          a source clock.
> +- clock-names: Must contain "rtc" and for a s3c6410 compatible controller,
> +               a "rtc_src" sorted in the same order as the clocks property.
>  
>  Example:
>  
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
