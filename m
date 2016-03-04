Return-Path: <rtc-linux+bncBDS7HNEFSALRBIGK463AKGQEAOTKPFA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si23272wmh.1.2016.03.04.11.42.23
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Mar 2016 11:42:23 -0800 (PST)
Date: Fri, 4 Mar 2016 20:42:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 4/6] rtc-rv3029: Add i2c register update-bits helper
Message-ID: <20160304194223.GB2970@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
 <20160304195337.51439645@wiggum>
 <20160304195611.48d5177b@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160304195611.48d5177b@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/03/2016 at 19:56:11 +0100, Michael B=C3=BCsch wrote :
> This simplifies mask/set operations on device I2C registers.
>=20
> Signed-off-by: Michael Buesch <m@bues.ch>
> ---
>  drivers/rtc/rtc-rv3029c2.c | 54 ++++++++++++++++++++++++----------------=
------
>  1 file changed, 28 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
> index 29cc871..769f73a 100644
> --- a/drivers/rtc/rtc-rv3029c2.c
> +++ b/drivers/rtc/rtc-rv3029c2.c
> @@ -2,6 +2,7 @@
>   * Micro Crystal RV-3029 rtc class driver
>   *
>   * Author: Gregory Hermant <gregory.hermant@calao-systems.com>
> + *         Michael Buesch <m@bues.ch>
>   *
>   * based on previously existing rtc class drivers
>   *
> @@ -143,6 +144,24 @@ rv3029_i2c_write_regs(struct i2c_client *client, u8 =
reg, u8 const buf[],
>  }
> =20
>  static int
> +rv3029_i2c_update_bits(struct i2c_client *client, u8 reg, u8 mask, u8 se=
t)
> +{
> +	u8 buf;
> +	int ret;
> +
> +	ret =3D rv3029_i2c_read_regs(client, reg, &buf, 1);
> +	if (ret < 0)
> +		return ret;
> +	buf &=3D mask;
> +	buf |=3D set;

Well, this is not exactly what is expected from an update_bits function,
it should be:

	buf &=3D ~mask;
	buf |=3D set & mask;

What you pass to the function is the mask of bits you want to set.

> +	ret =3D rv3029_i2c_write_regs(client, reg, &buf, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int
>  rv3029_i2c_get_sr(struct i2c_client *client, u8 *buf)
>  {
>  	int ret =3D rv3029_i2c_read_regs(client, RV3029_STATUS, buf, 1);
> @@ -260,22 +279,13 @@ static int rv3029_rtc_i2c_alarm_set_irq(struct i2c_=
client *client,
>  					int enable)
>  {
>  	int ret;
> -	u8 buf[1];
> -
> -	/* enable AIE irq */
> -	ret =3D rv3029_i2c_read_regs(client, RV3029_IRQ_CTRL, buf, 1);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "can't read INT reg\n");
> -		return ret;
> -	}
> -	if (enable)
> -		buf[0] |=3D RV3029_IRQ_CTRL_AIE;
> -	else
> -		buf[0] &=3D ~RV3029_IRQ_CTRL_AIE;
> =20
> -	ret =3D rv3029_i2c_write_regs(client, RV3029_IRQ_CTRL, buf, 1);
> +	/* enable/disable AIE irq */
> +	ret =3D rv3029_i2c_update_bits(client, RV3029_IRQ_CTRL,
> +				     (u8)~RV3029_IRQ_CTRL_AIE,

This allows to remove the bitwise not here

> +				     (enable ? RV3029_IRQ_CTRL_AIE : 0));
>  	if (ret < 0) {
> -		dev_err(&client->dev, "can't set INT reg\n");
> +		dev_err(&client->dev, "can't update INT reg\n");
>  		return ret;
>  	}
> =20
> @@ -316,20 +326,11 @@ static int rv3029_rtc_i2c_set_alarm(struct i2c_clie=
nt *client,
>  		return ret;
> =20
>  	if (alarm->enabled) {
> -		u8 buf[1];
> -
>  		/* clear AF flag */
> -		ret =3D rv3029_i2c_read_regs(client, RV3029_IRQ_FLAGS,
> -					   buf, 1);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "can't read alarm flag\n");
> -			return ret;
> -		}
> -		buf[0] &=3D ~RV3029_IRQ_FLAGS_AF;
> -		ret =3D rv3029_i2c_write_regs(client, RV3029_IRQ_FLAGS,
> -					    buf, 1);
> +		ret =3D rv3029_i2c_update_bits(client, RV3029_IRQ_FLAGS,
> +					     (u8)~RV3029_IRQ_FLAGS_AF, 0);

and here.

>  		if (ret < 0) {
> -			dev_err(&client->dev, "can't set alarm flag\n");
> +			dev_err(&client->dev, "can't clear alarm flag\n");
>  			return ret;
>  		}
>  		/* enable AIE irq */
> @@ -454,5 +455,6 @@ static struct i2c_driver rv3029_driver =3D {
>  module_i2c_driver(rv3029_driver);
> =20
>  MODULE_AUTHOR("Gregory Hermant <gregory.hermant@calao-systems.com>");
> +MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
>  MODULE_DESCRIPTION("Micro Crystal RV3029 RTC driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.7.0
>=20



--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
