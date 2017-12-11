Return-Path: <rabeeh@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20171211160835.GC32306@piout.net>
References: <20171130094049.fg3zoxgvhlb7jqw3@tarshish> <871skewf05.fsf@free-electrons.com>
 <CA+j0ot=PqFYwN=+zUc5F1uyXQoB9dX1gmwxTbXP-QdzQU+zspQ@mail.gmail.com> <20171211160835.GC32306@piout.net>
From: Rabeeh Khoury <rabeeh@solid-run.com>
Date: Mon, 11 Dec 2017 20:14:00 +0200
Message-ID: <CA+j0otm7EeY034nXj8ESYwSaP3JPuV7OoUS+1+GkQ7eOEAOCuw@mail.gmail.com>
Subject: Re: Armada RTC power up reset
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Baruch Siach <baruch@tkos.co.il>, linux-rtc@vger.kernel.org,
	"nadavh@marvell.com" <nadavh@marvell.com>
Content-Type: multipart/alternative; boundary="f40304364ef8b19b6b0560147f44"
List-ID: <linux-rtc.vger.kernel.org>

--f40304364ef8b19b6b0560147f44
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 11, 2017 at 6:08 PM, Alexandre Belloni <
alexandre.belloni@free-electrons.com> wrote:

> On 11/12/2017 at 14:46:41 +0200, Rabeeh Khoury wrote:
> > On Fri, Dec 1, 2017 at 7:10 PM, Gregory CLEMENT <
> > gregory.clement@free-electrons.com> wrote:
> >
> > > Hi Baruch,
> > >
> > >  On jeu., nov. 30 2017, Baruch Siach <baruch@tkos.co.il> wrote:
> > >
> > > > Hi Thomas,
> > > >
> > > > As you know, the Armada 38x/8k RTC needs a reset sequence to be
> > > operational
> > > > when first powered up. This reset code is currently in the vendor
> > > provided
> > > > U-Boot RTC driver. But having to run 'date reset' from the U-Boot
> prompt
> > > every
> > > > first boot (happens quite a lot when dealing with SOMs) is not nice.
> An
> > > > automatic reset in the kernel driver would be much better.
> > > >
> > > > Rabeeh has mentioned to me that you had an idea how to detect at run
> > > time that
> > > > the RTC is in first power up state. Do you recall the details?
> > >
> > > Actually it was me who worked on the RTC but I didn't remember having a
> > > way to detect that the RTC is in first power up state. I dig in the
> > > datasheet, errata sheet and alos on varisou branches of the vendor tree
> > > and didn't find anything.
> > >
> > > Maybe a solution could be to reset the RTC when we set the time.
> > >
> >
> >
> > This is one way to do it; but then on first boot you might get real
> awkward
> > time; like year 2035 which can seriously confuse the boot process.
> > Detecting an uninitialized RTC and forcing it to tick with time = 0 (i.e.
> > 1970) is better way since boot failures can be reproduced in an orderly
> > manner (and the developer would know what was really wrong).
>
> Certainly not. If you know the time is invalid, then just return an
> error. Else, userspace has no way to know whether it can rely on the
> time from the RTC and act accordingly.
>
Part of the problem is that you don't know if the time is valid or not; you
can look at some bits and try to guess.
For instance the test conf register gets random values on it's low [7:0]
value which can be used to tell if the RTC is in a initialized condition or
not.

Please look at the following two options -

The first; sets the values to a know good state (including time=0) on it's
probe() -
https://pastebin.com/ubqwEBBM

Second return -EPERM on an uninitialized RTC until first write resets it's
values to a known condition on first write (as Gregory suggest) -
https://pastebin.com/r7sydF8G

Suggestion?

--f40304364ef8b19b6b0560147f44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Dec 11, 2017 at 6:08 PM, Alexandre Belloni <span dir=3D"ltr">&l=
t;<a href=3D"mailto:alexandre.belloni@free-electrons.com" target=3D"_blank"=
>alexandre.belloni@free-electrons.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div class=3D"gmail-HOEnZb"><div clas=
s=3D"gmail-h5">On 11/12/2017 at 14:46:41 +0200, Rabeeh Khoury wrote:<br>
&gt; On Fri, Dec 1, 2017 at 7:10 PM, Gregory CLEMENT &lt;<br>
&gt; <a href=3D"mailto:gregory.clement@free-electrons.com">gregory.clement@=
free-<wbr>electrons.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hi Baruch,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 On jeu., nov. 30 2017, Baruch Siach &lt;<a href=3D"mailto:b=
aruch@tkos.co.il">baruch@tkos.co.il</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; Hi Thomas,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As you know, the Armada 38x/8k RTC needs a reset sequence to=
 be<br>
&gt; &gt; operational<br>
&gt; &gt; &gt; when first powered up. This reset code is currently in the v=
endor<br>
&gt; &gt; provided<br>
&gt; &gt; &gt; U-Boot RTC driver. But having to run &#39;date reset&#39; fr=
om the U-Boot prompt<br>
&gt; &gt; every<br>
&gt; &gt; &gt; first boot (happens quite a lot when dealing with SOMs) is n=
ot nice. An<br>
&gt; &gt; &gt; automatic reset in the kernel driver would be much better.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Rabeeh has mentioned to me that you had an idea how to detec=
t at run<br>
&gt; &gt; time that<br>
&gt; &gt; &gt; the RTC is in first power up state. Do you recall the detail=
s?<br>
&gt; &gt;<br>
&gt; &gt; Actually it was me who worked on the RTC but I didn&#39;t remembe=
r having a<br>
&gt; &gt; way to detect that the RTC is in first power up state. I dig in t=
he<br>
&gt; &gt; datasheet, errata sheet and alos on varisou branches of the vendo=
r tree<br>
&gt; &gt; and didn&#39;t find anything.<br>
&gt; &gt;<br>
&gt; &gt; Maybe a solution could be to reset the RTC when we set the time.<=
br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; This is one way to do it; but then on first boot you might get real aw=
kward<br>
&gt; time; like year 2035 which can seriously confuse the boot process.<br>
&gt; Detecting an uninitialized RTC and forcing it to tick with time =3D 0 =
(i.e.<br>
&gt; 1970) is better way since boot failures can be reproduced in an orderl=
y<br>
&gt; manner (and the developer would know what was really wrong).<br>
<br>
</div></div>Certainly not. If you know the time is invalid, then just retur=
n an<br>
error. Else, userspace has no way to know whether it can rely on the<br>
time from the RTC and act accordingly.<br></blockquote><div>Part of the pro=
blem is that you don&#39;t know if the time is valid or not; you can look a=
t some bits and try to guess.</div><div>For instance the test conf register=
 gets random values on it&#39;s low [7:0] value which can be used to tell i=
f the RTC is in a initialized condition or not.</div><div><br></div><div>Pl=
ease look at the following two options -</div><div><br></div><div>The first=
; sets the values to a know good state (including time=3D0) on it&#39;s pro=
be() -</div><div><a href=3D"https://pastebin.com/ubqwEBBM">https://pastebin=
.com/ubqwEBBM</a></div><div><br></div><div>Second return -EPERM on an unini=
tialized RTC until first write resets it&#39;s values to a known condition =
on first write (as Gregory suggest) -</div><div><a href=3D"https://pastebin=
.com/r7sydF8G">https://pastebin.com/r7sydF8G</a><br></div><div><br></div><d=
iv>Suggestion?</div><div><br></div><div><br></div><div><br></div></div></di=
v></div>

--f40304364ef8b19b6b0560147f44--
