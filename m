Return-Path: <rtc-linux+bncBDKZNNNLXAHBBDHD4C3AKGQENM6M2PY@googlegroups.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com. [2607:f8b0:4003:c06::243])
        by gmr-mx.google.com with ESMTPS id ph8si252939igb.0.2016.03.03.04.43.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 04:43:55 -0800 (PST)
Received: by mail-oi0-x243.google.com with SMTP id c129so1093637oif.3
        for <rtc-linux@googlegroups.com>; Thu, 03 Mar 2016 04:43:55 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1456992221-26712-8-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
	<1456992221-26712-8-git-send-email-k.kozlowski@samsung.com>
Date: Thu, 3 Mar 2016 21:43:55 +0900
Message-ID: <CAJKOXPeVNrzCJ0TTeBG=H0w2+qHzAcXfTck9gBBmZFvVPpPx0A@mail.gmail.com>
Subject: Re: [rtc-linux] [RFC 07/15] pinctrl: mvebu: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: rtc-linux@googlegroups.com
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
	Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Kishon Vijay Abraham I <kishon@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-03-03 17:03 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
> direct dependencies.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/pinctrl/mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
> index 170602407c0d..13685923729c 100644
> --- a/drivers/pinctrl/mvebu/Kconfig
> +++ b/drivers/pinctrl/mvebu/Kconfig
> @@ -7,6 +7,7 @@ config PINCTRL_MVEBU
>
>  config PINCTRL_DOVE
>         bool
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select PINCTRL_MVEBU
>         select MFD_SYSCON

False alarm, no need for the patch (non-selectable symbol)

Best regards,
Krzysztof

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
