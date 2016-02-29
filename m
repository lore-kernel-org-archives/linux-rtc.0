Return-Path: <rtc-linux+bncBDL3F4G2ZAIBBUWWZ23AKGQEPHISOAI@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id yd9si3274161pab.1.2016.02.28.18.22.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 18:22:10 -0800 (PST)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O3A01RMMEKW7700@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 29 Feb 2016 11:22:08 +0900 (KST)
Message-id: <56D3AB50.2060502@samsung.com>
Date: Mon, 29 Feb 2016 11:22:08 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
 Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [rtc-linux] Re: [PATCH 1/7] extcon: palmas: Drop IRQF_EARLY_RESUME flag
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
 <1456501377-16871-2-git-send-email-grygorii.strashko@ti.com>
In-reply-to: <1456501377-16871-2-git-send-email-grygorii.strashko@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Grygorii,

On 2016=EB=85=84 02=EC=9B=94 27=EC=9D=BC 00:42, Grygorii Strashko wrote:
> Palams extcon IRQs are nested threaded and wired to the Palmas
> inerrupt controller. So, this flag is not required for nested irqs
> anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
> nested_thread irqs over system suspend") was merged.
>=20
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/extcon/extcon-palmas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palma=
s.c
> index 93c30a8..0a861b3 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -266,7 +266,7 @@ static int palmas_usb_probe(struct platform_device *p=
dev)
>  				palmas_usb->id_irq,
>  				NULL, palmas_id_irq_handler,
>  				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas_usb_id", palmas_usb);
>  		if (status < 0) {
>  			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
> @@ -304,7 +304,7 @@ static int palmas_usb_probe(struct platform_device *p=
dev)
>  				palmas_usb->vbus_irq, NULL,
>  				palmas_vbus_irq_handler,
>  				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas_usb_vbus", palmas_usb);
>  		if (status < 0) {
>  			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
>=20

Applied it on extcon git.

Thanks,
Chanwoo Choi

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
