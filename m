Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33265 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdJRVIa (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 17:08:30 -0400
Date: Wed, 18 Oct 2017 23:08:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Introduce clock precision to help time travelers was Re: Extreme
 time jitter with suspend/resume cycles
Message-ID: <20171018210828.GA3581@amd>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <20171015063738.GA24716@xo-6d-61-c0.localdomain>
 <20171018213449.523cd958@alans-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <20171018213449.523cd958@alans-desktop>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-10-18 21:34:49, Alan Cox wrote:
> > And even the boring ones have pretty imprecise RTCs... For example Noki=
a N9.
> > I only power it up from time to time, I believe it drifts something like
> > minute per month... For normal use with SIM card, it can probably corre=
ct
> > from GSM network if you happen to have a cell phone signal, but...
> >=20
> > More interesting machines... Old thinkpad is running without CMOS batte=
ry.
> > ARM OLPC has _three_ RTCs, but not a single working one. N900 has worki=
ng
> > RTC but no or dead backup battery. On these, RTC driver probably knows
> > time is not valid, but feeds the garbage into the system time, anyway. =
Ouch.
> > Neither Sharp Zaurus SL-5500 nor C-3000 had battery backup on RTC...
>=20
> Not a new problem, RTC's used to cost lots of money 8)
>=20
> Most early Unixen set the clock at boot from the superblock timestamp of
> the root fs, some with RTC's also used to scream at you if the superblock
> stamp was too far head of current time.That doesn't quite work with
> initrd but you can do the same in userspace on Linux so you'll at least
> get 'when I last booted it' and because it's always moving forward lots
> of other messes don't happen.

Yeah, that's what "swclock" module of init system does. Someone solved
that one for me. But... that's not good enough. In particular, I'd
like time not to be displayed when "swclock" was used. Nokia 6230
could do it, so linux should be able to do it, too.

It seems kernel should pass accurancy info, or at least "this time is
probably off by hours at least" from gettimeofday() and similar
syscalls...


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnnwswACgkQMOfwapXb+vKUkACcC0Y70OHLyZcLpr3ls4FEhfB8
TlAAnjCE8fuetR7gp8q7N1oHaNKwmgrt
=mdMd
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
