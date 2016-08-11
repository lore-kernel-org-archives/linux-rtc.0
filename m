Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBRFAWG6QKGQEPUSGFOA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i193si87615wmg.1.2016.08.11.03.15.30
        for <rtc-linux@googlegroups.com>;
        Thu, 11 Aug 2016 03:15:30 -0700 (PDT)
Date: Thu, 11 Aug 2016 12:15:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Daniel Romell <danielromell@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, daro@hms.se, jao@hms.se, mago@hms.se
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: bq32k: Fix handling of oscillator
 failure flag
Message-ID: <20160811101520.GG8132@piout.net>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470909555-9226-3-git-send-email-daro@hms.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1470909555-9226-3-git-send-email-daro@hms.se>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/08/2016 at 11:59:15 +0200, Daniel Romell wrote :
> From: Jan =C3=96stlund <jao@hms.se>
>=20
> While the oscillator failure flag is set, the RTC registers
> should be considered invalid. bq32k_rtc_read_time() now
> returns an error instead of an invalid time.
>=20
> The failure flag is cleared the next time the clock is set.
>=20
> Signed-off-by: Daniel Romell <daro@hms.se>
> ---
>  drivers/rtc/rtc-bq32k.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> index 5a0c137..3fc6f7c 100644
> --- a/drivers/rtc/rtc-bq32k.c
> +++ b/drivers/rtc/rtc-bq32k.c
> @@ -93,6 +93,13 @@ static int bq32k_rtc_read_time(struct device *dev, str=
uct rtc_time *tm)
>  	if (error)
>  		return error;
> =20
> +	/*
> +	 * In case of oscillator failure, the register contents should be
> +	 * considered invalid. The flag is cleared the next time the RTC is set=
.
> +	 */
> +	if (regs.minutes & BQ32K_OF)
> +		return -EIO;

The other drivers return -EINVAL in that case. Else, the change is fine.

> +
>  	tm->tm_sec =3D bcd2bin(regs.seconds & BQ32K_SECONDS_MASK);
>  	tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_MINUTES_MASK);
>  	tm->tm_hour =3D bcd2bin(regs.cent_hours & BQ32K_HOURS_MASK);
> @@ -204,13 +211,10 @@ static int bq32k_probe(struct i2c_client *client,
> =20
>  	/* Check Oscillator Failure flag */
>  	error =3D bq32k_read(dev, &reg, BQ32K_MINUTES, 1);
> -	if (!error && (reg & BQ32K_OF)) {
> -		dev_warn(dev, "Oscillator Failure. Check RTC battery.\n");
> -		reg &=3D ~BQ32K_OF;
> -		error =3D bq32k_write(dev, &reg, BQ32K_MINUTES, 1);
> -	}
>  	if (error)
>  		return error;
> +	if (reg & BQ32K_OF)
> +		dev_warn(dev, "Oscillator Failure. Check RTC battery.\n");
> =20
>  	if (client->dev.of_node)
>  		trickle_charger_of_init(dev, client->dev.of_node);
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
