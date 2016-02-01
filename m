Return-Path: <rtc-linux+bncBDJIP47K7MERB7WIXW2QKGQEPTZNPDQ@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id tn7si3552458pac.1.2016.02.01.05.58.22
        for <rtc-linux@googlegroups.com>;
        Mon, 01 Feb 2016 05:58:22 -0800 (PST)
Date: Mon, 1 Feb 2016 07:58:17 -0600
From: Rob Herring <robh@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com, k.kozlowski@samsung.com,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V5 3/5] pinctrl: max77620: add pincontrol
 driver for MAX77620/MAX20024
Message-ID: <20160201135817.GA25324@rob-hp-laptop>
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
 <1453903808-29788-4-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1453903808-29788-4-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jan 27, 2016 at 07:40:06PM +0530, Laxman Dewangan wrote:
> MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO pins
> which also act as the special function in alternate mode. Also
> there is configuration like push-pull, open drain, FPS timing
> etc for these pins.
> 
> Add pincontrol driver to configure these parameters through
> pincontrol APIs.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> ---
> Changes from V1:
> - Cleanup code based on comment received on mfd/rtc.
> - Avoid duplication on error message.
>  
> Changes form V2:
> - Run coccicheck and checkpatch in strict mode for the alignment.
> - update based on api changes from core.
> 
> Changes from V3: 
> - Change all sys initcall to module driver.
> - change the max77620_read argument to unisgned int from u8.
> 
> Changes from V4: 
> - Added DT binding document as devicetree/bindings/pinctrl/pinctrl-max77620.txt
> - Detail out properties.
> 
>  .../bindings/pinctrl/pinctrl-max77620.txt          |  87 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/Kconfig                            |  10 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-max77620.c                 | 693 +++++++++++++++++++++
>  4 files changed, 791 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
>  create mode 100644 drivers/pinctrl/pinctrl-max77620.c

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
