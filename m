Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986741;
	b=j93okKmno8khrwPL3ltvyiEFoKWMbthNaDl767x9NvBvY0BOnti/Y4xJxvnDIW8fSzE/
	 tIM7Ndi34fjqyV0hQMZzdivxraxDNVQB3nvhbY7Zi7ejfQJmAPHafY3sOZaWdL2fdPBNx
	 AgNifGsqoXzNzKQOipx/1R1YAinaDEzIQGtlNJzRYYrejtAaccjthpNnUzV2pmwZDufmo
	 8enqdXQILHxPVuxFEUwGUswrOtvtmuQfeh+tAVFObbV2KzavRaQPRm0q7vKymGvAniARI
	 GLwEmFVPxRS0l3T0BoOvejZSsolUtxEs1jhorQsmI3ASQWBIN1xunT7AOpiTfxJhTzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986741;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xnvDVgToLFSexCkQ8IuVCodOWeCCPd6z2Xsxq1gejSw=;
	b=T1Nicr+uE4gsLWr/WaCNNoSnlA22TAWbvtRf7SFqJDl12BE3G5DV8zApQ3eDoEN14Tow
	 Z/9WlCq/oe8EH8+sXWtKKXPSiuq9dZAr9I/o1QCSKcRwh8b5xGwUGSOEYf7QNPJED4+Iv
	 16CD3lSrAUxIyb1+EKgAnuWLYKSyYx/SgdzxAqqu1JXIHdegKD9XEhqdoD6C1uahB8sif
	 rQ2XZM/iVUWX5KPsNUEdU5mHzzSLXcJd57plu5SZ8PJBiO9RF1oV0HPR4mGcmQYIdx1cj
	 w74wUaozobYJ66jd8kSMX0Lkyf+KLC1UQu4b6gnkP7vOUZIP/8yofpPlDk/N/zpDncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kya41GOC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987F606EE93;
	Fri,  6 Nov 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kya41GOC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4B81F0089F;
	Fri,  6 Nov 2026 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986741;
	bh=xnvDVgToLFSexCkQ8IuVCodOWeCCPd6z2Xsxq1gejSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kya41GOCC9EAJOzwek7u4IT30NnKey2AxngjIUqjJ3/KZCN9CCh3C5KdBVNgAisH5
	 WsDgmOGEglC1ogJGa6D4hVc+2FIR4vCm/eVP5gxuiM6divsLvG06BW968KmcHdQ9RW
	 Lt7WckpO1F+DBHmUl4aRuT8Q9xExiikeAcrploG+6Y7Jm7RYClvPVpT5ib3g2fsFoi
	 pQt2OYj4NYvViiAzmCLcu07p9GLGX6KFVIcnVP6qHMHPxwY8+NEGNf3MR2DLSny6Vv
	 miJ+aWSy2duCuf8T84/stK7PBv6shYU75kmrbtZHjcA+kEggO7zcQQ4YRanZlqq26w
	 XjOALHRqjVvVw==
Date: Fri, 6 Nov 2026 17:38:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Rea <rodrigo.rea@marsrover.mx>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexander.stein@ew.tq-group.com,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.aguirre@nxp.com,
	rodrigo.rea@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Message-ID: <20261106-shush-suffering-cd7caec6e3a2@spud>
References: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>
 <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5BH6bQ6n70AdO3Q"
Content-Disposition: inline
In-Reply-To: <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>

--b5BH6bQ6n70AdO3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 09:53:07PM +0000, Rodrigo Rea wrote:
> From: Rodrigo Rea <rodrigo.rea@nxp.com>
>=20
> Document the NXP PCA85074A real-time clock compatible.

Driver change suggests a fallback compatible can be used. Why haven't
you used one?

Thanks,
Conor.

>=20
> Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml b/Do=
cumentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
> index f7013cd8f..b06ad3e0c 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.yaml
> @@ -18,6 +18,7 @@ properties:
>        - nxp,pcf85063a
>        - nxp,pcf85063tp
>        - nxp,pca85073a
> +      - nxp,pca85074a
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.56.0
>=20

--b5BH6bQ6n70AdO3Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4QsQAKCRB4tDGHoIJi
0kE/AP9Hok3l+/Fm+6c3TsLN3Bqm333JnpXzT/zBxTkHaCLFIQD/UfLlwVoamv7s
e/a0/oGGd4uir1dBVssCwTMYPLcL8wM=
=Qy//
-----END PGP SIGNATURE-----

--b5BH6bQ6n70AdO3Q--
