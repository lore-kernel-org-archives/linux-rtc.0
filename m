Return-Path: <rtc-linux+bncBAABB3OO5WYAKGQEPNIFXYI@googlegroups.com>
Received: from SJOEDG01.corp.atmel.com (nasmtp02.atmel.com. [204.2.163.16])
        by gmr-mx.google.com with ESMTPS id f4si525605igo.2.2015.10.12.00.55.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 00:55:25 -0700 (PDT)
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, "Ferre, Nicolas"
	<Nicolas.FERRE@atmel.com>, "Desroches, Ludovic"
	<Ludovic.Desroches@atmel.com>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] RE: [PATCH] rtc: at91rm9200: clear RTC alarm status flag
 prior to suspending
Date: Mon, 12 Oct 2015 07:55:13 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641D632214D@penmbx01>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
 <20151012065323.GA3558@piout.net>
 <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
 <20151012075115.GC3558@piout.net>
In-Reply-To: <20151012075115.GC3558@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> Sent: 2015=E5=B9=B410=E6=9C=8812=E6=97=A5 15:51
> To: Yang, Wenyou
> Cc: Alessandro Zummo; Ferre, Nicolas; Desroches, Ludovic; rtc-
> linux@googlegroups.com; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior t=
o
> suspending
>=20
> On 12/10/2015 at 07:48:18 +0000, Yang, Wenyou wrote :
> > > On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> > > > This patch is to clear the RTC alarm status flag prior to
> > > > suspending to avoid the erroneous wake-up activity.
> > > >
> > >
> > > Is this a new issue appearing with the sama5d2 or was it present
> > > from the beginning?
> > With the sama5d2 ULP1 mode, not from the beginning.
> >
>=20
> I think this information should appear in the commit log.
I will add it in the next version, thanks.

>=20
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

Best Regards,
Wenyou Yang

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
