Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:51211 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764048AbdJQUGY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 Oct 2017 16:06:24 -0400
Date: Tue, 17 Oct 2017 15:06:22 -0500
From: Rob Herring <robh@kernel.org>
To: Eric Nelson <eric@nelint.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br,
        festevam@gmail.com
Subject: Re: [PATCH V2] rtc: add support for NXP PCF85363 real-time clock
Message-ID: <20171017200622.7xs6hiw3y43mxi2k@rob-hp-laptop>
References: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
 <1507737390-27818-1-git-send-email-eric@nelint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507737390-27818-1-git-send-email-eric@nelint.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Oct 11, 2017 at 08:56:30AM -0700, Eric Nelson wrote:
> Note that alarms are not currently implemented.
> 
> 64 bytes of nvmem is supported and exposed in
> sysfs (# is the instance number, starting with 0):
> 
> 	/sys/bus/nvmem/devices/pcf85363-#/nvmem
> 
> Signed-off-by: Eric Nelson <eric@nelint.com>
> ---
> V2 addresses a couple of issues highlighted by Fabio Estevam
>     1. Kconfig updated to select REGMAP_I2C
>     2. Switch to of_device_id from i2c_device_id for driver matching
> 
>  Documentation/devicetree/bindings/rtc/pcf85363.txt |  16 ++
>  drivers/rtc/Kconfig                                |  13 ++
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
>  4 files changed, 251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>  create mode 100644 drivers/rtc/rtc-pcf85363.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> new file mode 100644
> index 0000000..5fddb9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> @@ -0,0 +1,16 @@
> +NXP PCF85363 Real Time Clock
> +============================
> +
> +Required properties:
> +- compatible: Should contain "nxp,pcf85363".
> +- reg: I2C address for chip.
> +
> +Example:
> +
> +pcf85363: pcf85363@51 {
> +	compatible = "nxp,pcf85363";
> +	reg = <0x51>;
> +};
> +
> +Note that alarms are not yet supported, so a specifier for
> +"interrupts" will be ignored.

Irrelevant to the binding. That's a driver feature (or lack of). If the 
device has an interrupt line, you should document it. It can be optional 
though.

Rob
