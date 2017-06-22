Return-Path: <yesipov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170621222421.GA23791@roeck-us.net>
References: <1498056583-16551-1-git-send-email-yesipov@gmail.com> <20170621222421.GA23791@roeck-us.net>
From: Kirill Esipov <yesipov@gmail.com>
Date: Thu, 22 Jun 2017 15:07:42 +0300
Message-ID: <CAJcpCzGWiRRY2gZzNZVJOG2oLTsGjh9+DCn=vuY1A0szZf2Vjw@mail.gmail.com>
Subject: Re: rtc: ds3232: add temperature support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@free-electrons.com,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c03cd5ef9459405528b54b7"
List-ID: <linux-rtc.vger.kernel.org>

--94eb2c03cd5ef9459405528b54b7
Content-Type: text/plain; charset="UTF-8"

2017-06-22 1:24 GMT+03:00 Guenter Roeck <linux@roeck-us.net>:

> On Wed, Jun 21, 2017 at 05:49:43PM +0300, Kirill Esipov wrote:
> > DS3232/DS3234 has the temperature registers with a resolution of
> > 0.25 degree celsius. This enables to get the value through hwmon.
> >
> >       # cat /sys/class/hwmon/hwmon0/temp1_input
> >       37250
> >
> > Signed-off-by: Kirill Esipov <yesipov@gmail.com>
> > ---
> >  drivers/rtc/Kconfig      |  9 ++++++
> >  drivers/rtc/rtc-ds3232.c | 84 ++++++++++++++++++++++++++++++
> ++++++++++++++++++
> >  2 files changed, 93 insertions(+)
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 8d3b95728326..b4a6a916d4df 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -791,6 +791,15 @@ config RTC_DRV_DS3232
> >         This driver can also be built as a module.  If so, the module
> >         will be called rtc-ds3232.
> >
> > +config RTC_DRV_DS3232_HWMON
> > +     bool "HWMON support for Dallas/Maxim DS3232/DS3234"
> > +     depends on RTC_DRV_DS3232 && HWMON
> > +     depends on !(RTC_DRV_DS3232=y && HWMON=m)
> > +     default y
> > +     help
> > +       Say Y here if you want to expose temperature sensor data on
> > +       rtc-ds3232
> > +
> >  config RTC_DRV_PCF2127
> >       tristate "NXP PCF2127"
> >       depends on RTC_I2C_AND_SPI
> > diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> > index deff431a37c4..f94ff0685942 100644
> > --- a/drivers/rtc/rtc-ds3232.c
> > +++ b/drivers/rtc/rtc-ds3232.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/bcd.h>
> >  #include <linux/slab.h>
> >  #include <linux/regmap.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> >
> >  #define DS3232_REG_SECONDS      0x00
> >  #define DS3232_REG_MINUTES      0x01
> > @@ -275,6 +277,86 @@ static int ds3232_update_alarm(struct device *dev,
> unsigned int enabled)
> >       return ret;
> >  }
> >
> > +/*---------------------------------------------------------
> -------------*/
> > +
> > +#ifdef CONFIG_RTC_DRV_DS3232_HWMON
> > +
> > +/*
> > + * Temperature sensor support for ds3232/ds3234 devices.
> > + */
> > +
> > +#define DS3232_REG_TEMPERATURE       0x11
> > +
> > +/*
> > + * A user-initiated temperature conversion is not started by this
> function,
> > + * so the temperature is updated once every 64 seconds.
> > + */
> > +static int ds3232_hwmon_read_temp(struct device *dev, s32 *mC)
> > +{
> > +     struct ds3232 *ds3232 = dev_get_drvdata(dev);
> > +     u8 temp_buf[2];
> > +     s16 temp;
> > +     int ret;
> > +
> > +     ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE,
> temp_buf,
> > +                             sizeof(temp_buf));
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * Temperature is represented as a 10-bit code with a resolution of
> > +      * 0.25 degree celsius and encoded in two's complement format.
> > +      */
> > +     temp = (temp_buf[0] << 8) | temp_buf[1];
> > +     temp >>= 6;
> > +     *mC = temp * 250;
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t ds3232_hwmon_show_temp(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +     int ret;
> > +     s32 temp;
> > +
> > +     ret = ds3232_hwmon_read_temp(dev, &temp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return sprintf(buf, "%d\n", temp);
> > +}
> > +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3232_hwmon_show_temp,
> > +                     NULL, 0);
> > +
> > +static struct attribute *ds3232_hwmon_attrs[] = {
> > +     &sensor_dev_attr_temp1_input.dev_attr.attr,
> > +     NULL,
> > +};
> > +ATTRIBUTE_GROUPS(ds3232_hwmon);
> > +
> > +static void ds3232_hwmon_register(struct device *dev, const char *name)
> > +{
> > +     struct ds3232 *ds3232 = dev_get_drvdata(dev);
> > +     struct device *hwmon_dev;
> > +
> > +     hwmon_dev = devm_hwmon_device_register_with_groups(dev, name,
> ds3232,
> > +
> ds3232_hwmon_groups);
>
> Any reason for not using devm_hwmon_device_register_with_info() ?
>
>

Just to keep uniformity,  because other rtc drivers with hwmon (rtc-ds1307,
rtc-rv3029c2) use
devm_hwmon_device_register_with_groups().




> Guenter
>
> > +     if (IS_ERR(hwmon_dev)) {
> > +             dev_warn(dev, "unable to register hwmon device %ld\n",
> > +                      PTR_ERR(hwmon_dev));
> > +     }
> > +}
> > +
> > +#else
> > +
> > +static void ds3232_hwmon_register(struct ds3232 *ds3232)
> > +{
> > +}
> > +
> > +#endif
> > +
> >  static int ds3232_alarm_irq_enable(struct device *dev, unsigned int
> enabled)
> >  {
> >       struct ds3232 *ds3232 = dev_get_drvdata(dev);
> > @@ -366,6 +448,8 @@ static int ds3232_probe(struct device *dev, struct
> regmap *regmap, int irq,
> >       if (ds3232->irq > 0)
> >               device_init_wakeup(dev, 1);
> >
> > +     ds3232_hwmon_register(dev, name);
> > +
> >       ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
> >                                               THIS_MODULE);
> >       if (IS_ERR(ds3232->rtc))
>



-- 
Kirill Esipov

--94eb2c03cd5ef9459405528b54b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-06-22 1:24 GMT+03:00 Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D=
"gmail-HOEnZb"><div class=3D"gmail-h5">On Wed, Jun 21, 2017 at 05:49:43PM +=
0300, Kirill Esipov wrote:<br>
&gt; DS3232/DS3234 has the temperature registers with a resolution of<br>
&gt; 0.25 degree celsius. This enables to get the value through hwmon.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# cat /sys/class/hwmon/hwmon0/temp1_<wbr>inp=
ut<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A037250<br>
&gt;<br>
&gt; Signed-off-by: Kirill Esipov &lt;<a href=3D"mailto:yesipov@gmail.com">=
yesipov@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/rtc/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++<br>
&gt;=C2=A0 drivers/rtc/rtc-ds3232.c | 84 ++++++++++++++++++++++++++++++<wbr=
>++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 93 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig<br>
&gt; index 8d3b95728326..b4a6a916d4df 100644<br>
&gt; --- a/drivers/rtc/Kconfig<br>
&gt; +++ b/drivers/rtc/Kconfig<br>
&gt; @@ -791,6 +791,15 @@ config RTC_DRV_DS3232<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a mo=
dule.=C2=A0 If so, the module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called rtc-ds3232.<br>
&gt;<br>
&gt; +config RTC_DRV_DS3232_HWMON<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;HWMON support for Dallas/Maxim DS3232/=
DS3234&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on RTC_DRV_DS3232 &amp;&amp; HWMON<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on !(RTC_DRV_DS3232=3Dy &amp;&amp; HWMON=
=3Dm)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default y<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you want to expose temperatu=
re sensor data on<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rtc-ds3232<br>
&gt; +<br>
&gt;=C2=A0 config RTC_DRV_PCF2127<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;NXP PCF2127&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on RTC_I2C_AND_SPI<br>
&gt; diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c<br>
&gt; index deff431a37c4..f94ff0685942 100644<br>
&gt; --- a/drivers/rtc/rtc-ds3232.c<br>
&gt; +++ b/drivers/rtc/rtc-ds3232.c<br>
&gt; @@ -22,6 +22,8 @@<br>
&gt;=C2=A0 #include &lt;linux/bcd.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/slab.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/regmap.h&gt;<br>
&gt; +#include &lt;linux/hwmon.h&gt;<br>
&gt; +#include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt;<br>
&gt;=C2=A0 #define DS3232_REG_SECONDS=C2=A0 =C2=A0 =C2=A0 0x00<br>
&gt;=C2=A0 #define DS3232_REG_MINUTES=C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; @@ -275,6 +277,86 @@ static int ds3232_update_alarm(struct device *dev=
, unsigned int enabled)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +/*---------------------------<wbr>------------------------------<wbr>=
-------------*/<br>
&gt; +<br>
&gt; +#ifdef CONFIG_RTC_DRV_DS3232_HWMON<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Temperature sensor support for ds3232/ds3234 devices.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define DS3232_REG_TEMPERATURE=C2=A0 =C2=A0 =C2=A0 =C2=A00x11<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * A user-initiated temperature conversion is not started by this fun=
ction,<br>
&gt; + * so the temperature is updated once every 64 seconds.<br>
&gt; + */<br>
&gt; +static int ds3232_hwmon_read_temp(struct device *dev, s32 *mC)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct ds3232 *ds3232 =3D dev_get_drvdata(dev);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 temp_buf[2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0s16 temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regmap_bulk_read(ds3232-&gt;<wbr>regmap, =
DS3232_REG_TEMPERATURE, temp_buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(temp_buf));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Temperature is represented as a 10-bit code wi=
th a resolution of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 0.25 degree celsius and encoded in two&#39;s c=
omplement format.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0temp =3D (temp_buf[0] &lt;&lt; 8) | temp_buf[1];<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0temp &gt;&gt;=3D 6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*mC =3D temp * 250;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t ds3232_hwmon_show_temp(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr, char *buf=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0s32 temp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D ds3232_hwmon_read_temp(dev, &amp;temp);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%d\n&quot;, temp);<br>
&gt; +}<br>
&gt; +static SENSOR_DEVICE_ATTR(temp1_<wbr>input, S_IRUGO, ds3232_hwmon_sho=
w_temp,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NULL, 0);<br>
&gt; +<br>
&gt; +static struct attribute *ds3232_hwmon_attrs[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&amp;sensor_dev_attr_temp1_input.<wbr>dev_attr.at=
tr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt; +};<br>
&gt; +ATTRIBUTE_GROUPS(ds3232_<wbr>hwmon);<br>
&gt; +<br>
&gt; +static void ds3232_hwmon_register(struct device *dev, const char *nam=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct ds3232 *ds3232 =3D dev_get_drvdata(dev);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *hwmon_dev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hwmon_dev =3D devm_hwmon_device_register_<wbr>wit=
h_groups(dev, name, ds3232,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ds3232_hwmon_groups);<=
br>
<br>
</div></div>Any reason for not using devm_hwmon_device_register_<wbr>with_i=
nfo() ?<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br></div><div><br></div><div>Just to keep uniformity,=C2=A0 =
because other rtc drivers with hwmon (rtc-ds1307, rtc-rv3029c2) use=C2=A0</=
div><div>devm_hwmon_device_register_<wbr>with_groups().</div><div><br></div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#888888">
Guenter<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(hwmon_dev)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(dev, &quot;u=
nable to register hwmon device %ld\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PTR_ERR(hwmon_dev));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +#else<br>
&gt; +<br>
&gt; +static void ds3232_hwmon_register(struct ds3232 *ds3232)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 static int ds3232_alarm_irq_enable(struct device *dev, unsigned =
int enabled)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ds3232 *ds3232 =3D dev_get_drvdata(de=
v);<br>
&gt; @@ -366,6 +448,8 @@ static int ds3232_probe(struct device *dev, struct=
 regmap *regmap, int irq,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ds3232-&gt;irq &gt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_init_wake=
up(dev, 1);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ds3232_hwmon_register(dev, name);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ds3232-&gt;rtc =3D devm_rtc_device_register(=
dev, name, &amp;ds3232_rtc_ops,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0THIS_MODULE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(ds3232-&gt;rtc))<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div>Kirill Esipov</div></d=
iv></div>
</div></div>

--94eb2c03cd5ef9459405528b54b7--
