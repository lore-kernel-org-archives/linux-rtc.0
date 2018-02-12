Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0076.outbound.protection.outlook.com ([104.47.38.76]:28298
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751527AbeBLTDh (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 12 Feb 2018 14:03:37 -0500
Subject: Re: [PATCH] rtc: isl12026: Add driver.
To: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20180212185915.25041-1-david.daney@cavium.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <d2337554-c3df-f915-72c7-5decd571f12f@caviumnetworks.com>
Date: Mon, 12 Feb 2018 11:03:30 -0800
MIME-Version: 1.0
In-Reply-To: <20180212185915.25041-1-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/12/2018 10:59 AM, David Daney wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   .../devicetree/bindings/rtc/isil,isl12026.txt      |  27 +
>   drivers/rtc/Kconfig                                |   9 +
>   drivers/rtc/Makefile                               |   1 +
>   drivers/rtc/rtc-isl12026.c                         | 550 +++++++++++++++++++++
>   4 files changed, 587 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
>   create mode 100644 drivers/rtc/rtc-isl12026.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> new file mode 100644
> index 000000000000..4b6c7177a95a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> @@ -0,0 +1,27 @@
> +ISL12026 I2C RTC/EEPROM
> +
> +ISL12026 is an I2C RTC/EEPROM combination device.  The RTC and control
> +registers respond at bus address 0x6f, and the EEPROM array responds
> +at bus address 0x57.  The canonical "reg" value will be for the RTC portion.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl12026"
> + - "reg": I2C bus address of the device (always 0x6f)
> +
> +Optional properties:
> +
> + - "isil,pwr-bsw": If present PWR.BSW bit must be set to the specified
> +                   value for proper operation.
> +
> + - "isil,pwr-sbib": If present PWR.SBIB bit must be set to the specified
> +                    value for proper operation.
> +
> +
> +Example:
> +
> +	rtc@6f {

Two seconds after sending, I see that the compatible went missing.

I will wait several days for feedback and resubmit with the proper 
compatible

Sorry for the snafu,
David Daney


> +		reg = <0x6f>;
> +		isil,pwr-bsw = <0>;
> +		isil,pwr-sbib = <1>;
> +	}
>
