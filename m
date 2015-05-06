Return-Path: <rtc-linux+bncBDFYXLWD5IOBB4F7U2VAKGQEUZSKGKA@googlegroups.com>
Received: from mailout4.samsung.com (mailout4.samsung.com. [203.254.224.34])
        by gmr-mx.google.com with ESMTPS id xv6si2699073pab.2.2015.05.05.22.00.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 22:00:30 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NNW00D39WKSAJ30@mailout4.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 06 May 2015 14:00:28 +0900 (KST)
Date: Wed, 06 May 2015 05:00:27 +0000 (GMT)
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [rtc-linux] Re: Re: rtc: rtc-s3c: Set year, month, day value for
 setting alarm
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Donggeun Kim <dg77.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "ben-linux@fluff.org" <ben-linux@fluff.org>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
 =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>
Reply-to: rtc-linux@googlegroups.com
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
MIME-version: 1.0
Message-id: <1049205672.108131430888425869.JavaMail.weblogic@epmlwas03c>
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> ------- Original Message -------
> Sender : Alexandre Belloni<alexandre.belloni@free-electrons.com>
> Date : 2015-05-02 23:19 (GMT+09:00)
> Title : Re: rtc: rtc-s3c: Set year, month, day value for setting alarm
>=20
> Hi,
>=20
> On 10/06/2011 at 17:29:52 +0900, Donggeun Kim wrote :
> > This patch sets year, month, day value for set_alarm function.
> > The current driver omits to set the values.
> >=20
> > Signed-off-by: Donggeun Kim=20
> > Signed-off-by: MyungJoo Ham=20
> > Signed-off-by: KyungMin Park=20
>=20
> This patch never made it to the mainlined but seems useful enough. Do
> you want to respin it?

Donggeun is no more available with that address and I am not aware of
his new address either. I'm adding people who might be interested in
S3C-RTC driver.

CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Marek Szyprowski <m.szyprowski@samsung.com>

ps. Is there any problem for you to resubmit (conflict resolving)
that patch?

>=20
> > ---
> >  drivers/rtc/rtc-s3c.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> > index 16512ec..18e648b 100644
> > --- a/drivers/rtc/rtc-s3c.c
> > +++ b/drivers/rtc/rtc-s3c.c
> > @@ -251,6 +251,7 @@ static int s3c_rtc_setalarm(struct device *dev, str=
uct rtc_wkalrm *alrm)
> >   struct rtc_time *tm =3D &alrm->time;
> >   void __iomem *base =3D s3c_rtc_base;
> >   unsigned int alrm_en;
> > + int year =3D tm->tm_year - 100;
> > =20
> >   pr_debug("s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
> >   alrm->enabled,
> > @@ -276,6 +277,21 @@ static int s3c_rtc_setalarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
> >   writeb(bin2bcd(tm->tm_hour), base + S3C2410_ALMHOUR);
> >   }
> > =20
> > + if (year < 100 && year >=3D 0) {
> > + alrm_en |=3D S3C2410_RTCALM_YEAREN;
> > + writeb(bin2bcd(year), base + S3C2410_ALMYEAR);
> > + }
> > +
> > + if (tm->tm_mon < 12 && tm->tm_mon >=3D 0) {
> > + alrm_en |=3D S3C2410_RTCALM_MONEN;
> > + writeb(bin2bcd(tm->tm_mon + 1), base + S3C2410_ALMMON);
> > + }
> > +
> > + if (tm->tm_mday <=3D 31 && tm->tm_mday >=3D 1) {
> > + alrm_en |=3D S3C2410_RTCALM_DAYEN;
> > + writeb(bin2bcd(tm->tm_mday), base + S3C2410_ALMDATE);
> > + }
> > +
> >   pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
> > =20
> >   writeb(alrm_en, base + S3C2410_RTCALM);
>=20
> --=20
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


--
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), Ph.D.
Frontier CS Lab, Software R&D Center
Samsung Electronics
Cell: +82-10-6714-2858

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
