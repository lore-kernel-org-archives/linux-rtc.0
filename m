Return-Path: <rtc-linux+bncBAABB5HQUGVQKGQEZH2AWRI@googlegroups.com>
Received: from mx6.zte.com.cn (mx6.zte.com.cn. [95.130.199.165])
        by gmr-mx.google.com with ESMTP id u10si109021wif.1.2015.05.29.07.32.19
        for <rtc-linux@googlegroups.com>;
        Fri, 29 May 2015 07:32:20 -0700 (PDT)
Received: from zte.com.cn (unknown [192.168.168.119])
	by Websense Email Security Gateway with ESMTP id 717CB794ADDFF
	for <rtc-linux@googlegroups.com>; Fri, 29 May 2015 22:31:31 +0800 (CST)
In-Reply-To: <20150429232824.GC3242@piout.net>
References: <1429089611-29776-5-git-send-email-xlpang@126.com> <20150429232824.GC3242@piout.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Christian <andrew.christian@hp.com>,
        Arnd Bergmann <arnd@arndb.de>, CIH <cih@coventive.com>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Nicolas Pitre <nico@fluxnic.net>, Xunlei Pang <pang.xunlei@linaro.org>,
        Richard Purdie <rpurdie@rpsys.net>, rtc-linux@googlegroups.com,
        Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [5/5] drivers/rtc/sa1100: Replace deprecated
 rtc_tm_to_time() and rtc_time_to_tm()
MIME-Version: 1.0
Message-ID: <OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Fri, 29 May 2015 22:32:15 +0800
Content-Type: multipart/alternative; boundary="=_alternative 004FD9D648257E54_="
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This is a multipart message in MIME format.

--=_alternative 004FD9D648257E54_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 2015-04-30=
=20
AM 07:28:24:
>=20
> Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()=20
> and rtc_time_to_tm()
>=20
> Hi,
>=20
> On 15/04/2015 at 17:20:11 +0800, Xunlei Pang wrote :
> > From: Xunlei Pang <pang.xunlei@linaro.org>
> >=20
> > The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
> > which will overflow in year 2106 on 32-bit machines.
> >=20
> > This patch solves this by:
> >  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
> >  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
> >=20
> > Cc: CIH <cih@coventive.com>
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Cc: Andrew Christian <andrew.christian@hp.com>
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> > ---
> >  drivers/rtc/rtc-sa1100.c | 21 +++++----------------
> >  1 file changed, 5 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> > index b6e1ca0..625a320 100644
> > --- a/drivers/rtc/rtc-sa1100.c
> > +++ b/drivers/rtc/rtc-sa1100.c
> > @@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable
> (struct device *dev, unsigned int enabled)
> >=20
> >  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time=20
*tm)
> >  {
> > -   rtc_time_to_tm(RCNR, tm);
> > +   rtc_time64_to_tm(RCNR, tm);
> >     return 0;
> >  }
> >=20
> >  static int sa1100_rtc_set_time(struct device *dev, struct rtc_time=20
*tm)
> >  {
> > -   unsigned long time;
> > -   int ret;
> > -
> > -   ret =3D rtc_tm_to_time(tm, &time);
> > -   if (ret =3D=3D 0)
> > -      RCNR =3D time;
> > -   return ret;
> > +   RCNR =3D rtc_tm_to_time64(tm);
>=20
> For the same reason that Russell pointed in patch 4/5, this hides that
> it doesn't work after 2106-02-07 06:28:16 as the register is still 32
> bits.
> I would prefer that you return an error in that case.

Thanks for the review, I want to leave the ones like this untouched.

Regards,
-Xunlei

>=20
>=20
> --=20
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

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

--=_alternative 004FD9D648257E54_=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<tt><font size=3D2>Hi Alexandre,</font></tt>
<br>
<br><tt><font size=3D2>Alexandre Belloni &lt;alexandre.belloni@free-electro=
ns.com&gt;
wrote 2015-04-30 AM 07:28:24:<br>
&gt; <br>
&gt; Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()
<br>
&gt; and rtc_time_to_tm()</font></tt>
<br><tt><font size=3D2>&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; On 15/04/2015 at 17:20:11 +0800, Xunlei Pang wrote :<br>
&gt; &gt; From: Xunlei Pang &lt;pang.xunlei@linaro.org&gt;<br>
&gt; &gt; <br>
&gt; &gt; The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),=
<br>
&gt; &gt; which will overflow in year 2106 on 32-bit machines.<br>
&gt; &gt; <br>
&gt; &gt; This patch solves this by:<br>
&gt; &gt; &nbsp;- Replacing rtc_tm_to_time() with rtc_tm_to_time64()<br>
&gt; &gt; &nbsp;- Replacing rtc_time_to_tm() with rtc_time64_to_tm()<br>
&gt; &gt; <br>
&gt; &gt; Cc: CIH &lt;cih@coventive.com&gt;<br>
&gt; &gt; Cc: Nicolas Pitre &lt;nico@fluxnic.net&gt;<br>
&gt; &gt; Cc: Andrew Christian &lt;andrew.christian@hp.com&gt;<br>
&gt; &gt; Cc: Richard Purdie &lt;rpurdie@rpsys.net&gt;<br>
&gt; &gt; Signed-off-by: Xunlei Pang &lt;pang.xunlei@linaro.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; &nbsp;drivers/rtc/rtc-sa1100.c | 21 +++++----------------<br>
&gt; &gt; &nbsp;1 file changed, 5 insertions(+), 16 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c<=
br>
&gt; &gt; index b6e1ca0..625a320 100644<br>
&gt; &gt; --- a/drivers/rtc/rtc-sa1100.c<br>
&gt; &gt; +++ b/drivers/rtc/rtc-sa1100.c<br>
&gt; &gt; @@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable<br>
&gt; (struct device *dev, unsigned int enabled)<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp;static int sa1100_rtc_read_time(struct device *dev, struct
rtc_time *tm)<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; - &nbsp; rtc_time_to_tm(RCNR, tm);<br>
&gt; &gt; + &nbsp; rtc_time64_to_tm(RCNR, tm);<br>
&gt; &gt; &nbsp; &nbsp; return 0;<br>
&gt; &gt; &nbsp;}<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp;static int sa1100_rtc_set_time(struct device *dev, struct
rtc_time *tm)<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; - &nbsp; unsigned long time;<br>
&gt; &gt; - &nbsp; int ret;<br>
&gt; &gt; -<br>
&gt; &gt; - &nbsp; ret =3D rtc_tm_to_time(tm, &amp;time);<br>
&gt; &gt; - &nbsp; if (ret =3D=3D 0)<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp;RCNR =3D time;<br>
&gt; &gt; - &nbsp; return ret;<br>
&gt; &gt; + &nbsp; RCNR =3D rtc_tm_to_time64(tm);<br>
&gt; <br>
&gt; For the same reason that Russell pointed in patch 4/5, this hides
that<br>
&gt; it doesn't work after 2106-02-07 06:28:16 as the register is still
32<br>
&gt; bits.<br>
&gt; I would prefer that you return an error in that case.</font></tt>
<br>
<br><tt><font size=3D2>Thanks for the review, I want to leave the ones like
this untouched.</font></tt>
<br>
<br><tt><font size=3D2>Regards,</font></tt>
<br><tt><font size=3D2>-Xunlei</font></tt>
<br><tt><font size=3D2><br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Alexandre Belloni, Free Electrons<br>
&gt; Embedded Linux, Kernel and Android engineering<br>
&gt; </font></tt><a href=3D"http://free-electrons.com/"><tt><font size=3D2>=
http://free-electrons.com</font></tt></a><tt><font size=3D2><br>
</font></tt>

<br><pre><font color=3D"blue">
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

</font></pre><br>

<br><pre><font color=3D"blue">
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

</font></pre><br>

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

--=_alternative 004FD9D648257E54_=--
