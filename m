Return-Path: <rtc-linux+bncBDKZNNNLXAHBB6G7363AKGQE7DMQX3Q@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id ff2si6295586pad.2.2016.03.03.00.04.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 00:04:08 -0800 (PST)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3G007FIEESR890@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 03 Mar 2016 08:04:04 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Lee Jones <lee.jones@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-usb@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [rtc-linux] [RFC 00/15] tree-wide: mfd: syscon: Fix unmet ioremap dependency
Date: Thu, 03 Mar 2016 17:03:26 +0900
Message-id: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Building allyesconfig on ARCH=3Dum fails with:
   drivers/mfd/syscon.c: In function =E2=80=98of_syscon_register=E2=80=99:
   drivers/mfd/syscon.c:67:9: error: implicit declaration of function =E2=
=80=98ioremap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
      base =3D ioremap(res.start, resource_size(&res));

Since commit c89c0114955a ("mfd: syscon: Set regmap max_register in
of_syscon_register") the syscon depends on HAS_IOMEM because
it uses the ioremap().

However syscon is often directly selected... so first the dependency on
HAS_IOMEM has to be added to all selecting symbols.

Comments are welcomed whether this is appropriate approach.


The last patch "mfd: syscon: Fix build of missing ioremap on UM" should
enter all other to avoid kbuild complains like:

warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X &&
DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW
&& PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE &&
S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK &&
RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATM=
EL_ST
&& QCOM_GSBI && PHY_HI6220_USB)
selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)


Best regards,
Krzysztof


Krzysztof Kozlowski (15):
  clocksource: atmel: Add missing MFD_SYSCON dependency on HAS_IOMEM
  dmaengine: nxp: Add missing MFD_SYSCON dependency on HAS_IOMEM
  hwspinlock: qcom: Add missing MFD_SYSCON dependency on HAS_IOMEM
  irqchip: st: Add missing MFD_SYSCON dependency on HAS_IOMEM
  phy: hi6220: Add missing MFD_SYSCON dependency on HAS_IOMEM
  pinctrl: rockchip: Add missing MFD_SYSCON dependency on HAS_IOMEM
  pinctrl: mvebu: Add missing MFD_SYSCON dependency on HAS_IOMEM
  rtc: at91sam9: Add missing MFD_SYSCON dependency on HAS_IOMEM
  media: platform: Add missing MFD_SYSCON dependency on HAS_IOMEM
  net: ethernet: Add missing MFD_SYSCON dependency on HAS_IOMEM
  power: reset: keystone: Add missing MFD_SYSCON dependency on HAS_IOMEM
  soc: qcom: Add missing MFD_SYSCON dependency on HAS_IOMEM
  staging: media: omap4iss: Add missing MFD_SYSCON dependency on
    HAS_IOMEM
  usb: xhci: mtk: Add missing MFD_SYSCON dependency on HAS_IOMEM
  mfd: syscon: Fix build of missing ioremap on UM

 drivers/clocksource/Kconfig                 | 1 +
 drivers/dma/Kconfig                         | 1 +
 drivers/hwspinlock/Kconfig                  | 1 +
 drivers/irqchip/Kconfig                     | 1 +
 drivers/media/platform/Kconfig              | 1 +
 drivers/media/platform/exynos4-is/Kconfig   | 1 +
 drivers/mfd/Kconfig                         | 1 +
 drivers/net/ethernet/hisilicon/Kconfig      | 1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 6 ++++++
 drivers/net/ethernet/ti/Kconfig             | 1 +
 drivers/phy/Kconfig                         | 1 +
 drivers/pinctrl/Kconfig                     | 1 +
 drivers/pinctrl/mvebu/Kconfig               | 1 +
 drivers/power/reset/Kconfig                 | 1 +
 drivers/rtc/Kconfig                         | 1 +
 drivers/soc/qcom/Kconfig                    | 1 +
 drivers/staging/media/omap4iss/Kconfig      | 1 +
 drivers/usb/host/Kconfig                    | 1 +
 18 files changed, 23 insertions(+)

--=20
2.5.0

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
