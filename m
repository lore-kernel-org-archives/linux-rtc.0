Return-Path: <rtc-linux+bncBC433LF43MBBBJXC4DBAKGQEZORZFWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from outils.crapouillou.net (outils.crapouillou.net. [89.234.176.41])
        by gmr-mx.google.com with ESMTPS id e134si1243622wmd.3.2016.12.19.11.12.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 11:12:38 -0800 (PST)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: jz4740: make the driver builtin only
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_b67f78a1b88746ad6a62754038978753"
Date: Mon, 19 Dec 2016 20:12:07 +0100
From: Paul Cercueil <paul@crapouillou.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alessandro Zummo
 <a.zummo@towertech.it>, RTCLINUX <rtc-linux@googlegroups.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20161219094736.pa2o3xfxos66j7b4@piout.net>
References: <20161109003753.29759-1-alexandre.belloni@free-electrons.com>
 <20161109003753.29759-2-alexandre.belloni@free-electrons.com>
 <CAMuHMdV5yOktsrBDVJy11PPX6ObuBKiyP6smqDTettoAg7WeiQ@mail.gmail.com>
 <20161219094736.pa2o3xfxos66j7b4@piout.net>
Message-ID: <fe8c24d56eeba9f5c4426be49254b36a@mail.crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--=_b67f78a1b88746ad6a62754038978753
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

=20

Hi,=20

Le 2016-12-19 10:47, Alexandre Belloni a =C3=A9crit :=20

> Hi,
>=20
> On 19/12/2016 at 09:03:17 +0100, Geert Uytterhoeven wrote :
> On Wed, Nov 9, 2016 at 1:37 AM, Alexandre Belloni <alexandre.belloni@free=
-electrons.com> wrote: Since the driver is now calling machine_halt() that =
is not exported, it has to be built in the kernel. Building it as a module =
will fail at linking time. Signed-off-by: Alexandre Belloni <alexandre.bell=
oni@free-electrons.com> --- drivers/rtc/Kconfig | 5 +---- drivers/rtc/rtc-j=
z4740.c | 10 +--------- 2 files changed, 2 insertions(+), 13 deletions(-) d=
iff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig index 4259ce61c31b..2=
4b0778f6e28 100644 --- a/drivers/rtc/Kconfig +++ b/drivers/rtc/Kconfig @@ -=
1550,15 +1550,12 @@ config RTC_DRV_MPC5121 will be called rtc-mpc5121. conf=
ig RTC_DRV_JZ4740 - tristate "Ingenic JZ4740 SoC" + bool "Ingenic JZ4740 So=
C" Just noticed RTC_DRV_JZ4740 flipped from m to y. This is bad for distrib=
ution kernels. Can't the driver just call kernel_halt() instead of machine_=
halt()?

I'm not sure and I can't test. Paul, can you test?

Maybe the other concern is that users that are not loading the rtc
module will probably complain their machine is not powering off.

For the reason Alexandre pointed out it would be a bad idea to build it
as a module, IMHO.=20

But using kernel_halt() works fine too.=20
=20

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

--=_b67f78a1b88746ad6a62754038978753
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html><body style=3D'font-family: Verdana,Geneva,sans-serif'>
<p>Hi,</p>
<p>Le 2016-12-19 10:47, Alexandre Belloni a &eacute;crit&nbsp;:</p>
<blockquote type=3D"cite" style=3D"padding-left:5px; border-left:#1010ff 2p=
x solid; margin-left:5px"><!-- html ignored --><!-- head ignored --><!-- me=
ta ignored -->
<pre>Hi,

On 19/12/2016 at 09:03:17 +0100, Geert Uytterhoeven wrote :</pre>
<blockquote type=3D"cite" style=3D"padding-left:5px; border-left:#1010ff 2p=
x solid; margin-left:5px">On Wed, Nov 9, 2016 at 1:37 AM, Alexandre Belloni=
 &lt;<a href=3D"mailto:alexandre.belloni@free-electrons.com">alexandre.bell=
oni@free-electrons.com</a>&gt; wrote:
<blockquote type=3D"cite" style=3D"padding-left:5px; border-left:#1010ff 2p=
x solid; margin-left:5px">Since the driver is now calling machine_halt() th=
at is not exported, it has to be built in the kernel. Building it as a modu=
le will fail at linking time. Signed-off-by: Alexandre Belloni &lt;<a href=
=3D"mailto:alexandre.belloni@free-electrons.com">alexandre.belloni@free-ele=
ctrons.com</a>&gt; --- drivers/rtc/Kconfig | 5 +---- drivers/rtc/rtc-jz4740=
.c | 10 +--------- 2 files changed, 2 insertions(+), 13 deletions(-) diff -=
-git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig index 4259ce61c31b..24b077=
8f6e28 100644 --- a/drivers/rtc/Kconfig +++ b/drivers/rtc/Kconfig @@ -1550,=
15 +1550,12 @@ config RTC_DRV_MPC5121 will be called rtc-mpc5121. config RT=
C_DRV_JZ4740 - tristate "Ingenic JZ4740 SoC" + bool "Ingenic JZ4740 SoC"</b=
lockquote>
Just noticed RTC_DRV_JZ4740 flipped from m to y. This is bad for distributi=
on kernels. Can't the driver just call kernel_halt() instead of machine_hal=
t()?</blockquote>
<pre>I'm not sure and I can't test. Paul, can you test?

Maybe the other concern is that users that are not loading the rtc
module will probably complain their machine is not powering off.

</pre>
</blockquote>
<p>For the reason Alexandre pointed out it would be a bad idea to build it =
as a module, IMHO.</p>
<p>But using kernel_halt() works fine too.</p>
<div>&nbsp;</div>
</body></html>

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

--=_b67f78a1b88746ad6a62754038978753--
