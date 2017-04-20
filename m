Return-Path: <rtc-linux+bncBAABBFO64PDQKGQEAT62VHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id a3si1329224pfb.2.2017.04.20.10.25.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 10:25:41 -0700 (PDT)
Date: Thu, 20 Apr 2017 10:25:39 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, mark.rutland@arm.com
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Add trickle charger device tree binding
Message-ID: <20170420172538.GA13892@tyrael.amer.corp.natinst.com>
References: <1492468810-17224-1-git-send-email-mdf@kernel.org>
 <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <20170420155634.gs7qkufw7j4mfqpx@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Apr 20, 2017 at 10:56:34AM -0500, Rob Herring wrote:
> On Mon, Apr 17, 2017 at 03:40:10PM -0700, Moritz Fischer wrote:
> > Introduce a device tree binding for specifying the trickle charger
> > configuration for ds1374. This is based on the code for ds13390.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  .../devicetree/bindings/rtc/dallas,ds1374.txt      | 18 ++++++++
> >  drivers/rtc/rtc-ds1374.c                           | 54 ++++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> > new file mode 100644
> > index 0000000..4cf5bd7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/dallas,ds1374.txt
> > @@ -0,0 +1,18 @@
> > +* Dallas DS1374		I2C Real-Time Clock / WDT
> 
> Please remove from trivial-devices.txt, too. (which is moving in 4.12 
> BTW)

Ok, I'll redo this on top of b7e252fcddfa573bb1ee275b53bba6cef85671d4
(Documentation: devicetree: move trivial-devices out of I2C realm) then.

> 
> > +
> > +Required properties:
> > +- compatible: Should contain "dallas,ds1374".
> > +- reg: I2C address for chip
> > +
> > +Optional properties:
> > +- trickle-resistor-ohms : Selected resistor for trickle charger
> > +	Values usable for ds1374 are 250, 2000, 4000
> > +	Should be given if trickle charger should be enabled
> > +- trickle-diode-disable : Do not use internal trickle charger diode
> > +	Should be given if internal trickle charger diode should be disabled
> 
> These should have vendor prefix unless you think they are common.

Well works at least for maxim, dallas & different models like
ds1390, ds1374, so I figured I'd keep the bindings the same.

> 
> > +Example:
> > +	ds1374: rtc@0 {
> > +		compatible = "dallas,ds1374";
> > +		trickle-resistor-ohms = <250>;
> > +		reg = <0>;
> > +	};

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

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY+O8QAAoJEL5CEHepFqovni8H/1HsZv5pWBlbnW1xEio7f4ac
0jb7u+fXvhn/dPVz46LD3JhJjEdSBaQRh9SKFJFiLUUxlPquXnn+OfpGjGIp4lX7
P0iPAcN8Nkj078pEyokjs31Au9lGoMFJdhxqPr1mU8BgUyqV1yopT9FpL1e6amX3
rJatOIFfXTCmc3O5dG4AZt/WE5C2yGPmD9eEQh3zof1iCDnw7Ol0TtRzylAQ2Flr
fQtsDT/GIHWtGrqePxCSx61CuY698wGEUW4aKtQNfY7g/Ap4CUHItA8Zpxbj4Ji3
o12o3tBLQ0iY6+4ZaRbl5+6NqypiwDCHNgfJQx/mejQy4ATCfkLmQZsvUcodV24=
=lUWj
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
