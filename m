Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYUBWK6QKGQE5E5KTIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si154222wmg.1.2016.08.11.06.42.58
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Aug 2016 06:42:58 -0700 (PDT)
Date: Thu, 11 Aug 2016 15:42:57 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Romell <danielromell@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, daro@hms.se, jao@hms.se, mago@hms.se
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: bq32k: Use correct mask name for
 'minutes' register.
Message-ID: <20160811134257.GH8132@piout.net>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470915104-10683-2-git-send-email-daro@hms.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470915104-10683-2-git-send-email-daro@hms.se>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/08/2016 at 13:31:43 +0200, Daniel Romell wrote :
> From: Jan =C3=96stlund <jao@hms.se>
>=20
> The BQ32K_SECONDS_MASK and BQ32K_MINUTES_MASK both has the same
> value. This is no functional change.
>=20
> Signed-off-by: Daniel Romell <daro@hms.se>

Sorry, I saw it only before trying apply but both patches also need Jan's S=
oB.

> ---
>  drivers/rtc/rtc-bq32k.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> index 0299988..5a0c137 100644
> --- a/drivers/rtc/rtc-bq32k.c
> +++ b/drivers/rtc/rtc-bq32k.c
> @@ -94,7 +94,7 @@ static int bq32k_rtc_read_time(struct device *dev, stru=
ct rtc_time *tm)
>  		return error;
> =20
>  	tm->tm_sec =3D bcd2bin(regs.seconds & BQ32K_SECONDS_MASK);
> -	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_SECONDS_MASK);
> +	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_MINUTES_MASK);
>  	tm->tm_hour =3D bcd2bin(regs.cent_hours & BQ32K_HOURS_MASK);
>  	tm->tm_mday =3D bcd2bin(regs.date);
>  	tm->tm_wday =3D bcd2bin(regs.day) - 1;
> --=20
> 2.7.4
>=20

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
