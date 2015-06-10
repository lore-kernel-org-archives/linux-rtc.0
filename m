Return-Path: <rtc-linux+bncBC2PPF5ZT4BBBRGL36VQKGQETHQ3Y3Y@googlegroups.com>
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com. [2a00:1450:4010:c03::22b])
        by gmr-mx.google.com with ESMTPS id bm9si696210lbb.0.2015.06.10.00.22.43
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 00:22:43 -0700 (PDT)
Received: by mail-la0-x22b.google.com with SMTP id w7so26708081lae.1
        for <rtc-linux@googlegroups.com>; Wed, 10 Jun 2015 00:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHKZfL3ne3m-O0oRyD-Lfjq_BCX5B8JzB7dUuE1yrF0Zp0eaTg@mail.gmail.com>
References: <1433845413-13960-1-git-send-email-adrianhuang0701@gmail.com>
	<1433845413-13960-2-git-send-email-adrianhuang0701@gmail.com>
	<CAHKZfL3ne3m-O0oRyD-Lfjq_BCX5B8JzB7dUuE1yrF0Zp0eaTg@mail.gmail.com>
Date: Wed, 10 Jun 2015 09:22:43 +0200
Message-ID: <CANoYJu=Mni_7wf2SPDWFwj6KqhsCfOEtux1H7_4bqD_cn37wGQ@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v2 1/2] rtc-cmos: Clear interrupt flag if
 alarm time is
From: Diego Ercolani <diego.ercolani@gmail.com>
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Egbert Eich <eich@suse.com>, Max Asbock <amax@lenovo.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Content-Type: multipart/alternative; boundary=001a11c3f64eafacf3051824bd92
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--001a11c3f64eafacf3051824bd92
Content-Type: text/plain; charset=UTF-8

No problem to me to test, please give a build for openSUSE_13.2 so I can
test on my system
Thank you

2015-06-10 7:51 GMT+02:00 Huang Adrian <adrianhuang0701@gmail.com>:

> Hi Alexandre,
>
> This reworked patch is based on your suggestion. Could you kindly
> review it? If it looks good to you, I'll ask Borislav, Diego and
> Egbert a favor for testing.
>
> Thanks in advance.
>
> -- Adrian
>
> > ---
> >  drivers/rtc/rtc-cmos.c | 65
> ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> > index a82556a..4e60ac8 100644
> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -51,6 +51,7 @@ struct cmos_rtc {
> >         struct device           *dev;
> >         int                     irq;
> >         struct resource         *iomem;
> > +       time64_t                alarm_expires;
> >
> >         void                    (*wake_on)(struct device *);
> >         void                    (*wake_off)(struct device *);
> > @@ -377,6 +378,8 @@ static int cmos_set_alarm(struct device *dev, struct
> rtc_wkalrm *t)
> >
> >         spin_unlock_irq(&rtc_lock);
> >
> > +       cmos->alarm_expires = rtc_tm_to_time64(&t->time);
> > +
> >         return 0;
> >  }
> >
> > @@ -588,7 +591,7 @@ static struct bin_attribute nvram = {
> >
> >  /*----------------------------------------------------------------*/
> >
> > -static struct cmos_rtc cmos_rtc;
> > +static struct cmos_rtc cmos_rtc = { .alarm_expires = 0 };
> >
> >  static irqreturn_t cmos_interrupt(int irq, void *p)
> >  {
> > @@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device
> *dev)
> >         cmos->dev = NULL;
> >  }
> >
> > +static int cmos_aie_poweroff(struct device *dev)
> > +{
> > +       struct cmos_rtc *cmos = dev_get_drvdata(dev);
> > +       struct rtc_time now;
> > +       int err;
> > +       time64_t t_now;
> > +       unsigned char rtc_control;
> > +
> > +       if (!cmos->alarm_expires)
> > +               return -EINVAL;
> > +
> > +       spin_lock_irq(&rtc_lock);
> > +       rtc_control = CMOS_READ(RTC_CONTROL);
> > +       spin_unlock_irq(&rtc_lock);
> > +
> > +       /* We only care about the situation where AIE is disabled. */
> > +       if (rtc_control & RTC_AIE)
> > +               return -EBUSY;
> > +
> > +       err = cmos_read_time(dev, &now);
> > +       if (err < 0)
> > +               return err;
> > +       t_now = rtc_tm_to_time64(&now);
> > +
> > +       /*
> > +        * When enabling "RTC wake-up" in BIOS setup, the machine reboots
> > +        * automatically right after shutdown on some buggy boxes.
> > +        * This automatic rebooting issue won't happen when the alarm
> > +        * time is larger than now+1 seconds.
> > +        *
> > +        * If the alarm time is equal to now+1 seconds, we need to wait
> > +        * for 1 second so that AF is set by CMOS hardware. Therefore, we
> > +        * can get a chance to clear AF in cmos_do_shutdown().
> > +        *
> > +        * If the alarm time is less equal to 'now', the function simply
> > +        * returns '0' so that we can get a chance to clear AF in
> > +        * cmos_do_shutdown().
> > +        */
> > +       if (cmos->alarm_expires > (t_now + 1))
> > +               return -EBUSY;
> > +       else if (cmos->alarm_expires == (t_now + 1))
> > +               msleep(1000);
> > +
> > +       return 0;
> > +}
> > +
> >  #ifdef CONFIG_PM
> >
> >  static int cmos_suspend(struct device *dev)
> > @@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *pnp)
> >         struct device *dev = &pnp->dev;
> >         struct cmos_rtc *cmos = dev_get_drvdata(dev);
> >
> > -       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> > -               return;
> > +       if (system_state == SYSTEM_POWER_OFF) {
> > +               cmos_poweroff(dev);
> > +               if (cmos_aie_poweroff(dev) < 0)
> > +                       return;
> > +       }
> >
> >         cmos_do_shutdown(cmos->irq);
> >  }
> > @@ -1200,8 +1252,11 @@ static void cmos_platform_shutdown(struct
> platform_device *pdev)
> >         struct device *dev = &pdev->dev;
> >         struct cmos_rtc *cmos = dev_get_drvdata(dev);
> >
> > -       if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
> > -               return;
> > +       if (system_state == SYSTEM_POWER_OFF) {
> > +               cmos_poweroff(dev);
> > +               if (cmos_aie_poweroff(dev) < 0)
> > +                       return;
> > +       }
> >
> >         cmos_do_shutdown(cmos->irq);
> >  }
> > --
> > 1.9.1
> >
>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a11c3f64eafacf3051824bd92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>No problem to me to test, please give a build for ope=
nSUSE_13.2 so I can test on my system<br></div>Thank you<br></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-06-10 7:51 GMT+02:00 =
Huang Adrian <span dir=3D"ltr">&lt;<a href=3D"mailto:adrianhuang0701@gmail.=
com" target=3D"_blank">adrianhuang0701@gmail.com</a>&gt;</span>:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi Alexandre,<br>
<br>
This reworked patch is based on your suggestion. Could you kindly<br>
review it? If it looks good to you, I&#39;ll ask Borislav, Diego and<br>
Egbert a favor for testing.<br>
<br>
Thanks in advance.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- Adrian<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; ---<br>
&gt;=C2=A0 drivers/rtc/rtc-cmos.c | 65 ++++++++++++++++++++++++++++++++++++=
++++++++++----<br>
&gt;=C2=A0 1 file changed, 60 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c<br>
&gt; index a82556a..4e60ac8 100644<br>
&gt; --- a/drivers/rtc/rtc-cmos.c<br>
&gt; +++ b/drivers/rtc/rtc-cmos.c<br>
&gt; @@ -51,6 +51,7 @@ struct cmos_rtc {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*iomem;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0time64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 alarm_expires;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*wake_on)(struct device *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*wake_off)(struct device *);<br>
&gt; @@ -377,6 +378,8 @@ static int cmos_set_alarm(struct device *dev, stru=
ct rtc_wkalrm *t)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&amp;rtc_lock);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0cmos-&gt;alarm_expires =3D rtc_tm_to_time6=
4(&amp;t-&gt;time);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; @@ -588,7 +591,7 @@ static struct bin_attribute nvram =3D {<br>
&gt;<br>
&gt;=C2=A0 /*--------------------------------------------------------------=
--*/<br>
&gt;<br>
&gt; -static struct cmos_rtc cmos_rtc;<br>
&gt; +static struct cmos_rtc cmos_rtc =3D { .alarm_expires =3D 0 };<br>
&gt;<br>
&gt;=C2=A0 static irqreturn_t cmos_interrupt(int irq, void *p)<br>
&gt;=C2=A0 {<br>
&gt; @@ -860,6 +863,52 @@ static void __exit cmos_do_remove(struct device *=
dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmos-&gt;dev =3D NULL;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int cmos_aie_poweroff(struct device *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmos_rtc *cmos =3D dev_get_drvdata(=
dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rtc_time now;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0time64_t t_now;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char rtc_control;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cmos-&gt;alarm_expires)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irq(&amp;rtc_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rtc_control =3D CMOS_READ(RTC_CONTROL);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&amp;rtc_lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* We only care about the situation where =
AIE is disabled. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rtc_control &amp; RTC_AIE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D cmos_read_time(dev, &amp;now);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0t_now =3D rtc_tm_to_time64(&amp;now);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * When enabling &quot;RTC wake-up&quot; i=
n BIOS setup, the machine reboots<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * automatically right after shutdown on s=
ome buggy boxes.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This automatic rebooting issue won&#39;=
t happen when the alarm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * time is larger than now+1 seconds.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the alarm time is equal to now+1 sec=
onds, we need to wait<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * for 1 second so that AF is set by CMOS =
hardware. Therefore, we<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * can get a chance to clear AF in cmos_do=
_shutdown().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the alarm time is less equal to &#39=
;now&#39;, the function simply<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * returns &#39;0&#39; so that we can get =
a chance to clear AF in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * cmos_do_shutdown().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmos-&gt;alarm_expires &gt; (t_now + 1=
))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (cmos-&gt;alarm_expires =3D=3D (t_=
now + 1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(1000);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 #ifdef CONFIG_PM<br>
&gt;<br>
&gt;=C2=A0 static int cmos_suspend(struct device *dev)<br>
&gt; @@ -1094,8 +1143,11 @@ static void cmos_pnp_shutdown(struct pnp_dev *p=
np)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pnp-&gt;d=
ev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmos_rtc *cmos =3D dev_get_drv=
data(dev);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (system_state =3D=3D SYSTEM_POWER_OFF &=
amp;&amp; !cmos_poweroff(dev))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (system_state =3D=3D SYSTEM_POWER_OFF) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmos_poweroff(=
dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmos_aie_p=
oweroff(dev) &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmos_do_shutdown(cmos-&gt;irq);<br>
&gt;=C2=A0 }<br>
&gt; @@ -1200,8 +1252,11 @@ static void cmos_platform_shutdown(struct platf=
orm_device *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;=
dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmos_rtc *cmos =3D dev_get_drv=
data(dev);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (system_state =3D=3D SYSTEM_POWER_OFF &=
amp;&amp; !cmos_poweroff(dev))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (system_state =3D=3D SYSTEM_POWER_OFF) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmos_poweroff(=
dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmos_aie_p=
oweroff(dev) &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmos_do_shutdown(cmos-&gt;irq);<br>
&gt;=C2=A0 }<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
</div></div></blockquote></div><br></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a11c3f64eafacf3051824bd92--
