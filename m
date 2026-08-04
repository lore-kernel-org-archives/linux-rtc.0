Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC43932F9
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882737; cv=none; b=jOmuopcRotzJxgmtSZ0FBwsUXcPsN/qvOtCDYmDUkMjzjfYfNNNb/Y9ZG9isPE8fWAApHR3nFdXvERCMrsIpDhT0nB7i3v+mCN7wIFYBjy9uAxnDBQ3DvW2kS1mcDE6kxqi6GO+cI1V7XT2JqU0tWr1fCWcKFl7YaSqofrMPU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882737; c=relaxed/simple;
	bh=ia69ebwsJ1DsdZlSuEP06O1nz4zgCm7tARgTvZjnc8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peAzVe22eanmmqTbOJLidhVYj+G7m3MRktWShonk4Zco5De/ZpabKDvGQOigVqejNE+Ua5MJGa1ESxxABL1Bo2FjPBCY6Hf3SVPla57a5A4V/ltrSwC4p5HDwl6egxUnXtlYNZWqX9uB5J/pS1UtTIEcE9pGXZ7DYi2zmxJoChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=REt4egoc; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="REt4egoc"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D2F53240029
	for <linux-rtc@vger.kernel.org>; Wed,  5 Aug 2026 00:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785882732;
	bh=90/Zpc+1pZjM+SsoWmbfz0zmvMaRbeUbFlKQojBOftY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=REt4egoct876dOQK8/skwZj7O12uD7IxDvx5D51Hlzkphvya96pWWy/c1S8KCrWHP
	 IlLlbQnN7rkfDBNpM0osgUJXsW82YXRuGcygXS7Th6IXzcRbRfL+sJUfh2zAkH3yKu
	 tP0oOgi3nG48E/5FmqlA0x+7ZMRoDDR3w1FG/C1SeqA8ckfyBoSYKMF4seHvGPq3dL
	 lfJ7kS1k+S5O0t3tSVvCR8tPKfX5cBYsZNakATy9ZusiyeML2IdNXaqkV2O+VvU3n9
	 bpS++ZkRCXh1TrqWTd8WpyA8fLyC17wZX/cQm2WkutaXUomoqFv8N+bi0LGT+KiJ8e
	 eX55+iQLNoGjw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hF7Zf0Nmsz9rxB;
	Wed,  5 Aug 2026 00:32:10 +0200 (CEST)
Message-ID: <42763e1ed91d8d37b1ab914633f1e3525237e2d2.camel@posteo.de>
Subject: Re: [PATCH v2 4/5] rtc: s35390a: Add pinctrl
From: Markus Probst <markus.probst@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <uwe@kleine-koenig.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth	
 <sebastian.hesselbarth@gmail.com>, Michael Langer	
 <michael.brainbug.langer@googlemail.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 04 Aug 2026 22:32:12 +0000
In-Reply-To: <2026080422201232a44ff0@mail.local>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
	 <20260801-rtc_s35390a_int1-v2-4-f10c99ad1d6c@posteo.de>
	 <2026080422201232a44ff0@mail.local>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-EiC9+BFaK8j2Yw0xY8df"
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-EiC9+BFaK8j2Yw0xY8df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-05 at 00:20 +0200, Alexandre Belloni wrote:
> On 01/08/2026 18:43:04+0000, Markus Probst wrote:
> > Allow configuration of other output modes than wake alarm, including:
> > - keeping the previous configured mode
> > - disabling output
> > - custom frequency
> > - minute periodical interrupt (1: 50% duty, 2: 7.81 ms)
> > - raw 32.768 kHz output
> >=20
> > Allow use of interrupt signal 1.
>=20
> There are a lot of checkpatch --strict warnings taht can be fixed. This
> patch also needs to be reviewed by the pinctrl maintainers.
Sashiko found quite a lot of issues too.

I also wrongfully used pinconf instead of pinmux, for the pin function
assignment.

I will try to create a new revision today/tomorrow (depending on the
timezone).

Thanks
- Markus Probst

>=20
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/rtc/Kconfig       |   3 +
> >  drivers/rtc/rtc-s35390a.c | 403 ++++++++++++++++++++++++++++++++++++++=
+-------
> >  2 files changed, 349 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 01def8231873..054ff134d84e 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -668,7 +668,10 @@ config RTC_DRV_RC5T619
> > =20
> >  config RTC_DRV_S35390A
> >  	tristate "Seiko Instruments S-35390A"
> > +	depends on OF
> > +	depends on PINCTRL
> >  	select BITREVERSE
> > +	select GENERIC_PINCONF
> >  	help
> >  	  If you say yes here you will get support for the Seiko
> >  	  Instruments S-35390A.
> > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > index fbf5471eb3d0..fc0dbce0e8f4 100644
> > --- a/drivers/rtc/rtc-s35390a.c
> > +++ b/drivers/rtc/rtc-s35390a.c
> > @@ -12,11 +12,18 @@
> >  #include <linux/bcd.h>
> >  #include <linux/slab.h>
> >  #include <linux/delay.h>
> > +#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/pinconf.h>
> > +#include <linux/pinctrl/pinconf-generic.h>
> > +#include <dt-bindings/rtc/s35390a.h>
> > +
> > +#define DRIVER_NAME "rtc-s35390a"
> > =20
> >  #define S35390A_CMD_STATUS1	0
> >  #define S35390A_CMD_STATUS2	1
> >  #define S35390A_CMD_TIME1	2
> >  #define S35390A_CMD_TIME2	3
> > +#define S35390A_CMD_INT1_REG1	4
> >  #define S35390A_CMD_INT2_REG1	5
> >  #define S35390A_CMD_FREE_REG    7
> > =20
> > @@ -36,19 +43,31 @@
> >  #define S35390A_FLAG_POC	BIT(0)
> >  #define S35390A_FLAG_BLD	BIT(1)
> >  #define S35390A_FLAG_INT2	BIT(2)
> > +#define S35390A_FLAG_INT1	BIT(3)
> >  #define S35390A_FLAG_24H	BIT(6)
> >  #define S35390A_FLAG_RESET	BIT(7)
> > =20
> >  /* flag for STATUS2 */
> >  #define S35390A_FLAG_TEST	BIT(0)
> > =20
> > +
> > +#define S35390A_INT_MODE_NOINTR	0x00
> > +
> >  /* INT2 pin output mode */
> >  #define S35390A_INT2_MODE_MASK		0x0E
> > -#define S35390A_INT2_MODE_NOINTR	0x00
> >  #define S35390A_INT2_MODE_ALARM		BIT(1) /* INT2AE */
> >  #define S35390A_INT2_MODE_PMIN_EDG	BIT(2) /* INT2ME */
> >  #define S35390A_INT2_MODE_FREQ		BIT(3) /* INT2FE */
> > -#define S35390A_INT2_MODE_PMIN		(BIT(3) | BIT(2)) /* INT2FE | INT2ME *=
/
> > +#define S35390A_INT2_MODE_PMIN1		(BIT(3) | BIT(2)) /* INT2FE | INT2ME =
*/
> > +
> > +/* INT1 pin output mode */
> > +#define S35390A_INT1_MODE_MASK		0xF0
> > +#define S35390A_INT1_MODE_ALARM		BIT(5) /* INT1AE */
> > +#define S35390A_INT1_MODE_PMIN_EDG	BIT(6) /* INT1ME */
> > +#define S35390A_INT1_MODE_FREQ		BIT(7) /* INT1FE */
> > +#define S35390A_INT1_MODE_PMIN1		(BIT(7) | BIT(6)) /* INT1FE | INT1ME =
*/
> > +#define S35390A_INT1_MODE_PMIN2		(BIT(7) | BIT(6) | BIT(5)) /* INT1FE =
| INT1ME | INT1AE */
> > +#define S35390A_INT1_MODE_32768KHZ	BIT(4) /* 32kE */
> > =20
> >  static const struct i2c_device_id s35390a_id[] =3D {
> >  	{ .name =3D "s35390a" },
> > @@ -64,8 +83,15 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
> > =20
> >  struct s35390a {
> >  	struct i2c_client *client[8];
> > -	struct rtc_time tm_alarm;
> > +	struct rtc_device *rtc;
> > +	struct pinctrl_dev *pinctrl;
> > +	struct rtc_wkalrm alarm;
> >  	int twentyfourhour;
> > +
> > +	struct mutex mode_lock;
> > +	bool mode_init;
> > +	int mode[2];
> > +	u8 freq[2];
> >  };
> > =20
> >  static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf,=
 int len)
> > @@ -283,33 +309,33 @@ static int s35390a_rtc_set_alarm(struct device *d=
ev, struct rtc_wkalrm *alm)
> >  		alm->time.tm_min, alm->time.tm_hour, alm->time.tm_mday,
> >  		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
> > =20
> > -	/* disable interrupt (which deasserts the irq line) */
> > -	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> > -	if (err < 0)
> > -		return err;
> > +	guard(mutex)(&s35390a->mode_lock);
> > =20
> > -	/* clear pending interrupt (in STATUS1 only), if any */
> > -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &sts, sizeof(st=
s));
> > +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	if (alm->enabled)
> > -		sts =3D S35390A_INT2_MODE_ALARM;
> > -	else
> > -		sts =3D S35390A_INT2_MODE_NOINTR;
> > +	/* disable interrupt (which deasserts the irq line) */
> > +	if (s35390a->mode[0] =3D=3D S35390A_MODE_WAKEUP)
> > +		sts =3D (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT_MODE_NOINTR;
> > +
> > +	if (s35390a->mode[1] =3D=3D S35390A_MODE_WAKEUP)
> > +		sts =3D (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT_MODE_NOINTR;
> > =20
> > -	/* set interrupt mode*/
> >  	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> >  	if (err < 0)
> >  		return err;
> > =20
> > +	if (!alm->enabled)
> > +		goto end;
> > +
> >  	if (alm->time.tm_wday !=3D -1)
> >  		buf[S35390A_ALRM_BYTE_WDAY] =3D bin2bcd(alm->time.tm_wday) | 0x80;
> >  	else
> >  		buf[S35390A_ALRM_BYTE_WDAY] =3D 0;
> > =20
> >  	buf[S35390A_ALRM_BYTE_HOURS] =3D s35390a_hr2reg(s35390a,
> > -			alm->time.tm_hour) | 0x80;
> > +						      alm->time.tm_hour) | 0x80;
> >  	buf[S35390A_ALRM_BYTE_MINS] =3D bin2bcd(alm->time.tm_min) | 0x80;
> > =20
> >  	if (alm->time.tm_hour >=3D 12)
> > @@ -318,13 +344,33 @@ static int s35390a_rtc_set_alarm(struct device *d=
ev, struct rtc_wkalrm *alm)
> >  	for (i =3D 0; i < 3; ++i)
> >  		buf[i] =3D bitrev8(buf[i]);
> > =20
> > -	err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf,
> > -								sizeof(buf));
> > +	/* set interrupt mode */
> > +	if (s35390a->mode[0] =3D=3D S35390A_MODE_WAKEUP)
> > +		sts =3D (sts & ~S35390A_INT1_MODE_MASK) | S35390A_INT1_MODE_ALARM;
> > +
> > +	if (s35390a->mode[1] =3D=3D S35390A_MODE_WAKEUP)
> > +		sts =3D (sts & ~S35390A_INT2_MODE_MASK) | S35390A_INT2_MODE_ALARM;
> > +
> > +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (s35390a->mode[0] =3D=3D S35390A_MODE_WAKEUP) {
> > +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT1_REG1, buf, sizeof(=
buf));
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	if (s35390a->mode[1] =3D=3D S35390A_MODE_WAKEUP) {
> > +		err =3D s35390a_set_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(=
buf));
> > +		if (err)
> > +			return err;
> > +	}
> > =20
> > -	if (!err)
> > -		s35390a->tm_alarm =3D alm->time;
> > +end:
> > +	s35390a->alarm =3D *alm;
> > =20
> > -	return err;
> > +	return 0;
> >  }
> > =20
> >  static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalr=
m *alm)
> > @@ -332,24 +378,35 @@ static int s35390a_rtc_read_alarm(struct device *=
dev, struct rtc_wkalrm *alm)
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> >  	struct s35390a *s35390a =3D i2c_get_clientdata(client);
> >  	u8 buf[3], sts;
> > -	int i, err;
> > +	int i, err, reg;
> > +
> > +	guard(mutex)(&s35390a->mode_lock);
> > =20
> >  	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(st=
s));
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	if ((sts & S35390A_INT2_MODE_MASK) !=3D S35390A_INT2_MODE_ALARM) {
> > +	if (s35390a->mode[1] =3D=3D S35390A_MODE_WAKEUP
> > +		&& (sts & S35390A_INT2_MODE_MASK) =3D=3D S35390A_INT2_MODE_ALARM) {
> > +
> > +		reg =3D S35390A_CMD_INT2_REG1;
> > +	} else if (s35390a->mode[0] =3D=3D S35390A_MODE_WAKEUP
> > +		&& (sts & S35390A_INT1_MODE_MASK) =3D=3D S35390A_INT1_MODE_ALARM) {
> > +
> > +		reg =3D S35390A_CMD_INT1_REG1;
> > +	} else {
> >  		/*
> >  		 * When the alarm isn't enabled, the register to configure
> >  		 * the alarm time isn't accessible.
> >  		 */
> >  		alm->enabled =3D 0;
> > +		alm->time =3D s35390a->alarm.time;
> >  		return 0;
> > -	} else {
> > -		alm->enabled =3D 1;
> >  	}
> > =20
> > -	err =3D s35390a_get_reg(s35390a, S35390A_CMD_INT2_REG1, buf, sizeof(b=
uf));
> > +	alm->enabled =3D 1;
> > +
> > +	err =3D s35390a_get_reg(s35390a, reg, buf, sizeof(buf));
> >  	if (err < 0)
> >  		return err;
> > =20
> > @@ -358,7 +415,7 @@ static int s35390a_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *alm)
> >  		buf[i] =3D bitrev8(buf[i]);
> > =20
> >  	/*
> > -	 * B0 of the three matching registers is an enable flag. Iff it is se=
t
> > +	 * B0 of the three matching registers is an enable flag. If it is set
> >  	 * the configured value is used for matching.
> >  	 */
> >  	if (buf[S35390A_ALRM_BYTE_WDAY] & 0x80)
> > @@ -388,10 +445,10 @@ static int s35390a_rtc_alarm_irq_enable(struct de=
vice *dev, unsigned int enabled
> >  	struct s35390a *s35390a =3D dev_get_drvdata(dev);
> >  	struct rtc_wkalrm alm;
> > =20
> > -	alm.enabled =3D enabled;
> > -
> >  	if (enabled)
> > -		alm.time =3D s35390a->tm_alarm;
> > +		alm =3D s35390a->alarm;
> > +
> > +	alm.enabled =3D enabled;
> > =20
> >  	return s35390a_rtc_set_alarm(dev, &alm);
> >  }
> > @@ -452,13 +509,241 @@ static int s35390a_nvmem_write(void *priv, unsig=
ned int offset, void *val,
> >  	return s35390a_set_reg(s35390a, S35390A_CMD_FREE_REG, val, bytes);
> >  }
> > =20
> > +static int s35390a_pinctrl_get_groups_count(struct pinctrl_dev *pctlde=
v)
> > +{
> > +	return 0;
> > +}
> > +
> > +static const char *s35390a_pinctrl_get_group_name(struct pinctrl_dev *=
pctldev,
> > +						  unsigned int group)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static const struct pinctrl_pin_desc s35390a_pins_desc[] =3D {
> > +	PINCTRL_PIN(0, "int1"),
> > +	PINCTRL_PIN(1, "int2"),
> > +};
> > +
> > +static const struct pinctrl_ops s35390a_pinctrl_ops =3D {
> > +	.get_groups_count =3D s35390a_pinctrl_get_groups_count,
> > +	.get_group_name =3D s35390a_pinctrl_get_group_name,
> > +	.dt_node_to_map =3D pinconf_generic_dt_node_to_map_pin,
> > +	.dt_free_map =3D pinconf_generic_dt_free_map,
> > +};
> > +
> > +#define PIN_CONFIG_MODE		(PIN_CONFIG_END + 1)
> > +#define PIN_CONFIG_FREQ		(PIN_CONFIG_END + 2)
> > +
> > +static const struct pinconf_generic_params s35390a_pinconf_params[] =
=3D {
> > +	{"sii,mode", PIN_CONFIG_MODE},
> > +	{"sii,frequency", PIN_CONFIG_FREQ},
> > +};
> > +
> > +static int s35390a_set_freq(struct s35390a *s35390a, int pin, int freq=
)
> > +{
> > +	int err, reg;
> > +	u8 buf;
> > +
> > +	reg =3D pin =3D=3D 0 ? S35390A_CMD_INT1_REG1 : S35390A_CMD_INT2_REG1;
> > +
> > +	buf =3D bitrev8(freq);
> > +
> > +	err =3D s35390a_set_reg(s35390a, reg, &buf, 1);
> > +	if (err < 0)
> > +		return err;
> > +	return 0;
> > +}
> > +
> > +static int s35390a_update_mode(struct s35390a *s35390a, int pin, int m=
ode, int freq)
> > +{
> > +	int err;
> > +	u8 buf, status1, flag, mask;
> > +	bool update_irq =3D false;
> > +
> > +	mask =3D pin =3D=3D 0 ? S35390A_INT1_MODE_MASK : S35390A_INT2_MODE_MA=
SK;
> > +
> > +	s35390a->mode_init =3D true;
> > +
> > +	guard(mutex)(&s35390a->mode_lock);
> > +
> > +	dev_dbg(&s35390a->client[0]->dev, "%s: pin=3D%d mode=3D%d\n",
> > +			__func__, pin, mode);
> > +
> > +	if (mode =3D=3D S35390A_MODE_FREQ) {
> > +		if (freq & ~S35390A_FREQ_MASK) {
> > +			dev_err(&s35390a->client[0]->dev, "Unsupported frequency %u\n", fre=
q);
> > +			return -EINVAL;
> > +		}
> > +	} else
> > +		freq =3D 0;
> > +
> > +	if (mode =3D=3D s35390a->mode[pin] && freq =3D=3D s35390a->freq[pin])
> > +		return 0;
> > +
> > +	s35390a->mode[pin] =3D mode;
> > +	s35390a->freq[pin] =3D freq;
> > +
> > +	if (mode =3D=3D S35390A_MODE_IGNORE)
> > +		return 0;
> > +
> > +	err =3D s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
> > +	if (err < 0) {
> > +		dev_err(&s35390a->client[0]->dev, "error reading status\n");
> > +		return err;
> > +	}
> > +
> > +	switch (mode) {
> > +	case S35390A_MODE_DISABLE:
> > +	case S35390A_MODE_ALARM: /* not implemented */
> > +		buf =3D (buf & ~mask) | S35390A_INT_MODE_NOINTR;
> > +		break;
> > +	case S35390A_MODE_WAKEUP:
> > +		flag =3D pin =3D=3D 0 ? S35390A_INT1_MODE_ALARM : S35390A_INT2_MODE_=
ALARM;
> > +		if ((buf & mask) !=3D flag) {
> > +			buf =3D (buf & ~mask) | S35390A_INT_MODE_NOINTR;
> > +			break;
> > +		}
> > +
> > +		err =3D s35390a_read_status(s35390a, &status1);
> > +		if (err < 0) {
> > +			dev_err(&s35390a->client[0]->dev, "error reading status\n");
> > +			return err;
> > +		}
> > +
> > +		flag =3D pin =3D=3D 0 ? S35390A_FLAG_INT1 : S35390A_FLAG_INT2;
> > +
> > +		/* disable alarm */
> > +		if (status1 & flag) {
> > +			buf =3D (buf & ~mask) | S35390A_INT_MODE_NOINTR;
> > +			update_irq =3D true;
> > +		}
> > +
> > +		break;
> > +	case S35390A_MODE_FREQ:
> > +		flag =3D pin =3D=3D 0 ? S35390A_INT1_MODE_FREQ : S35390A_INT2_MODE_F=
REQ;
> > +		buf =3D (buf & ~mask) | flag;
> > +		break;
> > +	case S35390A_MODE_PMIN1:
> > +		flag =3D pin =3D=3D 0 ? S35390A_INT1_MODE_PMIN1 : S35390A_INT2_MODE_=
PMIN1;
> > +		buf =3D (buf & ~mask) | flag;
> > +		break;
> > +
> > +	/* INT1 only modes */
> > +	case S35390A_MODE_PMIN2:
> > +		buf =3D (buf & ~mask) | S35390A_INT1_MODE_PMIN2;
> > +		break;
> > +	case S35390A_MODE_32768KHZ:
> > +		buf =3D (buf & ~mask) | S35390A_INT1_MODE_32768KHZ;
> > +		break;
> > +	}
> > +
> > +	err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
> > +	if (err < 0) {
> > +		dev_err(&s35390a->client[0]->dev, "error setting interrupts\n");
> > +		return err;
> > +	}
> > +
> > +	if (freq) {
> > +		err =3D s35390a_set_freq(s35390a, pin, freq);
> > +		if (err < 0) {
> > +			dev_err(&s35390a->client[0]->dev, "error setting frequency\n");
> > +			return err;
> > +		}
> > +	}
> > +
> > +	if (update_irq)
> > +		rtc_update_irq(s35390a->rtc, 1, RTC_AF);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s35390a_pinconf_get(struct pinctrl_dev *pctldev,
> > +			       unsigned int pin, unsigned long *config)
> > +{
> > +	struct s35390a *s35390a =3D pinctrl_dev_get_drvdata(pctldev);
> > +	unsigned int param =3D pinconf_to_config_param(*config);
> > +	u16 arg;
> > +
> > +	switch (param) {
> > +	case PIN_CONFIG_MODE:
> > +		arg =3D s35390a->mode[pin];
> > +		break;
> > +	case PIN_CONFIG_FREQ:
> > +		arg =3D s35390a->freq[pin];
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	*config =3D pinconf_to_config_packed(param, arg);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s35390a_pinconf_set(struct pinctrl_dev *pctldev,
> > +			       unsigned int pin, unsigned long *configs,
> > +			       unsigned int num_configs)
> > +{
> > +	struct s35390a *s35390a =3D pinctrl_dev_get_drvdata(pctldev);
> > +	unsigned int param;
> > +	u32 param_val;
> > +	int i, mode, freq =3D 0;
> > +
> > +	mode =3D pin =3D=3D 0 ? S35390A_MODE_IGNORE : S35390A_MODE_WAKEUP;
> > +
> > +	for (i =3D 0; i < num_configs; i++) {
> > +		param =3D pinconf_to_config_param(configs[0]);
> > +		param_val =3D pinconf_to_config_argument(configs[0]);
> > +
> > +		switch (param) {
> > +		case PIN_CONFIG_MODE:
> > +			if (param_val <=3D (pin =3D=3D 0 ? S35390A_MODE_INT1_MAX : S35390A_=
MODE_INT2_MAX))
> > +				mode =3D param_val;
> > +			else {
> > +				dev_err(&s35390a->client[0]->dev, "Unsupported pin mode %u\n",
> > +					param_val);
> > +				return -EINVAL;
> > +			}
> > +			break;
> > +		case PIN_CONFIG_FREQ:
> > +			freq =3D param_val;
> > +			break;
> > +		default:
> > +			dev_err(&s35390a->client[0]->dev, "Property %u not supported\n",
> > +				param);
> > +			return -EOPNOTSUPP;
> > +		}
> > +	}
> > +
> > +	return s35390a_update_mode(s35390a, pin, mode, freq);
> > +}
> > +
> > +
> > +static const struct pinconf_ops s35390a_pinconf_ops =3D {
> > +	.is_generic =3D true,
> > +	.pin_config_get =3D s35390a_pinconf_get,
> > +	.pin_config_set =3D s35390a_pinconf_set,
> > +};
> > +
> > +static struct pinctrl_desc s35390a_pinctrl_desc =3D {
> > +	.name =3D DRIVER_NAME,
> > +	.pins =3D s35390a_pins_desc,
> > +	.npins =3D ARRAY_SIZE(s35390a_pins_desc),
> > +	.pctlops =3D &s35390a_pinctrl_ops,
> > +	.confops =3D &s35390a_pinconf_ops,
> > +	.custom_params =3D s35390a_pinconf_params,
> > +	.num_custom_params =3D ARRAY_SIZE(s35390a_pinconf_params),
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> >  static int s35390a_probe(struct i2c_client *client)
> >  {
> >  	int err, err_read;
> >  	unsigned int i;
> >  	struct s35390a *s35390a;
> >  	struct rtc_device *rtc;
> > -	u8 buf, status1;
> > +	u8 status1;
> >  	struct device *dev =3D &client->dev;
> >  	struct nvmem_config nvmem_cfg =3D {
> >  		.name =3D "s35390a_nvram",
> > @@ -477,7 +762,10 @@ static int s35390a_probe(struct i2c_client *client=
)
> >  	if (!s35390a)
> >  		return -ENOMEM;
> > =20
> > +	mutex_init(&s35390a->mode_lock);
> > +
> >  	s35390a->client[0] =3D client;
> > +
> >  	i2c_set_clientdata(client, s35390a);
> > =20
> >  	/* This chip uses multiple addresses, use dummy devices for them */
> > @@ -492,10 +780,37 @@ static int s35390a_probe(struct i2c_client *clien=
t)
> >  		}
> >  	}
> > =20
> > +	err =3D s35390a_disable_test_mode(s35390a);
> > +	if (err < 0) {
> > +		dev_err(dev, "error disabling test mode\n");
> > +		return err;
> > +	}
> > +
> >  	rtc =3D devm_rtc_allocate_device(dev);
> >  	if (IS_ERR(rtc))
> >  		return PTR_ERR(rtc);
> > =20
> > +	rtc->ops =3D &s35390a_rtc_ops;
> > +	rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > +	rtc->range_max =3D RTC_TIMESTAMP_END_2099;
> > +
> > +	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
> > +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> > +
> > +	s35390a->rtc =3D rtc;
> > +
> > +	err =3D devm_pinctrl_register_and_init(dev, &s35390a_pinctrl_desc, s3=
5390a,
> > +					     &s35390a->pinctrl);
> > +	if (err)
> > +		return err;
> > +
> > +	/* If no pinctrl config is defined in DT, fallback to previous behavi=
our */
> > +	if (!s35390a->mode_init) {
> > +		err =3D s35390a_update_mode(s35390a, 1, S35390A_MODE_WAKEUP, 0);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	err_read =3D s35390a_read_status(s35390a, &status1);
> >  	if (err_read < 0) {
> >  		dev_err(dev, "error resetting chip\n");
> > @@ -507,34 +822,8 @@ static int s35390a_probe(struct i2c_client *client=
)
> >  	else
> >  		s35390a->twentyfourhour =3D 0;
> > =20
> > -	if (status1 & S35390A_FLAG_INT2) {
> > -		/* disable alarm (and maybe test mode) */
> > -		buf =3D 0;
> > -		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
> > -		if (err < 0) {
> > -			dev_err(dev, "error disabling alarm\n");
> > -			return err;
> > -		}
> > -	} else {
> > -		err =3D s35390a_disable_test_mode(s35390a);
> > -		if (err < 0) {
> > -			dev_err(dev, "error disabling test mode\n");
> > -			return err;
> > -		}
> > -	}
> > -
> >  	device_set_wakeup_capable(dev, 1);
> > =20
> > -	rtc->ops =3D &s35390a_rtc_ops;
> > -	rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > -	rtc->range_max =3D RTC_TIMESTAMP_END_2099;
> > -
> > -	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
> > -	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> > -
> > -	if (status1 & S35390A_FLAG_INT2)
> > -		rtc_update_irq(rtc, 1, RTC_AF);
> > -
> >  	nvmem_cfg.priv =3D s35390a;
> >  	err =3D devm_rtc_nvmem_register(rtc, &nvmem_cfg);
> >  	if (err)
> > @@ -545,7 +834,7 @@ static int s35390a_probe(struct i2c_client *client)
> > =20
> >  static struct i2c_driver s35390a_driver =3D {
> >  	.driver		=3D {
> > -		.name	=3D "rtc-s35390a",
> > +		.name	=3D DRIVER_NAME,
> >  		.of_match_table =3D of_match_ptr(s35390a_of_match),
> >  	},
> >  	.probe		=3D s35390a_probe,
> >=20
> > --=20
> > 2.54.0
> >=20

--=-EiC9+BFaK8j2Yw0xY8df
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpyaFsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSPSUP/i1sMVN8LXjlIo3cEML/
F5L4EuM90g7rNgK4GlOxfvjtR6/0ftW4Svic0J+n3oi1JiBmBPfSe2cJhkf42Cac
yRS4ONqoJw07GqwOQa1pG19i42ZTe7Oe2mXiVpgotoZ850L0YZ7ohQMQ3UE0SgDU
p59Jxvi0kYudW61R55HWar0FnUKNA3xO17LjqKoAapKDGNBl9s0qvds68QZrDUsp
jo1RFaG0FK4sRs3R7qLH6blpkxV9X+WdnBMM+TTDHH26i753EGHFMCB+KdBULBM4
KDgk7kn+cds9J+Opo+PdC763qrxpzmjrKObVzHbY9kNB2GF1VoGkAV7glVQjEPev
+wQNTmpra60nz24HSj1PNwzhPOeNTS9MSdvv3yYQvrq466s42kQaAFu0PdNxpyLI
fHb7dQBVJ3M4+abVuA6rebBwSYt0ERvQGNm6UhHs2V+3pj15FELwNghRwbC+8jOw
pRUvEE9+LeGnD2n1Sc3rRKqPtoj0i5o9JVNU4qnuGxsssHw1lhRCkT7OCAeH8mun
RUOCxr3wnQkND5HyQXmc5kzq1psW8Z5fPnnH51YHLnthkhk4SkP8qwPEJIxe2eIF
PUNTcnu6x427FV8NxHE+DromARKQdH9WsKjL3Vi+qEBKum9H6/w8KsZtn73spNVu
Y0DU0nEbuv49onf1ZnQTPqTy
=E267
-----END PGP SIGNATURE-----

--=-EiC9+BFaK8j2Yw0xY8df--
