Return-Path: <rtc-linux+bncBAABB6UW3SVAKGQEZFKGYVQ@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id zr2si475659pbb.0.2015.05.16.02.18.49
        for <rtc-linux@googlegroups.com>;
        Sat, 16 May 2015 02:18:50 -0700 (PDT)
In-Reply-To: <CALAqxLW3e79ZHwvO8-R6KJ2gCxKTZ4tnvUSUN8y+gN6UuYctXw@mail.gmail.com>
References: <1431682292-29732-1-git-send-email-xlpang@126.com> <CALAqxLW3e79ZHwvO8-R6KJ2gCxKTZ4tnvUSUN8y+gN6UuYctXw@mail.gmail.com>
To: John Stultz <john.stultz@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Xunlei Pang <pang.xunlei@linaro.org>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        sparclinux@vger.kernel.org, Xunlei Pang <xlpang@126.com>
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/interface.c: Change
 rtc_set_mmss() to use time64_t
MIME-Version: 1.0
Message-ID: <OFAA580410.382C2466-ON48257E47.003315B5-48257E47.00334413@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Sat, 16 May 2015 17:19:35 +0800
Content-Type: multipart/alternative; boundary="=_alternative 0033440D48257E47_="
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This is a multipart message in MIME format.

--=_alternative 0033440D48257E47_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John,

John Stultz <john.stultz@linaro.org> wrote 2015-05-16 AM 07:46:28:
>=20
> Re: [PATCH 1/2] drivers/rtc/interface.c: Change rtc_set_mmss() to use=20
time64_t
>=20
> On Fri, May 15, 2015 at 2:31 AM, Xunlei Pang <xlpang@126.com> wrote:
> > From: Xunlei Pang <pang.xunlei@linaro.org>
> >
> > rtc_set_mmss() uses "unsigned long" as its second parameter which
> > may have y2038 problem on 32-bit systems.
> >
> > Change it to use time64_t.
> >
> > All its call sites will be changed later(there are no problems
> > leaving these call sites untouched).
>=20
> This line isn't super convincing. Better to explain *why* there aren't
> problems making this change first, rather then just asserting it, and
> to give some confidence you'll address this, point out that sparc is
> the only user of this funciton and will be updated by the following
> patch in the series.

Thanks for the review. But now I have another idea to remove it=20
completely.
I will resend that if it is viable.

Regards,
-Xunlei
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

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

--=_alternative 0033440D48257E47_=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi John,</font>
<br>
<br><tt><font size=3D2>John Stultz &lt;john.stultz@linaro.org&gt; wrote 201=
5-05-16
AM 07:46:28:<br>
&gt; <br>
&gt; Re: [PATCH 1/2] drivers/rtc/interface.c: Change rtc_set_mmss() to
use time64_t</font></tt>
<br><tt><font size=3D2>&gt; <br>
&gt; On Fri, May 15, 2015 at 2:31 AM, Xunlei Pang &lt;xlpang@126.com&gt;
wrote:<br>
&gt; &gt; From: Xunlei Pang &lt;pang.xunlei@linaro.org&gt;<br>
&gt; &gt;<br>
&gt; &gt; rtc_set_mmss() uses &quot;unsigned long&quot; as its second param=
eter
which<br>
&gt; &gt; may have y2038 problem on 32-bit systems.<br>
&gt; &gt;<br>
&gt; &gt; Change it to use time64_t.<br>
&gt; &gt;<br>
&gt; &gt; All its call sites will be changed later(there are no problems<br=
>
&gt; &gt; leaving these call sites untouched).<br>
&gt; <br>
&gt; This line isn't super convincing. Better to explain *why* there aren't=
<br>
&gt; problems making this change first, rather then just asserting it,
and<br>
&gt; to give some confidence you'll address this, point out that sparc
is<br>
&gt; the only user of this funciton and will be updated by the following<br=
>
&gt; patch in the series.</font></tt>
<br>
<br><tt><font size=3D2>Thanks for the review. But now I have another idea
to remove it completely.</font></tt>
<br><tt><font size=3D2>I will resend that if it is viable.</font></tt>
<br>
<br><tt><font size=3D2>Regards,</font></tt>
<br><tt><font size=3D2>-Xunlei</font></tt>

<br><pre><font color=3D"blue">
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

</font></pre><br>

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

--=_alternative 0033440D48257E47_=--
