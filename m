Return-Path: <rtc-linux+bncBDEKVJM7XAHRBYNP4C3AKGQETHXHFPI@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.133])
        by gmr-mx.google.com with ESMTPS id 71si101557wmp.0.2016.03.03.02.54.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 02:54:24 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: [rtc-linux] Re: [RFC 05/15] phy: hi6220: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
Date: Thu, 03 Mar 2016 11:54:17 +0100
Message-ID: <1777963.D97F7d0Oik@wuerfel>
In-Reply-To: <1456992221-26712-6-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com> <1456992221-26712-6-git-send-email-k.kozlowski@samsung.com>
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

On Thursday 03 March 2016 17:03:31 Krzysztof Kozlowski wrote:
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -225,6 +225,7 @@ config PHY_MT65XX_USB3
>  config PHY_HI6220_USB
>         tristate "hi6220 USB PHY support"
>         depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select GENERIC_PHY
>         select MFD_SYSCON
>         help
> -- 
> 2.5.0
> 

This is indeed required, and seems to be what caused the problem
you saw in the first place.

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
