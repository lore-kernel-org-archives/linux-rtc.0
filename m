Return-Path: <rtc-linux+bncBDHIF2NA5EJBBSGGYW5QKGQEVOBC22A@googlegroups.com>
Received: from mail-lf0-x234.google.com (mail-lf0-x234.google.com. [2a00:1450:4010:c07::234])
        by gmr-mx.google.com with ESMTPS id c135si221771wme.2.2016.06.27.10.32.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 10:32:55 -0700 (PDT)
Received: by mail-lf0-x234.google.com with SMTP id h129so161351416lfh.1
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 10:32:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m2bn2mtut1.fsf@baylibre.com>
References: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
	<m2bn2mtut1.fsf@baylibre.com>
Date: Mon, 27 Jun 2016 18:32:55 +0100
Message-ID: <CANe6Qb-aSSigiY_oC7=avLZ=0yhEFFwkMi+sLiaRJKNFnmetRA@mail.gmail.com>
Subject: [rtc-linux] Re: RTC support for AMlogic devies
From: "'Ben Dooks' via rtc-linux" <rtc-linux@googlegroups.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-kernel@lists.codethink.co.uk, ben.dooks@codethink.co.uk,
	devicetree@vger.kernel.org, rtc-linux@googlegroups.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, frowand.list@gmail.com,
	linux-amlogic@lists.infradead.org, robh+dt@kernel.org
Content-Type: multipart/alternative; boundary=001a114a6a7223fd33053645e9ba
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a114a6a7223fd33053645e9ba
Content-Type: text/plain; charset=UTF-8

I will check later. I think the issue is the dt patches require the reset
controller patches. The driver itself should compile fine
On 27 Jun 2016 6:18 p.m., "Kevin Hilman" <khilman@baylibre.com> wrote:

> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>
> > This series is support for the RTC block on some of the AMLogic
> > Meson ARM SoCs.
> >
> > The first patch is the driver, followed by device-tree patches
> > and enablement for the ODRoid-C1 (where it has been tested)
>
> In the cover letter, please be explicit about any dependencies that are
> not upstream.  This series applies to mainline (v4.7-rc*) but does not
> build.  I tested it with my v4.7/integ branch and it seems to work.
>
> The series also has a handful of checkpatch warnings that should be
> addressed (see: http://hastebin.com/tacurokasu.pas)
>
> Other than that, I gave it a quick spin on meson8b-odroidc1 using
> tools/testing/selftests/timers/rtctest.c, and the basic time stuff seems
> to be working:
>
> / # ./rtctest
>
>                         RTC Driver Test Example.
>
>
> ...Update IRQs not supported.
>
>
> Current RTC date/time is 27-6-2016, 00:01:41.
> RTC_ALM_READ ioctl: Invalid argument
>
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a114a6a7223fd33053645e9ba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I will check later. I think the issue is the dt patches requ=
ire the reset controller patches. The driver itself should compile fine</p>
<div class=3D"gmail_quote">On 27 Jun 2016 6:18 p.m., &quot;Kevin Hilman&quo=
t; &lt;<a href=3D"mailto:khilman@baylibre.com">khilman@baylibre.com</a>&gt;=
 wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ben Dooks &l=
t;<a href=3D"mailto:ben.dooks@codethink.co.uk">ben.dooks@codethink.co.uk</a=
>&gt; writes:<br>
<br>
&gt; This series is support for the RTC block on some of the AMLogic<br>
&gt; Meson ARM SoCs.<br>
&gt;<br>
&gt; The first patch is the driver, followed by device-tree patches<br>
&gt; and enablement for the ODRoid-C1 (where it has been tested)<br>
<br>
In the cover letter, please be explicit about any dependencies that are<br>
not upstream.=C2=A0 This series applies to mainline (v4.7-rc*) but does not=
<br>
build.=C2=A0 I tested it with my v4.7/integ branch and it seems to work.<br=
>
<br>
The series also has a handful of checkpatch warnings that should be<br>
addressed (see: <a href=3D"http://hastebin.com/tacurokasu.pas" rel=3D"noref=
errer" target=3D"_blank">http://hastebin.com/tacurokasu.pas</a>)<br>
<br>
Other than that, I gave it a quick spin on meson8b-odroidc1 using<br>
tools/testing/selftests/timers/rtctest.c, and the basic time stuff seems<br=
>
to be working:<br>
<br>
/ # ./rtctest<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RTC Driver Test Example.<br>
<br>
<br>
...Update IRQs not supported.<br>
<br>
<br>
Current RTC date/time is 27-6-2016, 00:01:41.<br>
RTC_ALM_READ ioctl: Invalid argument<br>
<br>
<br>
<br>
_______________________________________________<br>
linux-amlogic mailing list<br>
<a href=3D"mailto:linux-amlogic@lists.infradead.org">linux-amlogic@lists.in=
fradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-amlogic" rel=
=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/mailman/listin=
fo/linux-amlogic</a><br>
</blockquote></div>

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

--001a114a6a7223fd33053645e9ba--
