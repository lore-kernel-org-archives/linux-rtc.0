Return-Path: <rtc-linux+bncBD3IBDERZIEBB5WN4C3AKGQEI5TEPFQ@googlegroups.com>
Date: Thu, 3 Mar 2016 03:58:45 -0800 (PST)
From: cvs268@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	s.trumtrar@pengutronix.de
Message-Id: <6c5c65d7-2cee-4e3f-a91c-c9fbd4c006c7@googlegroups.com>
In-Reply-To: <20160131140418.GD11885@pengutronix.de>
References: <1451927075-8656-1-git-send-email-s.trumtrar@pengutronix.de>
 <1451927075-8656-2-git-send-email-s.trumtrar@pengutronix.de>
 <20160131115457.GL20165@piout.net>
 <20160131140418.GD11885@pengutronix.de>
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc: add driver for RX6110SA real time clock
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_885_2103885592.1457006325641"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_885_2103885592.1457006325641
Content-Type: multipart/alternative;
	boundary="----=_Part_886_2101094210.1457006325641"

------=_Part_886_2101094210.1457006325641
Content-Type: text/plain; charset=UTF-8

 

> > > If the need ever arises to also support the I2C variant, this driver 
> > > could easily be refactored to support both cases. 
>
I will soon be getting an embedded board with this RX6110 RTC on it 
connected via I2C.
So i would like to take-up the task of adding I2C support in a few weeks.

A quick search shows drivers/rtc/rtc-rx4581.c was similarly written based 
on drivers/rtc/rtc-rx8581.c

Q. Should i proceed to create drivers/rtc/rtc-rx6110-i2c.c or whats the 
recommended approach?
I did not find any RTC driver that supports both i2c and spi (eg. depending 
upon some config option)

regards
CVS

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

------=_Part_886_2101094210.1457006325641
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0<br><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">&gt=
; &gt; If the need ever arises to also support the I2C variant, this driver
<br>&gt; &gt; could easily be refactored to support both cases.
<br></blockquote><div>I will soon be getting an embedded board with this RX=
6110 RTC on it connected via I2C.<br>So i would like to take-up the task of=
 adding I2C support in a few weeks.<br><br>A quick search shows drivers/rtc=
/rtc-rx4581.c was similarly written based on drivers/rtc/rtc-rx8581.c<br><b=
r>Q. Should i proceed to create drivers/rtc/rtc-rx6110-i2c.c or whats the r=
ecommended approach?<br>I did not find any RTC driver that supports both i2=
c and spi (eg. depending upon some config option)<br><br>regards<br>CVS<br>=
</div></div>

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

------=_Part_886_2101094210.1457006325641--

------=_Part_885_2103885592.1457006325641--
