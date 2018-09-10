Return-Path: <jgebben@sweptlaser.com>
MIME-Version: 1.0
References: <20180907151744.32634-1-jgebben@sweptlaser.com> <20180908150957.GD2598@piout.net>
In-Reply-To: <20180908150957.GD2598@piout.net>
From: Jeremy Gebben <jgebben@sweptlaser.com>
Date: Mon, 10 Sep 2018 10:39:21 -0600
Message-ID: <CAB48C-pVeDLGSGK6reWgrrqkeJhQv-R75E2Gh=bA6itOchQtbA@mail.gmail.com>
Subject: Re: [PATCH] rtc: abx80x: add basic watchdog support
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000007fdd8a05758700a4"
List-ID: <linux-rtc.vger.kernel.org>

--0000000000007fdd8a05758700a4
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 8, 2018 at 9:10 AM Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

> Hi,
>
> Please Cc the watchdog maintainers. Else, I have very few comments.
>

Sure, I'll add them on the next version.



> On 07/09/2018 09:17:43-0600, Jeremy Gebben wrote:
> > The abx804 and abx805 chips have support for a simple watchdog
> > function that can trigger an external reset.
> >
> > Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
> > ---
> >  drivers/rtc/Kconfig      |  11 +++
> >  drivers/rtc/rtc-abx80x.c | 160 ++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 159 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 7d7be60a2413..4771e3a89721 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -195,6 +195,17 @@ config RTC_DRV_ABX80X
> >         This driver can also be built as a module. If so, the module
> >         will be called rtc-abx80x.
> >
> > +config RTC_DRV_ABX80X_WDT
> > +     bool "Abracon ABx80x Watchdog"
> > +     default y
> > +     depends on RTC_DRV_ABX80X
> > +     help
> > +       If you say yes here you get watchdog support for Abracon ABX804
> and ABX805
> > +       clock chips. This watchdog supports timeouts up to 31 seconds
> with 1 second
> > +       granularity.
> > +
> > +          This watchdog device is part of the rtc-abx80x module.
> > +
>
> I'm not sure it is worth having a separate config option for that. You
> may as well just always include the watchdog support code. However,
> doesn't it need to depend on CONFIG_WATCHDOG?
>

Yes, you're right about CONFIG_WATCHDOG, I thought I had that already but I
guess it got dropped.



> >  config RTC_DRV_AC100
> >       tristate "X-Powers AC100"
> >       depends on MFD_AC100
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 2cefa67a1132..fa558939e944 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/rtc.h>
> > +#include <linux/watchdog.h>
> >
> >  #define ABX8XX_REG_HTH               0x00
> >  #define ABX8XX_REG_SC                0x01
> > @@ -37,6 +38,7 @@
> >
> >  #define ABX8XX_REG_STATUS    0x0f
> >  #define ABX8XX_STATUS_AF     BIT(2)
> > +#define ABX8XX_STATUS_WDT    BIT(6)
> >
> >  #define ABX8XX_REG_CTRL1     0x10
> >  #define ABX8XX_CTRL_WRITE    BIT(0)
> > @@ -61,6 +63,14 @@
> >  #define ABX8XX_OSS_OF                BIT(1)
> >  #define ABX8XX_OSS_OMODE     BIT(4)
> >
> > +#define ABX8XX_REG_WDT               0x1b
> > +#define ABX8XX_WDT_WDS               BIT(7)
> > +#define ABX8XX_WDT_BMB_MASK  0x7c
> > +#define ABX8XX_WDT_BMB_SHIFT 2
> > +#define ABX8XX_WDT_MAX_TIME  (ABX8XX_WDT_BMB_MASK >>
> ABX8XX_WDT_BMB_SHIFT)
> > +#define ABX8XX_WDT_WRB_MASK  0x03
> > +#define ABX8XX_WDT_WRB_1HZ   0x02
> > +
> >  #define ABX8XX_REG_CFG_KEY   0x1f
> >  #define ABX8XX_CFG_KEY_OSC   0xa1
> >  #define ABX8XX_CFG_KEY_MISC  0x9d
> > @@ -80,20 +90,27 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
> >  struct abx80x_cap {
> >       u16 pn;
> >       bool has_tc;
> > +     bool has_wdog;
> >  };
> >
> >  static struct abx80x_cap abx80x_caps[] = {
> >       [AB0801] = {.pn = 0x0801},
> >       [AB0803] = {.pn = 0x0803},
> > -     [AB0804] = {.pn = 0x0804, .has_tc = true},
> > -     [AB0805] = {.pn = 0x0805, .has_tc = true},
> > +     [AB0804] = {.pn = 0x0804, .has_tc = true, .has_wdog = true},
> > +     [AB0805] = {.pn = 0x0805, .has_tc = true, .has_wdog = true},
> >       [AB1801] = {.pn = 0x1801},
> >       [AB1803] = {.pn = 0x1803},
> > -     [AB1804] = {.pn = 0x1804, .has_tc = true},
> > -     [AB1805] = {.pn = 0x1805, .has_tc = true},
> > +     [AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
> > +     [AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
> >       [ABX80X] = {.pn = 0}
> >  };
> >
> > +struct abx80x_priv {
> > +     struct rtc_device *rtc;
> > +     struct i2c_client *client;
> > +     struct watchdog_device wdog;
> > +};
> > +
>
> To make the watchdog part easier to review, you could separate the
> introduction of abx80x_priv in a preliminary patch and then introduce
> the watchdog code.
>

Ok.

>  static int abx80x_is_rc_mode(struct i2c_client *client)
> >  {
> >       int flags = 0;
> > @@ -218,7 +235,8 @@ static int abx80x_rtc_set_time(struct device *dev,
> struct rtc_time *tm)
> >  static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
> >  {
> >       struct i2c_client *client = dev_id;
> > -     struct rtc_device *rtc = i2c_get_clientdata(client);
> > +     struct abx80x_priv *priv = i2c_get_clientdata(client);
> > +     struct rtc_device *rtc = priv->rtc;
> >       int status;
> >
> >       status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> > @@ -228,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void
> *dev_id)
> >       if (status & ABX8XX_STATUS_AF)
> >               rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
> >
> > +     /*
> > +      * It is unclear if we'll get an interrupt before the external
> > +      * reset kicks in.
> > +      */
> > +     if (status & ABX8XX_STATUS_WDT)
> > +             dev_err(&client->dev, "watchdog timeout interrupt!\n");
> > +
>
> dev_alert maybe?
>


Ok.

Thanks,

Jeremy


>
> >       i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
> >
> >       return IRQ_HANDLED;
> > @@ -529,11 +554,110 @@ static void rtc_calib_remove_sysfs_group(void
> *_dev)
> >       sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
> >  }
> >
> > +#ifdef CONFIG_RTC_DRV_ABX80X_WDT
> > +
> > +static inline u8 timeout_bits(unsigned int timeout)
> > +{
> > +     return ((timeout << ABX8XX_WDT_BMB_SHIFT) & ABX8XX_WDT_BMB_MASK) |
> > +              ABX8XX_WDT_WRB_1HZ;
> > +}
> > +
> > +static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> > +                                 unsigned int timeout)
> > +{
> > +     struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
> > +     u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
> > +
> > +     /*
> > +      * Writing any timeout to the WDT register resets the watchdog
> timer.
> > +      * Writing 0 disables it.
> > +      */
> > +     return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT,
> val);
> > +}
> > +
> > +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
> > +                             unsigned int new_timeout)
> > +{
> > +     int err = __abx80x_wdog_set_timeout(wdog, new_timeout);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     wdog->timeout = new_timeout;
> > +     return 0;
> > +}
> > +
> > +static int abx80x_wdog_ping(struct watchdog_device *wdog)
> > +{
> > +     return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> > +}
> > +
> > +static int abx80x_wdog_start(struct watchdog_device *wdog)
> > +{
> > +     int err = __abx80x_wdog_set_timeout(wdog, wdog->timeout);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     set_bit(WDOG_HW_RUNNING, &wdog->status);
> > +     return 0;
> > +}
> > +
> > +static int abx80x_wdog_stop(struct watchdog_device *wdog)
> > +{
> > +     int err = __abx80x_wdog_set_timeout(wdog, 0);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     clear_bit(WDOG_HW_RUNNING, &wdog->status);
> > +     return 0;
> > +}
> > +
> > +static const struct watchdog_info abx80x_wdog_info = {
> > +     .identity = "abx80x watchdog",
> > +     .options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> WDIOF_MAGICCLOSE,
> > +};
> > +
> > +static const struct watchdog_ops abx80x_wdog_ops = {
> > +     .owner = THIS_MODULE,
> > +     .start = abx80x_wdog_start,
> > +     .stop = abx80x_wdog_stop,
> > +     .ping = abx80x_wdog_ping,
> > +     .set_timeout = abx80x_wdog_set_timeout,
> > +};
> > +
> > +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> > +{
> > +     int err;
> > +
> > +     priv->wdog.ops = &abx80x_wdog_ops;
> > +     priv->wdog.info = &abx80x_wdog_info;
> > +     priv->wdog.min_timeout = 1;
> > +     priv->wdog.max_timeout = ABX8XX_WDT_MAX_TIME;
> > +
> > +     err = devm_watchdog_register_device(&priv->client->dev,
> > +                                         &priv->wdog);
> > +     if (err)
> > +             return err;
> > +
> > +     watchdog_set_drvdata(&priv->wdog, priv);
> > +     watchdog_init_timeout(&priv->wdog, ABX8XX_WDT_MAX_TIME,
> > +                           &priv->client->dev);
> > +     return 0;
> > +}
> > +#else
> > +static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >  static int abx80x_probe(struct i2c_client *client,
> >                       const struct i2c_device_id *id)
> >  {
> >       struct device_node *np = client->dev.of_node;
> > -     struct rtc_device *rtc;
> > +     struct abx80x_priv *priv;
> >       int i, data, err, trickle_cfg = -EINVAL;
> >       char buf[7];
> >       unsigned int part = id->driver_data;
> > @@ -610,13 +734,25 @@ static int abx80x_probe(struct i2c_client *client,
> >       if (err)
> >               return err;
> >
> > -     rtc = devm_rtc_allocate_device(&client->dev);
> > -     if (IS_ERR(rtc))
> > -             return PTR_ERR(rtc);
> > +     priv = devm_kzalloc(&client->dev, sizeof(struct abx80x_priv),
> > +                         GFP_KERNEL);
> > +     if (priv == NULL)
> > +             return -ENOMEM;
> > +
> > +     priv->rtc = devm_rtc_allocate_device(&client->dev);
> > +     if (IS_ERR(priv->rtc))
> > +             return PTR_ERR(priv->rtc);
> >
> > -     rtc->ops = &abx80x_rtc_ops;
> > +     priv->rtc->ops = &abx80x_rtc_ops;
> > +     priv->client = client;
> >
> > -     i2c_set_clientdata(client, rtc);
> > +     i2c_set_clientdata(client, priv);
> > +
> > +     if (abx80x_caps[part].has_wdog) {
> > +             err = abx80x_setup_watchdog(priv);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> >       if (client->irq > 0) {
> >               dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
> > @@ -649,7 +785,7 @@ static int abx80x_probe(struct i2c_client *client,
> >               return err;
> >       }
> >
> > -     err = rtc_register_device(rtc);
> > +     err = rtc_register_device(priv->rtc);
> >
> >       return err;
> >  }
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

--0000000000007fdd8a05758700a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat=
, Sep 8, 2018 at 9:10 AM Alexandre Belloni &lt;<a href=3D"mailto:alexandre.=
belloni@bootlin.com">alexandre.belloni@bootlin.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
Please Cc the watchdog maintainers. Else, I have very few comments.<br></bl=
ockquote><div><br></div><div>Sure, I&#39;ll add them on the next version.=
=C2=A0</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 07/09/2018 09:17:43-0600, Jeremy Gebben wrote:<br>
&gt; The abx804 and abx805 chips have support for a simple watchdog<br>
&gt; function that can trigger an external reset.<br>
&gt; <br>
&gt; Signed-off-by: Jeremy Gebben &lt;<a href=3D"mailto:jgebben@sweptlaser.=
com" target=3D"_blank">jgebben@sweptlaser.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/rtc/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +++<br>
&gt;=C2=A0 drivers/rtc/rtc-abx80x.c | 160 +++++++++++++++++++++++++++++++++=
+++---<br>
&gt;=C2=A0 2 files changed, 159 insertions(+), 12 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig<br>
&gt; index 7d7be60a2413..4771e3a89721 100644<br>
&gt; --- a/drivers/rtc/Kconfig<br>
&gt; +++ b/drivers/rtc/Kconfig<br>
&gt; @@ -195,6 +195,17 @@ config RTC_DRV_ABX80X<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a mo=
dule. If so, the module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called rtc-abx80x.<br>
&gt;=C2=A0 <br>
&gt; +config RTC_DRV_ABX80X_WDT<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;Abracon ABx80x Watchdog&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default y<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on RTC_DRV_ABX80X<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes here you get watchdog suppo=
rt for Abracon ABX804 and ABX805<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0clock chips. This watchdog supports timeou=
ts up to 31 seconds with 1 second<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0granularity.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This watchdog device is part of th=
e rtc-abx80x module.<br>
&gt; +<br>
<br>
I&#39;m not sure it is worth having a separate config option for that. You<=
br>
may as well just always include the watchdog support code. However,<br>
doesn&#39;t it need to depend on CONFIG_WATCHDOG?<br></blockquote><div><br>=
</div><div>Yes, you&#39;re right about CONFIG_WATCHDOG, I thought I had tha=
t already but I guess it got dropped.<br></div><div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 config RTC_DRV_AC100<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;X-Powers AC100&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_AC100<br>
&gt; diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c<br>
&gt; index 2cefa67a1132..fa558939e944 100644<br>
&gt; --- a/drivers/rtc/rtc-abx80x.c<br>
&gt; +++ b/drivers/rtc/rtc-abx80x.c<br>
&gt; @@ -17,6 +17,7 @@<br>
&gt;=C2=A0 #include &lt;linux/i2c.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/module.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/rtc.h&gt;<br>
&gt; +#include &lt;linux/watchdog.h&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ABX8XX_REG_HTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x00<br>
&gt;=C2=A0 #define ABX8XX_REG_SC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x01<br>
&gt; @@ -37,6 +38,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ABX8XX_REG_STATUS=C2=A0 =C2=A0 0x0f<br>
&gt;=C2=A0 #define ABX8XX_STATUS_AF=C2=A0 =C2=A0 =C2=A0BIT(2)<br>
&gt; +#define ABX8XX_STATUS_WDT=C2=A0 =C2=A0 BIT(6)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ABX8XX_REG_CTRL1=C2=A0 =C2=A0 =C2=A00x10<br>
&gt;=C2=A0 #define ABX8XX_CTRL_WRITE=C2=A0 =C2=A0 BIT(0)<br>
&gt; @@ -61,6 +63,14 @@<br>
&gt;=C2=A0 #define ABX8XX_OSS_OF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(1)<br>
&gt;=C2=A0 #define ABX8XX_OSS_OMODE=C2=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt;=C2=A0 <br>
&gt; +#define ABX8XX_REG_WDT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x1b<br>
&gt; +#define ABX8XX_WDT_WDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(7)<br>
&gt; +#define ABX8XX_WDT_BMB_MASK=C2=A0 0x7c<br>
&gt; +#define ABX8XX_WDT_BMB_SHIFT 2<br>
&gt; +#define ABX8XX_WDT_MAX_TIME=C2=A0 (ABX8XX_WDT_BMB_MASK &gt;&gt; ABX8X=
X_WDT_BMB_SHIFT)<br>
&gt; +#define ABX8XX_WDT_WRB_MASK=C2=A0 0x03<br>
&gt; +#define ABX8XX_WDT_WRB_1HZ=C2=A0 =C2=A00x02<br>
&gt; +<br>
&gt;=C2=A0 #define ABX8XX_REG_CFG_KEY=C2=A0 =C2=A00x1f<br>
&gt;=C2=A0 #define ABX8XX_CFG_KEY_OSC=C2=A0 =C2=A00xa1<br>
&gt;=C2=A0 #define ABX8XX_CFG_KEY_MISC=C2=A0 0x9d<br>
&gt; @@ -80,20 +90,27 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,<=
br>
&gt;=C2=A0 struct abx80x_cap {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 pn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_tc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool has_wdog;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static struct abx80x_cap abx80x_caps[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AB0801] =3D {.pn =3D 0x0801},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AB0803] =3D {.pn =3D 0x0803},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[AB0804] =3D {.pn =3D 0x0804, .has_tc =3D true},<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0[AB0805] =3D {.pn =3D 0x0805, .has_tc =3D true},<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0[AB0804] =3D {.pn =3D 0x0804, .has_tc =3D true, .=
has_wdog =3D true},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[AB0805] =3D {.pn =3D 0x0805, .has_tc =3D true, .=
has_wdog =3D true},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AB1801] =3D {.pn =3D 0x1801},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AB1803] =3D {.pn =3D 0x1803},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[AB1804] =3D {.pn =3D 0x1804, .has_tc =3D true},<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0[AB1805] =3D {.pn =3D 0x1805, .has_tc =3D true},<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0[AB1804] =3D {.pn =3D 0x1804, .has_tc =3D true, .=
has_wdog =3D true},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[AB1805] =3D {.pn =3D 0x1805, .has_tc =3D true, .=
has_wdog =3D true},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[ABX80X] =3D {.pn =3D 0}<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +struct abx80x_priv {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rtc_device *rtc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct watchdog_device wdog;<br>
&gt; +};<br>
&gt; +<br>
<br>
To make the watchdog part easier to review, you could separate the<br>
introduction of abx80x_priv in a preliminary patch and then introduce<br>
the watchdog code.<br></blockquote><div><br></div><div>Ok.=C2=A0</div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 static int abx80x_is_rc_mode(struct i2c_client *client)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int flags =3D 0;<br>
&gt; @@ -218,7 +235,8 @@ static int abx80x_rtc_set_time(struct device *dev,=
 struct rtc_time *tm)<br>
&gt;=C2=A0 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_client *client =3D dev_id;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rtc_device *rtc =3D i2c_get_clientdata(cli=
ent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct abx80x_priv *priv =3D i2c_get_clientdata(c=
lient);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rtc_device *rtc =3D priv-&gt;rtc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D i2c_smbus_read_byte_data(client, =
ABX8XX_REG_STATUS);<br>
&gt; @@ -228,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, voi=
d *dev_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (status &amp; ABX8XX_STATUS_AF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtc_update_irq(r=
tc, 1, RTC_AF | RTC_IRQF);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * It is unclear if we&#39;ll get an interrupt be=
fore the external<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * reset kicks in.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (status &amp; ABX8XX_STATUS_WDT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;watchdog timeout interrupt!\n&quot;);<br>
&gt; +<br>
<br>
dev_alert maybe?<br></blockquote><div><br></div><div><br></div><div>Ok.</di=
v><div><br></div><div>Thanks,</div><div><br></div><div>Jeremy</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_smbus_write_byte_data(client, ABX8XX_REG=
_STATUS, 0);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; @@ -529,11 +554,110 @@ static void rtc_calib_remove_sysfs_group(void *=
_dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysfs_remove_group(&amp;dev-&gt;kobj, &amp;r=
tc_calib_attr_group);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#ifdef CONFIG_RTC_DRV_ABX80X_WDT<br>
&gt; +<br>
&gt; +static inline u8 timeout_bits(unsigned int timeout)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ((timeout &lt;&lt; ABX8XX_WDT_BMB_SHIFT) &=
amp; ABX8XX_WDT_BMB_MASK) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ABX8XX_WDT_WRB_1HZ;<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int timeout)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct abx80x_priv *priv =3D watchdog_get_drvdata=
(wdog);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 val =3D ABX8XX_WDT_WDS | timeout_bits(timeout)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Writing any timeout to the WDT register resets=
 the watchdog timer.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Writing 0 disables it.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return i2c_smbus_write_byte_data(priv-&gt;client,=
 ABX8XX_REG_WDT, val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int new_timeout)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D __abx80x_wdog_set_timeout(wdog, new_t=
imeout);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wdog-&gt;timeout =3D new_timeout;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int abx80x_wdog_ping(struct watchdog_device *wdog)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return __abx80x_wdog_set_timeout(wdog, wdog-&gt;t=
imeout);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int abx80x_wdog_start(struct watchdog_device *wdog)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D __abx80x_wdog_set_timeout(wdog, wdog-=
&gt;timeout);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0set_bit(WDOG_HW_RUNNING, &amp;wdog-&gt;status);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int abx80x_wdog_stop(struct watchdog_device *wdog)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D __abx80x_wdog_set_timeout(wdog, 0);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clear_bit(WDOG_HW_RUNNING, &amp;wdog-&gt;status);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct watchdog_info abx80x_wdog_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.identity =3D &quot;abx80x watchdog&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEO=
UT | WDIOF_MAGICCLOSE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct watchdog_ops abx80x_wdog_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.start =3D abx80x_wdog_start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.stop =3D abx80x_wdog_stop,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.ping =3D abx80x_wdog_ping,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.set_timeout =3D abx80x_wdog_set_timeout,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int abx80x_setup_watchdog(struct abx80x_priv *priv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;wdog.ops =3D &amp;abx80x_wdog_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;<a href=3D"http://wdog.info" rel=3D"nore=
ferrer" target=3D"_blank">wdog.info</a> =3D &amp;abx80x_wdog_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;wdog.min_timeout =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;wdog.max_timeout =3D ABX8XX_WDT_MAX_TIME=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D devm_watchdog_register_device(&amp;priv-&=
gt;client-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;priv-&gt;wdog);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_set_drvdata(&amp;priv-&gt;wdog, priv);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0watchdog_init_timeout(&amp;priv-&gt;wdog, ABX8XX_=
WDT_MAX_TIME,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;priv-&gt;client-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +#else<br>
&gt; +static int abx80x_setup_watchdog(struct abx80x_priv *priv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 static int abx80x_probe(struct i2c_client *client,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const struct i2c_device_id *id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D client-&gt;dev.of=
_node;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rtc_device *rtc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct abx80x_priv *priv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, data, err, trickle_cfg =3D -EINVAL;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[7];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int part =3D id-&gt;driver_data;<br=
>
&gt; @@ -610,13 +734,25 @@ static int abx80x_probe(struct i2c_client *clien=
t,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0rtc =3D devm_rtc_allocate_device(&amp;client-&gt;=
dev);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (IS_ERR(rtc))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(rtc);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv =3D devm_kzalloc(&amp;client-&gt;dev, sizeof=
(struct abx80x_priv),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (priv =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;rtc =3D devm_rtc_allocate_device(&amp;cl=
ient-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(priv-&gt;rtc))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(priv-&=
gt;rtc);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0rtc-&gt;ops =3D &amp;abx80x_rtc_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;rtc-&gt;ops =3D &amp;abx80x_rtc_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;client =3D client;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, rtc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, priv);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (abx80x_caps[part].has_wdog) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D abx80x_setup_=
watchdog(priv);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (client-&gt;irq &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;cl=
ient-&gt;dev, &quot;IRQ %d supplied\n&quot;, client-&gt;irq);<br>
&gt; @@ -649,7 +785,7 @@ static int abx80x_probe(struct i2c_client *client,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0err =3D rtc_register_device(rtc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D rtc_register_device(priv-&gt;rtc);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 }<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
<br>
-- <br>
Alexandre Belloni, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
</blockquote></div></div>

--0000000000007fdd8a05758700a4--
