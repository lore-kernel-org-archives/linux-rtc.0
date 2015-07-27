Return-Path: <rtc-linux+bncBAABB27T3CWQKGQEH3BQFXI@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id x1si742909igb.2.2015.07.27.07.02.18
        for <rtc-linux@googlegroups.com>;
        Mon, 27 Jul 2015 07:02:19 -0700 (PDT)
Date: Mon, 27 Jul 2015 22:01:53 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Philippe Reynes <tremyfr@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v5 0/6] add device tree support for mxc rtc
Message-ID: <20150727140153.GM12927@tiger>
References: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sun, Jul 26, 2015 at 11:37:47PM +0200, Philippe Reynes wrote:
> This serie add the device tree support for the mxc rtc driver.
> To do this, three steps are required :
> - define two rtc clocks for imx31 and imx35
> - enhance mxc rtc driver to use two clocks (ref and ipg)
> - add device tree support to mxc rtc driver

Looks good to me.  As we already have Alexandre's ACK on rtc-mxc driver
part, I will queue the series on IMX tree with waiting for a couple of
days to see if there is any objection.

Shawn

> 
> Changelog:
> v5: (thanks Shawn Guo, Rob Herring and Alexandre Belloni)
> - rename rtc clock to ref
> - fix typo in binding documentation
> - enable rtc by default on imx27
> v4: (thanks Alexandre Belloni)
> - add prepare_clock for rtc clock
> - split apf27: dt: enable support in two patches
> v3: (thanks Fabio Estevam)
> - fix typo in imx35 clock comment
> v2: (thanks Shawn Guo and Alexandre Belloni)
> - add a second clock to imx35
> - split the add of clock in a separate patches
> - split the dt documentation in a separate patch
> 
> Philippe Reynes (6):
>   imx31: add a second rtc clock
>   imx35: define two clocks for rtc
>   rtc: mxc: use a second rtc clock
>   dt-binding: document the binding for mxc rtc
>   rtc: mxc: add support of device tree
>   imx27: dt: add support of internal rtc
> 
>  Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   26 +++++++++
>  arch/arm/boot/dts/imx27.dtsi                      |    9 +++
>  drivers/clk/imx/clk-imx31.c                       |    3 +-
>  drivers/clk/imx/clk-imx35.c                       |    6 ++-
>  drivers/rtc/rtc-mxc.c                             |   60 ++++++++++++++++-----
>  5 files changed, 88 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
> 
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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
