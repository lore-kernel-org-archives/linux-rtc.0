Return-Path: <rtc-linux+bncBDS7HNEFSALRB3HI5K4AKGQENAZLYNQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si186610wmg.1.2016.04.22.16.31.55
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Apr 2016 16:31:55 -0700 (PDT)
Date: Sat, 23 Apr 2016 01:31:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 4/6] rtc: rv3029: Removes some checks and warnings
Message-ID: <20160422233144.GG17051@piout.net>
References: <cover.1461250479.git.mylene.josserand@free-electrons.com>
 <f4a0b6a1f25057a2d8685dadb0eef5bb0968cf6a.1461250479.git.mylene.josserand@free-electrons.com>
 <20160422232946.GF17051@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160422232946.GF17051@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 23/04/2016 at 01:29:46 +0200, Alexandre Belloni wrote :
> Hi,
>=20
> On 21/04/2016 at 20:24:17 +0200, Myl=C4=8Dne Josserand wrote :
> > @@ -829,8 +829,6 @@ static void rv3029_unregister_driver(void)
> > =20
> >  static int rv3049_probe(struct spi_device *spi)
> >  {
> > -	int res;
> > -	unsigned int tmp;
>=20
> Well, you just introduced those variables in the previous patch.
>=20

And I forgot to add that you still have a few checkpatch warnings to
remove while at it:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#129: FILE: drivers/rtc/rtc-rv3029c2.c:129:
+			    unsigned len)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#141: FILE: drivers/rtc/rtc-rv3029c2.c:141:
+			     unsigned len)


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
