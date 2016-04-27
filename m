Return-Path: <rtc-linux+bncBDUOXGMN6YKBBK4NQO4QKGQEPYD5HTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id ai9si145209lbc.2.2016.04.27.07.03.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 07:03:23 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id p64so8491699lfg.0
        for <rtc-linux@googlegroups.com>; Wed, 27 Apr 2016 07:03:23 -0700 (PDT)
Message-ID: <1461765799.2957.4.camel@gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
From: Sergei Ianovich <ynvich@gmail.com>
To: Mark Brown <broonie@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, "open list:OPEN FIRMWARE AND..."
	 <devicetree@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>
Date: Wed, 27 Apr 2016 17:03:19 +0300
In-Reply-To: <20160427135012.GP3217@sirena.org.uk>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
	 <20160410151237.GD5377@piout.net> <1460301781.17404.171.camel@gmail.com>
	 <20160410153855.GG5377@piout.net> <20160412012518.GQ3351@sirena.org.uk>
	 <CAC5umyguFq7vBenkJYM8AWCNJ3oGBKzKAMHHMsO=+OFHtE4b0A@mail.gmail.com>
	 <20160427135012.GP3217@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 2016-04-27 at 14:50 +0100, Mark Brown wrote:
> On Wed, Apr 27, 2016 at 04:53:18AM +0900, Akinobu Mita wrote:
>=20
> >=20
> > For the read data transfer, the address/command byte is sent on the
> > rising edge of the first eight SCLK cycles and the read data byte
> > is
> > transmitted on the falling edge of the next eight SCL cycles.
> That's an innovative and exciting hardware design :/=C2=A0=C2=A0Definitel=
y
> doesn't
> seem to correspond too closely to any SPI mode I can think of.

DS1302 uses the standard MicroWire half-duplex transfer timing. The
timing can be handled by eg. PXA270 built-in SPI controller with proper
configuration.

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
