Return-Path: <rtc-linux+bncBD62P6P6EQIOV6VFVQCRUBC3SQYJM@googlegroups.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com. [2607:f8b0:4002:c01::231])
        by gmr-mx.google.com with ESMTPS id d142si443968ywe.7.2015.06.23.08.38.17
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 08:38:17 -0700 (PDT)
Received: by mail-yh0-x231.google.com with SMTP id v31so5270366yhn.1
        for <rtc-linux@googlegroups.com>; Tue, 23 Jun 2015 08:38:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org> <1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 23 Jun 2015 10:37:58 -0500
Message-ID: <CAL_JsqKe9AjnDuAKmjx4nqvnfZ3ac0tjto2G2rjHjYVVTjqr-Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH-v2 3/3] mfd: devicetree: bindings: Add new
 88pm800 mfd binding
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Jun 17, 2015 at 1:58 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
> With addition of DT support to 88pm800 mfd driver, this patch
> adds new DT binding documentation along with respective properties.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>

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
> +                               regulator-min-microvolt = <600000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +                       ldo1: LDO1 {
> +                               regulator-compatible = "88PM800-LDO1";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +               };
> +
> +               rtc {
> +                       compatible = "marvell,88pm80x-rtc";
> +               };
> +       };
> --
> 1.9.1
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
