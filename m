Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBU6DU67AKGQE5XYI3XA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y7si753648wmd.0.2016.09.02.13.32.19
        for <rtc-linux@googlegroups.com>;
        Fri, 02 Sep 2016 13:32:19 -0700 (PDT)
Date: Fri, 2 Sep 2016 22:32:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	kernel-janitors@vger.kernel.org, linux-tegra@vger.kernel.org,
	Alexandre Courbot <gnurou@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [rtc-linux] Re: [PATCH] rtc: constify rtc_class_ops structures
Message-ID: <20160902203218.swu3fcxb266jeq2s@piout.net>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/08/2016 at 10:05:25 +0200, Julia Lawall wrote :
> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct rtc_class_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> expression e1,e2,e3,e4;
> position p;
> @@
> (
> devm_rtc_device_register(e1,e2,&i@p,e3)
> |
> rtc_device_register(e1,e2,&i@p,e3)
> |
> platform_device_register_data(e1,e2,e3,&i@p,e4)
> )
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct rtc_class_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/rtc/rtc-at32ap700x.c |    2 +-
>  drivers/rtc/rtc-coh901331.c  |    2 +-
>  drivers/rtc/rtc-davinci.c    |    2 +-
>  drivers/rtc/rtc-digicolor.c  |    2 +-
>  drivers/rtc/rtc-ds1302.c     |    2 +-
>  drivers/rtc/rtc-gemini.c     |    2 +-
>  drivers/rtc/rtc-jz4740.c     |    2 +-
>  drivers/rtc/rtc-mcp795.c     |    2 +-
>  drivers/rtc/rtc-mt6397.c     |    2 +-
>  drivers/rtc/rtc-nuc900.c     |    2 +-
>  drivers/rtc/rtc-omap.c       |    2 +-
>  drivers/rtc/rtc-palmas.c     |    2 +-
>  drivers/rtc/rtc-pcf50633.c   |    2 +-
>  drivers/rtc/rtc-rx6110.c     |    2 +-
>  drivers/rtc/rtc-rx8025.c     |    2 +-
>  drivers/rtc/rtc-spear.c      |    2 +-
>  drivers/rtc/rtc-stmp3xxx.c   |    2 +-
>  drivers/rtc/rtc-tegra.c      |    2 +-
>  drivers/rtc/rtc-twl.c        |    2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
