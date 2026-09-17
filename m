Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E257D203;
	Thu, 17 Sep 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654032; cv=none; b=Ps+AJrZnHUP/QsDAOa9mpgoP2768EQPcVgIkcyTRxzttHVkfmk7W8fL0KoLw9lYBRfO7Wf0fMstWpSJQhSUnEmS6/eTL+7TiO9JEemGF4tbsXKVCuaDcflQAkmLKu5wLSThGUqdvfWLRuMYMi33TYCYkDYB+Kna0wS8zmkHWiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654032; c=relaxed/simple;
	bh=kBNaSBWTm2C4+vYfrxvDaW8XIh14WOvjhRkh0VLR4Is=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AJBoW2eGco/lUSDLEHM0WdqeMhRwjaPch0JQmBU/uSHLP+fdObrVEl0eY8IoBaRf/PoT75EmfMk9ZfzRJB3Kukwqb6+tcVV86vJRJsXNIDDvN12OcmRF3RNLZGEJaZpkL7WOMxIKY1MthXOHAdfHD3td0y5h75icxc5JWqGs6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHobeukQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHobeukQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4231F00893;
	Thu, 17 Sep 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654028;
	bh=6q4GTMcgAl3ZByqjLTNoRIV7KG/GBkyqJNgpM66Siag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHobeukQH6+jTCHR+K5dHBSBbdJMUxLkV7YMmUJv0GRvD5BITNjA+gVRvlNrSC6qM
	 AuW4mg+iZIA6E8mweWL8n0oaxoHCKiFn/uCK4ysoiHH2vH2LRWwHhV2yPP+Xz1/c/L
	 qxAuRfWhB/sC911AgGgq08blpDN9h8BftnEg1ZVKd3T5a/+ULM47L3hypyJX5A91DO
	 xHXTcY6MfCdC596iafJ9/vKuoDUn1QfhWAqoC/gPertUN4ybqF3nd9Xj01Z3/xxkxj
	 PKv1aq8po+GDcHDjww6XayWglaKlVdsuDgx1fugelRk8otefAS3OUZ4oe800BExVvK
	 1Ymybqvja+i0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260917135841.841680-2-sander.speetjens@gmail.com>
References: <20260917135841.841680-1-sander.speetjens@gmail.com>
 <20260917135841.841680-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:07:07 +0000
Message-Id: <20260917140707.BD4231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: constraint bypass due to missing scalar type on -mi=
llivolt property
--

commit a0ac03cb8b207820432d22540ca183fbaafbeb38
Author: Sander Speetjens <sander.speetjens@gmail.com>

dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
   =20
This commit adds the trickle-voltage-millivolt property to the
raspberrypi,bcm2835-firmware binding for the Raspberry Pi 5 RTC. It also
introduces minimum and maximum voltage constraints for this property.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm283=
5-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm=
2835-firmware.yaml
> index 983ea80eaec97..dc71fd57834e8 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmw=
are.yaml
> @@ -133,6 +133,11 @@ properties:
>      required:
>        - compatible
> =20
> +  trickle-voltage-millivolt:
> +    $ref: /schemas/rtc/rtc.yaml#/properties/trickle-voltage-millivolt
> +    minimum: 1300
> +    maximum: 5000

[Severity: Medium]
Are these constraints applied effectively here?

Since dtschema's property-units.yaml assigns a default array type to
properties ending in -millivolt, applying minimum and maximum constraints
here without explicitly redefining the property as a scalar type (e.g.,
via $ref: /schemas/types.yaml#/definitions/uint32) can cause JSON Schema
to silently bypass these constraints.

Could device trees with out-of-bounds voltages pass validation when
dt_binding_check evaluates the constraints against the default array type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917135841.8416=
80-1-sander.speetjens@gmail.com?part=3D1
