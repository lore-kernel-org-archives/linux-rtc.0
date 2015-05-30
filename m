Return-Path: <rtc-linux+bncBAABBWEWU2VQKGQE4JO7JTY@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id lg9si1129932qcb.1.2015.05.30.03.05.11
        for <rtc-linux@googlegroups.com>;
        Sat, 30 May 2015 03:05:12 -0700 (PDT)
Received: from zte.com.cn (unknown [192.168.168.119])
	by Websense Email Security Gateway with ESMTP id 60328F86AF968
	for <rtc-linux@googlegroups.com>; Sat, 30 May 2015 18:05:07 +0800 (CST)
In-Reply-To: <OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@LocalDomain>
References: <1429089611-29776-5-git-send-email-xlpang@126.com> <20150429232824.GC3242@piout.net> <OF1F6D43BC.C38481A0-ON48257E54.004FA90B-48257E54.004FD9D8@LocalDomain>
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
Message-ID: <OF8AF02B38.A9E97627-ON48257E55.00352B8F-48257E55.0037661B@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Sat, 30 May 2015 18:05:10 +0800
Content-Type: multipart/alternative; boundary="=_alternative 0037661B48257E55_="
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

--=_alternative 0037661B48257E55_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

PangXunLei10110855/user/zte_ltd wrote 2015-05-29 PM 10:32:15:
> Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()=20
> and rtc_time_to_tm()
>=20
> Hi Alexandre,
>=20
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote=20
> 2015-04-30 AM 07:28:24:
> >=20
> > Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()=20
> > and rtc_time_to_tm()
> >=20
> > Hi,
> >=20
> > On 15/04/2015 at 17:20:11 +0800, Xunlei Pang wrote :
> > > From: Xunlei Pang <pang.xunlei@linaro.org>
> > >=20
> > > The driver uses deprecated rtc_tm_to_time() and rtc_time_to_tm(),
> > > which will overflow in year 2106 on 32-bit machines.
> > >=20
> > > This patch solves this by:
> > >  - Replacing rtc_tm_to_time() with rtc_tm_to_time64()
> > >  - Replacing rtc_time_to_tm() with rtc_time64_to_tm()
> > >=20
> > > Cc: CIH <cih@coventive.com>
> > > Cc: Nicolas Pitre <nico@fluxnic.net>
> > > Cc: Andrew Christian <andrew.christian@hp.com>
> > > Cc: Richard Purdie <rpurdie@rpsys.net>
> > > Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> > > ---
> > >  drivers/rtc/rtc-sa1100.c | 21 +++++----------------
> > >  1 file changed, 5 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> > > index b6e1ca0..625a320 100644
> > > --- a/drivers/rtc/rtc-sa1100.c
> > > +++ b/drivers/rtc/rtc-sa1100.c
> > > @@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable
> > (struct device *dev, unsigned int enabled)
> > >=20
> > >  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time=
=20
*tm)
> > >  {
> > > -   rtc_time_to_tm(RCNR, tm);
> > > +   rtc_time64_to_tm(RCNR, tm);
> > >     return 0;
> > >  }
> > >=20
> > >  static int sa1100_rtc_set_time(struct device *dev, struct rtc_time=
=20
*tm)
> > >  {
> > > -   unsigned long time;
> > > -   int ret;
> > > -
> > > -   ret =3D rtc_tm_to_time(tm, &time);
> > > -   if (ret =3D=3D 0)
> > > -      RCNR =3D time;
> > > -   return ret;
> > > +   RCNR =3D rtc_tm_to_time64(tm);
> >=20
> > For the same reason that Russell pointed in patch 4/5, this hides that
> > it doesn't work after 2106-02-07 06:28:16 as the register is still 32
> > bits.
> > I would prefer that you return an error in that case.
>=20
> Thanks for the review, I want to leave the ones like this untouched.
>=20

To further explain, for the rtc hardware with 32-bit counters, we actually=
=20

had a solution before: https://lkml.org/lkml/2014/11/27/341

But seems some guys don't like the solution, so rtc drivers like this one=
=20
can't be simply changed to use the new-added y2038-safe interfaces.

Maybe those drivers will still retain the deprecated interfaces until a=20
better solution is proposed.

Thanks,
-Xunlei
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

--=_alternative 0037661B48257E55_=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<tt><font size=3D2>PangXunLei10110855/user/zte_ltd wrote 2015-05-29 PM 10:3=
2:15:<br>
&gt; Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()
<br>
&gt; and rtc_time_to_tm()</font></tt>
<br><tt><font size=3D2>&gt; <br>
&gt; Hi Alexandre,</font></tt>
<br><tt><font size=3D2>&gt; <br>
&gt; Alexandre Belloni &lt;alexandre.belloni@free-electrons.com&gt; wrote
<br>
&gt; 2015-04-30 AM 07:28:24:<br>
&gt; &gt; <br>
&gt; &gt; Re: [5/5] drivers/rtc/sa1100: Replace deprecated rtc_tm_to_time()
<br>
&gt; &gt; and rtc_time_to_tm()</font></tt>
<br><tt><font size=3D2>&gt; &gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; On 15/04/2015 at 17:20:11 +0800, Xunlei Pang wrote :<br>
&gt; &gt; &gt; From: Xunlei Pang &lt;pang.xunlei@linaro.org&gt;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The driver uses deprecated rtc_tm_to_time() and rtc_time_to_=
tm(),<br>
&gt; &gt; &gt; which will overflow in year 2106 on 32-bit machines.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; This patch solves this by:<br>
&gt; &gt; &gt; &nbsp;- Replacing rtc_tm_to_time() with rtc_tm_to_time64()<b=
r>
&gt; &gt; &gt; &nbsp;- Replacing rtc_time_to_tm() with rtc_time64_to_tm()<b=
r>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Cc: CIH &lt;cih@coventive.com&gt;<br>
&gt; &gt; &gt; Cc: Nicolas Pitre &lt;nico@fluxnic.net&gt;<br>
&gt; &gt; &gt; Cc: Andrew Christian &lt;andrew.christian@hp.com&gt;<br>
&gt; &gt; &gt; Cc: Richard Purdie &lt;rpurdie@rpsys.net&gt;<br>
&gt; &gt; &gt; Signed-off-by: Xunlei Pang &lt;pang.xunlei@linaro.org&gt;<br=
>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &nbsp;drivers/rtc/rtc-sa1100.c | 21 +++++----------------<br=
>
&gt; &gt; &gt; &nbsp;1 file changed, 5 insertions(+), 16 deletions(-)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa11=
00.c<br>
&gt; &gt; &gt; index b6e1ca0..625a320 100644<br>
&gt; &gt; &gt; --- a/drivers/rtc/rtc-sa1100.c<br>
&gt; &gt; &gt; +++ b/drivers/rtc/rtc-sa1100.c<br>
&gt; &gt; &gt; @@ -157,19 +157,14 @@ static int sa1100_rtc_alarm_irq_enable=
<br>
&gt; &gt; (struct device *dev, unsigned int enabled)<br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; &nbsp;static int sa1100_rtc_read_time(struct device *dev,
struct rtc_time *tm)<br>
&gt; &gt; &gt; &nbsp;{<br>
&gt; &gt; &gt; - &nbsp; rtc_time_to_tm(RCNR, tm);<br>
&gt; &gt; &gt; + &nbsp; rtc_time64_to_tm(RCNR, tm);<br>
&gt; &gt; &gt; &nbsp; &nbsp; return 0;<br>
&gt; &gt; &gt; &nbsp;}<br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; &nbsp;static int sa1100_rtc_set_time(struct device *dev,
struct rtc_time *tm)<br>
&gt; &gt; &gt; &nbsp;{<br>
&gt; &gt; &gt; - &nbsp; unsigned long time;<br>
&gt; &gt; &gt; - &nbsp; int ret;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; - &nbsp; ret =3D rtc_tm_to_time(tm, &amp;time);<br>
&gt; &gt; &gt; - &nbsp; if (ret =3D=3D 0)<br>
&gt; &gt; &gt; - &nbsp; &nbsp; &nbsp;RCNR =3D time;<br>
&gt; &gt; &gt; - &nbsp; return ret;<br>
&gt; &gt; &gt; + &nbsp; RCNR =3D rtc_tm_to_time64(tm);<br>
&gt; &gt; <br>
&gt; &gt; For the same reason that Russell pointed in patch 4/5, this hides
that<br>
&gt; &gt; it doesn't work after 2106-02-07 06:28:16 as the register is
still 32<br>
&gt; &gt; bits.<br>
&gt; &gt; I would prefer that you return an error in that case.</font></tt>
<br><tt><font size=3D2>&gt; <br>
&gt; Thanks for the review, I want to leave the ones like this untouched.</=
font></tt>
<br><tt><font size=3D2>&gt; </font></tt>
<br>
<br><tt><font size=3D2>To further explain, for the rtc hardware with 32-bit
counters, we actually </font></tt>
<br><tt><font size=3D2>had a solution before: </font></tt><a href=3Dhttps:/=
/lkml.org/lkml/2014/11/27/341><tt><font size=3D2>https://lkml.org/lkml/2014=
/11/27/341</font></tt></a>
<br>
<br><tt><font size=3D2>But seems some guys don't like the solution, so rtc
drivers like this one </font></tt>
<br><tt><font size=3D2>can't be simply changed to use the new-added y2038-s=
afe
interfaces.</font></tt>
<br>
<br><tt><font size=3D2>Maybe those drivers will still retain the deprecated
interfaces until a </font></tt>
<br><tt><font size=3D2>better solution is proposed.</font></tt>
<br>
<br><tt><font size=3D2>Thanks,</font></tt>
<br><tt><font size=3D2>-Xunlei</font></tt>
<br>

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

--=_alternative 0037661B48257E55_=--
