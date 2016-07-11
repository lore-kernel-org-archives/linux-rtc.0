Return-Path: <rtc-linux+bncBDKZNNNLXAHBBJPIRS6AKGQE7EYL5ZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id w75si283749pfd.0.2016.07.10.22.52.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 22:52:37 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA400L5ZYZKVC10@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 11 Jul 2016 06:52:32 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH 3/3] ARM: dts: exynos: correct the rtc
 compatible value for exynos5
To: Randy Li <ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
 <1468056226-19128-4-git-send-email-ayaka@soulik.info>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5783341F.1030006@samsung.com>
Date: Mon, 11 Jul 2016 07:52:31 +0200
MIME-version: 1.0
In-reply-to: <1468056226-19128-4-git-send-email-ayaka@soulik.info>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/09/2016 11:23 AM, Randy Li wrote:
> Those platforms are reported to use the same rtc IP core
> as exynos3250's.

Insufficient. Exynos4 also has to be updated. Actually all SoC from SoC
family requires rtc src clock. I think S3C6410 also requires it but I
don't have all the data necessary to confirm this.

Best regards,
Krzysztof

> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5.dtsi    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 62f3dcd..cdd69a0 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -208,7 +208,7 @@
>  		};
>  
>  		rtc: rtc@10070000 {
> -			compatible = "samsung,s3c6410-rtc";
> +			compatible = "samsung,exynos3250-rtc";
>  			reg = <0x10070000 0x100>;
>  			interrupts = <0 73 0>, <0 74 0>;
>  			interrupt-parent = <&pmu_system_controller>;
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index d5c0f18..71a1ad2 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -88,7 +88,7 @@
>  	};
>  
>  	rtc: rtc@101E0000 {
> -		compatible = "samsung,s3c6410-rtc";
> +		compatible = "samsung,exynos3250-rtc";
>  		reg = <0x101E0000 0x100>;
>  		interrupts = <0 43 0>, <0 44 0>;
>  		status = "disabled";
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
