Return-Path: <rtc-linux+bncBCZ5JMGKVMKBBWPV72XQKGQEA7RZ7MA@googlegroups.com>
Date: Mon, 21 Sep 2015 01:07:52 -0700 (PDT)
From: Hao Nguyen <conghaobk@gmail.com>
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: conghaobk@gmail.com, alexandre.belloni@free-electrons.com
Message-Id: <c9f2b773-528d-45c6-a7c0-8ac370fe89b1@googlegroups.com>
In-Reply-To: <20150920203906.GL4287@piout.net>
References: <e108d983-f05c-409a-9f98-e86487e6099f@googlegroups.com>
 <20150920203906.GL4287@piout.net>
Subject: Re: [rtc-linux] Synchronization system time to rtc in Linux
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5105_921562488.1442822872329"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_5105_921562488.1442822872329
Content-Type: multipart/alternative;
	boundary="----=_Part_5106_401395410.1442822872329"

------=_Part_5106_401395410.1442822872329
Content-Type: text/plain; charset=UTF-8

Hi Alexandre Belloni,
I know that hwclock can sync the system time to rtc with option -w.
But eveytime i change the system time, i need to use command "hwclock -w" 
to update time to rtc.
I want the synchronization can be done automatically. This mean, everytime 
i change the system time by "date" command, the time is updated to rtc 
automatically.

Do you have any idea for this? Does linux support this?

On Monday, September 21, 2015 at 3:39:08 AM UTC+7, Alexandre Belloni wrote:
>
> Hi, 
>
> On 17/09/2015 at 21:07:19 -0700, Hao Nguyen wrote : 
> > We're working on our custom board running Linux kernel v2.6.37. 
> > 
> > Our board uses CBC34803 chip cho real time function. Everything is ok 
> > except a problem. 
> > The problem is when i change system time using "date" command with 
> option 
> > '-s', time doesn't automatically update to RTC CBC34803. 
> > My question:  which is responsible for update system time to rtc 
> whenever 
> > the system time changes? 
>
> hwclock is the tool you are looking for. 
>
> -- 
> Alexandre Belloni, Free Electrons 
> Embedded Linux, Kernel and Android engineering 
> http://free-electrons.com 
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

------=_Part_5106_401395410.1442822872329
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alexandre Belloni,<div>I know that hwclock can sync the=
 system time to rtc with option -w.</div><div>But eveytime i change the sys=
tem time, i need to use command &quot;hwclock -w&quot; to update time to rt=
c.</div><div>I want the synchronization can be done automatically. This mea=
n, everytime i change the system time by &quot;date&quot; command, the time=
 is updated to rtc automatically.</div><div><br></div><div>Do you have any =
idea for this? Does linux support this?<br><div><br>On Monday, September 21=
, 2015 at 3:39:08 AM UTC+7, Alexandre Belloni wrote:<blockquote class=3D"gm=
ail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc soli=
d;padding-left: 1ex;">Hi,
<br>
<br>On 17/09/2015 at 21:07:19 -0700, Hao Nguyen wrote :
<br>&gt; We&#39;re working on our custom board running Linux kernel v2.6.37=
.
<br>&gt;=20
<br>&gt; Our board uses CBC34803 chip cho real time function. Everything is=
 ok=20
<br>&gt; except a problem.
<br>&gt; The problem is when i change system time using &quot;date&quot; co=
mmand with option=20
<br>&gt; &#39;-s&#39;, time doesn&#39;t automatically update to RTC CBC3480=
3.
<br>&gt; My question: =C2=A0which is responsible for update system time to =
rtc whenever=20
<br>&gt; the system time changes?
<br>
<br>hwclock is the tool you are looking for.
<br>
<br>--=20
<br>Alexandre Belloni, Free Electrons
<br>Embedded Linux, Kernel and Android engineering
<br><a href=3D"http://free-electrons.com" target=3D"_blank" rel=3D"nofollow=
" onmousedown=3D"this.href=3D&#39;http://www.google.com/url?q\75http%3A%2F%=
2Ffree-electrons.com\46sa\75D\46sntz\0751\46usg\75AFQjCNGC8C9pT7xKJEabITLGL=
5cqtolifQ&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.google.=
com/url?q\75http%3A%2F%2Ffree-electrons.com\46sa\75D\46sntz\0751\46usg\75AF=
QjCNGC8C9pT7xKJEabITLGL5cqtolifQ&#39;;return true;">http://free-electrons.c=
om</a>
<br></blockquote></div></div></div>

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

------=_Part_5106_401395410.1442822872329--

------=_Part_5105_921562488.1442822872329--
