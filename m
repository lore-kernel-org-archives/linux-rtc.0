Return-Path: <rtc-linux+bncBC2PPF5ZT4BBBQMV7OVAKGQEMTI2CVI@googlegroups.com>
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com. [2a00:1450:4010:c03::235])
        by gmr-mx.google.com with ESMTPS id su3si54376lbb.1.2015.05.21.23.20.49
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 23:20:49 -0700 (PDT)
Received: by mail-la0-x235.google.com with SMTP id v1so5784380lag.3
        for <rtc-linux@googlegroups.com>; Thu, 21 May 2015 23:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com>
 <20150518094755.GC23662@pd.tnic> <CANoYJu=utAHVNPU5PnPoBXtpMPVVbFf557xbBO=2GuHyx-JNHg@mail.gmail.com>
 <20150518101248.GE23662@pd.tnic> <20150518160126.GI23662@pd.tnic>
 <CANoYJumsPcXhEaFCgTKvE5mFKJELN0D4F3vjOH97RHPvTeo0fw@mail.gmail.com>
 <20150521205248.GC23652@pd.tnic> <CAHKZfL1n9u=LZwYP5rFJC_MtiBL=TRroq156BAuCeUcPfvO94g@mail.gmail.com>
In-Reply-To: <CAHKZfL1n9u=LZwYP5rFJC_MtiBL=TRroq156BAuCeUcPfvO94g@mail.gmail.com>
From: Diego Ercolani <diego.ercolani@gmail.com>
Date: Fri, 22 May 2015 06:20:48 +0000
Message-ID: <CANoYJuk3WDFjUERx8UNSL04iC7P3XYLdv+P4wrUUO1UBVD3S0w@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
To: Huang Adrian <adrianhuang0701@gmail.com>, Borislav Petkov <bp@suse.de>
Cc: Egbert Eich <eich@suse.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: multipart/alternative; boundary=001a11345a28467e140516a5a92b
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--001a11345a28467e140516a5a92b
Content-Type: text/plain; charset=UTF-8

Sure, only if I haven't to pay ;-)

Il giorno ven 22 mag 2015 01:44 Huang Adrian <adrianhuang0701@gmail.com> ha
scritto:

> > Cool, very nice. Thanks a lot for testing!
> >
>
> Awesome, thanks to all you guys for testing. I'm really appreciated.
>
> > @Adrian: I think you can add Tested-by:'s to your v2.
> >
>
> Sure. I'll send v2 out later with Borislav's Acked-by/Tested-by and
> Egbert's Tested-by.
>
> @Diego: May I have your Tested-by, too?
>
> -- Adrian
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

--001a11345a28467e140516a5a92b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Sure, only if I haven&#39;t to pay ;-)</p>
<br><div class=3D"gmail_quote">Il giorno ven 22 mag 2015 01:44=C2=A0Huang A=
drian &lt;<a href=3D"mailto:adrianhuang0701@gmail.com">adrianhuang0701@gmai=
l.com</a>&gt; ha scritto:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; Cool, very=
 nice. Thanks a lot for testing!<br>
&gt;<br>
<br>
Awesome, thanks to all you guys for testing. I&#39;m really appreciated.<br=
>
<br>
&gt; @Adrian: I think you can add Tested-by:&#39;s to your v2.<br>
&gt;<br>
<br>
Sure. I&#39;ll send v2 out later with Borislav&#39;s Acked-by/Tested-by and=
<br>
Egbert&#39;s Tested-by.<br>
<br>
@Diego: May I have your Tested-by, too?<br>
<br>
-- Adrian<br>
</blockquote></div>

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

--001a11345a28467e140516a5a92b--
