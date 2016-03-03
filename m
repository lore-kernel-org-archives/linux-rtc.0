Return-Path: <rtc-linux+bncBDEKVJM7XAHRBTFS4C3AKGQEVKTMJ7A@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id w10si263831wmw.3.2016.03.03.03.00.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 03:00:28 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Kishon Vijay Abraham I <kishon@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org
Subject: [rtc-linux] Re: [RFC 11/15] power: reset: keystone: Add missing
 MFD_SYSCON dependency on HAS_IOMEM
Date: Thu, 03 Mar 2016 12:00:14 +0100
Message-ID: <5230562.E0gg2SNP0m@wuerfel>
In-Reply-To: <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com> <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
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

On Thursday 03 March 2016 17:03:37 Krzysztof Kozlowski wrote:
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 0a6408a39c66..0f34846ae80d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -141,6 +141,7 @@ config POWER_RESET_XGENE
>  config POWER_RESET_KEYSTONE
>         bool "Keystone reset driver"
>         depends on ARCH_KEYSTONE
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         help
>           Reboot support for the KEYSTONE SoCs.
> 

This is platform specific, but we should probably add || COMPILE_TEST
along with the HAS_IOMEM dependency.

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
