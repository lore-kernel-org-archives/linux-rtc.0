Return-Path: <rtc-linux+bncBDL3F4G2ZAIBBJHQYS4QKGQERUWWCLQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id 17si5091763pfw.0.2016.05.09.18.23.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 18:23:47 -0700 (PDT)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6X00AD7T7MW160@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 10 May 2016 10:23:46 +0900 (KST)
Message-id: <57313821.4050309@samsung.com>
Date: Tue, 10 May 2016 10:23:45 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>,
 Sebastian Reichel <sre@kernel.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v6 5/9] extcon: max8997: Fix handling error
 code of regmap_irq_get_virq()
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Krzysztof,

On 2016=EB=85=84 05=EC=9B=94 06=EC=9D=BC 16:27, Krzysztof Kozlowski wrote:
> The regmap_irq_get_virq() can return negative ERRNO, so its result
> should not be stored in unsigned int because error would be ignored.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8=
997.c
> index 68754ac2c8ea..0afa3e8b5dc3 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -660,11 +660,11 @@ static int max8997_muic_probe(struct platform_devic=
e *pdev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(muic_irqs); i++) {
>  		struct max8997_muic_irq *muic_irq =3D &muic_irqs[i];
> -		unsigned int virq =3D 0;
> +		int virq =3D 0;
> =20
>  		virq =3D regmap_irq_get_virq(max8997->irq_data_muic,
>  					muic_irq->irq);
> -		if (!virq) {
> +		if (virq <=3D 0) {
>  			ret =3D -EINVAL;
>  			goto err_irq;
>  		}
>=20

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

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
