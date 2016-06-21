Return-Path: <rtc-linux+bncBDSNL5X27IMRBV7YUS5QKGQEEUAZN7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com. [2607:f8b0:4001:c0b::22f])
        by gmr-mx.google.com with ESMTPS id f63si138253ith.2.2016.06.21.06.08.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 06:08:39 -0700 (PDT)
Received: by mail-it0-x22f.google.com with SMTP id f6so13291469ith.0
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 06:08:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466493294-11143-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466493294-11143-1-git-send-email-andrew.smirnov@gmail.com>
From: Chris Healy <cphealy@gmail.com>
Date: Tue, 21 Jun 2016 06:08:38 -0700
Message-ID: <CAFXsbZpWyaf7GFCrwpxnH79scBUZ=T_+BEVctY9-u0K5xMBRHw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 00/17] DS1341 support and code cleanup
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a1140c338f4dc540535c98434
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a1140c338f4dc540535c98434
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 21, 2016 at 12:14 AM, Andrey Smirnov <andrew.smirnov@gmail.com>
wrote:

> Hi everyone,
>
> This set is a v2 of the DS1307 driver patches. Changes since v1:
>
>  - Devicetree bindings are separated into a separate commit
>
>  - Device tree properties now have vendor specific prefixes and
>    documenatation explicitly stating their type
>
>  - Three more patches, with improvements to rtctest.c, are added to
>    the patchset
>
> Any feedback is appreciated.
>
> Thank you,
> Andrey Smirnov
>
> Andrey Smirnov (17):
>   RTC: ds1307: Add DS1341 variant
>   RTC: ds1307: Disable square wave and timers as default
>   RTC: ds1307: Add devicetree bindings for DS1341
>   RTC: ds1307: Add DS1341 specific power-saving options
>   RTC: ds1307: Convert ds1307_can_wakeup_device into a predicate
>   RTC: ds1307: Convert want_irq into a predicate
>   RTC: ds1307: Move chip configuration into a separate routine
>   RTC: ds1307: Move chip sanity checking into a separate routine
>   RTC: ds1307: Remove register "cache"
>   RTC: ds1307: Constify struct ds1307 where possible
>   RTC: ds1307: Convert goto to a loop
>   RTC: ds1307: Redefine RX8025_REG_* to minimize extra code
>   RTC: ds1307: Report oscillator problems more intelligently
>   RTC: ds1307: Move last bits of sanity checking out of chip_configure
>   RTC: rtctest: Change alarm IRQ support detection
>   RTC: rtctest: Change no IRQ detection for RTC_IRQP_READ
>   RTC: rtctest: Change no IRQ detection for RTC_IRQP_SET
>
>  .../devicetree/bindings/rtc/dallas,ds1341.txt      |  23 +
>  drivers/rtc/rtc-ds1307.c                           | 742
> ++++++++++++---------
>  tools/testing/selftests/timers/rtctest.c           |  13 +-
>  3 files changed, 467 insertions(+), 311 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1341.txt
>
> --
> 2.5.5
>
> Full series tested on a Freescale (NXP) i.MX6 with a DS1341 RTC both with
and without the new DT bindings.  Additionally, ran rtctest successfully.

Tested-by: Chris Healy <cphealy@gmail.com>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a1140c338f4dc540535c98434
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Tue, Jun 21, 2016 at 12:14 AM, Andrey Smirnov <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:andrew.smirnov@gmail.com" target=3D"_bl=
ank">andrew.smirnov@gmail.com</a>&gt;</span> wrote:<br></div><div><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hi everyone,<=
br>
<br>
This set is a v2 of the DS1307 driver patches. Changes since v1:<br>
<br>
=C2=A0- Devicetree bindings are separated into a separate commit<br>
<br>
=C2=A0- Device tree properties now have vendor specific prefixes and<br>
=C2=A0 =C2=A0documenatation explicitly stating their type<br>
<br>
=C2=A0- Three more patches, with improvements to rtctest.c, are added to<br=
>
=C2=A0 =C2=A0the patchset<br>
<br>
Any feedback is appreciated.<br>
<br>
Thank you,<br>
Andrey Smirnov<br>
<br>
Andrey Smirnov (17):<br>
=C2=A0 RTC: ds1307: Add DS1341 variant<br>
=C2=A0 RTC: ds1307: Disable square wave and timers as default<br>
=C2=A0 RTC: ds1307: Add devicetree bindings for DS1341<br>
=C2=A0 RTC: ds1307: Add DS1341 specific power-saving options<br>
=C2=A0 RTC: ds1307: Convert ds1307_can_wakeup_device into a predicate<br>
=C2=A0 RTC: ds1307: Convert want_irq into a predicate<br>
=C2=A0 RTC: ds1307: Move chip configuration into a separate routine<br>
=C2=A0 RTC: ds1307: Move chip sanity checking into a separate routine<br>
=C2=A0 RTC: ds1307: Remove register &quot;cache&quot;<br>
=C2=A0 RTC: ds1307: Constify struct ds1307 where possible<br>
=C2=A0 RTC: ds1307: Convert goto to a loop<br>
=C2=A0 RTC: ds1307: Redefine RX8025_REG_* to minimize extra code<br>
=C2=A0 RTC: ds1307: Report oscillator problems more intelligently<br>
=C2=A0 RTC: ds1307: Move last bits of sanity checking out of chip_configure=
<br>
=C2=A0 RTC: rtctest: Change alarm IRQ support detection<br>
=C2=A0 RTC: rtctest: Change no IRQ detection for RTC_IRQP_READ<br>
=C2=A0 RTC: rtctest: Change no IRQ detection for RTC_IRQP_SET<br>
<br>
=C2=A0.../devicetree/bindings/rtc/dallas,ds1341.txt=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 23 +<br>
=C2=A0drivers/rtc/rtc-ds1307.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 742 ++++++++++++-----=
----<br>
=C2=A0tools/testing/selftests/timers/rtctest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A03 files changed, 467 insertions(+), 311 deletions(-)<br>
=C2=A0create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds134=
1.txt<br>
<span class=3D""><font color=3D"#888888"><br>
--<br>
2.5.5<br>
<br>
</font></span></blockquote></div><div>Full series tested on a Freescale (NX=
P) i.MX6 with a DS1341 RTC both with and without the new DT bindings.=C2=A0=
 Additionally, ran rtctest successfully.</div><div><br></div><div>Tested-by=
: Chris Healy &lt;<a href=3D"mailto:cphealy@gmail.com">cphealy@gmail.com</a=
>&gt;</div><div><br></div></div></div></div>

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

--001a1140c338f4dc540535c98434--
