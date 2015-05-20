Return-Path: <rtc-linux+bncBAABB7GU56VAKGQEVGZXWXY@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id s16si65111ign.2.2015.05.19.18.59.23
        for <rtc-linux@googlegroups.com>;
        Tue, 19 May 2015 18:59:23 -0700 (PDT)
Date: Wed, 20 May 2015 09:58:51 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com,
	robh+dt@kernel.org, a.zummo@towertech.it, p.zabel@pengutronix.de,
	alexandre.belloni@free-electrons.com, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
Message-ID: <20150520015851.GB1071@dragon>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li@freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Change from v1 to v2
>  - Change simple-bus to simple-mfd
>  - RTC remove lock.
>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
>  - power off, remove extra space
> 
> SNVS is MPF module.
> include rtc, power off, ON/OFF power key
> 
>   arm: imx: power-off: change to syscon to access register
>   rtc: arm: imx: snvs: change use syscon to access register
> Above two patch change existed power-off and rtc use syscon
> 
>   Document: dt: fsl: snvs: change support syscon
>   arm: dts: imx: update snvs to use syscon access register
> Update dt file and document
> 
>   input: keyboard: imx: add snvs power key driver
>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>   arm: dts: imx6sx: enable snvs power key
> Added on/off key driver
> 
> Frank Li (6):
>   arm: imx: power-off: change to syscon to access register
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   arm: dts: imx: update snvs to use syscon access register
>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>   arm: dts: imx6sx: enable snvs power key

So, the series will break existing DTBs for RTC and poweroff, right?
If this is unavoidable, should we at least have some warning messages
telling users about his breakage?

Shawn

> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver
> 
>  .../devicetree/bindings/crypto/fsl-sec4.txt        |  93 +++++++--
>  .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 +
>  .../bindings/power_supply/imx-snvs-poweroff.txt    |  24 +--
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
>  arch/arm/boot/dts/imx6sl.dtsi                      |  12 +-
>  arch/arm/boot/dts/imx6sx.dtsi                      |  19 +-
>  arch/arm/boot/dts/vfxxx.dtsi                       |   9 +-
>  drivers/input/keyboard/Kconfig                     |  11 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/snvs_pwrkey.c               | 232 +++++++++++++++++++++
>  drivers/power/reset/imx-snvs-poweroff.c            |  21 +-
>  drivers/rtc/rtc-snvs.c                             | 128 +++++-------
>  12 files changed, 417 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
>  create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
> 
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
