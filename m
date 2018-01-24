Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57329 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933300AbeAXMKS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 24 Jan 2018 07:10:18 -0500
Date: Wed, 24 Jan 2018 13:10:01 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, jdelvare@suse.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis.Osterland@diehl.com, alexandre.belloni@free-electrons.com,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Message-ID: <20180124121001.n477l35sugixvffq@pengutronix.de>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de>
 <20180123182254.GA27379@roeck-us.net>
 <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nsd6et7i2p43twdo"
In-Reply-To: <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--nsd6et7i2p43twdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 10:03:33AM +0100, Michael Grzeschik wrote:
> On Tue, Jan 23, 2018 at 10:22:54AM -0800, Guenter Roeck wrote:
> > On Tue, Jan 23, 2018 at 01:18:01PM +0100, Michael Grzeschik wrote:
> > > We add support for the ISL1219 chip that got an integrated tamper
> > > detection function. This patch implements the feature by using an hwm=
on
> > > interface.
> > >=20
> > > The ISL1219 can also describe the timestamp of the intrusion
> > > event. For this we add the documentation of the new interface
> > > intrusion[0-*]_timestamp.
> > >=20
> > > The devicetree documentation for the ISL1219 device tree
> > > binding is added with an short example.
> > >=20
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> > > ---
> > >  .../rtc/{intersil,isl1208.txt =3D> isil,isl1208.txt} |  18 +-
> > >  Documentation/hwmon/sysfs-interface                |   7 +
> > >  drivers/rtc/rtc-isl1208.c                          | 190 +++++++++++=
++++++++--
> > >  3 files changed, 201 insertions(+), 14 deletions(-)
> > >  rename Documentation/devicetree/bindings/rtc/{intersil,isl1208.txt =
=3D> isil,isl1208.txt} (57%)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.t=
xt b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > > similarity index 57%
> > > rename from Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> > > rename to Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > > index a54e99feae1ca..d549699e1cfc4 100644
> > > --- a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > > @@ -1,14 +1,21 @@
> > > -Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
> > > +Intersil ISL1208, ISL1218, ISL1219 I2C RTC/Alarm chip
> > > =20
> > >  ISL1208 is a trivial I2C device (it has simple device tree bindings,
> > >  consisting of a compatible field, an address and possibly an interru=
pt
> > >  line).
> > > =20
> > > +ISL1219 supports tamper detection user space representation through
> > > +case intrusion hwmon sensor.
> > > +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> > > +I2C devices support only one irq. #IRQ and #EVDET are open-drain act=
ive low,
> > > +so it is possible layout them to one SoC pin with pull-up.
> > > +
> > >  Required properties supported by the device:
> > > =20
> > >   - "compatible": must be one of
> > >  	"isil,isl1208"
> > >  	"isil,isl1218"
> > > +	"isil,isl1219"
> > >   - "reg": I2C bus address of the device
> > > =20
> > >  Optional properties:
> > > @@ -33,3 +40,12 @@ Example isl1208 node with #IRQ pin connected to So=
C gpio1 pin 12:
> > >  		interrupt-parent =3D <&gpio1>;
> > >  		interrupts =3D <12 IRQ_TYPE_EDGE_FALLING>;
> > >  	};
> > > +
> > > +Example isl1219 node with #IRQ pin and #EVDET pin connected to SoC g=
pio1 pin 12:
> > > +
> > > +	isl1219: isl1219@68 {
> > > +		compatible =3D "intersil,isl1219";
> > > +		reg =3D <0x68>;
> > > +		interrupts-extended =3D <&gpio1 12 IRQ_TYPE_EDGE_FALLING>;
> > > +	};
> > > +
> > > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmo=
n/sysfs-interface
> > > index fc337c317c673..a12b3c2b2a18c 100644
> > > --- a/Documentation/hwmon/sysfs-interface
> > > +++ b/Documentation/hwmon/sysfs-interface
> > > @@ -702,6 +702,13 @@ intrusion[0-*]_alarm
> > >  		the user. This is done by writing 0 to the file. Writing
> > >  		other values is unsupported.
> > > =20
> > > +intrusion[0-*]_timestamp
> > > +		Chassis intrusion detection
> > > +		YYYY-MM-DD HH:MM:SS UTC (ts.sec): intrusion detected
> > > +		RO
> > > +		The corresponding timestamp on which the intrustion
> > > +		was detected.
> > > +
> >=20
> > Sneaky. Nack. You don't just add attributes to the ABI because you want=
 it,
> > without serious discussion, and much less so hidden in an RTC driver
> > (and even less as unparseable attribute).
>=20
> Right; but it was not meant to be sneaky. I should have stick to my first
> thought and label this patch RFC. Sorry for that.
>=20
> > In addition to that, I consider the attribute unnecessary. The intrusion
> > already generates an event which should be sufficient for all practical
> > purposes.
>=20
> Would it make sense in between the other sysfs attributes of this driver?

I rethought that case and can tell that this timestamp has more value
here. The rtc is able to generate the timestamp even when the hardware
is not running and the rtc is still powered by battery. In that case it
would trigger an interrupt as soon the driver is running. For that
situation the intrusion timestamp does not correlate with the interrupt
event.

Michael

> > >  intrusion[0-*]_beep
> > >  		Chassis intrusion beep
> > >  		0: disable
> > > diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> > > index a13a4ba79004d..6e4d24614d98b 100644
> > > --- a/drivers/rtc/rtc-isl1208.c
> > > +++ b/drivers/rtc/rtc-isl1208.c
> > > @@ -14,6 +14,8 @@
> > >  #include <linux/i2c.h>
> > >  #include <linux/bcd.h>
> > >  #include <linux/rtc.h>
> > > +#include <linux/hwmon.h>
> > > +#include <linux/hwmon-sysfs.h>
> > > =20
> > >  /* Register map */
> > >  /* rtc section */
> > > @@ -33,6 +35,7 @@
> > >  #define ISL1208_REG_SR_ARST    (1<<7)	/* auto reset */
> > >  #define ISL1208_REG_SR_XTOSCB  (1<<6)	/* crystal oscillator */
> > >  #define ISL1208_REG_SR_WRTC    (1<<4)	/* write rtc */
> > > +#define ISL1208_REG_SR_EVT     (1<<3)	/* event */
> > >  #define ISL1208_REG_SR_ALM     (1<<2)	/* alarm */
> > >  #define ISL1208_REG_SR_BAT     (1<<1)	/* battery */
> > >  #define ISL1208_REG_SR_RTCF    (1<<0)	/* rtc fail */
> > > @@ -57,8 +60,29 @@
> > >  #define ISL1208_REG_USR2 0x13
> > >  #define ISL1208_USR_SECTION_LEN 2
> > > =20
> > > +/* event section */
> > > +#define ISL1208_REG_SCT 0x14
> > > +#define ISL1208_REG_MNT 0x15
> > > +#define ISL1208_REG_HRT 0x16
> > > +#define ISL1208_REG_DTT 0x17
> > > +#define ISL1208_REG_MOT 0x18
> > > +#define ISL1208_REG_YRT 0x19
> > > +#define ISL1208_EVT_SECTION_LEN 6
> > > +
> > >  static struct i2c_driver isl1208_driver;
> > > =20
> > > +/* ISL1208 various variants */
> > > +enum {
> > > +	TYPE_ISL1208 =3D 0,
> > > +	TYPE_ISL1218,
> > > +	TYPE_ISL1219,
> > > +};
> > > +
> > > +struct isl1208 {
> > > +	struct rtc_device *rtc;
> > > +	struct device *hwmon;
> > > +};
> > > +
> > >  /* block read */
> > >  static int
> > >  isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
> > > @@ -80,8 +104,8 @@ isl1208_i2c_read_regs(struct i2c_client *client, u=
8 reg, u8 buf[],
> > >  	};
> > >  	int ret;
> > > =20
> > > -	BUG_ON(reg > ISL1208_REG_USR2);
> > > -	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
> > > +	WARN_ON(reg > ISL1208_REG_YRT);
> > > +	WARN_ON(reg + len > ISL1208_REG_YRT + 1);
> > > =20
> > >  	ret =3D i2c_transfer(client->adapter, msgs, 2);
> > >  	if (ret > 0)
> > > @@ -104,8 +128,8 @@ isl1208_i2c_set_regs(struct i2c_client *client, u=
8 reg, u8 const buf[],
> > >  	};
> > >  	int ret;
> > > =20
> > > -	BUG_ON(reg > ISL1208_REG_USR2);
> > > -	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
> > > +	WARN_ON(reg > ISL1208_REG_YRT);
> > > +	WARN_ON(reg + len > ISL1208_REG_YRT + 1);
> > > =20
> > >  	i2c_buf[0] =3D reg;
> > >  	memcpy(&i2c_buf[1], &buf[0], len);
> > > @@ -493,12 +517,128 @@ isl1208_rtc_set_alarm(struct device *dev, stru=
ct rtc_wkalrm *alarm)
> > >  	return isl1208_i2c_set_alarm(to_i2c_client(dev), alarm);
> > >  }
> > > =20
> > > +static ssize_t isl1208_hwmon_show_tamper(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct i2c_client *client =3D dev_get_drvdata(dev);
> > > +	int sr;
> > > +
> > > +	sr =3D isl1208_i2c_get_sr(client);
> > > +	if (sr < 0) {
> > > +		dev_err(dev, "%s: reading SR failed\n", __func__);
> > > +		return sr;
> > > +	}
> > > +
> > > +	if (sr & ISL1208_REG_SR_EVT)
> > > +		return sprintf(buf, "1\n");
> > > +
> > > +	return sprintf(buf, "0\n");
> > > +};
> > > +
> > > +static ssize_t isl1208_hwmon_clear_caseopen(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t count)
> > > +{
> > > +	struct i2c_client *client =3D dev_get_drvdata(dev);
> > > +	unsigned long val;
> > > +	int sr;
> > > +
> > > +	if (kstrtoul(buf, 10, &val) || val !=3D 0)
> > > +		return -EINVAL;
> > > +
> > > +	sr =3D isl1208_i2c_get_sr(client);
> > > +	if (sr < 0) {
> > > +		dev_err(dev, "%s: reading SR failed\n", __func__);
> > > +		return sr;
> > > +	}
> > > +
> > > +	sr &=3D ~ISL1208_REG_SR_EVT;
> > > +
> > > +	sr =3D i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);
> > > +	if (sr < 0)
> > > +		dev_err(dev, "%s: writing SR failed\n",
> > > +			__func__);
> > > +
> > > +	return count;
> > > +};
> > > +
> > > +static ssize_t isl1208_hwmon_show_tamper_timestamp(struct device *de=
v,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct i2c_client *client =3D dev_get_drvdata(dev);
> > > +	u8 regs[ISL1208_EVT_SECTION_LEN] =3D { 0, };
> > > +	struct timespec64 tv64;
> > > +	struct rtc_time tm;
> > > +	int sr;
> > > +
> > > +	sr =3D isl1208_i2c_get_sr(client);
> > > +	if (sr < 0) {
> > > +		dev_err(dev, "%s: reading SR failed\n", __func__);
> > > +		return sr;
> > > +	}
> > > +
> > > +	if (!(sr & ISL1208_REG_SR_EVT))
> > > +		return 0;
> > > +
> > > +	sr =3D isl1208_i2c_read_regs(client, ISL1208_REG_SCT, regs,
> > > +				   ISL1208_EVT_SECTION_LEN);
> > > +	if (sr < 0) {
> > > +		dev_err(dev, "%s: reading event section failed\n",
> > > +			__func__);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* MSB of each alarm register is an enable bit */
> > > +	tm.tm_sec =3D bcd2bin(regs[ISL1208_REG_SCT - ISL1208_REG_SCT] & 0x7=
f);
> > > +	tm.tm_min =3D bcd2bin(regs[ISL1208_REG_MNT - ISL1208_REG_SCT] & 0x7=
f);
> > > +	tm.tm_hour =3D bcd2bin(regs[ISL1208_REG_HRT - ISL1208_REG_SCT] & 0x=
3f);
> > > +	tm.tm_mday =3D bcd2bin(regs[ISL1208_REG_DTT - ISL1208_REG_SCT] & 0x=
3f);
> > > +	tm.tm_mon =3D
> > > +		bcd2bin(regs[ISL1208_REG_MOT - ISL1208_REG_SCT] & 0x1f) - 1;
> > > +	tm.tm_year =3D bcd2bin(regs[ISL1208_REG_YRT - ISL1208_REG_SCT]) + 1=
00;
> > > +
> > > +	tv64.tv_sec =3D rtc_tm_to_time64(&tm);
> > > +
> > > +	return sprintf(buf,
> > > +		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
> > > +		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> > > +		tm.tm_hour, tm.tm_min, tm.tm_sec,
> > > +		(long long) tv64.tv_sec);
> > > +};
> > > +
> > > +static SENSOR_DEVICE_ATTR(intrusion0_alarm, 0644, isl1208_hwmon_show=
_tamper,
> > > +			isl1208_hwmon_clear_caseopen, 0);
> > > +
> > > +static SENSOR_DEVICE_ATTR(intrusion0_timestamp, 0444,
> > > +		isl1208_hwmon_show_tamper_timestamp, NULL, 0);
> > > +
> > > +static struct attribute *isl1208_hwmon_attrs[] =3D {
> > > +	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
> > > +	&sensor_dev_attr_intrusion0_timestamp.dev_attr.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(isl1208_hwmon);
> > > +
> > > +static void isl1208_hwmon_register(struct i2c_client *client)
> > > +{
> > > +	struct isl1208 *isl1208 =3D i2c_get_clientdata(client);
> > > +
> > > +	isl1208->hwmon =3D devm_hwmon_device_register_with_groups(&client->=
dev,
> > > +						client->name,
> > > +						client, isl1208_hwmon_groups);
> > > +	if (IS_ERR(isl1208->hwmon)) {
> > > +		dev_warn(&client->dev,
> > > +			"unable to register hwmon device %ld\n",
> > > +			PTR_ERR(isl1208->hwmon));
> > > +	}
> > > +}
> > > +
> > >  static irqreturn_t
> > >  isl1208_rtc_interrupt(int irq, void *data)
> > >  {
> > >  	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
> > >  	struct i2c_client *client =3D data;
> > > -	struct rtc_device *rtc =3D i2c_get_clientdata(client);
> > > +	struct isl1208 *isl1208 =3D i2c_get_clientdata(client);
> > >  	int handled =3D 0, sr, err;
> > > =20
> > >  	/*
> > > @@ -521,7 +661,7 @@ isl1208_rtc_interrupt(int irq, void *data)
> > >  	if (sr & ISL1208_REG_SR_ALM) {
> > >  		dev_dbg(&client->dev, "alarm!\n");
> > > =20
> > > -		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> > > +		rtc_update_irq(isl1208->rtc, 1, RTC_IRQF | RTC_AF);
> > > =20
> > >  		/* Clear the alarm */
> > >  		sr &=3D ~ISL1208_REG_SR_ALM;
> > > @@ -538,6 +678,13 @@ isl1208_rtc_interrupt(int irq, void *data)
> > >  			return err;
> > >  	}
> > > =20
> > > +	if (isl1208->hwmon && (sr & ISL1208_REG_SR_EVT)) {
> > > +		sysfs_notify(&isl1208->hwmon->kobj, NULL,
> > > +			sensor_dev_attr_intrusion0_alarm.dev_attr.attr.name);
> > > +		dev_warn(&client->dev, "event detected");
> > > +		handled =3D 1;
> > > +	}
> > > +
> > >  	return handled ? IRQ_HANDLED : IRQ_NONE;
> > >  }
> > > =20
> > > @@ -627,7 +774,7 @@ static int
> > >  isl1208_probe(struct i2c_client *client, const struct i2c_device_id =
*id)
> > >  {
> > >  	int rc =3D 0;
> > > -	struct rtc_device *rtc;
> > > +	struct isl1208 *isl1208;
> > > =20
> > >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > >  		return -ENODEV;
> > > @@ -635,13 +782,19 @@ isl1208_probe(struct i2c_client *client, const =
struct i2c_device_id *id)
> > >  	if (isl1208_i2c_validate_client(client) < 0)
> > >  		return -ENODEV;
> > > =20
> > > -	rtc =3D devm_rtc_device_register(&client->dev, isl1208_driver.drive=
r.name,
> > > +	isl1208 =3D devm_kzalloc(&client->dev, sizeof(struct isl1208),
> > > +				GFP_KERNEL);
> > > +	if (!isl1208)
> > > +		return -ENOMEM;
> > > +
> > > +	isl1208->rtc =3D devm_rtc_device_register(&client->dev,
> > > +				  isl1208_driver.driver.name,
> > >  				  &isl1208_rtc_ops,
> > >  				  THIS_MODULE);
> > > -	if (IS_ERR(rtc))
> > > -		return PTR_ERR(rtc);
> > > +	if (IS_ERR(isl1208->rtc))
> > > +		return PTR_ERR(isl1208->rtc);
> > > =20
> > > -	i2c_set_clientdata(client, rtc);
> > > +	i2c_set_clientdata(client, isl1208);
> > > =20
> > >  	rc =3D isl1208_i2c_get_sr(client);
> > >  	if (rc < 0) {
> > > @@ -657,6 +810,15 @@ isl1208_probe(struct i2c_client *client, const s=
truct i2c_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > > =20
> > > +	if (id->driver_data =3D=3D TYPE_ISL1219) {
> > > +		rc =3D i2c_smbus_write_byte_data(client, ISL1208_REG_09, 0x10);
> > > +		if (rc < 0) {
> > > +			dev_err(&client->dev, "could not enable tamper detection\n");
> > > +			return rc;
> > > +		}
> > > +		isl1208_hwmon_register(client);
> > > +	}
> > > +
> > >  	if (client->irq > 0) {
> > >  		rc =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > >  					       isl1208_rtc_interrupt,
> > > @@ -686,8 +848,9 @@ isl1208_remove(struct i2c_client *client)
> > >  }
> > > =20
> > >  static const struct i2c_device_id isl1208_id[] =3D {
> > > -	{ "isl1208", 0 },
> > > -	{ "isl1218", 0 },
> > > +	{ "isl1208", TYPE_ISL1208 },
> > > +	{ "isl1218", TYPE_ISL1218 },
> > > +	{ "isl1219", TYPE_ISL1219 },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, isl1208_id);
> > > @@ -695,6 +858,7 @@ MODULE_DEVICE_TABLE(i2c, isl1208_id);
> > >  static const struct of_device_id isl1208_of_match[] =3D {
> > >  	{ .compatible =3D "isil,isl1208" },
> > >  	{ .compatible =3D "isil,isl1218" },
> > > +	{ .compatible =3D "isil,isl1219" },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, isl1208_of_match);
> > > --=20
> > > 2.11.0
> > >=20
> >=20
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--nsd6et7i2p43twdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAlpod5YACgkQC+njFXoe
LGTc6BAAx0XGThYoHQ+3JIOaRwE5+p8m2I84237t5BqJMcc0tXFRcz7joAMW5G7V
FHLUpKOzdNvxKG2crorur5/i4F2I+QmvhO8AGxvDqZOV9OXopWEEdEXdh+w5x93z
smQ4u+PbIGesIGgrNq6G0hYJHCI7TZPJGWlaSZ7i4vn++zCMgRphS2k1J82Sa0lc
mH9qcRp/oVPyhvHLZcCBbMX1Lif1Y6odfu2020L3VcztkFKma4PRRCxO0VQ+2bUY
ZiyKulL7vq1ldi0OOn4fyPK9J7dxK2anjNxXk23zVodDmcD/5iFcrPWEfdBFnQm0
uWZO1XOGrFlpftX4egMb+PUd0c4Fj2ynP/cnCUhWocdVdCBgJv8HO9/8kSGS8MsC
3tmtYSS0pHLLoFZ1TzOvoK5eJ+eE+j1CRTbapkXrZK4hXxItRHgMRtzCZJWwCQj0
qTCJ1QeMuIIXPbXQLSZO8JYyXYJxCNWwIqidyuksvM+fucg42hCM4iQZeqJI7IYz
fGyMaBxnLp9O+R8RL0ElhLKk+iBToTOt4Ynk4/prsfN7K/dXFtI/sGr3cQG4Q1BD
2XwVMqN7kQ8Oz47Qak51XK2VCHJVGDrSLscFOAutBhzbGw+y2RaAvIHAH5sYu7ej
GIryl1ZTEV/kAisC9akVxoOKCmoqmx0v3Ln85yKlWVkpUetpXoQ=
=pFja
-----END PGP SIGNATURE-----

--nsd6et7i2p43twdo--
