Return-Path: <rtc-linux+bncBDKZNNNLXAHBBR7FRS6AKGQEKKV7TVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id 62si149796pfx.1.2016.07.10.22.46.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jul 2016 22:46:47 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OA40076NYPUOA10@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 11 Jul 2016 06:46:42 +0100 (BST)
Subject: [rtc-linux] Re: [PATCH 0/3] making rtc cores from s3c6410 and
 exynos3250 both work
To: Randy Li <ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <578332C0.4010601@samsung.com>
Date: Mon, 11 Jul 2016 07:46:40 +0200
MIME-version: 1.0
In-reply-to: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
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
> The 8792f7772f4f40ffc68bad5f28311205584b734d would just make those
> platform using rtc core from exynos3250 work but have a huge 
> effect on those platforms using the rtc core from s3c6410.
> These patches would fix this problem.
> 

Which problem? What huge effect? On which platforms? You didn't describe
it...

Your change breaks the ABI and is not compatible with current bindings
documentation.

Best regards,
Krzysztof

> Randy Li (3):
>   Revert "drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data"
>   rtc: s3c: add device data for samsung,exynos3250-rtc
>   ARM: dts: exynos: correct the rtc compatible value for exynos5
> 
>  arch/arm/boot/dts/exynos3250.dtsi |  2 +-
>  arch/arm/boot/dts/exynos5.dtsi    |  2 +-
>  drivers/rtc/rtc-s3c.c             | 15 +++++++++++++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
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
