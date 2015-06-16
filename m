Return-Path: <rtc-linux+bncBCSIRPX5CUIPRQMBVQCRUBAQKT2EE@googlegroups.com>
Date: Tue, 16 Jun 2015 10:46:31 -0700 (PDT)
From: Alexey Mednyy <swexru@gmail.com>
To: rtc-linux@googlegroups.com
Message-Id: <87a8cf00-e052-4000-acc3-f7807950664a@googlegroups.com>
In-Reply-To: <CAJKOXPd2uPW9ivdj_FF8jCYOEkmj2OgGMxKUqo8QOpei0FgTVQ@mail.gmail.com>
References: <13a98422-3d30-4ff0-a4b9-ecf67ed0a757@googlegroups.com>
 <CAJKOXPd2uPW9ivdj_FF8jCYOEkmj2OgGMxKUqo8QOpei0FgTVQ@mail.gmail.com>
Subject: Re: [rtc-linux] [QUESTION] rtc and regmap_irq wakeup
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_810_1827390077.1434476791717"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_810_1827390077.1434476791717
Content-Type: multipart/alternative;
	boundary="----=_Part_811_1781388392.1434476791717"

------=_Part_811_1781388392.1434476791717
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 16, 2015 at 3:59:34 AM UTC+3, Krzysztof Koz=C5=82owski wro=
te:
>
> 2015-06-16 3:26 GMT+09:00 Alexey Mednyy <swe...@gmail.com <javascript:>>:=
=20
> >=20
> > Hello all!=20
> >=20
> > I'm trying to add wakealarm support to rtc-mc13xxx driver. But I've=20
> faced some troubles.=20
> >=20
> > It's using nested IRQs over mc13xxx-core driver.=20
> > What I've done:=20
> > 1. Added device_init_wakeup to both mc13xxx-core (parent irq) and to=20
> rtc-mc13xxx=20
> > 2. Added dev_pm_ops to both core and rtc=20
> > 3. Added enable_irq_wake to core suspend for core irq=20
>
> Consider adding it also in RTC driver.=20
>

I tried, no luck.
=20

>
> >=20
> > 4. Disabled 1HZ irq in rtc-mc13xxx ( do not wakeup after 1 second)=20
> >=20
> > Now I've got wakealarm file and I can write to it. But device doesn't=
=20
> wakeup.=20
>
> Does the wakealarm work fine without suspend? You can easily test it=20
> with rtcwake.=20
>

Yes it works like that:
rtcwake -v -d /dev/rtc0 -s 5 -m on

But not working with real suspend to mem.

For some reason irq become masked while suspending, as I mentioned in=20
before:

I've added some printk's to suspend core suspend (as it goes after child=20
> suspend) and I can see that IRQ_TODA bit of IRQ_MASK1 register in mc13xxx=
=20
> is masked(turned off).
> For some reason rtc or regmap irq, disabled TODA irq before suspend.
> Can't figure why.=20

=20
So questions still the same:

1. Why TODA irq turned off before suspend?
2. Is there any restrictions in IRQs, rtc can use for wakeup? Could it be=
=20
regmap_irq_chips irq?

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

------=_Part_811_1781388392.1434476791717
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tuesday, June 16, 2015 at 3:59:34 AM UTC+3, Krzysztof K=
oz=C5=82owski wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;ma=
rgin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">2015-06-16=
 3:26 GMT+09:00 Alexey Mednyy &lt;<a href=3D"javascript:" target=3D"_blank"=
 gdf-obfuscated-mailto=3D"3k1tphkI5IQJ" rel=3D"nofollow" onmousedown=3D"thi=
s.href=3D'javascript:';return true;" onclick=3D"this.href=3D'javascript:';r=
eturn true;">swe...@gmail.com</a>&gt;:
<br>&gt;
<br>&gt; Hello all!
<br>&gt;
<br>&gt; I'm trying to add wakealarm support to rtc-mc13xxx driver. But I'v=
e faced some troubles.
<br>&gt;
<br>&gt; It's using nested IRQs over mc13xxx-core driver.
<br>&gt; What I've done:
<br>&gt; 1. Added device_init_wakeup to both mc13xxx-core (parent irq) and =
to rtc-mc13xxx
<br>&gt; 2. Added dev_pm_ops to both core and rtc
<br>&gt; 3. Added enable_irq_wake to core suspend for core irq
<br>
<br>Consider adding it also in RTC driver.
<br></blockquote><div><br>I tried, no luck.<br>&nbsp;<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1p=
x #ccc solid;padding-left: 1ex;">
<br>&gt;
<br>&gt; 4. Disabled 1HZ irq in rtc-mc13xxx ( do not wakeup after 1 second)
<br>&gt;
<br>&gt; Now I've got wakealarm file and I can write to it. But device does=
n't wakeup.
<br>
<br>Does the wakealarm work fine without suspend? You can easily test it
<br>with rtcwake.
<br></blockquote><br>Yes it works like that:<br>rtcwake -v -d /dev/rtc0 -s =
5 -m on<br><br>But not working with real suspend to mem.<br><br>For some re=
ason irq become masked while suspending, as I mentioned in before:<br><br><=
blockquote style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(2=
04, 204, 204); padding-left: 1ex;" class=3D"gmail_quote">I've added some pr=
intk's to suspend core suspend (as it goes after child
 suspend) and I can see that IRQ_TODA bit of IRQ_MASK1 register in=20
mc13xxx is masked(turned off).<br>For some reason rtc or regmap irq, disabl=
ed TODA irq before suspend.<br>Can't figure why. </blockquote><div>&nbsp;</=
div>So questions still the same:<br><br>1. Why TODA irq turned off before s=
uspend?<br>2. Is there any <span lang=3D"en"><span>restrictions in IRQs, rt=
c can use for wakeup?</span></span> Could it be regmap_irq_chips irq?<br></=
div>

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

------=_Part_811_1781388392.1434476791717--

------=_Part_810_1827390077.1434476791717--
