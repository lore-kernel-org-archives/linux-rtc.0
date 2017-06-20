Return-Path: <rtc-linux+bncBDZKLXNI4ACBBPFBUTFAKGQEGO3YN2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz. [195.113.26.193])
        by gmr-mx.google.com with ESMTPS id w136si3641419wmf.3.2017.06.20.05.10.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 05:10:35 -0700 (PDT)
Date: Tue, 20 Jun 2017 14:10:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linaro-kernel@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 51/51] power: suspend test: stop using rtc
 deprecated functions
Message-ID: <20170620121035.GB13221@amd>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <1497951359-13334-52-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
In-Reply-To: <1497951359-13334-52-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Tue 2017-06-20 11:35:59, Benjamin Gaignard wrote:
> rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> rely on 32bits variables and that will make rtc break in y2038/2016.
> Stop using those two functions to safer 64bits ones.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllJELsACgkQMOfwapXb+vItPACfWZa9Zvws5xviE1Uo93s0SZFX
nmAAoJE89i+iligrXRD5h2/QONUrMghS
=0Eaj
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
