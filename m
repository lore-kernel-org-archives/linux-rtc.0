Return-Path: <rtc-linux+bncBCHOPY7NVYCRBQU7R6WQKGQEZLYMY5Y@googlegroups.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com. [2607:f8b0:4003:c06::232])
        by gmr-mx.google.com with ESMTPS id rs3si647550igb.2.2015.07.13.07.48.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 07:48:34 -0700 (PDT)
Received: by mail-oi0-x232.google.com with SMTP id n4so24905595oib.3
        for <rtc-linux@googlegroups.com>; Mon, 13 Jul 2015 07:48:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
References: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
Date: Mon, 13 Jul 2015 09:48:33 -0500
Message-ID: <CAHrpEqSi=BPuZrqSvozvggAFsnXy2DqnfkzP5dpsP2cShzM7Hg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: snvs: select option REGMAP_MMIO
From: Zhi Li <lznuaa@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: rtc-linux@googlegroups.com, Frank Li <Frank.Li@freescale.com>,
	kbuild test robot <fengguang.wu@intel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jul 13, 2015 at 3:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> Select REGMAP_MMIO to fix the following build error seen with x86_64
> randconfig.
>
>   drivers/built-in.o: In function `snvs_rtc_probe':
> rtc-snvs.c:(.text+0x567730): undefined reference to `devm_regmap_init_mmio_clk'
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Acked-by: Frank Li <Frank.Li@freescale.com>

> ---
> This is a fix to patch "rtc: snvs: use syscon to access register",
> which I queued on IMX tree for 4.3.  So I will apply it to the same
> branch.
>
> Shawn
>
>  drivers/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 83b4b89b9d5a..533bfa3b6039 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1523,6 +1523,7 @@ config RTC_DRV_MXC
>
>  config RTC_DRV_SNVS
>         tristate "Freescale SNVS RTC support"
> +       select REGMAP_MMIO
>         depends on HAS_IOMEM
>         depends on OF
>         help
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

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
