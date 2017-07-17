Return-Path: <rtc-linux+bncBD6PHS6WQMDRBM6PWPFQKGQEXZRBPOA@googlegroups.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com. [2607:f8b0:400e:c05::22e])
        by gmr-mx.google.com with ESMTPS id i89si907382pfi.9.2017.07.17.09.37.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 09:37:07 -0700 (PDT)
Received: by mail-pg0-x22e.google.com with SMTP id 123so9512144pgj.1
        for <rtc-linux@googlegroups.com>; Mon, 17 Jul 2017 09:37:07 -0700 (PDT)
Date: Mon, 17 Jul 2017 09:37:02 -0700
From: "'Benson Leung' via rtc-linux" <rtc-linux@googlegroups.com>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Javier Martinez Canillas <martinez.javier@gmail.com>,
	Guenter Roeck <groeck@chromium.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 1/4] mfd: cros_ec: Get rid of
 cros_ec_check_features from cros_ec_dev.
Message-ID: <20170717163702.GA149214@decatoncale.mtv.corp.google.com>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
 <20170712101309.6045-2-enric.balletbo@collabora.com>
 <CAMHSBOUT2hpcXrSuvRrZfnEXWtN9QfNLqHvM4TCvHPKiokP0Ag@mail.gmail.com>
 <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
In-Reply-To: <CAFqH_53O8UDPnhCq7BwS7tZ9814HD5GLXWGfbeYJ2PFFk06Uzg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi Enric,

On Mon, Jul 17, 2017 at 12:30:30PM +0200, Enric Balletbo Serra wrote:
> Hi Gwendal,
> 
> Interesting I didn't know that. So are you saying that this patch will
> break support for devices like Pixel 2? I tested the patches on
> various devices but not on Pixel 2 so could be.

This would affect any systems where we have chained ECs. Samus (Chromebook
Pixel 2015) has its PD EC hooked up in this way. Practically speaking,
that would mean that the cros_usbpd-charger power supply driver may not work
correctly.

I don't think we expect any other systems to have this configuration,
but the first one we shipped did, so we will have to support it.

Thanks,
Benson

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZbOeuAAoJEB8J9XsKL+ZYPUUP/jl0EUnsXvp5RTP13/o8a0dK
ZlHGscqp6Jj2HiokkAISVoMkumrToaNLkfCtsFGONoeF4ZrbifrmTRzITwYD0Uqn
F3NOKPM4sVyNgsodDmY4sDAGf6YjUdDZNF/2qVBM/L3ZhGMerr2qC7JsYoSwUMjp
CQEA4XNReWpscg0FFdcDsmxpHbJqZ3AeWYbCvbV0ylkCIZZG9HwtkPagO+ihaeTj
q5KTL+lpmDhHpUqeQtdubAHrKhs9ZPWML67p4YIdnn6d7q5NR+QaqNpBleNBpAel
J/kzKros3xLbe5UnbJ3KTtdK7OIAmyJJf6On78glwDI8m6qX1NwfcPIyKZofcymc
il8Iyec1c0b54isZrl4wA4nTC33KzihATkAhqZBZPMwRn9kRIPnDHCag9ZQWfpME
f36aV8pKPrgxnCrRA4WKpLOaUuHS4ks9aoVKa/6fvA7D0wnV7o2L8xQMtKL/QgWm
/fCj34m59LiQ3XyNAlWaIuwiDk6UGHAZQRF9VJS8VTjWzmN5tEN63pOotCtFAVoY
kM9S42mihlhmsGin55NcTTb5DixwPvJQVV5Fi+5dK6Kpa+xwQy6g0n9sNx/4cyX+
KcrMOOUeDzueDOlb/Xth7Vl87qqZbhVdv1XIW4mVw7tnoiITlXjC39Q5GmDvdB4K
rTYDExJIt5dn4Bq/zUrL
=KeCE
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
