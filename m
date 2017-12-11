Return-Path: <rabeeh@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <871skewf05.fsf@free-electrons.com>
References: <20171130094049.fg3zoxgvhlb7jqw3@tarshish> <871skewf05.fsf@free-electrons.com>
From: Rabeeh Khoury <rabeeh@solid-run.com>
Date: Mon, 11 Dec 2017 14:46:41 +0200
Message-ID: <CA+j0ot=PqFYwN=+zUc5F1uyXQoB9dX1gmwxTbXP-QdzQU+zspQ@mail.gmail.com>
Subject: Re: Armada RTC power up reset
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org,
	"nadavh@marvell.com" <nadavh@marvell.com>
Content-Type: multipart/alternative; boundary="089e08211e902024cd05600fed56"
List-ID: <linux-rtc.vger.kernel.org>

--089e08211e902024cd05600fed56
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, Dec 1, 2017 at 7:10 PM, Gregory CLEMENT <
gregory.clement@free-electrons.com> wrote:

> Hi Baruch,
>
>  On jeu., nov. 30 2017, Baruch Siach <baruch@tkos.co.il> wrote:
>
> > Hi Thomas,
> >
> > As you know, the Armada 38x/8k RTC needs a reset sequence to be
> operational
> > when first powered up. This reset code is currently in the vendor
> provided
> > U-Boot RTC driver. But having to run 'date reset' from the U-Boot prompt
> every
> > first boot (happens quite a lot when dealing with SOMs) is not nice. An
> > automatic reset in the kernel driver would be much better.
> >
> > Rabeeh has mentioned to me that you had an idea how to detect at run
> time that
> > the RTC is in first power up state. Do you recall the details?
>
> Actually it was me who worked on the RTC but I didn't remember having a
> way to detect that the RTC is in first power up state. I dig in the
> datasheet, errata sheet and alos on varisou branches of the vendor tree
> and didn't find anything.
>
> Maybe a solution could be to reset the RTC when we set the time.
>


This is one way to do it; but then on first boot you might get real awkward
time; like year 2035 which can seriously confuse the boot process.
Detecting an uninitialized RTC and forcing it to tick with time = 0 (i.e.
1970) is better way since boot failures can be reproduced in an orderly
manner (and the developer would know what was really wrong).

Now for the point; I was reviewing all the bits in the RTC unit when it's
stuck; there are few bits that can indicate an uninitialized state; for
instance - RTC test configuration register (0xa381c).
I'm getting random values in bits [7:0] where it should be 0x0; we can this
as an indication; but the tip I got from Nadavh (CCed) is that Thomas (and
probably you) have found a bit that we can rely on to detect a stuck state
that can trigger a reset of the RTC on device probe.

Any ideas?

Regards,
Rabeeh

--089e08211e902024cd05600fed56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gregory,<br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Dec 1, 2017 at 7:10 PM, Gregory CLEMENT <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gregory.clement@free-electrons.com" target=
=3D"_blank">gregory.clement@free-electron<wbr>s.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Hi Baruch,<br>
<span><br>
=C2=A0On jeu., nov. 30 2017, Baruch Siach &lt;<a href=3D"mailto:baruch@tkos=
.co.il" target=3D"_blank">baruch@tkos.co.il</a>&gt; wrote:<br>
<br>
&gt; Hi Thomas,<br>
&gt;<br>
&gt; As you know, the Armada 38x/8k RTC needs a reset sequence to be operat=
ional<br>
&gt; when first powered up. This reset code is currently in the vendor prov=
ided<br>
&gt; U-Boot RTC driver. But having to run &#39;date reset&#39; from the U-B=
oot prompt every<br>
&gt; first boot (happens quite a lot when dealing with SOMs) is not nice. A=
n<br>
&gt; automatic reset in the kernel driver would be much better.<br>
&gt;<br>
&gt; Rabeeh has mentioned to me that you had an idea how to detect at run t=
ime that<br>
&gt; the RTC is in first power up state. Do you recall the details?<br>
<br>
</span>Actually it was me who worked on the RTC but I didn&#39;t remember h=
aving a<br>
way to detect that the RTC is in first power up state. I dig in the<br>
datasheet, errata sheet and alos on varisou branches of the vendor tree<br>
and didn&#39;t find anything.<br>
<br>
Maybe a solution could be to reset the RTC when we set the time.<br></block=
quote><div><br></div><div><br></div><div>This is one way to do it; but then=
 on first boot you might get real awkward time; like year 2035 which can se=
riously confuse the boot process.</div><div>Detecting an uninitialized RTC =
and forcing it to tick with time =3D 0 (i.e. 1970) is better way since boot=
 failures can be reproduced in an orderly manner (and the developer would k=
now what was really wrong).</div><div><br></div><div>Now for the point; I w=
as reviewing all the bits in the RTC unit when it&#39;s stuck; there are fe=
w bits that can indicate an uninitialized state; for instance - RTC test co=
nfiguration register (0xa381c).<br></div><div>I&#39;m getting random values=
 in bits [7:0] where it should be 0x0; we can this as an indication; but th=
e tip I got from Nadavh (CCed) is that Thomas (and probably you) have found=
 a bit that we can rely on to detect a stuck state that can trigger a reset=
 of the RTC on device probe.</div><div><br></div><div>Any ideas?</div><div>=
<br></div><div>Regards,</div><div>Rabeeh</div><div><br></div></div></div></=
div>

--089e08211e902024cd05600fed56--
