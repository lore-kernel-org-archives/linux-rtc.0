Return-Path: <rtc-linux+bncBDEKVJM7XAHRBAG44C3AKGQEQRDHSNQ@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.135])
        by gmr-mx.google.com with ESMTPS id s141si111215wmd.1.2016.03.03.04.28.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 04:28:47 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, David Brown <david.brown@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Andy Gross <andy.gross@linaro.org>, linux-media@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Thomas Gleixner <tglx@linutronix.de>, linux-soc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [rtc-linux] Re: [RFC 04/15] irqchip: st: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
Date: Thu, 03 Mar 2016 13:28:29 +0100
Message-ID: <2188157.YL7RR6FeEK@wuerfel>
In-Reply-To: <CAJKOXPcZuyicNAaH6CpOe+bTrLtM1k0tVisS_xJXGDrxyZ_i5A@mail.gmail.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com> <2506651.J2Z42d81nD@wuerfel> <CAJKOXPcZuyicNAaH6CpOe+bTrLtM1k0tVisS_xJXGDrxyZ_i5A@mail.gmail.com>
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

On Thursday 03 March 2016 21:00:57 Krzysztof Kozlowski wrote:
> >
> > Not user visible.
> 
> Hmmm... you are right (here and in other patches) but why am I getting
> all these errors:
> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X
> && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI &&
> TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE &&
> S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK &&
> RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM
> && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which
> has unmet direct dependencies (HAS_IOMEM)
> ?
> (ARCH=um, allyesconfig)

The problem is that Kconfig will just print any option that
selects the one that has a missing dependency, but doesn't
show which of those are actually enabled.

> Adding depends here (and in other places) really helps... but it
> should not have any impact...

I think patch 5 by itself would have been sufficient.

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
