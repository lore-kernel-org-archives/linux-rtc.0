Return-Path: <rtc-linux+bncBDKZNNNLXAHBBY57QC3AKGQEZYYOY7A@googlegroups.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com. [2607:f8b0:400e:c00::236])
        by gmr-mx.google.com with ESMTPS id u66si2430269pfa.2.2016.02.13.22.34.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Feb 2016 22:34:11 -0800 (PST)
Received: by mail-pf0-x236.google.com with SMTP id q63so69813641pfb.0
        for <rtc-linux@googlegroups.com>; Sat, 13 Feb 2016 22:34:11 -0800 (PST)
Sender: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc: s3c: Document required clocks in the DT binding
To: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javier@osg.samsung.com>
References: <1455038632-14545-1-git-send-email-javier@osg.samsung.com>
Cc: k.kozlowski.k@gmail.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Rob Herring <robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-ID: <56C01FDD.9050204@samsung.com>
Date: Sun, 14 Feb 2016 15:34:05 +0900
MIME-Version: 1.0
In-Reply-To: <1455038632-14545-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

W dniu 10.02.2016 o 02:23, Javier Martinez Canillas pisze:
> The S3C Real Time Clock driver requires the clock and source clock to
> be defined in the device node but that requirement is not documented.

+Cc: Alessandro Zummo

No, not entirely. The samsung,s3c6410-rtc needs rtc and rtc_src clocks
but rest of compatible devices need only rtc clock.

Best regards,
Krzysztof

> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/rtc/s3c-rtc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> index ac2fcd6ff4b8..1068ffce9f91 100644
> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
> @@ -14,6 +14,10 @@ Required properties:
>    interrupt number is the rtc alarm interrupt and second interrupt number
>    is the rtc tick interrupt. The number of cells representing a interrupt
>    depends on the parent interrupt controller.
> +- clocks: Must contain a list of phandle and clock specifier for the rtc
> +          and source clocks.
> +- clock-names: Must contain "rtc" and "rtc_src" entries sorted in the
> +               same order as the clocks property.
>  
>  Example:
>  
> @@ -21,4 +25,6 @@ Example:
>  		compatible = "samsung,s3c6410-rtc";
>  		reg = <0x10070000 0x100>;
>  		interrupts = <44 0 45 0>;
> +		clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
> +		clock-names = "rtc", "rtc_src";
>  	};
> 

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
