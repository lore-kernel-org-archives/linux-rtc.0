Return-Path: <rtc-linux+bncBDQ2L75W5QGBBP5G7KUQKGQEK7NZTLA@googlegroups.com>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk. [2400:8900::f03c:91ff:fedb:4f4])
        by gmr-mx.google.com with ESMTPS id ei3si2214833pdb.1.2015.04.27.12.51.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Apr 2015 12:51:27 -0700 (PDT)
Date: Mon, 27 Apr 2015 20:50:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Rajeev Kumar <rajeevkumar.linux@gmail.com>
Cc: dmitry.torokhov@gmail.com, a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	alsa-devel@alsa-project.org, rtc-linux@googlegroups.com,
	akpm@linux-foundation.org, rajeev-dlh.kumar@st.com
Message-ID: <20150427195052.GC22845@sirena.org.uk>
References: <1430119562-14816-1-git-send-email-rajeevkumar.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fIeM2UqBLUBfNdiZ"
In-Reply-To: <1430119562-14816-1-git-send-email-rajeevkumar.linux@gmail.com>
Subject: [rtc-linux] Re: [PATCH: RESEND] Update email-id of author
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--fIeM2UqBLUBfNdiZ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Apr 27, 2015 at 12:56:02PM +0530, Rajeev Kumar wrote:

>  .mailmap                                     |    1 +
>  arch/arm/mach-spear/generic.h                |    2 +-
>  arch/arm/mach-spear/include/mach/irqs.h      |    2 +-
>  arch/arm/mach-spear/include/mach/spear.h     |    2 +-
>  arch/arm/mach-spear/spear6xx.c               |    2 +-
>  drivers/input/keyboard/spear-keyboard.c      |    2 +-
>  drivers/rtc/rtc-spear.c                      |    4 ++--
>  include/linux/platform_data/keyboard-spear.h |    2 +-
>  include/sound/designware_i2s.h               |    2 +-
>  include/sound/spear_dma.h                    |    2 +-
>  10 files changed, 11 insertions(+), 10 deletions(-)

Please split this up into per-subsystem patches so it's easier to apply.

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

--fIeM2UqBLUBfNdiZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpMbAAoJECTWi3JdVIfQ7UwH/0K/e3IB2Sa/2rTAKf7WX18u
uaZAFc760g8wSmyLIZq/YF1erSQYaHfwu9AMUnp3TAWHtCGXaPn/81bqQ0JXhIsc
Ljvy/AbHbzwMa3SAnP3/s5rJvd92G3wUm1CjV83heUh8KyBBSEkuzWCoGo/UjZxF
FS5+VcuKeCP0AwSufiQ+gJn1B/mhkuQHXHVM4Z+smgsL8hwKY6y9rANkfdtfHDh+
waR4omPKHw1kgyp0XKafkQwcL0v00pPyfaRsGVM0AEpi6IMWLtP0Z5h9br9mTujy
Sxrl7ExJlKxVenWmDIm0OI+dfGU0YM++CmipCNi4QeWfWzD/UEhPh5DXwr1QwoE=
=vpKH
-----END PGP SIGNATURE-----

--fIeM2UqBLUBfNdiZ--
