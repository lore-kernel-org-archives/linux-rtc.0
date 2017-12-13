Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbdLMMQM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 07:16:12 -0500
Date: Wed, 13 Dec 2017 12:16:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
Message-ID: <20171213121603.GF6416@sirena.org.uk>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
 <20171212221643.GL8318@piout.net>
 <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
 <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
 <20171213110426.GQ8318@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
In-Reply-To: <20171213110426.GQ8318@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 12:04:26PM +0100, Alexandre Belloni wrote:

> Also, I think we could try having only the time64_t in the ring buffer.
> Maybe I'm wrong but I think tools reading that buffer can do the
> conversion themselves. Maybe I don't understand correctly how
> tracepoints work and this doesn't make sense, tell me.

Tools reading the buffer can do the conversion themselves but it's also
useful for users to just view the log directly via tracing/trace
sometimes.  OTOH the whole point is to be low overhead so...

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxGgIACgkQJNaLcl1U
h9B17Qf/Y3Hhk7S3MvQugCMGEQCfP4171P6OxC1GEDNQKWvrfMvKJjPCQQr44eqC
yWLIOVgMb5CrBLoIlcngGkhKV4oKAPWjljFogIIJQtL4AsHvD3IlKGzvmViHTA64
2UmFDyLh0yDgyHDibn6R53e9RuTcGDvA4W1cweqU3wfzm5rO8E1SgJrZwMHauUqf
xf2IehGA2EOzKtaoq1goVuKqWPDR6S7hvcd9cVSuVl5yKlR4gzGFcx+2dUtT0u1l
EfO4exsi2juEna8c/pAQ34XydtTdSJJfaspmGSEpfNXTnRrbe0zXUWQ4e/Xj9bm7
aC5sawvUVM2Kg4urwoVP6IrQ1OwaoQ==
=Tvdy
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
