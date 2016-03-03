Return-Path: <rtc-linux+bncBDKZNNNLXAHBB67A363AKGQENSILCVQ@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id y20si3907412pfa.2.2016.03.03.00.06.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 00:06:19 -0800 (PST)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O3G007KTEIF0X90@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 03 Mar 2016 08:06:15 +0000 (GMT)
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
Subject: [rtc-linux] [RFC 15/15] mfd: syscon: Fix build of missing ioremap on UM
Date: Thu, 03 Mar 2016 17:03:41 +0900
Message-id: <1456992221-26712-16-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Since commit c89c0114955a ("mfd: syscon: Set regmap max_register in
of_syscon_register") the syscon uses ioremap so it fails on COMPILE_TEST
without HAS_IOMEM:

drivers/mfd/syscon.c: In function =E2=80=98of_syscon_register=E2=80=99:
drivers/mfd/syscon.c:67:9: error: implicit declaration of function =E2=80=
=98ioremap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  base =3D ioremap(res.start, resource_size(&res));
         ^
drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer w=
ithout a cast [-Wint-conversion]
  base =3D ioremap(res.start, resource_size(&res));
       ^
drivers/mfd/syscon.c:109:2: error: implicit declaration of function =E2=80=
=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  iounmap(base);

When selecting MFD_SYSCON, depend on HAS_IOMEM to avoid unmet direct
dependencies.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: c89c0114955a ("mfd: syscon: Set regmap max_register in of_syscon_reg=
ister")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aa21dc55eb15..2e5b1e525a1d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1034,6 +1034,7 @@ config MFD_SUN6I_PRCM
=20
 config MFD_SYSCON
 	bool "System Controller Register R/W Based on Regmap"
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Select this option to enable accessing system control registers
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
