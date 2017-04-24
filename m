Return-Path: <rtc-linux+bncBAABBBW47HDQKGQEKJQ65OY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id j13si108680itj.3.2017.04.24.14.28.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 14:28:38 -0700 (PDT)
Date: Mon, 24 Apr 2017 14:28:35 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>, rtc-linux <rtc-linux@googlegroups.com>,
	Devicetree List <devicetree@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Add trickle charger device tree binding
Message-ID: <20170424212835.GA24096@tyrael.amer.corp.natinst.com>
References: <1492468810-17224-1-git-send-email-mdf@kernel.org>
 <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop>
 <20170420172538.GA13892@tyrael.amer.corp.natinst.com>
 <CAAtXAHfNuRXninLWySAOdtV99ih4PBt=JPszn3UkNa08OvXLFQ@mail.gmail.com>
 <20170424171639.6vv5hxrejylloh3b@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <20170424171639.6vv5hxrejylloh3b@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Alex,

On Mon, Apr 24, 2017 at 07:16:39PM +0200, Alexandre Belloni wrote:

> I think I would do something with MFD as you were suggesting on IRC. You
> can have a look at the flexcom driver (atmel-flexcom.c) which is simply
> selecting a mode and then using whatever IP driver already existed
> (UART, I2C or SPI).

That's an interesting approach, so the idea is to basically use the MFD
to switch an existing driver one way or another via pdata? That could work.

> 
> I didn't have a close look but maybe that fits. Then, as you are
> concerned wtih backward compatibility, you could enforce the mode from
> the MFD driver, depending on the CONFIG_RTC_DRV_DS1374_WDT value.

This is where I'm currently at:

https://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux.git/log/?h=wip/mfd-ds1374-rfc

Still a WIP, maybe can get out a patchset by the end of the week ...

Thanks,
Moritz

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY/m4BAAoJEL5CEHepFqovSesIAI2GEJFD0AZkimJRrMJ7UEFG
tdM0SLlrNj1iBf3o9hIFerAKC7sB+Xgx9IWAGK4ijgkegP4rRvk6q23eCjeBz1Mb
T3p/cgfKjVMmmZDGmHCgVmrqjtPfB+WWKMLun6K4AxdJK3Ipcdvlh70z7yk4NqFh
G1Xw4ZXWx3XF9k8g3MIKVT66+uyY7uLDfOdSWeCEcbCl3U7o6rF6wm4KQyHMGmkN
9AFr//ZadgADwy+JBqftSyX3p4Jn+uUP5KEn8hJ5IV29qeY8tqEwtSUaukwzMIEc
IwtFWNe7Qkh9+snApI0i9yPEPucgO0Mxnt98KFkSwW2WkaPrPINfExIh965YEKY=
=UdI7
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
