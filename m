Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C6480DD5;
	Tue, 15 Sep 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491290; cv=none; b=UEEzm9ESDjVuf/YG/BQ0q20o2PjWkWSTcBtvvkr4+j1Jck4EQinZ87CIU86vvJYRlGnCmF+PsUIMtmUpKZSGAac1nBFiWiK8mbowXlFuV1CGSQBlE6Z2QZPZOR3c5NUSMoQBnWo9wXUNppSx0N/+nFlYyAahTPVidZlVemT080o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491290; c=relaxed/simple;
	bh=d2G/GGG0mQPgUWqPPiFbPuhRAlhnQ3YOV4/AssBbbcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ9QNyAieXFWdT4qFNAHwaV536xfWwK2QW1NW0oCUW6+bRboQzXbMwZx7Ac4BhKTC13fF/BJ1kJWMlv0Mq6ncOFBrzmd//yLewg5NJNx4pJ1R7msF8rW0LGl4j6T5LdAYGJ6VpCacE8jiHeNmjj6h8rAvKQ9dlGfTnZMqe+uzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp4BJav6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp4BJav6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEA51F000FF;
	Tue, 15 Sep 2026 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491289;
	bh=QmikjEz2kQCP96XnosKZprGleG3DtsAJNmuSAG5lyb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lp4BJav6kh8J+MQhC8UHo1h0gFUt97j+zkLSx+2Ptxqt8lS+C9YWAapiGJy51fwYF
	 D4qWe7uUxE9WQ2IV7tA4MHrPDjswjR5odvto2iavS9D3Q9jlwBwbQc+stQ5J+A6ehe
	 Q3ZA1po08kqCDWxHHhEjjjmKyveI5W12RQ3WvWZf/JxSg9QRHuflAmnMzu5gR3lpJi
	 1fRH78yov8vkaE+s87qRNA8nGDJZKOadO5k81cbMRKZcwLxtsUkHkGJB9hPScprFIK
	 nIhx9L3TLrpyOAeUvhQ7/InnEzTRY66xItjdIk4XUOd2TRihHMBlnCa8tuBigwJXBO
	 4jN9yhde0vbuQ==
Date: Tue, 15 Sep 2026 17:54:44 +0100
From: Conor Dooley <conor@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: rtc: rzn1: interrupts are not required
Message-ID: <20260915-cultural-patriarch-9ad164b46cba@spud>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-11-wsa+renesas@sang-engineering.com>
 <CA+V-a8ssNZ4X+e31V59YdqYmoap-S1W3Vfois9oNisVT3izxag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwpbWqJqgxjHsJk4"
Content-Disposition: inline
In-Reply-To: <CA+V-a8ssNZ4X+e31V59YdqYmoap-S1W3Vfois9oNisVT3izxag@mail.gmail.com>

--uwpbWqJqgxjHsJk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:55:20AM +0100, Lad, Prabhakar wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Mon, Sep 14, 2026 at 10:24=E2=80=AFPM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> >
> > Interrupts are only needed for alarms to work. Reading/Setting the RTC
> > works fine without interrupts. Drop the requirement for interrupts
> > because an upcoming SoC does not have interrupts wired.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yam=
l b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> > index 7ea77cd0bee1..b426a34958d6 100644
> > --- a/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
> > @@ -52,8 +52,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-names
> Maybe we can add a conditional schema check for SoCs where
> interrupts{-names} are required.

Yeah, I'd prefer this. If all current devices have the interrupt wired,
there's little value in permitting them to not be populated and thereby
lose the support for alarms.

>=20
> Cheers,
> Prabhakar
>=20
> >    - clocks
> >    - clock-names
> >    - power-domains
> > --
> > 2.53.0
> >
> >

--uwpbWqJqgxjHsJk4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaql4VAAKCRB4tDGHoIJi
0jaXAQCoq2o2f3FGShm2Pfu9uUKw/bZxhnUK0nesf1f9/yE+ywD9FJ8El30VzRO0
Fq82CMq+kmhuqeWMmXPhWqoeVNHcqQ8=
=eElu
-----END PGP SIGNATURE-----

--uwpbWqJqgxjHsJk4--
