Return-Path: <rtc-linux+bncBC2PPF5ZT4BBBYP4ZCWAKGQEZCL6PNQ@googlegroups.com>
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com. [2a00:1450:4010:c03::22c])
        by gmr-mx.google.com with ESMTPS id su3si1534489lbb.1.2015.06.29.23.59.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 23:59:45 -0700 (PDT)
Received: by mail-la0-x22c.google.com with SMTP id c2so745631lag.3
        for <rtc-linux@googlegroups.com>; Mon, 29 Jun 2015 23:59:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHKZfL0H1mrj8pScggejtFStaA66zX43RZRYQnkYsZ4gVb-ojQ@mail.gmail.com>
References: <1435642598-5073-1-git-send-email-adrianhuang0701@gmail.com>
	<CAHKZfL0H1mrj8pScggejtFStaA66zX43RZRYQnkYsZ4gVb-ojQ@mail.gmail.com>
Date: Tue, 30 Jun 2015 08:59:45 +0200
Message-ID: <CANoYJu=0L7yUfS2Z87OJXc+_+Z6DmQ_oGZvg2AygS_2DTOixxQ@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH v3 0/2] rtc: Prevent the automatic reboot
 after powering off the system
From: Diego Ercolani <diego.ercolani@gmail.com>
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, Egbert Eich <eich@suse.com>, rtc-linux@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Max Asbock <amax@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Content-Type: multipart/alternative; boundary=001a11c25cc659cea60519b6c023
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--001a11c25cc659cea60519b6c023
Content-Type: text/plain; charset=UTF-8

I'll be waiting for the built kernel.
Thank you
Diego

2015-06-30 7:52 GMT+02:00 Huang Adrian <adrianhuang0701@gmail.com>:

> Boris, Egbert and Diego
>
> Could you please test this patch set on your buggy boxes? Thanks in
> advance.
>
> BTW, Boris, could you please also build a patched openSUSE_13.2 kernel
> for Diego's testing? Thanks again.
>
>
> -- Adrian
>
>
> On Tue, Jun 30, 2015 at 1:36 PM, Adrian Huang <adrianhuang0701@gmail.com>
> wrote:
> > Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") added the
> > alarm disable quirk to work around the broken BIOSes. The same symptom
> > is observed on Lenovo Thinkserver. Instead of adding the impacted
> > servers to the "alarm disable" quirk, this patchset aims at preventing
> > the issue so that the commit can be reverted.
> >
> > The brief description of the root cause is that: When configuring
> > the RTC registers to setup a wake up event in the S5 handler (BIOS),
> > the handler does not clear the interrupt flag bits by reading
> > Register C of CMOS RTC.
> >
> > Changes from v2:
> >   * Drop the approach "Clear interrupt flag if alarm time is less
> >     equal to now+1". Instead, cancel the alarm if the configured
> >     alarm time is equal to now+1 seconds. (Suggested by Alexandre)
> >
> > Changes from v1:
> >   * Change the order of [PATCH 1/2] and [PATCH 2/2] (per Borislav)
> >   * Drop the approach "RTC alarm timer restoration approach". Instead,
> >     [PATCH 1/2] makes sure that AF is cleared in cmos_do_shutdown()
> >     before powering off the machine. (Suggested by Alexandre)
> >
> > Adrian Huang (2):
> >   rtc-cmos: Cancel alarm timer if alarm time is equal to now+1 seconds
> >   rtc-cmos: Revert "rtc-cmos: Add an alarm disable quirk"
> >
> >  drivers/rtc/rtc-cmos.c | 113
> ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 60 insertions(+), 53 deletions(-)
> >
> > --
> > 1.9.1
> >
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

--001a11c25cc659cea60519b6c023
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;ll be waiting for the built kernel.<br></d=
iv>Thank you<br></div>Diego<br></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">2015-06-30 7:52 GMT+02:00 Huang Adrian <span dir=3D"ltr=
">&lt;<a href=3D"mailto:adrianhuang0701@gmail.com" target=3D"_blank">adrian=
huang0701@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Boris=
, Egbert and Diego<br>
<br>
Could you please test this patch set on your buggy boxes? Thanks in advance=
.<br>
<br>
BTW, Boris, could you please also build a patched openSUSE_13.2 kernel<br>
for Diego&#39;s testing? Thanks again.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- Adrian<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On Tue, Jun 30, 2015 at 1:36 PM, Adrian Huang &lt;<a href=3D"mailto:adrianh=
uang0701@gmail.com">adrianhuang0701@gmail.com</a>&gt; wrote:<br>
&gt; Commit d5a1c7e3fc38 (&quot;rtc-cmos: Add an alarm disable quirk&quot;)=
 added the<br>
&gt; alarm disable quirk to work around the broken BIOSes. The same symptom=
<br>
&gt; is observed on Lenovo Thinkserver. Instead of adding the impacted<br>
&gt; servers to the &quot;alarm disable&quot; quirk, this patchset aims at =
preventing<br>
&gt; the issue so that the commit can be reverted.<br>
&gt;<br>
&gt; The brief description of the root cause is that: When configuring<br>
&gt; the RTC registers to setup a wake up event in the S5 handler (BIOS),<b=
r>
&gt; the handler does not clear the interrupt flag bits by reading<br>
&gt; Register C of CMOS RTC.<br>
&gt;<br>
&gt; Changes from v2:<br>
&gt;=C2=A0 =C2=A0* Drop the approach &quot;Clear interrupt flag if alarm ti=
me is less<br>
&gt;=C2=A0 =C2=A0 =C2=A0equal to now+1&quot;. Instead, cancel the alarm if =
the configured<br>
&gt;=C2=A0 =C2=A0 =C2=A0alarm time is equal to now+1 seconds. (Suggested by=
 Alexandre)<br>
&gt;<br>
&gt; Changes from v1:<br>
&gt;=C2=A0 =C2=A0* Change the order of [PATCH 1/2] and [PATCH 2/2] (per Bor=
islav)<br>
&gt;=C2=A0 =C2=A0* Drop the approach &quot;RTC alarm timer restoration appr=
oach&quot;. Instead,<br>
&gt;=C2=A0 =C2=A0 =C2=A0[PATCH 1/2] makes sure that AF is cleared in cmos_d=
o_shutdown()<br>
&gt;=C2=A0 =C2=A0 =C2=A0before powering off the machine. (Suggested by Alex=
andre)<br>
&gt;<br>
&gt; Adrian Huang (2):<br>
&gt;=C2=A0 =C2=A0rtc-cmos: Cancel alarm timer if alarm time is equal to now=
+1 seconds<br>
&gt;=C2=A0 =C2=A0rtc-cmos: Revert &quot;rtc-cmos: Add an alarm disable quir=
k&quot;<br>
&gt;<br>
&gt;=C2=A0 drivers/rtc/rtc-cmos.c | 113 ++++++++++++++++++++++++++---------=
--------------<br>
&gt;=C2=A0 1 file changed, 60 insertions(+), 53 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
</div></div></blockquote></div><br></div>

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

--001a11c25cc659cea60519b6c023--
