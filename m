Return-Path: <rtc-linux+bncBCNJ5VGR4ANRBDM3SLCAKGQE4HXMH6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com. [192.185.144.29])
        by gmr-mx.google.com with ESMTPS id 126si650573itj.3.2017.01.22.02.46.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jan 2017 02:46:37 -0800 (PST)
Received: from cm3.websitewelcome.com (unknown [108.167.139.23])
	by gateway31.websitewelcome.com (Postfix) with ESMTP id EAC38AAF60
	for <rtc-linux@googlegroups.com>; Sun, 22 Jan 2017 04:46:36 -0600 (CST)
Subject: [rtc-linux] Re: imx6ul: power-up using the RTC
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Sebastian Reichel <sre@kernel.org>
References: <b516070d-6539-98d1-c832-d79ac89e8d43@mobi-wize.com>
 <20170120121210.gm3wcg4yyvrigpn3@earth>
 <20170120153459.tewyg54dcgqnpz2j@piout.net>
From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: b20788@freescale.com, shawnguo@kernel.org, Frank.Li@freescale.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, a.zummo@towertech.it,
 linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
 linux-pm@vger.kernel.org
Message-ID: <7a2d9e48-9a58-7d79-bc36-05a9b790cce3@mobi-wize.com>
Date: Sun, 22 Jan 2017 12:46:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170120153459.tewyg54dcgqnpz2j@piout.net>
Content-Type: multipart/alternative;
 boundary="------------97360874817FC5033E78858C"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is a multi-part message in MIME format.
--------------97360874817FC5033E78858C
Content-Type: text/plain; charset=UTF-8

On 20/01/2017 17:34, Alexandre Belloni wrote:
> On 20/01/2017 at 13:12:10 +0100, Sebastian Reichel wrote : >> Hi, >> >> On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro
wrote: >>> I'm trying to use the low power RTC of the i.MX6UL to start
from >>> power-off state. >>> >>> I started by hopefully running: # echo
+30 > >>> /sys/class/rtc/rtc0/wakealarm && shutdown -h now The system
was >>> powered down, but it didn't come up after 30 seconds as
expected. >>> >>> So I dug into the datasheet and the source... >>> To
activate the power on alarm, the flags SRTC_ENV, LPTA_EN and LPWUI_EN on
>>> the SNVS_LP Control register (LPCR) should be asserted. The wakeup
time >>> should be written to the SNVS_LP Time alarm register (LPTA).
The code that >>> does this is on
drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm(). >>> >>> The first problem I
found was with the use of the syscon-poweroff driver. >>> The "Turn off
System Power" flag is part of the same register (LPCR). The >>> current
code of syscon-poweroff set the register to the "mask" property from >>>
the device tree on power off, overriding all the existing flags. >>>
After setting the "mask" property on the device tree to 0x6b instead of
>>> 0x60 (asserting the mentioned bits), the system do power up on
timer, as >>> expected. >>> >>> However, I didn't like the idea of
keeping those flags on even when no one >>> set the alarm. >>> As a
quick test, I modified the syscon-poweroff driver to ignore the bits >>>
that are not on the mask: >>> >>> diff --git
a/drivers/power/reset/syscon-poweroff.c >>>
b/drivers/power/reset/syscon-poweroff.c >>> index b683383..a5da02b
100644 >>> --- a/drivers/power/reset/syscon-poweroff.c >>> +++
b/drivers/power/reset/syscon-poweroff.c >>> @@ -33,7 +33,7 @@ static u32
mask; >>> static void syscon_poweroff(void) >>> { >>>         /* Issue
the poweroff */ >>> -       regmap_write(map, offset, mask); >>> +      
regmap_update_bits(map, offset, mask, mask); >>>         mdelay(1000);
>>> >>> >>> After applying this fix, the wake up alarm didn't work.
Strangely, when I >>> added some debug prints to investigate the case,
it worked again >>> (sometimes... depends on the exact places I add the
prints). >>> I suspect that some other driver clears the flags during
the power down, but >>> I couldn't find such driver. >>> >>> Do you have
any clue what code may change this register during the shutdown >>>
process? Any other insights are welcomed as well :) >> >> To summarize
it looks like this? >> >> | regmap_write       | 0x60 |
broken                     | >> | regmap_write       | 0x6b | works
stable               | >> | regmap_update_bits | 0x60 | works only with
dbg prints | >> >> For me it looks like the debug prints may delay the
poweroff driver >> long enough, that some other driver (rtc?) writes the
0x0b bits. >> > > Is snvs_rtc_alarm_irq_enable() waiting long enough?
I'd say yes but you > never know... You can also use the kernel tracin
infrastructure to trace > every accesses made to that regmap. That could
give you a hint. > > At least you can try a regmap_read before returning
from > snvs_rtc_alarm_irq_enable() and see whether SNVS_LPCR_LPTA_EN and
> SNVS_LPCR_LPWUI_EN are still there. >
I added a debug print on snvs_rtc_alarm_irq_enable. It reads and prints the
value of the control register after the write & sync operation.

Immediately after the write to /sys/class/rtc/rtc0/wakealarm the
register value
is correct (0x2b).
However, during the shutdown process the function is called again via the
rtc_timer_do_work(). I still do not fully understand this flow. This call is
done with the enable parameter == 1, but my debug print shows 0x29,
meaning the
LPTA_EN bit stays low.

My current guess is that the clear of LPTA_EN in snvs_rtc_set_alarm have
internal race with the afterward bit set.
I'll try to check this and update.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--------------97360874817FC5033E78858C
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    On 20/01/2017 17:34, Alexandre Belloni wrote:<br>
    <span style=3D"white-space: pre;">&gt; On 20/01/2017 at 13:12:10 +0100,=
 Sebastian Reichel wrote :
&gt;&gt; Hi,
&gt;&gt;
&gt;&gt; On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro wrote:
&gt;&gt;&gt; I'm trying to use the low power RTC of the i.MX6UL to start fr=
om
&gt;&gt;&gt; power-off state.
&gt;&gt;&gt;
&gt;&gt;&gt; I started by hopefully running: # echo +30 &gt;
&gt;&gt;&gt; /sys/class/rtc/rtc0/wakealarm &amp;&amp; shutdown -h now The s=
ystem was
&gt;&gt;&gt; powered down, but it didn't come up after 30 seconds as expect=
ed.
&gt;&gt;&gt;
&gt;&gt;&gt; So I dug into the datasheet and the source...
&gt;&gt;&gt; To activate the power on alarm, the flags SRTC_ENV, LPTA_EN an=
d LPWUI_EN on
&gt;&gt;&gt; the SNVS_LP Control register (LPCR) should be asserted. The wa=
keup time
&gt;&gt;&gt; should be written to the SNVS_LP Time alarm register (LPTA). T=
he code that
&gt;&gt;&gt; does this is on drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm().
&gt;&gt;&gt;
&gt;&gt;&gt; The first problem I found was with the use of the syscon-power=
off driver.
&gt;&gt;&gt; The "Turn off System Power" flag is part of the same register =
(LPCR). The
&gt;&gt;&gt; current code of syscon-poweroff set the register to the "mask"=
 property from
&gt;&gt;&gt; the device tree on power off, overriding all the existing flag=
s.
&gt;&gt;&gt; After setting the "mask" property on the device tree to 0x6b i=
nstead of
&gt;&gt;&gt; 0x60 (asserting the mentioned bits), the system do power up on=
 timer, as
&gt;&gt;&gt; expected.
&gt;&gt;&gt;
&gt;&gt;&gt; However, I didn't like the idea of keeping those flags on even=
 when no one
&gt;&gt;&gt; set the alarm.
&gt;&gt;&gt; As a quick test, I modified the syscon-poweroff driver to igno=
re the bits
&gt;&gt;&gt; that are not on the mask:
&gt;&gt;&gt;
&gt;&gt;&gt; diff --git a/drivers/power/reset/syscon-poweroff.c
&gt;&gt;&gt; b/drivers/power/reset/syscon-poweroff.c
&gt;&gt;&gt; index b683383..a5da02b 100644
&gt;&gt;&gt; --- a/drivers/power/reset/syscon-poweroff.c
&gt;&gt;&gt; +++ b/drivers/power/reset/syscon-poweroff.c
&gt;&gt;&gt; @@ -33,7 +33,7 @@ static u32 mask;
&gt;&gt;&gt; static void syscon_poweroff(void)
&gt;&gt;&gt; {
&gt;&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Issue the p=
oweroff */
&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_write(map, offset=
, mask);
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_update_bits(map, =
offset, mask, mask);
&gt;&gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdelay(1000);
&gt;&gt;&gt;
&gt;&gt;&gt;
&gt;&gt;&gt; After applying this fix, the wake up alarm didn't work. Strang=
ely, when I
&gt;&gt;&gt; added some debug prints to investigate the case, it worked aga=
in
&gt;&gt;&gt; (sometimes... depends on the exact places I add the prints).
&gt;&gt;&gt; I suspect that some other driver clears the flags during the p=
ower down, but
&gt;&gt;&gt; I couldn't find such driver.
&gt;&gt;&gt;
&gt;&gt;&gt; Do you have any clue what code may change this register during=
 the shutdown
&gt;&gt;&gt; process? Any other insights are welcomed as well :)
&gt;&gt;
&gt;&gt; To summarize it looks like this?
&gt;&gt;
&gt;&gt; | regmap_write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0x60 | broken=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
&gt;&gt; | regmap_write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0x6b | works =
stable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
&gt;&gt; | regmap_update_bits | 0x60 | works only with dbg prints |
&gt;&gt;
&gt;&gt; For me it looks like the debug prints may delay the poweroff drive=
r
&gt;&gt; long enough, that some other driver (rtc?) writes the 0x0b bits.
&gt;&gt;
&gt;
&gt; Is snvs_rtc_alarm_irq_enable() waiting long enough? I'd say yes but yo=
u
&gt; never know... You can also use the kernel tracin infrastructure to tra=
ce
&gt; every accesses made to that regmap. That could give you a hint.
&gt;
&gt; At least you can try a regmap_read before returning from
&gt; snvs_rtc_alarm_irq_enable() and see whether SNVS_LPCR_LPTA_EN and
&gt; SNVS_LPCR_LPWUI_EN are still there.
&gt;</span><br>
    I added a debug print on snvs_rtc_alarm_irq_enable. It reads and
    prints the<br>
    value of the control register after the write &amp; sync operation.<br>
    <br>
    Immediately after the write to /sys/class/rtc/rtc0/wakealarm the
    register value<br>
    is correct (0x2b).<br>
    However, during the shutdown process the function is called again
    via the<br>
    rtc_timer_do_work(). I still do not fully understand this flow. This
    call is<br>
    done with the enable parameter =3D=3D 1, but my debug print shows 0x29,
    meaning the<br>
    LPTA_EN bit stays low.<br>
    <br>
    My current guess is that the clear of LPTA_EN in snvs_rtc_set_alarm
    have<br>
    internal race with the afterward bit set.<br>
    I'll try to check this and update.<br>
    <br>
  </body>
</html>

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

--------------97360874817FC5033E78858C--
