Return-Path: <rtc-linux+bncBDS7HNEFSALRB3G25G3AKGQEZOSJOJI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c140si84786wmh.1.2016.03.04.21.23.55
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Mar 2016 21:23:55 -0800 (PST)
Date: Sat, 5 Mar 2016 06:23:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 0/6] rtc-rv3029: Add trickle charger
Message-ID: <20160305052354.GA3293@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
 <20160304200256.2d56c790@wiggum>
 <20160304223654.7a02abde@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160304223654.7a02abde@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/03/2016 at 22:36:54 +0100, Michael B=C3=BCsch wrote :
> This series eventually adds support for the trickle charger mechanism
> to the MicroCrystal rv3029 RTC driver.
>=20
> This series includes the changes from the first and second review round.
>=20
> The tricke charger functionality was verified on a rv3029 connected to
> a RaspberryPi. The resistance between VCC and the battery pin was
> measured for some 'trickle-resistor-ohms' settings.
>=20
> The series is also available in this git repository:
>=20
> git://git.bues.ch/linux.git rv3029
>=20

All applied, thanks!



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
