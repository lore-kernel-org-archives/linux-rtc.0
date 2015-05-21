Return-Path: <rtc-linux+bncBC2PPF5ZT4BBBR5P62VAKGQE2MZA4FQ@googlegroups.com>
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com. [2a00:1450:4010:c04::236])
        by gmr-mx.google.com with ESMTPS id su3si1264155lbb.1.2015.05.21.01.31.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 01:31:03 -0700 (PDT)
Received: by mail-lb0-x236.google.com with SMTP id qq2so12558849lbb.3
        for <rtc-linux@googlegroups.com>; Thu, 21 May 2015 01:31:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150518160126.GI23662@pd.tnic>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518094755.GC23662@pd.tnic>
	<CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
	<20150518101248.GE23662@pd.tnic>
	<20150518160126.GI23662@pd.tnic>
Date: Thu, 21 May 2015 10:31:03 +0200
Message-ID: <CANoYJuks7x4=meiTyHfvUkYHEaQ0KYnOYcwYtQ9f3r=0+_V0kw@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
From: Diego Ercolani <diego.ercolani@gmail.com>
To: Borislav Petkov <bp@suse.de>
Cc: Adrian Huang <adrianhuang0701@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>,
	Egbert Eich <eich@suse.com>
Content-Type: multipart/alternative; boundary=e89a8f642fde3348240516935d02
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--e89a8f642fde3348240516935d02
Content-Type: text/plain; charset=UTF-8

I'm sorry, I'm experiencing a new issue related to btrfs, so my system is
not usable now: https://bugzilla.opensuse.org/show_bug.cgi?id=931787 until
I found a solution

2015-05-18 18:01 GMT+02:00 Borislav Petkov <bp@suse.de>:

> On Mon, May 18, 2015 at 12:12:48PM +0200, Borislav Petkov wrote:
> > > In the meanwhile I upgraded my linux box to opensuse 13.2 with actual
> > > kernel: 3.16.7-21-desktop
> >
> > Ok, I'll prepare one.
>
> Ok, I've uploaded a test kernel here - kernel-desktop, 64-bit:
>
> http://beta.suse.com/private/bpetkov/
>
> Let me know if you have trouble testing it.
>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --
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

--e89a8f642fde3348240516935d02
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m sorry, I&#39;m experiencing a new issue related to=
 btrfs, so my system is not usable now: <a href=3D"https://bugzilla.opensus=
e.org/show_bug.cgi?id=3D931787">https://bugzilla.opensuse.org/show_bug.cgi?=
id=3D931787</a> until I found a solution<br></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">2015-05-18 18:01 GMT+02:00 Borislav Petkov=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:bp@suse.de" target=3D"_blank">bp@s=
use.de</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, May 18, 20=
15 at 12:12:48PM +0200, Borislav Petkov wrote:<br>
&gt; &gt; In the meanwhile I upgraded my linux box to opensuse 13.2 with ac=
tual<br>
&gt; &gt; kernel: 3.16.7-21-desktop<br>
&gt;<br>
&gt; Ok, I&#39;ll prepare one.<br>
<br>
Ok, I&#39;ve uploaded a test kernel here - kernel-desktop, 64-bit:<br>
<br>
<a href=3D"http://beta.suse.com/private/bpetkov/" target=3D"_blank">http://=
beta.suse.com/private/bpetkov/</a><br>
<br>
Let me know if you have trouble testing it.<br>
<br>
Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Regards/Gruss,<br>
=C2=A0 =C2=A0 Boris.<br>
<br>
ECO tip #101: Trim your mails when you reply.<br>
--<br>
</font></span></blockquote></div><br></div>

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

--e89a8f642fde3348240516935d02--
