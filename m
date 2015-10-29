Return-Path: <rtc-linux+bncBDKZNNNLXAHBBP7KY2YQKGQEOQUIB2Y@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id vy6si5275606pbc.1.2015.10.28.22.57.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 22:57:18 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWY002GCWJE9Z10@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 29 Oct 2015 05:57:14 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v4 1/4] dt-bindings: mfd: s2mps11: add
 documentation for s2mps15 PMIC
To: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
 <1446094723-6212-2-git-send-email-alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>,
 devicetree@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <5631B537.1090404@samsung.com>
Date: Thu, 29 Oct 2015 14:57:11 +0900
MIME-version: 1.0
In-reply-to: <1446094723-6212-2-git-send-email-alim.akhtar@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 29.10.2015 13:58, Alim Akhtar wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Add dt-binding documentation for s2mps15 PMIC device. The s2mps15 device
> is similar to s2mps11/14 PMIC device and has 27 LDO and 10 buck regulators.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/s2mps11.txt |   23 ++++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/s2mps11.txt b/Documentation/devicetree/bindings/mfd/s2mps11.txt
> index 890f0b0e1643..c0427c9d0886 100644
> --- a/Documentation/devicetree/bindings/mfd/s2mps11.txt
> +++ b/Documentation/devicetree/bindings/mfd/s2mps11.txt
> @@ -1,5 +1,5 @@
>  
> -* Samsung S2MPS11, S2MPS13, S2MPS14 and S2MPU02 Voltage and Current Regulator
> +* Samsung S2MPS11/13/14/15 and S2MPU02 Voltage and Current Regulator
>  
>  The Samsung S2MPS11 is a multi-function device which includes voltage and
>  current regulators, RTC, charger controller and other sub-blocks. It is
> @@ -7,8 +7,12 @@ interfaced to the host controller using an I2C interface. Each sub-block is
>  addressed by the host system using different I2C slave addresses.
>  
>  Required properties:
> -- compatible: Should be "samsung,s2mps11-pmic" or "samsung,s2mps13-pmic"
> -	      or "samsung,s2mps14-pmic" or "samsung,s2mpu02-pmic".
> +- compatible: Should be one of the following
> +	- "samsung,s2mps11-pmic"
> +	- "samsung,s2mps13-pmic"
> +	- "samsung,s2mps14-pmic"
> +	- "samsung,s2mps15-pmic"
> +	- "samsung,s2mpu02-pmic".
>  - reg: Specifies the I2C slave address of the pmic block. It should be 0x66.
>  
>  Optional properties:
> @@ -24,7 +28,7 @@ Optional properties:
>    unwanted buck warm reset (setting buck voltages to default values).
>  
>  Optional nodes:
> -- clocks: s2mps11, s2mps13 and s5m8767 provide three(AP/CP/BT) buffered 32.768
> +- clocks: s2mps11, s2mps13, s2mps15 and s5m8767 provide three(AP/CP/BT) buffered 32.768
>    KHz outputs, so to register these as clocks with common clock framework
>    instantiate a sub-node named "clocks". It uses the common clock binding
>    documented in :
> @@ -37,12 +41,13 @@ Optional nodes:
>      the clock which they consume.
>      Clock               ID           Devices
>      ----------------------------------------------------------
> -    32KhzAP		0            S2MPS11, S2MPS13, S2MPS14, S5M8767
> -    32KhzCP		1            S2MPS11, S2MPS13, S5M8767
> -    32KhzBT		2            S2MPS11, S2MPS13, S2MPS14, S5M8767
> +    32KhzAP		0            S2MPS11, S2MPS13, S2MPS14, S2MPS15, S5M8767
> +    32KhzCP		1            S2MPS11, S2MPS13, S2MPS15, S5M8767
> +    32KhzBT		2            S2MPS11, S2MPS13, S2MPS14, S2MPS15, S5M8767
>  
>    - compatible: Should be one of: "samsung,s2mps11-clk", "samsung,s2mps13-clk",
> -		"samsung,s2mps14-clk", "samsung,s5m8767-clk"
> +		"samsung,s2mps14-clk", "samsung,s2mps15-clk",
> +		"samsung,s5m8767-clk"

Noooo. Why "samsung,s2mps15-clk"?

Adding a new compatible to bindings is a major change so my review tag
(from v1 where there was no such compatible) should be dropped. Please
drop it.

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
