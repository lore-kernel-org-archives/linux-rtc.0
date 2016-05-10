Return-Path: <rtc-linux+bncBDL3F4G2ZAIBBT7QYS4QKGQEGGVOH5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id d141si4922006pfd.1.2016.05.09.18.24.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 18:24:31 -0700 (PDT)
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6X00QB8T8TVQA0@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 10 May 2016 10:24:29 +0900 (KST)
Message-id: <5731384C.6000209@samsung.com>
Date: Tue, 10 May 2016 10:24:28 +0900
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
Subject: [rtc-linux] Re: [PATCH v6 7/9] extcon: max8997: Fix inconsistent indenting
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-6-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1462519636-3250-6-git-send-email-k.kozlowski@samsung.com>
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
> Fix smatch warning:
> 	max8997_muic_probe() warn: inconsistent indenting
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8=
997.c
> index 0afa3e8b5dc3..cf8de5be2405 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -737,7 +737,7 @@ static int max8997_muic_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	/* Set initial path for UART */
> -	 max8997_muic_set_path(info, info->path_uart, true);
> +	max8997_muic_set_path(info, info->path_uart, true);
> =20
>  	/* Set ADC debounce time */
>  	max8997_muic_set_debounce_time(info, ADC_DEBOUNCE_TIME_25MS);
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
