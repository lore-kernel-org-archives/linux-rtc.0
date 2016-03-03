Return-Path: <rtc-linux+bncBDEKVJM7XAHRBGNR4C3AKGQEXP5PT4Q@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id ph8si229491igb.0.2016.03.03.02.57.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 02:57:28 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: [rtc-linux] Re: [RFC 09/15] media: platform: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
Date: Thu, 03 Mar 2016 11:57:10 +0100
Message-ID: <2181866.k24LVvUjTs@wuerfel>
In-Reply-To: <1456992221-26712-10-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com> <1456992221-26712-10-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thursday 03 March 2016 17:03:35 Krzysztof Kozlowski wrote:
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 201f5c296a95..e5931e434fa2 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -79,6 +79,7 @@ config VIDEO_OMAP3
>         depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3
>         depends on HAS_DMA && OF
>         depends on OMAP_IOMMU
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select ARM_DMA_USE_IOMMU
>         select VIDEOBUF2_DMA_CONTIG

This is only built for OMAP3, so we won't get here without HAS_IOMEM

>         select MFD_SYSCON
> diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
> index 57d42c6172c5..c4317b99d257 100644
> --- a/drivers/media/platform/exynos4-is/Kconfig
> +++ b/drivers/media/platform/exynos4-is/Kconfig
> @@ -17,6 +17,7 @@ config VIDEO_S5P_FIMC
>         tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
>         depends on I2C
>         depends on HAS_DMA
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select VIDEOBUF2_DMA_CONTIG
>         select V4L2_MEM2MEM_DEV

This  is guarded by HAS_DMA, which implies HAS_IOMEM afaik.

	Arnd

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
