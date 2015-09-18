Return-Path: <rtc-linux+bncBCZ7NMHQ3YLRBANP6KXQKGQE4JLAEJA@googlegroups.com>
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com. [2a00:1450:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id ch7si13016wib.2.2015.09.18.16.00.17
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2015 16:00:17 -0700 (PDT)
Received: by mail-wi0-x22b.google.com with SMTP id gb1so49780198wic.1
        for <rtc-linux@googlegroups.com>; Fri, 18 Sep 2015 16:00:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150918220148.GH4287@piout.net>
References: <1442590077-29816-1-git-send-email-grimaldi.ivan@gmail.com> <20150918220148.GH4287@piout.net>
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Date: Sat, 19 Sep 2015 00:59:57 +0200
Message-ID: <CAO1575Xr1DUfkTtd8_DBQb5crH29q9cTrDYZQ2ohpLrfLDs65g@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH v3 1/2] Fixed ds1390_get_reg returned value
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, mpfj@mimc.co.uk, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d043bdb0ec5834105200d7ee9
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--f46d043bdb0ec5834105200d7ee9
Content-Type: text/plain; charset=UTF-8

I'm sorry, but I had trouble with my client behind the corporate proxy.

The correct version of the patches are version 3; if you have problems with
them, I can resend to you (I promise this time I will send it only once
:-)).

Next time I add also the changelog.

Ivan

2015-09-19 0:01 GMT+02:00 Alexandre Belloni <
alexandre.belloni@free-electrons.com>:

> Hi,
>
> You've sent that series so many times that I'm not sure which one I
> should look at...
>
> Also, please include a changelog when submitting a new version of a
> patch.
>
> On 18/09/2015 at 17:27:56 +0200, Ivan Grimaldi wrote :
> > spi_write_then_read puts in rx_buf the received data starting from
> > the first byte of the rx_buf
> >
> > Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
> > ---
> >  drivers/rtc/rtc-ds1390.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
> > index e67bfcb..a4303b4 100644
> > --- a/drivers/rtc/rtc-ds1390.c
> > +++ b/drivers/rtc/rtc-ds1390.c
> > @@ -62,7 +62,7 @@ static int ds1390_get_reg(struct device *dev, unsigned
> char address,
> >       if (status != 0)
> >               return status;
> >
> > -     *data = chip->txrx_buf[1];
> > +     *data = chip->txrx_buf[0];
> >
> >       return 0;
> >  }
> > --
> > 2.5.2
> >
> > --
> > --
> > You received this message because you are subscribed to "rtc-linux".
> > Membership options at http://groups.google.com/group/rtc-linux .
> > Please read http://groups.google.com/group/rtc-linux/web/checklist
> > before submitting a driver.
> > ---
> > You received this message because you are subscribed to the Google
> Groups "rtc-linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> an email to rtc-linux+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
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

--f46d043bdb0ec5834105200d7ee9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;m sorry, but I had trouble with my client =
behind the corporate proxy.</div><div><br></div><div>The correct version of=
 the patches are version 3; if you have problems with them, I can resend to=
 you (I promise this time I will send it only once :-)).</div><div><br></di=
v><div>Next time I add also the changelog.</div><div><br></div><div>Ivan</d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-09-=
19 0:01 GMT+02:00 Alexandre Belloni <span dir=3D"ltr">&lt;<a href=3D"mailto=
:alexandre.belloni@free-electrons.com" target=3D"_blank">alexandre.belloni@=
free-electrons.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex">Hi,<br>
<br>
You&#39;ve sent that series so many times that I&#39;m not sure which one I=
<br>
should look at...<br>
<br>
Also, please include a changelog when submitting a new version of a<br>
patch.<br>
<div><div><br>
On 18/09/2015 at 17:27:56 +0200, Ivan Grimaldi wrote :<br>
&gt; spi_write_then_read puts in rx_buf the received data starting from<br>
&gt; the first byte of the rx_buf<br>
&gt;<br>
&gt; Signed-off-by: Ivan Grimaldi &lt;<a href=3D"mailto:grimaldi.ivan@gmail=
.com" target=3D"_blank">grimaldi.ivan@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/rtc/rtc-ds1390.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c<br>
&gt; index e67bfcb..a4303b4 100644<br>
&gt; --- a/drivers/rtc/rtc-ds1390.c<br>
&gt; +++ b/drivers/rtc/rtc-ds1390.c<br>
&gt; @@ -62,7 +62,7 @@ static int ds1390_get_reg(struct device *dev, unsign=
ed char address,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (status !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<b=
r>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0*data =3D chip-&gt;txrx_buf[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*data =3D chip-&gt;txrx_buf[0];<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; --<br>
&gt; 2.5.2<br>
&gt;<br>
</div></div>&gt; --<br>
<span><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to &quot;rtc-linu=
x&quot;.<br>
&gt; Membership options at <a href=3D"http://groups.google.com/group/rtc-li=
nux" rel=3D"noreferrer" target=3D"_blank">http://groups.google.com/group/rt=
c-linux</a> .<br>
&gt; Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/ch=
ecklist" rel=3D"noreferrer" target=3D"_blank">http://groups.google.com/grou=
p/rtc-linux/web/checklist</a><br>
&gt; before submitting a driver.<br>
&gt; ---<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups &quot;rtc-linux&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an email to <a href=3D"mailto:rtc-linux%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">rtc-linux+unsubscribe@googlegroups.com</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/optout</a=
>.<br>
<br>
--<br>
Alexandre Belloni, Free Electrons<br>
Embedded Linux, Kernel and Android engineering<br>
<a href=3D"http://free-electrons.com" rel=3D"noreferrer" target=3D"_blank">=
http://free-electrons.com</a><br>
</font></span></blockquote></div><br></div></div>

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

--f46d043bdb0ec5834105200d7ee9--
