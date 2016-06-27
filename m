Return-Path: <rtc-linux+bncBDSJBYGBRIMBBKX2YW5QKGQESXDTJEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x70si375482wmf.1.2016.06.27.12.23.22
        for <rtc-linux@googlegroups.com>;
        Mon, 27 Jun 2016 12:23:22 -0700 (PDT)
Date: Mon, 27 Jun 2016 21:23:21 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v3 5/8] rtc: ac100: Add clk output support
Message-ID: <20160627192321.GX4000@lukather>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
 <20160622100206.GV26668@lukather>
 <CAGb2v67DVBZbRb2PWLP8WurPaNin=2Fa=HMAEK_PdBeqv1x+8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
In-Reply-To: <CAGb2v67DVBZbRb2PWLP8WurPaNin=2Fa=HMAEK_PdBeqv1x+8Q@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jun 22, 2016 at 06:11:55PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 22, 2016 at 6:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Jun 20, 2016 at 10:52:15AM +0800, Chen-Yu Tsai wrote:
> >> +     /*
> >> +      * The ADDA 4 MHz clock is from the codec side of the AC100,
> >> +      * which is likely a different power domain. However, boards
> >> +      * always have both sides powered on, so it is impossible to
> >> +      * test this.
> >> +      */
> >
> > If that ADDA clock is exposed by the codec, why are you putting it in
> > the RTC?
> 
> The thing is it's not entirely clear that it's from the codec side.
> I'm just inferring this from the name. (I'll make the comment clearer.)
> The codec parts of the datasheet don't mention this clock at all.
> 
> Allwinner's SDK puts all the clocks under the RTC module. And the
> are always on, so I can't really turn off the codec and see what
> happens. That and I don't have an oscilloscope or logic analyzer.

Why not just create a separate clock driver then?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
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

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcX0pAAoJEBx+YmzsjxAgH5oP/1SDE/ZGU8JvaVyGamQnRemk
hGoiDYWZ5t0/fradi68lkp9imwYvPCxd8EfG6vyVw+J4/4QBXdKijPc4s5XzRuNU
CaS46PpfxpPkk4UHSEjxCoXY6RHZCsexl7AIdZWXuUxinyLqqEjI3vV/rZvtdh3L
68tJsyfuamITQAkcAKp+z6g4BY3pTA8sZHJPt1NsmApHD2d5Px6qIlsRSnPNVXNa
h6yvocYDeZbDqcKrWax77ZN+FROvdNdA9PcJgAJDgi1WCsirlKBZ6CxueR8ME2rd
JxfGUJecdpijXhNdA39mkvMnAJ3OPBrsupLeox2pd3zN+v9IPvd4Qz3Rwp1PYk91
jvq9jmxaU5IvidDA7Mf1aV0k464S33J1oTWGMwsg2+qaciRg0RhH3Gd4KDGdEL7x
7TU2ftZE3ni+sUHBVHUgvJB07QNhZsVYmLb/7uZo5JmhGwKMcMKZTJ5wIdUbAodz
kMhD8KwJ22W7camroq2odh8DQouAOki3uS4IkAMbSx/ztr8gkUnVhHl6YbjsvCqM
V7dVQSTYbV3RN+CtOxyKbaRWbDLXx6AiC4tJCpr3cRbZ6XvCG5A+nC7yNQf0w/i/
XYk54xexFTZO54b0wUqSkpw/cgfj5LDkxcstTYMDRPj/B1kVUnoqAHuAWtUvzvhh
FvvgltlJclLztLZyRr9T
=Vh/U
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--
