Return-Path: <rtc-linux+bncBDA7X7F2WUEBBBFRWCVQKGQEO5NTD4A@googlegroups.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com. [74.125.82.54])
        by gmr-mx.google.com with ESMTPS id ec7si459427wib.3.2015.06.01.01.32.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 01:32:03 -0700 (PDT)
Received: by mail-wg0-f54.google.com with SMTP id gq6so107693605wgb.3
        for <rtc-linux@googlegroups.com>; Mon, 01 Jun 2015 01:32:03 -0700 (PDT)
Date: Mon, 1 Jun 2015 09:31:59 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, sameo@linux.intel.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	zhaoy <zhaoy@marvell.com>
Subject: [rtc-linux] Re: [PATCH 2/4] mfd: 88pm800: use irq_mode to configure
 interrupt status reg clear method
Message-ID: <20150601083159.GD3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Sat, 30 May 2015, Vaibhav Hiremath wrote:

> From the spec, bit 1 of reg 0xe (page 0): IN_CLEAR_MODE controls the
> method of clearing interrupt status register of 88pm800;
>=20
>   0: clear on read
>   1: clear on write
>=20
> Signed-off-by: zhaoy <zhaoy@marvell.com>

This signed-off is not acceptable.

No nicknames.  Full names only.

> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c       | 4 +++-
>  include/linux/mfd/88pm80x.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 06ee058..8ea4467 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -391,7 +391,8 @@ static int device_irq_init_800(struct pm80x_chip *chi=
p)
>  	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
>  	    PM800_WAKEUP2_INT_MASK;
> =20
> -	data =3D PM800_WAKEUP2_INT_CLEAR;
> +	data =3D (chip->irq_mode) ?
> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;

These variable names are terrible.  'irq_mode' as a bool tells me
nothing.

What does; irq_mode =3D 'yes' and irq_mode =3D 'no' mean?  If I didn't
read the remainder of the code, I would assume if it was 'yes' then
the device was in IRQ Mode and if not, it would be in PIO or Polling
mode, but that's not what it means at all is it?

As for 'data', well, isn't everything data?

>  	ret =3D regmap_update_bits(map, PM800_WAKEUP2, mask, data);
> =20
>  	if (ret < 0)
> @@ -514,6 +515,7 @@ static int device_800_init(struct pm80x_chip *chip,
>  	}
> =20
>  	chip->regmap_irq_chip =3D &pm800_irq_chip;
> +	chip->irq_mode =3D pdata->irq_mode;
> =20
>  	ret =3D device_irq_init_800(chip);
>  	if (ret < 0) {
> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> index 97cb283..6ed6c16 100644
> --- a/include/linux/mfd/88pm80x.h
> +++ b/include/linux/mfd/88pm80x.h
> @@ -77,6 +77,8 @@ enum {
>  #define PM800_WAKEUP2		(0x0E)
>  #define PM800_WAKEUP2_INV_INT		(1 << 0)
>  #define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
> +#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
> +#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)
>  #define PM800_WAKEUP2_INT_MASK		(1 << 2)
> =20
>  #define PM800_POWER_UP_LOG	(0x10)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
