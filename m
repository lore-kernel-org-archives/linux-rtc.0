Return-Path: <rtc-linux+bncBDA7X7F2WUEBBT4X4WVQKGQEYW65FYI@googlegroups.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id p9si396692wiz.3.2015.06.11.01.50.23
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 01:50:23 -0700 (PDT)
Received: by mail-wi0-f180.google.com with SMTP id d19so68412468wiw.0
        for <rtc-linux@googlegroups.com>; Thu, 11 Jun 2015 01:50:23 -0700 (PDT)
Date: Thu, 11 Jun 2015 09:50:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [rtc-linux] Re: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
Message-ID: <20150611085019.GE2982@x1>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
 <20150526161024.GQ11677@x1>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22F4C4@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22F4C4@SW-EX-MBX02.diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 11 Jun 2015, Opensource [Steve Twiss] wrote:

> On 28 May 2015 13:53, Steve Twiss wrote:
>=20
> > To: 'Lee Jones'
> > Subject: RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
> >=20
> > Hi Lee,
> >=20
> > I will refactor a lot of the driver and implement your changes as reque=
sted.
>=20
> Hi Lee,
>=20
> I realise this is a busy kernel time for you, as ever, so this is just to=
 see if I am
> missing anything with the reply I sent about the requested alterations a =
couple
> of weeks ago.=20

Looks like I missed v4.  It's laying in my inbox 'read' and not marked
as 'important', goes against my usual process.  I'll take a look now.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
