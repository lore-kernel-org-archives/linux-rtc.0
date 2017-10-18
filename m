Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34445 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdJRV4k (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 17:56:40 -0400
Date: Wed, 18 Oct 2017 23:56:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Gabriel Beddingfield <gabe@nestlabs.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        hharte@nestlabs.com
Subject: Re: Introduce clock precision to help time travelers was Re: Extreme
 time jitter with suspend/resume cycles
Message-ID: <20171018215638.GA7487@amd>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <20171015063738.GA24716@xo-6d-61-c0.localdomain>
 <20171018213449.523cd958@alans-desktop>
 <20171018210828.GA3581@amd>
 <20171018212645.7htby4qmnfbep3vx@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <20171018212645.7htby4qmnfbep3vx@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-10-18 23:26:45, Alexandre Belloni wrote:
> On 18/10/2017 at 23:08:28 +0200, Pavel Machek wrote:
> > On Wed 2017-10-18 21:34:49, Alan Cox wrote:
> > > > And even the boring ones have pretty imprecise RTCs... For example =
Nokia N9.
> > > > I only power it up from time to time, I believe it drifts something=
 like
> > > > minute per month... For normal use with SIM card, it can probably c=
orrect
> > > > from GSM network if you happen to have a cell phone signal, but...
> > > >=20
> > > > More interesting machines... Old thinkpad is running without CMOS b=
attery.
> > > > ARM OLPC has _three_ RTCs, but not a single working one. N900 has w=
orking
> > > > RTC but no or dead backup battery. On these, RTC driver probably kn=
ows
> > > > time is not valid, but feeds the garbage into the system time, anyw=
ay. Ouch.
> > > > Neither Sharp Zaurus SL-5500 nor C-3000 had battery backup on RTC...
> > >=20
> > > Not a new problem, RTC's used to cost lots of money 8)
> > >=20
> > > Most early Unixen set the clock at boot from the superblock timestamp=
 of
> > > the root fs, some with RTC's also used to scream at you if the superb=
lock
> > > stamp was too far head of current time.That doesn't quite work with
> > > initrd but you can do the same in userspace on Linux so you'll at lea=
st
> > > get 'when I last booted it' and because it's always moving forward lo=
ts
> > > of other messes don't happen.
> >=20
> > Yeah, that's what "swclock" module of init system does. Someone solved
> > that one for me. But... that's not good enough. In particular, I'd
> > like time not to be displayed when "swclock" was used. Nokia 6230
> > could do it, so linux should be able to do it, too.
> >=20
> > It seems kernel should pass accurancy info, or at least "this time is
> > probably off by hours at least" from gettimeofday() and similar
> > syscalls...
>=20
> The question being how do you expect the kernel to get that information?

I expect userland to tell kernel. "time is now 12.34, source is ntp,
to it is precise to milliseconds". Or maybe "time is now 23.45, source
is swclock, so it may be off by months".

> Some RTCs will tell you when they lost time/time accuracy and this
> should be properly reported by the driver. If not, this has to be
> implemented.

How is it reported to the userspace?

> For anything else, it is probably the job of userspace to try to be
> clever.

Userspace would be fine with me, but as far as I can tell, there's no
good way to do it in userspace.

My proposal would be: kernel keeps accuracy for timeofday.

If RTC says time is bad, accuracy is set to ~0.

settimeofday sets accuracy to 0 (completely accurate).

new_settimeofday gets new argument, accuracy.

new_gettimofday returns accuracy, too.

Does that sound sane? I'm not sure what other interfaces need to be extende=
d.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnnzhYACgkQMOfwapXb+vKiwQCfYK5SRF/OoyjWVYuMVvqqfwYE
2msAn2GSvw7h59SRJROI0cwJBBzZWq0i
=u9Qq
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
