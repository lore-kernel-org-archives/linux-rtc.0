Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777A285CA8;
	Tue, 20 Jan 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924710; cv=none; b=nDQuY1YbvBh0DwMQWfN1jJLHpGwyqi6psnVT25fcH+lABS8dO6s6VK/7mOn4u94HRZWe6t8265VKSU+Fge7SZ7kcJDhlfIgru+vcK5epS3IX1fQh+TizL28ddwc4A73Kd3DrsRt2WQhiqYP+c+TnFPBtlG1meNJ9xG+Zbg0l75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924710; c=relaxed/simple;
	bh=l37FTkgGHV4sgTU2D8F1KF5HqX8/MzgAGHjMDYU02wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVkMz7x/nC6YjUz2lDKybg26IrKoSPvMzKALmoNkXgax8/vh2yZsaFIKxWQbtV7Oc6sZicGxXpoygAhotfR9E904LrCZx5Ec/Gr9MmI/04Zka6ubKiSsIP+jnIfrqT9OFyqPR7l7mhBfGrlVMVNZ8XIHlU6v3Tkjw41pYxyZqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTA0Yp9S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTA0Yp9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FE7C16AAE;
	Tue, 20 Jan 2026 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924710;
	bh=l37FTkgGHV4sgTU2D8F1KF5HqX8/MzgAGHjMDYU02wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTA0Yp9SV2ZCtU8F8zB0ixx3f1jzFhHWG5oHyLD6RNwcu5Unvjr0wavgfIDjdYXFP
	 dLwPZa/TkotMCsEYfWVDexVQ9CiZ06AUrb9IGusgZbCFot0yTHia91UqdPYJOg15RT
	 3pPc+I2JZSqj9a8GXDuzU81mNgisqamTCzmKwdRE7Lu4M/Ea9Q/eoUCJkWHawGNlY/
	 UmVu+NvsgZy9CfKkYj/jk0ZCOhJ4Qmg9QNI1tMpL8IVtLoExpz9w3XWd2+ha3GJjjB
	 KqhlgN1E3wt4eNdTApNeetY6Pbi7FF7j2VvQa8G886MTaXtmAo2fG7ZOAK/Gv7Q5rt
	 hP6BT1jc4/pkA==
Date: Tue, 20 Jan 2026 15:58:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	tools@kernel.org, users@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <e9bde783-42f3-4f28-9a5e-aa65f36db9ca@sirena.org.uk>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>
 <20260120155241.GG1354723@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxQDUqLbwYzDnVrM"
Content-Disposition: inline
In-Reply-To: <20260120155241.GG1354723@google.com>
X-Cookie: Slippery when wet.


--jxQDUqLbwYzDnVrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2026 at 03:52:41PM +0000, Lee Jones wrote:
> On Tue, 20 Jan 2026, Lee Jones wrote:

> > [1/3] mfd: sec: add rtc alarm IRQ as platform device resource
> >       (no commit info)
> > [2/3] rtc: s5m: query platform device IRQ resource for alarm IRQ
> >       commit: c70aee3dd85482c67720eb642d59ebbb9433faa5
> > [3/3] mfd: sec: drop now unused struct sec_pmic_dev::irq_data
> >       (no commit info)

> Looks like b4 is having a bad day.

> I just applied v3, not this set.

If you fetch a series but don't delete it from the database then (with
b4 ty -d) then b4 will remember it and if any commits in what gets
applied match it'll generate a mail for b4 ty -a.  Usually that's when
some commits didn't get changed.

--jxQDUqLbwYzDnVrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvph0ACgkQJNaLcl1U
h9Dj5wf/aPeSfXUuH0xaET9UsP1lbE0XjWkk+mTPceqVhnkRCgLqNm6+QMGAkLR3
AhBbnU7ZukuBy8cKGaPDJUAp095/3jfzgnGZ33I6oRdDTXaQC9oVZZFa8IWtyJF7
mr2zCOL0mEVnbQltlvKyLJUcrLNWHA+YIof1ANk4cVCOX//2tCGcjL0oi6tMegUQ
TOMim+OyEGVj4yh4epOzup51msvpBAKRxNcszuWjHAoY1k5Gk0M48aGRbejGmZ3o
R9s76nBmAmVXgV/owkCLjVfb2L8eljzuPLrpQJCZxiTvNrrRXnbraiX7ykL7aVcg
TH7MRBCEnYeTZ4h6QgvnewT61qok/A==
=42eu
-----END PGP SIGNATURE-----

--jxQDUqLbwYzDnVrM--
