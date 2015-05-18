Return-Path: <rtc-linux+bncBC2PPF5ZT4BBBNXQ42VAKGQERJFGRHY@googlegroups.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com. [2607:f8b0:4003:c01::230])
        by gmr-mx.google.com with ESMTPS id k7si558037igu.0.2015.05.18.03.00.22
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 03:00:22 -0700 (PDT)
Received: by mail-ob0-x230.google.com with SMTP id e9so118413824obf.1
        for <rtc-linux@googlegroups.com>; Mon, 18 May 2015 03:00:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150518094755.GC23662@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518094755.GC23662@pd.tnic>
Date: Mon, 18 May 2015 12:00:22 +0200
Message-ID: <CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
From: Diego Ercolani <diego.ercolani@gmail.com>
To: Borislav Petkov <bp@suse.de>
Cc: Adrian Huang <adrianhuang0701@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
	Egbert Eich <eich@suse.com>
Content-Type: multipart/alternative; boundary=001a11c1e5d018821905165843a1
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--001a11c1e5d018821905165843a1
Content-Type: text/plain; charset=UTF-8

Hello, sure I can.
In the meanwhile I upgraded my linux box to opensuse 13.2 with actual
kernel: 3.16.7-21-desktop
so the patch should be applied to that kernel, and please, as is passed
some time please point out the tests you want me to try

Diego

2015-05-18 11:47 GMT+02:00 Borislav Petkov <bp@suse.de>:

> On Fri, May 08, 2015 at 05:34:25PM +0800, Adrian Huang wrote:
> > Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
> > added a special quirk is not needed because PATCH [2/2] of this
> > patchset makes the kernel more robust:
> > rtc: restore the RTC alarm time to the configured alarm time in BIOS
> > Setup
> >
> > Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> > ---
> >  drivers/rtc/rtc-cmos.c | 52
> --------------------------------------------------
> >  1 file changed, 52 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> > index a82556a..9754564 100644
> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -29,8 +29,6 @@
> >   * other drivers and utilities on correctly configured systems.
> >   */
> >
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > @@ -41,7 +39,6 @@
> >  #include <linux/pm.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > -#include <linux/dmi.h>
> >
> >  /* this is for "generic access to PC-style RTC" using
> CMOS_READ/CMOS_WRITE */
> >  #include <asm-generic/rtc.h>
> > @@ -380,50 +377,6 @@ static int cmos_set_alarm(struct device *dev,
> struct rtc_wkalrm *t)
> >       return 0;
> >  }
> >
> > -/*
> > - * Do not disable RTC alarm on shutdown - workaround for b0rked BIOSes.
> > - */
> > -static bool alarm_disable_quirk;
> > -
> > -static int __init set_alarm_disable_quirk(const struct dmi_system_id
> *id)
> > -{
> > -     alarm_disable_quirk = true;
> > -     pr_info("BIOS has alarm-disable quirk - RTC alarms disabled\n");
> > -     return 0;
> > -}
> > -
> > -static const struct dmi_system_id rtc_quirks[] __initconst = {
> > -     /* https://bugzilla.novell.com/show_bug.cgi?id=805740 */
> > -     {
> > -             .callback = set_alarm_disable_quirk,
> > -             .ident    = "IBM Truman",
> > -             .matches  = {
> > -                     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> > -                     DMI_MATCH(DMI_PRODUCT_NAME, "4852570"),
> > -             },
>
> So, your series really fix the reboot issue on this already notoriously
> buggy box.
>
> I did try to confirm it 5 times just to be sure and in all 5, the box
> remained off.
>
> We're testing another box currently which has the same issue.
>
> Now, for the next version of your patches, I'd ask you to put this patch
> second. I.e., you want to introduce the new fix first and *then* remove
> the quirk as this way we have a window where no quirk will be in place
> and possible bisection will be disturbed needlessly even though we can
> help it.
>
> > -     },
> > -     /* https://bugzilla.novell.com/show_bug.cgi?id=812592 */
> > -     {
> > -             .callback = set_alarm_disable_quirk,
> > -             .ident    = "Gigabyte GA-990XA-UD3",
> > -             .matches  = {
> > -                     DMI_MATCH(DMI_SYS_VENDOR,
> > -                                     "Gigabyte Technology Co., Ltd."),
> > -                     DMI_MATCH(DMI_PRODUCT_NAME, "GA-990XA-UD3"),
> > -             },
>
> Looking at the bugzilla entry above, that should be Diego's box.
>
> Diego, would you be able to test these patches? They're a better fix
> than what I did last year.
>
> If you want me to prepare an openSUSE kernel for you, let me know and
> I'll do one. I'd only need to know which distro.
>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --
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

--001a11c1e5d018821905165843a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello, sure I can.<br></div>In the meanwhil=
e I upgraded my linux box to opensuse 13.2 with actual kernel: 3.16.7-21-de=
sktop<br></div>so the patch should be applied to that kernel, and please, a=
s is passed some time please point out the tests you want me to try<br><br>=
</div>Diego<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2015-05-18 11:47 GMT+02:00 Borislav Petkov <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:bp@suse.de" target=3D"_blank">bp@suse.de</a>&gt;</span>:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">On Fri, May 08, 2015 at 05:34:25PM +0800, Adria=
n Huang wrote:<br>
&gt; Commit d5a1c7e3fc38 (&quot;rtc-cmos: Add an alarm disable quirk&quot;)=
 that<br>
&gt; added a special quirk is not needed because PATCH [2/2] of this<br>
&gt; patchset makes the kernel more robust:<br>
&gt; rtc: restore the RTC alarm time to the configured alarm time in BIOS<b=
r>
&gt; Setup<br>
&gt;<br>
&gt; Signed-off-by: Adrian Huang &lt;<a href=3D"mailto:ahuang12@lenovo.com"=
>ahuang12@lenovo.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/rtc/rtc-cmos.c | 52 ------------------------------------=
--------------<br>
&gt;=C2=A0 1 file changed, 52 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c<br>
&gt; index a82556a..9754564 100644<br>
&gt; --- a/drivers/rtc/rtc-cmos.c<br>
&gt; +++ b/drivers/rtc/rtc-cmos.c<br>
&gt; @@ -29,8 +29,6 @@<br>
&gt;=C2=A0 =C2=A0* other drivers and utilities on correctly configured syst=
ems.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; -#define pr_fmt(fmt) KBUILD_MODNAME &quot;: &quot; fmt<br>
&gt; -<br>
&gt;=C2=A0 #include &lt;linux/kernel.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/module.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/init.h&gt;<br>
&gt; @@ -41,7 +39,6 @@<br>
&gt;=C2=A0 #include &lt;linux/pm.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/of.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/of_platform.h&gt;<br>
&gt; -#include &lt;linux/dmi.h&gt;<br>
&gt;<br>
&gt;=C2=A0 /* this is for &quot;generic access to PC-style RTC&quot; using =
CMOS_READ/CMOS_WRITE */<br>
&gt;=C2=A0 #include &lt;asm-generic/rtc.h&gt;<br>
&gt; @@ -380,50 +377,6 @@ static int cmos_set_alarm(struct device *dev, str=
uct rtc_wkalrm *t)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -/*<br>
&gt; - * Do not disable RTC alarm on shutdown - workaround for b0rked BIOSe=
s.<br>
&gt; - */<br>
&gt; -static bool alarm_disable_quirk;<br>
&gt; -<br>
&gt; -static int __init set_alarm_disable_quirk(const struct dmi_system_id =
*id)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0alarm_disable_quirk =3D true;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0pr_info(&quot;BIOS has alarm-disable quirk - RTC =
alarms disabled\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static const struct dmi_system_id rtc_quirks[] __initconst =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* <a href=3D"https://bugzilla.novell.com/show_bu=
g.cgi?id=3D805740" target=3D"_blank">https://bugzilla.novell.com/show_bug.c=
gi?id=3D805740</a> */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D set_ala=
rm_disable_quirk,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident=C2=A0 =C2=A0 =
=3D &quot;IBM Truman&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches=C2=A0 =3D {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0DMI_MATCH(DMI_SYS_VENDOR, &quot;TOSHIBA&quot;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0DMI_MATCH(DMI_PRODUCT_NAME, &quot;4852570&quot;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
<br>
So, your series really fix the reboot issue on this already notoriously<br>
buggy box.<br>
<br>
I did try to confirm it 5 times just to be sure and in all 5, the box<br>
remained off.<br>
<br>
We&#39;re testing another box currently which has the same issue.<br>
<br>
Now, for the next version of your patches, I&#39;d ask you to put this patc=
h<br>
second. I.e., you want to introduce the new fix first and *then* remove<br>
the quirk as this way we have a window where no quirk will be in place<br>
and possible bisection will be disturbed needlessly even though we can<br>
help it.<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* <a href=3D"https://bugzilla.novell.com/show_bu=
g.cgi?id=3D812592" target=3D"_blank">https://bugzilla.novell.com/show_bug.c=
gi?id=3D812592</a> */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D set_ala=
rm_disable_quirk,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident=C2=A0 =C2=A0 =
=3D &quot;Gigabyte GA-990XA-UD3&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches=C2=A0 =3D {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0DMI_MATCH(DMI_SYS_VENDOR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Gigaby=
te Technology Co., Ltd.&quot;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0DMI_MATCH(DMI_PRODUCT_NAME, &quot;GA-990XA-UD3&quot;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
<br>
Looking at the bugzilla entry above, that should be Diego&#39;s box.<br>
<br>
Diego, would you be able to test these patches? They&#39;re a better fix<br=
>
than what I did last year.<br>
<br>
If you want me to prepare an openSUSE kernel for you, let me know and<br>
I&#39;ll do one. I&#39;d only need to know which distro.<br>
<br>
Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Regards/Gruss,<br>
=C2=A0 =C2=A0 Boris.<br>
<br>
ECO tip #101: Trim your mails when you reply.<br>
--<br>
</font></span></blockquote></div><br></div>

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

--001a11c1e5d018821905165843a1--
