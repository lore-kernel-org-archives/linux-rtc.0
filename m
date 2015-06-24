Return-Path: <rtc-linux+bncBDKZNNNLXAHBBUHTU6WAKGQEX5SC6LA@googlegroups.com>
Received: from mail-vn0-x234.google.com (mail-vn0-x234.google.com. [2607:f8b0:400c:c0f::234])
        by gmr-mx.google.com with ESMTPS id fg5si330170vdb.1.2015.06.23.17.29.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 17:29:04 -0700 (PDT)
Received: by mail-vn0-x234.google.com with SMTP id f62so4039736vnb.10
        for <rtc-linux@googlegroups.com>; Tue, 23 Jun 2015 17:29:04 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
	<1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
Date: Wed, 24 Jun 2015 09:29:04 +0900
Message-ID: <CAJKOXPf7OuGfxsZeewoimyyCRKGqjH+j-S81cAH=6DSRQmaS0A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH-v2 3/3] mfd: devicetree: bindings: Add new
 88pm800 mfd binding
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	lee.jones@linaro.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

2015-06-18 3:58 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
> With addition of DT support to 88pm800 mfd driver, this patch
> adds new DT binding documentation along with respective properties.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/88pm800.txt | 60 +++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
> new file mode 100644
> index 0000000..b8e72df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
> @@ -0,0 +1,60 @@
> +* Marvell 88PM8xx Power Management IC
> +
> +Required parent device properties:
> +- compatible : "marvell,88pm800", "marvell,88pm805", "marvell,88pm860"
> +- reg : the I2C slave address for the 88pm8xx chip
> +- interrupts : IRQ line for the 88pm8xx chip
> +- interrupt-controller: describes the 88pm8xx as an interrupt controller
> +- #interrupt-cells : should be 1.
> +               - The cell is the 88pm8xx local IRQ number
> +
> +Optional parent device properties:
> +- marvell,irq-clr-on-write: indicates whether interrupt status is cleared
> +  by write or read.
> +  If enabled, interrupt is cleared by write else just read would do.
> +
> +88pm8xx family of devices consists of varied group of sub-devices:
> +
> +Device                 Supply Names     Description
> +------                 ------------     -----------
> +88pm80x-onkey          :               : On key
> +88pm80x-rtc            :               : RTC
> +88pm80x-regulator      :               : Regulators
> +
> +Note: More device list will follow
> +
> +Example:
> +
> +       pmic: 88pm800@30 {
> +               compatible = "marvell,88pm800";
> +               reg = <0x30>;
> +               interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-parent = <&gic>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               marvell,irq-clr-on-write;
> +
> +               regulators {
> +                       compatible = "marvell,88pm80x-regulator";
> +
> +                       buck1a: BUCK1A {
> +                               regulator-compatible = "88PM800-BUCK1A";

That's a deprecated property.
Documentation/devicetree/bindings/regulator/regulator.txt

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
