Return-Path: <rtc-linux+bncBDSJBYGBRIMBBKOEVG5QKGQE74DUTNQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id x70si41605wmf.1.2016.06.22.03.02.17
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jun 2016 03:02:17 -0700 (PDT)
Date: Wed, 22 Jun 2016 12:02:06 +0200
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 5/8] rtc: ac100: Add clk output support
Message-ID: <20160622100206.GV26668@lukather>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
In-Reply-To: <1466391138-12862-6-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Mon, Jun 20, 2016 at 10:52:15AM +0800, Chen-Yu Tsai wrote:
> +	/*
> +	 * The ADDA 4 MHz clock is from the codec side of the AC100,
> +	 * which is likely a different power domain. However, boards
> +	 * always have both sides powered on, so it is impossible to
> +	 * test this.
> +	 */

If that ADDA clock is exposed by the codec, why are you putting it in
the RTC?

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

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXamIeAAoJEBx+YmzsjxAgep8QALb4QiyE0axUbD8L9KkpG7V0
dOsu/m7Qg+xvaQRGz5AUkytzp3EggzTyyaDQdwL9FaPQEzkxsq275QRu81jfcW28
pYi02XaSUpvAeMIlcAil4xKRzR9M7pWrL8/d/GBwMn/5Znw4nc2cosR4iwfMOH6i
aKSw9pJYjWRqqjaT6QZn+iny3v+diTETG4IAcPqBnljpXCuUHjYYEOJS+PNLYQvL
c09lui5fc9t7ZLIJgQsrJ7hSiNu5XL/qErRWNYxXQqwX4QJnURRW0S+q4z0wysWT
+Z77rMsKo6KKRqDDJRlnVtYwTiyrXnWgCKKI8m23e21biTdCEC1mKdDZciX26v2F
TgTo5+htGKknjpo5qeg+qukL+8aK0kHnLLSaHRLtXScIXYQEMFcY74+RlNcsnNPM
tMQSXcKbGm3HvLediuU4ldUGwQblu6aIDNBPcnetDGH1ehh/ocIfuCH2YSiBQF0g
Po8Yybgn4+kcpIjwIHoWEF4WvjeWY+EbX0/LuSbwl/L6CwzFe2u9HKK76rqPWwlp
E6uG57uWFFzwXtvMem9PKsC8McUU9571GYlSCUxN5ThmhH+cmbeshwN5U5RA7otp
RewA+kwqB0JYzzVdj89gFbaYfIcaXM93uImBinkoCxWMpLxHdtQ9EIcumTcO8zjg
Tuc3OrdLvJzf9H8ybHdv
=Z3pe
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
