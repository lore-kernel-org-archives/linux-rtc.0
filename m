Return-Path: <dirk.behme@gmail.com>
Date: Wed, 17 Feb 2016 08:55:50 -0800 (PST)
From: dirk.behme@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: alexandre.belloni@free-electrons.com,
	fixed-term.Oleksij.Rempel@de.bosch.com, dirk.behme@de.bosch.com
Message-Id: <4b26b8ab-7472-4299-afee-c5dcb0da7ed7@googlegroups.com>
In-Reply-To: <1454589920-32738-1-git-send-email-dirk.behme@de.bosch.com>
References: <1454589920-32738-1-git-send-email-dirk.behme@de.bosch.com>
Subject: Re: [PATCH] rtc: rv8803: convert spin_lock to mutex_lock
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_804_872376058.1455728150743"
List-ID: <rtc-linux.googlegroups.com>

------=_Part_804_872376058.1455728150743
Content-Type: multipart/alternative;
	boundary="----=_Part_805_301930943.1455728150744"

------=_Part_805_301930943.1455728150744
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Thursday, February 4, 2016 at 1:45:24 PM UTC+1, Dirk Behme wrote:
>
> From: Oleksij Rempel <fixed-term.O...@de.bosch.com <javascript:>> 
>
> Fix a scheduling while atomic issue caused by rv8803_set_time() 
> holding a spinlock during the call to i2c_smbus_read_byte_data(). 
>
> Signed-off-by: Oleksij Rempel <fixed-term.O...@de.bosch.com <javascript:>> 
>
>


Any further comments on this? Or could the be applied?

Best regards

Dirk

 

> --- 
>  drivers/rtc/rtc-rv8803.c | 40 +++++++++++++++++++--------------------- 
>  1 file changed, 19 insertions(+), 21 deletions(-) 
>
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c 
> index 33c7e2a..38621ff 100644 
> --- a/drivers/rtc/rtc-rv8803.c 
> +++ b/drivers/rtc/rtc-rv8803.c 
> @@ -52,7 +52,7 @@ 
>  struct rv8803_data { 
>          struct i2c_client *client; 
>          struct rtc_device *rtc; 
> -        spinlock_t flags_lock; 
> +        struct mutex flags_lock; 
>          u8 ctrl; 
>  }; 
>   
> @@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
> *dev_id) 
>          unsigned long events = 0; 
>          u8 flags; 
>   
> -        spin_lock(&rv8803->flags_lock); 
> +        mutex_lock(&rv8803->flags_lock); 
>   
>          flags = i2c_smbus_read_byte_data(client, RV8803_FLAG); 
>          if (flags <= 0) { 
> -                spin_unlock(&rv8803->flags_lock); 
> +                mutex_unlock(&rv8803->flags_lock); 
>                  return IRQ_NONE; 
>          } 
>   
> @@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
> *dev_id) 
>                                            rv8803->ctrl); 
>          } 
>   
> -        spin_unlock(&rv8803->flags_lock); 
> +        mutex_unlock(&rv8803->flags_lock); 
>   
>          return IRQ_HANDLED; 
>  } 
> @@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, struct 
> rtc_time *tm) 
>          struct rv8803_data *rv8803 = dev_get_drvdata(dev); 
>          u8 date[7]; 
>          int flags, ret; 
> -        unsigned long irqflags; 
>   
>          if ((tm->tm_year < 100) || (tm->tm_year > 199)) 
>                  return -EINVAL; 
> @@ -173,18 +172,18 @@ static int rv8803_set_time(struct device *dev, 
> struct rtc_time *tm) 
>          if (ret < 0) 
>                  return ret; 
>   
> -        spin_lock_irqsave(&rv8803->flags_lock, irqflags); 
> +        mutex_lock(&rv8803->flags_lock); 
>   
>          flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG); 
>          if (flags < 0) { 
> -                spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +                mutex_unlock(&rv8803->flags_lock); 
>                  return flags; 
>          } 
>   
>          ret = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, 
>                                          flags & ~RV8803_FLAG_V2F); 
>   
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +        mutex_unlock(&rv8803->flags_lock); 
>   
>          return ret; 
>  } 
> @@ -226,7 +225,7 @@ static int rv8803_set_alarm(struct device *dev, struct 
> rtc_wkalrm *alrm) 
>          u8 alarmvals[3]; 
>          u8 ctrl[2]; 
>          int ret, err; 
> -        unsigned long alarm_time, irqflags; 
> +        unsigned long alarm_time; 
>   
>          /* The alarm has no seconds, round up to nearest minute */ 
>          if (alrm->time.tm_sec) { 
> @@ -236,11 +235,11 @@ static int rv8803_set_alarm(struct device *dev, 
> struct rtc_wkalrm *alrm) 
>                  rtc_time_to_tm(alarm_time, &alrm->time); 
>          } 
>   
> -        spin_lock_irqsave(&rv8803->flags_lock, irqflags); 
> +        mutex_lock(&rv8803->flags_lock); 
>   
>          ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, 
> ctrl); 
>          if (ret != 2) { 
> -                spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +                mutex_unlock(&rv8803->flags_lock); 
>                  return ret < 0 ? ret : -EIO; 
>          } 
>   
> @@ -253,14 +252,14 @@ static int rv8803_set_alarm(struct device *dev, 
> struct rtc_wkalrm *alrm) 
>                  err = i2c_smbus_write_byte_data(rv8803->client, 
> RV8803_CTRL, 
>                                                  rv8803->ctrl); 
>                  if (err) { 
> -                        spin_unlock_irqrestore(&rv8803->flags_lock, 
> irqflags); 
> +                        mutex_unlock(&rv8803->flags_lock); 
>                          return err; 
>                  } 
>          } 
>   
>          ctrl[1] &= ~RV8803_FLAG_AF; 
>          err = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, 
> ctrl[1]); 
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +        mutex_unlock(&rv8803->flags_lock); 
>          if (err) 
>                  return err; 
>   
> @@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *dev, 
> unsigned int enabled) 
>          struct i2c_client *client = to_i2c_client(dev); 
>          struct rv8803_data *rv8803 = dev_get_drvdata(dev); 
>          int ctrl, flags, err; 
> -        unsigned long irqflags; 
>   
>          ctrl = rv8803->ctrl; 
>   
> @@ -305,15 +303,15 @@ static int rv8803_alarm_irq_enable(struct device 
> *dev, unsigned int enabled) 
>                          ctrl &= ~RV8803_CTRL_AIE; 
>          } 
>   
> -        spin_lock_irqsave(&rv8803->flags_lock, irqflags); 
> +        mutex_lock(&rv8803->flags_lock); 
>          flags = i2c_smbus_read_byte_data(client, RV8803_FLAG); 
>          if (flags < 0) { 
> -                spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +                mutex_unlock(&rv8803->flags_lock); 
>                  return flags; 
>          } 
>          flags &= ~(RV8803_FLAG_AF | RV8803_FLAG_UF); 
>          err = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags); 
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +        mutex_unlock(&rv8803->flags_lock); 
>          if (err) 
>                  return err; 
>   
> @@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, unsigned 
> int cmd, unsigned long arg) 
>          struct i2c_client *client = to_i2c_client(dev); 
>          struct rv8803_data *rv8803 = dev_get_drvdata(dev); 
>          int flags, ret = 0; 
> -        unsigned long irqflags; 
>   
>          switch (cmd) { 
>          case RTC_VL_READ: 
> @@ -355,16 +352,16 @@ static int rv8803_ioctl(struct device *dev, unsigned 
> int cmd, unsigned long arg) 
>                  return 0; 
>   
>          case RTC_VL_CLR: 
> -                spin_lock_irqsave(&rv8803->flags_lock, irqflags); 
> +                mutex_lock(&rv8803->flags_lock); 
>                  flags = i2c_smbus_read_byte_data(client, RV8803_FLAG); 
>                  if (flags < 0) { 
> -                        spin_unlock_irqrestore(&rv8803->flags_lock, 
> irqflags); 
> +                        mutex_unlock(&rv8803->flags_lock); 
>                          return flags; 
>                  } 
>   
>                  flags &= ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F); 
>                  ret = i2c_smbus_write_byte_data(client, RV8803_FLAG, 
> flags); 
> -                spin_unlock_irqrestore(&rv8803->flags_lock, irqflags); 
> +                mutex_unlock(&rv8803->flags_lock); 
>                  if (ret < 0) 
>                          return ret; 
>   
> @@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client *client, 
>          if (!rv8803) 
>                  return -ENOMEM; 
>   
> +        mutex_init(&rv8803->flags_lock); 
>          rv8803->client = client; 
>          i2c_set_clientdata(client, rv8803); 
>   
> -- 
> 2.5.0 
>
>
------=_Part_805_301930943.1455728150744
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thursday, February 4, 2016 at 1:45:24 PM UTC+1,=
 Dirk Behme wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">From: Oleksi=
j Rempel &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailt=
o=3D"PN-Y3GMWFwAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascr=
ipt:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return=
 true;">fixed-term.O...@de.<wbr>bosch.com</a>&gt;
<br>
<br>Fix a scheduling while atomic issue caused by rv8803_set_time()
<br>holding a spinlock during the call to i2c_smbus_read_byte_data().
<br>
<br>Signed-off-by: Oleksij Rempel &lt;<a href=3D"javascript:" target=3D"_bl=
ank" gdf-obfuscated-mailto=3D"PN-Y3GMWFwAJ" rel=3D"nofollow" onmousedown=3D=
"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#3=
9;javascript:&#39;;return true;">fixed-term.O...@de.<wbr>bosch.com</a>&gt;
<br></blockquote><div><br><br>Any further comments on this? Or could the be=
 applied?<br><br>Best regards<br><br>Dirk<br><br>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px =
#ccc solid;padding-left: 1ex;">---
<br>=C2=A0drivers/rtc/rtc-rv8803.c | 40 +++++++++++++++++++-----------<wbr>=
----------
<br>=C2=A01 file changed, 19 insertions(+), 21 deletions(-)
<br>
<br>diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
<br>index 33c7e2a..38621ff 100644
<br>--- a/drivers/rtc/rtc-rv8803.c
<br>+++ b/drivers/rtc/rtc-rv8803.c
<br>@@ -52,7 +52,7 @@
<br>=C2=A0struct rv8803_data {
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_client=
 *client;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rtc_device=
 *rtc;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spinlock_t flags_lock;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex flags_loc=
k;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 ctrl;
<br>=C2=A0};
<br>=C2=A0
<br>@@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq(int irq, void =
*dev_id)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long eve=
nts =3D 0;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 flags;
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&amp;rv8803-=
&gt;<wbr>flags_lock);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;rv8803=
-&gt;<wbr>flags_lock);
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags =3D i2c_smb=
us_read_byte_data(<wbr>client, RV8803_FLAG);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags &lt;=3D=
 0) {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock(&amp;<wbr>rv8803-&gt;flags_lock);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(<wbr>&amp;rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return IRQ_NONE;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>@@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void =
*dev_id)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0rv8803-&gt;ctrl);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock(&amp;rv880=
3-&gt;<wbr>flags_lock);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&amp;rv88=
03-<wbr>&gt;flags_lock);
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return IRQ_HANDLE=
D;
<br>=C2=A0}
<br>@@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, stru=
ct rtc_time *tm)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rv8803_dat=
a *rv8803 =3D dev_get_drvdata(dev);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 date[7];
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int flags, ret;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long irqflags=
;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((tm-&gt;tm_ye=
ar &lt; 100) || (tm-&gt;tm_year &gt; 199))
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
<br>@@ -173,18 +172,18 @@ static int rv8803_set_time(struct device *dev, st=
ruct rtc_time *tm)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret &lt; 0)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&amp=
;<wbr>rv8803-&gt;flags_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;rv8803=
-&gt;<wbr>flags_lock);
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags =3D i2c_smb=
us_read_byte_data(<wbr>rv8803-&gt;client, RV8803_FLAG);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags &lt; 0)=
 {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqrestore(&amp;rv8803-&gt;flag=
s_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(<wbr>&amp;rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return flags;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D i2c_smbus=
_write_byte_data(<wbr>rv8803-&gt;client, RV8803_FLAG,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags &amp; ~RV8803_FLAG_V2F);
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqre=
store(&amp;rv8803-&gt;flags_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&amp;rv88=
03-<wbr>&gt;flags_lock);
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
<br>=C2=A0}
<br>@@ -226,7 +225,7 @@ static int rv8803_set_alarm(struct device *dev, str=
uct rtc_wkalrm *alrm)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 alarmvals[3];
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 ctrl[2];
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, err;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long alarm_ti=
me, irqflags;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long alarm_ti=
me;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The alarm has =
no seconds, round up to nearest minute */
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (alrm-&gt;time=
.tm_sec) {
<br>@@ -236,11 +235,11 @@ static int rv8803_set_alarm(struct device *dev, s=
truct rtc_wkalrm *alrm)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rtc_time_to_<wbr>tm(alarm_time, &amp;alrm-=
&gt;time);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&amp=
;<wbr>rv8803-&gt;flags_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;rv8803=
-&gt;<wbr>flags_lock);
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D i2c_smbus=
_read_i2c_block_data(<wbr>client, RV8803_FLAG, 2, ctrl);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D 2) {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqrestore(&amp;rv8803-&gt;flag=
s_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(<wbr>&amp;rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret &lt; 0 ? ret : -EIO;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>@@ -253,14 +252,14 @@ static int rv8803_set_alarm(struct device *dev, s=
truct rtc_wkalrm *alrm)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D i2c_smbus_write_byte_data(<wbr>rv8=
803-&gt;client, RV8803_CTRL,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0rv8803-&gt;<wbr>ctrl);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err) {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
spin_<wbr>unlock_irqrestore(&amp;rv8803-&gt;<wbr>flags_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>mutex_unlock(&amp;rv8803-&gt;flags_<wbr>lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>return err;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctrl[1] &amp;=3D =
~RV8803_FLAG_AF;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D i2c_smbus=
_write_byte_data(<wbr>rv8803-&gt;client, RV8803_FLAG, ctrl[1]);
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqre=
store(&amp;rv8803-&gt;flags_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&amp;rv88=
03-<wbr>&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
<br>=C2=A0
<br>@@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *d=
ev, unsigned int enabled)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_client=
 *client =3D to_i2c_client(dev);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rv8803_dat=
a *rv8803 =3D dev_get_drvdata(dev);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ctrl, flags, =
err;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long irqflags=
;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctrl =3D rv8803-&=
gt;ctrl;
<br>=C2=A0
<br>@@ -305,15 +303,15 @@ static int rv8803_alarm_irq_enable(struct device =
*dev, unsigned int enabled)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0ctrl &amp;=3D ~RV8803_CTRL_AIE;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&amp=
;<wbr>rv8803-&gt;flags_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;rv8803=
-&gt;<wbr>flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags =3D i2c_smb=
us_read_byte_data(<wbr>client, RV8803_FLAG);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags &lt; 0)=
 {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqrestore(&amp;rv8803-&gt;flag=
s_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(<wbr>&amp;rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return flags;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags &amp;=3D ~(=
RV8803_FLAG_AF | RV8803_FLAG_UF);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D i2c_smbus=
_write_byte_data(<wbr>client, RV8803_FLAG, flags);
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqre=
store(&amp;rv8803-&gt;flags_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&amp;rv88=
03-<wbr>&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
<br>=C2=A0
<br>@@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, unsigne=
d int cmd, unsigned long arg)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_client=
 *client =3D to_i2c_client(dev);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rv8803_dat=
a *rv8803 =3D dev_get_drvdata(dev);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int flags, ret =
=3D 0;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long irqflags=
;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (cmd) {
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case RTC_VL_READ:
<br>@@ -355,16 +352,16 @@ static int rv8803_ioctl(struct device *dev, unsig=
ned int cmd, unsigned long arg)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case RTC_VL_CLR:
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_<wbr>irqsave(&amp;rv8803-&gt;flags_loc=
k, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;<wbr>rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags =3D i2c_smbus_read_byte_data(<wbr>cl=
ient, RV8803_FLAG);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags &lt; 0) {
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
spin_<wbr>unlock_irqrestore(&amp;rv8803-&gt;<wbr>flags_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>mutex_unlock(&amp;rv8803-&gt;flags_<wbr>lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>return flags;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags &amp;=3D ~(RV8803_FLAG_V1F | RV8803_=
FLAG_V2F);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D i2c_smbus_write_byte_data(<wbr>cli=
ent, RV8803_FLAG, flags);
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqrestore(&amp;rv8803-&gt;flag=
s_<wbr>lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(<wbr>&amp;rv8803-&gt;flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret &lt; 0)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0<wbr>return ret;
<br>=C2=A0
<br>@@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client *client,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rv8803)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
<br>=C2=A0
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&amp;rv8803=
-&gt;<wbr>flags_lock);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rv8803-&gt;client=
 =3D client;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_set_clientdat=
a(<wbr>client, rv8803);
<br>=C2=A0
<br>--=20
<br>2.5.0
<br>
<br></blockquote></div>
------=_Part_805_301930943.1455728150744--

------=_Part_804_872376058.1455728150743--
