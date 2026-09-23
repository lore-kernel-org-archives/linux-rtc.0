Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952F52CCFE;
	Wed, 23 Sep 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169688; cv=none; b=ttEvnUx1Tr8lesw4AYEVc2b+41QDmg1G0FDbYRURk8Er7n2EufHVLw21YuEugOm6cgoSGYsgQNA9atzeXoc0cMfS8vvUjzLtBjCTzbHQU/U8xx5vNe+3O/DV9nVWXB8sOnnaGyQxF3aOsouUu+UEmRYVdTRAqaQO/B/fd8/UcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169688; c=relaxed/simple;
	bh=/f2sN/Ewbptw8u7Gap6qLwKMTCM4UgEoJ4ssyHGhdyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iwdq7byfGnH4RSjdjF9O+2C/CEt3CC/eRMZsA3SomlYbMX5kE/Ux2mHLvBJdBw4P5cG7UJt02Gj/nwFU5UshDyhDeFzXPQniBayUXbmVPv4ff7Ys6MhU1ih63GJ4xd7KCW2lNM6Xg+X7UN/wFTOIRKnarJyB9n4Hysi1bmR+xbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P56okp7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P56okp7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5564B1F000FF;
	Wed, 23 Sep 2026 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169673;
	bh=nlBLPLeHbL8Adyh8Bnon4/pJNRPeAYg2b/zgCLnuzsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P56okp7L+h5x6dnZzE3I1A0r9Jv83HIC9ENRDFeS9SoxNnl24srR0rFFPNctkGE6W
	 byWq5alnXF9mc3QCA4u6DQVXnbjq04da/1grEHb3cWSOWmv+6mufVvcovCB/66NjaZ
	 rc/CAZkZL/2sSvLR7GeVNRy94ab5/Le48uA94ReJzt/nvr42SKjy3OYzmST6Nylv/P
	 fnacYNg7Y+gjcJzS2Ieb0z5qfrm0fNlJj90GWAHTLAYfQtCCBy8mVyxMbAT6+vXOlL
	 nFaK0LdfnZzRHptrDIMspD6+fWaM6g5I1I2zhr826WzbDaQIK8TWHqvD4aLcCO0O/c
	 KbP+XIB30CMOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260923131323.1099979-2-sander.speetjens@gmail.com>
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
 <20260923131323.1099979-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:21:12 +0000
Message-Id: <20260923132113.5564B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: minimum and maximum constraints are ignored due to arr=
ay isolation
--

commit ff7cdbdeb8fcd609ef36f409f92bd2d94dc107d7
Author: Sander Speetjens <sander.speetjens@gmail.com>

dt-bindings: rtc: Add property for Raspberry Pi 5 RTC

The Raspberry Pi 5 has a built-in RTC that can be battery-backed
via the VBAT pin. Expose the trickle-voltage-millivolt DT property so the
driver can program the correct charge voltage for board specific
configurations with the attached battery.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm283=
5-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm=
2835-firmware.yaml
> index 983ea80eaec97..9349fc8908a50 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> @@ -133,6 +133,13 @@ properties:
>      required:
>        - compatible
> =20
> +  trickle-voltage-millivolt:
> +    allOf:
> +      - $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 1300
> +        maximum: 5000

[Severity: Low]
Are the minimum and maximum constraints ignored here due to being placed in=
 a
separate dictionary under allOf?

In dt-schema, properties using scalar types like uint32 are parsed as array=
s.
The JSON Schema minimum and maximum keywords only apply to numeric instance=
s,
so when applied to an array, they are silently ignored. The dt-schema
preprocessor fixes this by pushing constraints into the items schema, but o=
nly
if they reside in the exact same dictionary as the reference to
/schemas/types.yaml#/definitions/uint32.

Because minimum and maximum are placed in a separate dictionary within the
allOf list, the preprocessor misses them, leaving them ineffective. Out-of-=
bounds
trickle-voltage-millivolt values could silently pass dt_binding_check valid=
ation.

> +
>  required:
>    - compatible
>    - mboxes

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131323.1099=
979-1-sander.speetjens@gmail.com?part=3D1
