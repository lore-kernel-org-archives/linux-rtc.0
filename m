Return-Path: <rtc-linux+bncBDQ2L75W5QGBBX6A5GUQKGQERLBCC6I@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id x3si1297073pdh.2.2015.04.24.08.25.18
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Apr 2015 08:25:18 -0700 (PDT)
Date: Fri, 24 Apr 2015 16:24:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Message-ID: <20150424152445.GR22845@sirena.org.uk>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <7acb2e683450a608adf81e6b820e62b523429101.1429280614.git.stwiss.opensource@diasemi.com>
 <20150418114828.GG26185@sirena.org.uk>
 <6ED8E3B22081A4459DAC7699F3695FB7014B2175E5@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PeBQ4doskhxk04X/"
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B2175E5@SW-EX-MBX02.diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1 2/6] regulator: da9062: DA9062 regulator driver
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--PeBQ4doskhxk04X/
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Apr 24, 2015 at 02:47:06PM +0000, Opensource [Steve Twiss] wrote:
> On 18 April 2015 12:48 Mark Brown wrote:

> Okay. I think I am getting this.
> As of v3.18 there are  newer parts to regulator_desc from the commit 
> a0c7b16 "regulator: of: Provide simplified DT parsing method"
> The search function is now in the core. 

> Am I on on the right track with this one?

Yes.

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

--PeBQ4doskhxk04X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOmA8AAoJECTWi3JdVIfQoU0H/1d6VpxbZu02WyPC4lLH7equ
l9ntoiG1Sbb+xhBQN/tci3wqw2tAIqt5NzgM2bOj51qutEN5Wd8+zVGGQDkYsLOW
vziBRlhwsLEhR/F2c/t9teKwzpfNSpJquVFqi5gXSmaagWr+fb4oBK4O9oCCHKjn
LGNV9C4328KqgUrSm4od6283oLSvXgU5OueH0wjcRQVKyr+6I36QZOMy9cRD8mra
rqBKS3GNFNMlWbtr7upOviksH6YmgVuUg8I3kdThYaz+JknNpWoMXFo6SMW66KGE
xNWcXawiDShyHlvZCjFOHhVGwWHldoiMLqxk4NeHOzlxSfUT32sXYlYEEh5N6Ho=
=e1Qu
-----END PGP SIGNATURE-----

--PeBQ4doskhxk04X/--
