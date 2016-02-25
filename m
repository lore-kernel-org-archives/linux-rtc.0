Return-Path: <rtc-linux+bncBC3JZ2XR4EBBBHGRXS3AKGQEO2QGH4Y@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id 12si1284816pfb.1.2016.02.25.08.15.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2016 08:15:24 -0800 (PST)
Date: Thu, 25 Feb 2016 17:15:11 +0100
From: Thierry Reding <treding@nvidia.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <rtc-linux@googlegroups.com>,
	<swarren@nvidia.com>, <k.kozlowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH V8 0/8] Add support for MAXIM
 MAX77620/MAX20024 PMIC
Message-ID: <20160225161510.GB1903@ulmo.nvidia.com>
References: <1455191794-6065-1-git-send-email-ldewangan@nvidia.com>
 <20160216160029.GC11400@ulmo.nvidia.com>
 <56C7EE58.8000905@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <56C7EE58.8000905@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Feb 20, 2016 at 10:10:56AM +0530, Laxman Dewangan wrote:
> 
> On Tuesday 16 February 2016 09:30 PM, Thierry Reding wrote:
> >On Thu, Feb 11, 2016 at 05:26:26PM +0530, Laxman Dewangan wrote:
> >>Add SW support for MAXIM Semiconductor's Power Management
> >>IC (PMIC) MAX77620/MAX20024. This PMIC supports DC-DC/LDOS, GPIOs,
> >>RTC, watchdog, clocks etc.
> >Hi Laxman,
> >
> >This series is starting to look pretty good. Do you have patches in the
> >works to add the corresponding DT content for the various boards that we
> >support? I think the Jetson TX1 patch would be most interesting since
> >that's what people can get their hands on.
> >
> 
> Yes, I am just waiting for this series to be concluded and applied. Once it
> is done, I will immediately post the patches to enable this driver in config
> and dt entry for the Jetson-TX1.

Why hold back on the patches? I'm currently having trouble testing
your stash here on Jetson TX1 and I suspect that I'm using the wrong
device tree content (it was derived from downstream many moons ago).
There's nothing wrong with posting patches that depend on patches on
the list. Typically you'd note the dependency in the cover letter to
make it easier for people to find what belongs together.

Thierry

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

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWzyiOAAoJEN0jrNd/PrOhx6wP/j3nl4wG3BodnmqWDktA7uJK
KmhX4+Xd/vdP31e9Hp1EEauCNG9dxz7rAKeWNxsI+leY2IXJplSbgLW6lRjJNMs2
27W4EPUrqmzFqwEofVAVu9hZF4aTkXF9QWjgI1OEAad2W9w22ahzZ9WKWwERjKLE
ROHQtZ9fL3BBfdpGyz8Ama8q1jdueE3A3/e92AgsCl8GV5ut3QQpVTDbrt6jrkDC
c6FhzT3w+ftDlY+RHdK7RHIL8XlJgwthMpXdnzEhANkK8+GusAua/eZ97t7FeG2j
2GV2bPXfWFJXRxdRQ/2ujxZ12xUahHHddpYz2NgvH4IVZ3Gd1IYdvwjkNYuFnnVV
OqeeuxaWf/jsVrjuGgIT0o0gdEQJQx+6wVyQGHRUyhX+BbXHX3VffxIlwxudK/qE
Np0u3+tKAEvzn71EfWaVKsr1EIdih+zWYsBrno3zik/iv0XwqsDSr6ueaidaPp2j
9WrzYACNbXSoYuCeN+hfA74FG7iOPycY7bYujl6aXchcG4FhJIcT4WFURytqghsu
KgrXJmOVgKszr5Q7bsYuGsVAVERDSJEHpF3IVD2av9OqKqkZqzPtMaPPa6okVef7
Q/sxRk13Sa+Oww1NMhm6UCy1pQIaoLNepq0FIF2EY1L7e1OHs4QRnWUveYhm/hmb
KCZ9etWc/J9GD+KkHk+2
=4kMH
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
