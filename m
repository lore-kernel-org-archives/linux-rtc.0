Return-Path: <rtc-linux+bncBDJIP47K7MERBWHY5G4AKGQE3XOV62Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id y20si775966pfa.2.2016.04.22.12.32.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 12:32:38 -0700 (PDT)
Date: Fri, 22 Apr 2016 14:32:32 -0500
From: Rob Herring <robh@kernel.org>
To: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Cc: lee.jones@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: add Cypress FM33256B Processor
 Companion driver
Message-ID: <20160422193232.GA9737@rob-hp-laptop>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-2-git-send-email-jlp@gomspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461150471-23163-2-git-send-email-jlp@gomspace.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Apr 20, 2016 at 01:07:49PM +0200, Jeppe Ledet-Pedersen wrote:
> This patch adds support for the Cypress Semiconductor FM33256B processor
> companion. The device contains a 256 kbit FRAM, an RTC, a supply voltage
> monitor, and a watchdog timer.
> 
> Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
> ---
>  Documentation/devicetree/bindings/mfd/fm33256b.txt |  30 ++
>  MAINTAINERS                                        |   6 +
>  drivers/mfd/Kconfig                                |  16 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/fm33256b.c                             | 488 +++++++++++++++++++++
>  include/linux/mfd/fm33256b.h                       |  76 ++++
>  6 files changed, 617 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fm33256b.txt
>  create mode 100644 drivers/mfd/fm33256b.c
>  create mode 100644 include/linux/mfd/fm33256b.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fm33256b.txt b/Documentation/devicetree/bindings/mfd/fm33256b.txt
> new file mode 100644
> index 0000000..6591c94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/fm33256b.txt
> @@ -0,0 +1,30 @@
> +Device-tree bindings for Cypress Semiconductor FM33256B Processor Companion
> +---------------------------------------------------------------------------
> +
> +Required properties:
> +- compatible: must be "cypress,fm33256b".
> +- reg: SPI chip select
> +- spi-max-frequency: Max SPI frequency to use (< 16000000)
> +
> +Optional properties:
> +- cypress,charge-enabled: enable trickle charger

What does the driver do if charging is disabled? Would using 'status = 
"disabled"' be any different?
 
> +- cypress,charge-fast: enable fast (1 mA) charging

What does fast mean?

I think it is time for a common binding here. There's all sorts of 
variations on setting the charge current in bindings. Add something like 
"charge-current-microamp" in power_supply.txt and use it here. Then 
1000uA implies "fast charge".

> +
> +The MFD exposes two subdevices:
> +- The FRAM: "cypress,fm33256b-fram"
> +- The RTC: "cypress,fm33256b-rtc"
> +
> +Example:
> +
> +spi1: spi@f800800 {
> +	status = "okay";
> +	cs-gpios = <&pioC 25 0>;
> +
> +	fm33256b@0 {
> +		compatible = "cypress,fm33256b";
> +		spi-max-frequency = <10000000>;
> +		cypress,charge-enabled;
> +		cypress,charge-fast;
> +		reg = <0>;
> +	};

Where's the 2nd sub device?

> +};

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
