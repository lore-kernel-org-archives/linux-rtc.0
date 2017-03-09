Return-Path: <rtc-linux+bncBDSJBYGBRIMBBKHJQTDAKGQEEONPQQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Date: Thu, 9 Mar 2017 11:55:35 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
	dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel.vetter@intel.com>,
	David Airlie <airlied@linux.ie>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/15] clk: divider: Make divider_round_rate
 take the parent clock
Message-ID: <20170309105535.wdypl3j2ha4ekzyb@lukather>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <7ebd073b4941e4b7c619f15ff0a375ff7919d403.1488876832.git-series.maxime.ripard@free-electrons.com>
 <20170307141157.GC10239@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5ft7t2tnadun7xg"
In-Reply-To: <20170307141157.GC10239@codeaurora.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--s5ft7t2tnadun7xg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Stephen,

On Tue, Mar 07, 2017 at 06:11:57AM -0800, Stephen Boyd wrote:
> On 03/07, Maxime Ripard wrote:
> > So far, divider_round_rate only considers the parent clock returned by
> > clk_hw_get_parent.
> > 
> > This works fine on clocks that have a single parents, this doesn't work on
> > muxes, since we will only consider the first parent, while other parents
> > may totally be able to provide a better combination.
> > 
> > Clocks in that case cannot use divider_round_rate, so would have to come up
> > with a very similar logic to work around it. Instead of having to do
> > something like this, and duplicate that logic everywhere, give an
> > additional parameter for the parent clock to consider.
> > 
> > Current users have been converted using the following coccinelle script
> > 
> > @@
> > identifier hw, rate, prate, table, width, flags;
> > @@
> > 
> > -long divider_round_rate(struct clk_hw *hw,
> > +long divider_round_rate(struct clk_hw *hw, struct clk_hw *parent,
> >                         unsigned long rate,
> >                         unsigned long *prate,
> >                         const struct clk_div_table *table,
> >                         u8 width,
> >                         unsigned long flags) { ... }
> > 
> > @@
> > identifier fn, hw;
> > expression E2, E3, E4, E5, E6;
> > @@
> >  fn (struct clk_hw *hw, ...) {
> >  <...
> > -divider_round_rate(hw, E2, E3, E4, E5, E6)
> > +divider_round_rate(hw, clk_hw_get_parent(hw), E2, E3, E4, E5, E6)
> >  ...>
> > }
> 
> Why not introduce another function like 
> 
> 	divider_round_rate_parent()
> 	divider_round_rate_mux()
> 
> that takes the extra parent argument? Technically, a divider is
> considered to only have one parent, and if it has more than one
> parent, then it is a mux and a divider.

Yes, that would work too, without needing the cross tree change. I'll
do that in the next version.

Thanks!
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

--s5ft7t2tnadun7xg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYwTSnAAoJEBx+YmzsjxAgasYP/i8/gnfsDA6RKGnKu3dnn1el
ax9gwSyGaYWQxuhj+/e9qlt3qCLn59+QPA0vBKtK7wcBjesCT02fMNEV2eZZScAs
68EnlhYmuIJ1BagD3eht0LfqW5HKBXBxY/IO7neYZyCXh3XmBbhD3GTXD/3B94vS
qtLw2HoruWUpisaqLm2tLWF0mYp44zdjvTXhq1q6ilQMYhBYLZKJlnitXHmElPDs
ZtEtofvl5j8OP47jOSeMwSad/HMz1ge43PLfF6OMPsibV+kn+hS7yo5wiyoAcNm4
1tTFnvpZCGQPxniCraP6jUEywVoYYJhZ9VytCZhYDsOQPTTVFtaxkEmy8jFE5qsB
DCHSoVoKROdCsyRVn5x4e9xJgxwdHN41+6blVNG/zWGtZLsls9Nxi0auAxeKjce6
is7db48DMcujV4wf6VDt5Bc3+NuxGILL+b5TVgVg3iTyifkBKeXrC4Wcryl2csdK
ZDadZgCeSS+CceWb5JE/JSjHAesgzrnoTtl0XYfEbjnHzyc8GptaIWA5fiTHGnQa
zjBFcU+iuHX+oompZg9pmTGY0geFTGr7FRpyDHDI2M2y+Csy27cvD5ZrH7Nwlilh
y01ef/lvAXr/snKVTdXD8nQ20gc53fgyMnBQvPONoFtl95M3QhBc2DziCYeYmmRA
z0pw4g0LdOs5Q9zUwQHy
=ItpR
-----END PGP SIGNATURE-----

--s5ft7t2tnadun7xg--
