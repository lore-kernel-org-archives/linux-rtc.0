Return-Path: <rtc-linux+bncBDMLZJ6I5AIBBBNEWK6QKGQED3BOS4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Date: Thu, 11 Aug 2016 07:56:03 -0700 (PDT)
From: danielromell@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: danielromell@gmail.com, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org, daro@hms.se, jao@hms.se, mago@hms.se
Message-Id: <5b6636b7-ff29-458b-b566-4b97e401b794@googlegroups.com>
In-Reply-To: <20160811134257.GH8132@piout.net>
References: <1470909555-9226-1-git-send-email-daro@hms.se>
 <1470915104-10683-2-git-send-email-daro@hms.se>
 <20160811134257.GH8132@piout.net>
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: bq32k: Use correct mask name for
 'minutes' register.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_752_1398190889.1470927363702"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_752_1398190889.1470927363702
Content-Type: multipart/alternative;
	boundary="----=_Part_753_619770547.1470927363702"

------=_Part_753_619770547.1470927363702
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Den torsdag 11 augusti 2016 kl. 15:42:58 UTC+2 skrev alexandre.belloni:
>
> On 11/08/2016 at 13:31:43 +0200, Daniel Romell wrote :=20
> > From: Jan =C3=96stlund <j...@hms.se <javascript:>>=20
> >=20
> > The BQ32K_SECONDS_MASK and BQ32K_MINUTES_MASK both has the same=20
> > value. This is no functional change.=20
> >=20
> > Signed-off-by: Daniel Romell <da...@hms.se <javascript:>>=20
>
> Sorry, I saw it only before trying apply but both patches also need Jan's=
=20
> SoB.=20
>

Ah, sorry, my bad. I'll ask him to add that.=20
Is it ok if he just reply to the emails with his SoB line, or do you need a=
=20
new patch set? =20

>
> > ---=20
> >  drivers/rtc/rtc-bq32k.c | 2 +-=20
> >  1 file changed, 1 insertion(+), 1 deletion(-)=20
> >=20
> > diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c=20
> > index 0299988..5a0c137 100644=20
> > --- a/drivers/rtc/rtc-bq32k.c=20
> > +++ b/drivers/rtc/rtc-bq32k.c=20
> > @@ -94,7 +94,7 @@ static int bq32k_rtc_read_time(struct device *dev,=20
> struct rtc_time *tm)=20
> >                  return error;=20
> >  =20
> >          tm->tm_sec =3D bcd2bin(regs.seconds & BQ32K_SECONDS_MASK);=20
> > -        tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_SECONDS_MASK);=20
> > +        tm->tm_min =3D bcd2bin(regs.minutes & BQ32K_MINUTES_MASK);=20
> >          tm->tm_hour =3D bcd2bin(regs.cent_hours & BQ32K_HOURS_MASK);=
=20
> >          tm->tm_mday =3D bcd2bin(regs.date);=20
> >          tm->tm_wday =3D bcd2bin(regs.day) - 1;=20
> > --=20
> > 2.7.4=20
> >=20
>
> --=20
> Alexandre Belloni, Free Electrons=20
> Embedded Linux and Kernel engineering=20
> http://free-electrons.com=20
>

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

------=_Part_753_619770547.1470927363702
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>Den torsdag 11 augusti 2016 kl. 15:42:58 UTC+2 skr=
ev alexandre.belloni:<blockquote class=3D"gmail_quote" style=3D"margin: 0;m=
argin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On 11/08/=
2016 at 13:31:43 +0200, Daniel Romell wrote :
<br>&gt; From: Jan =C3=96stlund &lt;<a href=3D"javascript:" target=3D"_blan=
k" gdf-obfuscated-mailto=3D"BgHE7s_AAwAJ" rel=3D"nofollow" onmousedown=3D"t=
his.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;=
javascript:&#39;;return true;">j...@hms.se</a>&gt;
<br>&gt;=20
<br>&gt; The BQ32K_SECONDS_MASK and BQ32K_MINUTES_MASK both has the same
<br>&gt; value. This is no functional change.
<br>&gt;=20
<br>&gt; Signed-off-by: Daniel Romell &lt;<a href=3D"javascript:" target=3D=
"_blank" gdf-obfuscated-mailto=3D"BgHE7s_AAwAJ" rel=3D"nofollow" onmousedow=
n=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=
=3D&#39;javascript:&#39;;return true;">da...@hms.se</a>&gt;
<br>
<br>Sorry, I saw it only before trying apply but both patches also need Jan=
&#39;s SoB.
<br></blockquote><div><br></div><div>Ah, sorry, my bad. I&#39;ll ask him to=
 add that.=C2=A0</div><div>Is it ok if he just reply to the emails with his=
 SoB line, or do you need a new patch set? =C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc s=
olid;padding-left: 1ex;">
<br>&gt; ---
<br>&gt; =C2=A0drivers/rtc/rtc-bq32k.c | 2 +-
<br>&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
<br>&gt;=20
<br>&gt; diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
<br>&gt; index 0299988..5a0c137 100644
<br>&gt; --- a/drivers/rtc/rtc-bq32k.c
<br>&gt; +++ b/drivers/rtc/rtc-bq32k.c
<br>&gt; @@ -94,7 +94,7 @@ static int bq32k_rtc_read_time(struct device *de=
v, struct rtc_time *tm)
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return error;
<br>&gt; =C2=A0
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_se=
c =3D bcd2bin(regs.seconds &amp; BQ32K_SECONDS_MASK);
<br>&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_min =3D=
 bcd2bin(regs.minutes &amp; BQ32K_SECONDS_MASK);
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_min =3D=
 bcd2bin(regs.minutes &amp; BQ32K_MINUTES_MASK);
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_ho=
ur =3D bcd2bin(regs.cent_hours &amp; BQ32K_HOURS_MASK);
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_md=
ay =3D bcd2bin(regs.date);
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tm-&gt;tm_wd=
ay =3D bcd2bin(regs.day) - 1;
<br>&gt; --=20
<br>&gt; 2.7.4
<br>&gt;=20
<br>
<br>--=20
<br>Alexandre Belloni, Free Electrons
<br>Embedded Linux and Kernel engineering
<br><a href=3D"http://free-electrons.com" target=3D"_blank" rel=3D"nofollow=
" onmousedown=3D"this.href=3D&#39;http://www.google.com/url?q\x3dhttp%3A%2F=
%2Ffree-electrons.com\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNGC8C9pT7xKJEa=
bITLGL5cqtolifQ&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.g=
oogle.com/url?q\x3dhttp%3A%2F%2Ffree-electrons.com\x26sa\x3dD\x26sntz\x3d1\=
x26usg\x3dAFQjCNGC8C9pT7xKJEabITLGL5cqtolifQ&#39;;return true;">http://free=
-electrons.com</a>
<br></blockquote></div>

<p></p>

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

------=_Part_753_619770547.1470927363702--

------=_Part_752_1398190889.1470927363702--
