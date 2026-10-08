Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F843D34BC;
	Thu,  8 Oct 2026 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443753; cv=none; b=SM8J3QQeqhGzKXiQEz6jk49y1Kb5wNX0Ua6Ot0YtWibMhpVKTpLqOmpqj7VUNkYRd1kBn158xQrFGqECEwFsv43v85QhiGYWe5Gy8IsgFoJbvD1JvZncyyMC4pPYiJBjN6cObttaFMPV4mfL/7xTB2jW33HgX6zZcqE4qLnOIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443753; c=relaxed/simple;
	bh=PkeDfHH4xYs/A22OE0aCHBDxN1Lx9flrxtlXFOmA1oc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=PTHrBM6NuKy71UZ2WtYU7/x3Lyhd/gOKIsKu9/wMdWK8I8LRU7EN9O4/ujUNhUXg9BJz3YICn4kR1SVdG2cl7IrNXuBwWBviq7PGF8YnbnIiufxiZG7PnQSxGBdQChI3MKuc2xypofE79DmhWkyn+4ivg8hZzZQgnW+61aXAuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1FMm76g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1FMm76g"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3B70B1F000FF;
	Thu,  8 Oct 2026 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791443751;
	bh=Sqq2VDRL1595OmRx1U1VOiFvJEjtd1chObdNQ4Ega74=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To;
	b=j1FMm76gYJFFmlJq5PIzzhFrBwosa0chb4qXmHAVfElgGHj1DzRH6KrHkFsas0pDq
	 uo32OND5U1TLFwIZm15OIcP9R3yQWSxiKY4MvqiBPmZUsU+OJrYM+aUs7IQoLmtAX2
	 Edn+SWuYpoGNR9fzgrCw5chJiI4qZjXWoejdje2hQ4rgj/Ksz59R/H1wMKiu99UTln
	 fDmDUMmPm700FOlnS1NkL0gC9OTGx9IAVj1QBKx2/FCDvw/VMkqo+TXx1MDIcNyMCx
	 SlEod5JoV0kiOPPPeIntAZeukmmKEuqfa8WKKs7J4ylP/OzmwFrRXk93NTbzN7GV4N
	 xvdvxOiE8SgNQ==
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=436759a2d5ee04d1b92a4f8158928ac58f1b314e63d3db11725cf7376ad3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 08 Oct 2026 09:15:48 +0200
Message-Id: <DLZ9T4IKTDTB.1DM6JN54FABRE@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] rtc: pcf8563: add SMBus support
Cc: <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20261008071408.3548442-1-mwalle@kernel.org>
In-Reply-To: <20261008071408.3548442-1-mwalle@kernel.org>

--436759a2d5ee04d1b92a4f8158928ac58f1b314e63d3db11725cf7376ad3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 8, 2026 at 9:13 AM CEST, Michael Walle wrote:
> Since commit 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap") the driver
> uses regmap to access the RTC. Regmap itself will figure out if there is
> a suitable I2C or SMBus host controllers. Thus, don't restict the driver
> to just I2C controllers and make it work on SMBus controllers supporting
> i2c block accesses, too.
>
> This was tested on a custom x86 board.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---

Sorry forgot the changelog:

v2:
 - instead of dropping the check altogether, check for either i2c or
   smbus block support.

--436759a2d5ee04d1b92a4f8158928ac58f1b314e63d3db11725cf7376ad3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCasdDJBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jbagGA5OrklnuAy8QbxUY4rzGP7IUJ6XWjExGx
M/R9ZBFVVtAVZMdPH2y8LGNmqVO6pjI7AYDBOljkEAz51DDybPpUhpCYgOEgYbdL
pdadLnXzL9ihqT/iFLz0bkoPyM4ETOSbG30=
=UX0q
-----END PGP SIGNATURE-----

--436759a2d5ee04d1b92a4f8158928ac58f1b314e63d3db11725cf7376ad3--
