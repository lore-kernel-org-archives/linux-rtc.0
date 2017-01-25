Return-Path: <rtc-linux+bncBDSJBYGBRIMBB3MLUPCAKGQEE6Y4DGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f142si1514657wmf.2.2017.01.25.07.36.12
        for <rtc-linux@googlegroups.com>;
        Wed, 25 Jan 2017 07:36:12 -0800 (PST)
Date: Wed, 25 Jan 2017 16:36:02 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 0/7] rtc: sun6i: Fix the RTC accuracy
Message-ID: <20170125153602.tcdh2rk3bs3cz5j6@lukather>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
 <20170124174935.att4s7mqfbyxkxqk@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s6h6thk2i7f7xoh5"
In-Reply-To: <20170124174935.att4s7mqfbyxkxqk@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--s6h6thk2i7f7xoh5
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Jan 24, 2017 at 06:49:35PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 23/01/2017 at 11:41:45 +0100, Maxime Ripard wrote :
> > Hi,
> > 
> > The RTC used in the A31 and later SoC has an accuracy issue, which is
> > already significant even after a couple of hours.
> > 
> > This is due to the fact that the oscillator used by default is an internal
> > and very inaccurate one.
> > 
> > A first attempt at fixing that by switching to the external oscillator was
> > done in the patch "rtc: sun6i: Switch to the external oscillator". However,
> > it turned out to be problematic since it was tracked properly in the clock
> > framework, which might lead to some clocks being disabled, even though
> > their devices were not notified.
> > 
> > This is a second attempt, this time by making it part of the CCF. It
> > turned out to be a bit more complicated than one would expect since the mux
> > found inside the RTC also controls one of the input of the main clock unit.
> > Therefore, it needs to be probed before the main clock unit driver.
> > 
> > Let me know what you think,
> > Maxime
> > 
> > Changes from v1:
> >   - Force the muxing to the external oscillator even for old DT
> >   - Make the patches a bit more stable friendly
> >   - Change the bindings to have a cell of 1, to account for the external
> >     output of the oscillator
> >   - Split the driver remove() removal into a separate patch and switched to
> >     devm
> >   - Reordered the patches
> > 
> > Maxime Ripard (7):
> >   rtc: sun6i: Disable the build as a module
> >   rtc: sun6i: Add some locking
> >   rtc: sun6i: Switch to the external oscillator
> >   rtc: sun6i: Expose the 32kHz oscillator
> >   rtc: sun6i: Switch to devm_rtc_device_register
> >   ARM: sun8i: a23/a33: Enable the real LOSC and use it
> >   ARM: sun8i: a23/a33: Add the oscillators accuracy
> > 
> 
> I've applied 1/7 to 5/7. Thanks!

And I just applied patches 6 and 7. Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--s6h6thk2i7f7xoh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYiMXeAAoJEBx+YmzsjxAgyiwP/0TlOJhOckdv5uIahbHnS+UI
+Nfa/XeioBR+7ydOUg8n+F0MFmH9vnsncBkP4qNTWE2xzQVfbdnYr47XJ3r4Z6el
Vs2eUtCwjsyeuKF1ZDYx4pgmPT71OHyfwaGZIqLIVDiFmgjze8eBj0y4wlkK3Gj4
DEtYUlL8rBOHB4OGI+Ny8I3Mshh32gNwYpgMTZ15Uanzje2UQ1OGlOR1qdbFR5Bi
eXcy1P3d8NQ2hFSKDg5FJgFhzWweIMY39TlHbSNM5Em0eQYtbf44+xb1rDLG6lMj
IQIYnk20nz6LXguD2QKAOPnBHrwkYECCmCS6aOrh9np9nf+VHqXWXHgEP28c2ijp
gcacSUMpLqJHf1O5By4qhaRYtBA6JuMdpqAw/cyL2upv/cPcUldaoAmi3+audsf1
6P7sm4l597z6VXXGIcTnBrf3CcYHUf4c83CsiM23m1YgmewCd6/UO9hCnZgKkr7a
1ksH6UYJDtENV1/dLsU2tMr3w9jnA7TXX1KByrkEQFP/8+G7UOEvDDijNqnZarhj
KvN/75p+Q5r98Nlp1Xp+byKL01p+x7xxYSacmLe98VFeTM1tK36rZo5IJ82KiFs7
VP6xTZ/Jqv6mATaBJtgn13NA/6gO6daYjQyQCiUK1z0Vesgd4ncoMwHmg25qxLNb
cAFKe3B8GOroza8mkDCs
=NgQM
-----END PGP SIGNATURE-----

--s6h6thk2i7f7xoh5--
