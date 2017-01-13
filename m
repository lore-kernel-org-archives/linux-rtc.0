Return-Path: <rtc-linux+bncBCO2N6GP2YDRBGNC4TBQKGQERO3ND4Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Date: Fri, 13 Jan 2017 09:40:40 -0800 (PST)
From: adelaunay.stm32@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: amelie.delaunay@st.com, alexandre.belloni@free-electrons.com,
	broonie@kernel.org, a.zummo@towertech.it, mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com, mathieu.poirier@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de
Message-Id: <9bb9454e-5c19-4212-ab9a-863249782301@googlegroups.com>
In-Reply-To: <CAK8P3a3vzwB5MDiVse+meK17KKHtaZWzmOkfzJ2d=n=sgjzkRw@mail.gmail.com>
References: <20170113153311.2611510-1-arnd@arndb.de> <20170113153311.2611510-3-arnd@arndb.de>
 <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
 <CAK8P3a3vzwB5MDiVse+meK17KKHtaZWzmOkfzJ2d=n=sgjzkRw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_680_358861466.1484329240516"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_680_358861466.1484329240516
Content-Type: multipart/alternative;
	boundary="----=_Part_681_332200871.1484329240516"

------=_Part_681_332200871.1484329240516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le vendredi 13 janvier 2017 17:48:50 UTC+1, Arnd Bergmann a =C3=A9crit :
>
> On Fri, Jan 13, 2017 at 4:56 PM, Amelie DELAUNAY <amelie....@st.com=20
> <javascript:>> wrote:=20
> > On 01/13/2017 04:32 PM, Arnd Bergmann wrote:=20
> >>=20
> >> Using the ~ operator on a BIT() constant results in a large 'unsigned=
=20
> >> long'=20
> >> constant that won't fit into an 'unsigned int' function argument on=20
> 64-bit=20
> >> architectures, resulting in a harmless build warning in x86=20
> allmodconfig:=20
> >>=20
> >> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':=20
> >> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly=20
> truncated=20
> >> to unsigned type [-Werror=3Doverflow]=20
> >>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);=20
> >=20
> > I thought I would fix this warning by replacing all ~PWR_CR_DBP by 0,=
=20
> > because the mask PWR_CR_DBP prevents other bits to be cleared.=20
> > In this way, I avoid the ugly cast...=20
>
> Good idea, much nicer than mine! Can you send that patch?=20
>
>     Arnd

=20
If it can wait Monday, yes.
Amelie

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

------=_Part_681_332200871.1484329240516
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Le vendredi 13 janvier 2017 17:48:50 UTC+1, Arnd Bergmann =
a =C3=A9crit=C2=A0:<blockquote class=3D"gmail_quote" style=3D"margin: 0;mar=
gin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On Fri, Jan=
 13, 2017 at 4:56 PM, Amelie DELAUNAY &lt;<a href=3D"javascript:" target=3D=
"_blank" gdf-obfuscated-mailto=3D"mGuNuoufEAAJ" rel=3D"nofollow" onmousedow=
n=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=
=3D&#39;javascript:&#39;;return true;">amelie....@st.com</a>&gt; wrote:
<br>&gt; On 01/13/2017 04:32 PM, Arnd Bergmann wrote:
<br>&gt;&gt;
<br>&gt;&gt; Using the ~ operator on a BIT() constant results in a large &#=
39;unsigned
<br>&gt;&gt; long&#39;
<br>&gt;&gt; constant that won&#39;t fit into an &#39;unsigned int&#39; fun=
ction argument on 64-bit
<br>&gt;&gt; architectures, resulting in a harmless build warning in x86 al=
lmodconfig:
<br>&gt;&gt;
<br>&gt;&gt; drivers/rtc/rtc-stm32.c: In function &#39;stm32_rtc_probe&#39;=
:
<br>&gt;&gt; drivers/rtc/rtc-stm32.c:651:<wbr>51: error: large integer impl=
icitly truncated
<br>&gt;&gt; to unsigned type [-Werror=3Doverflow]
<br>&gt;&gt; =C2=A0 regmap_update_bits(rtc-&gt;dbp, PWR_CR, PWR_CR_DBP, ~PW=
R_CR_DBP);
<br>&gt;
<br>&gt; I thought I would fix this warning by replacing all ~PWR_CR_DBP by=
 0,
<br>&gt; because the mask PWR_CR_DBP prevents other bits to be cleared.
<br>&gt; In this way, I avoid the ugly cast...
<br>
<br>Good idea, much nicer than mine! Can you send that patch?
<br>
<br>=C2=A0 =C2=A0 Arnd</blockquote><div>=C2=A0</div><div>If it can wait Mon=
day, yes.<br>Amelie<br></div></div>

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

------=_Part_681_332200871.1484329240516--

------=_Part_680_358861466.1484329240516--
