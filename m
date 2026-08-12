Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C23ABD8E;
	Wed, 12 Aug 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520962; cv=none; b=Qjk82ERZAOm+Y53b4ouMHg/AYGsIMkV3e3AacwHfTU9Yh4dvfT/5HrgyBRZNVzZn/92SidVM0d6v46Lmeff0p82xrQgvcxJYs7WIb9IfpnRwqEzsr/dz7SZxYHzLi3aOTYnyH5PNHUHPv++1eUnW8KifV1A7+ovIF3obqc8MPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520962; c=relaxed/simple;
	bh=v6d4q0nmN6hoGcH7keRxg7j++Fwht+/FpX+aOsHUTrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmpyymP3xO4P0JryLFXZHskFc4FKeKZqP0j9rZ/Dg1z2tZdkJHkuPEZLQvlYbmHXLH9dInp8hx7Hr0nuVMUXS+Ux7eWblfq5XWk10voggTw6WYelsM9eexSXzgVX8gXVONf/Y+jubDgOZ28tB1CUy4cn78Tl4vB8rX69tqEYTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwApARYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwApARYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E541F00A3A;
	Wed, 12 Aug 2026 07:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520961;
	bh=QRBpCckM+A8zHabhh60etxSeNZOhrfsWusw8PbtDK9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jwApARYJJcVt3IZP1LZmJuqj09PVvykAcqneFcVgpSv/Ry4eXel3fgj2g9TRP4E5O
	 5sj6oEht27Wq1kKrVkTt6uuvXRQFg2MpZcpDYj0/icblRtX5yTCBM2uSSS3G7AE6mV
	 78TD7a3cRkmbWwFXCa8YzLwe8ILoerZSS7JTvXKBOe56aybv02yqmz8obHP4WETptK
	 VNBFLCaCB2KkhfdBpkp+TaRjbK9X8zSok/Unhe7dPUDgITK2EprJ8v7OX2WoCdPe0e
	 YyFFV/g1ormili1p8rKCkWScfqSC2TTHGnBmVUsFSOBPRHSRNIj3y/2Q+uqWdNjTCB
	 qKVjC7dPIhV0w==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND v7 1/2] dt-bindings: rtc: Add pcf85053 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260812073552.3542956-1-lakshay.piplani@nxp.com>
References: <20260812073552.3542956-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:49:20 +0000
Message-Id: <20260812074920.A9E541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The schema incorrectly uses `additionalProperties: false` instea=
d of `unevaluatedProperties: false` while inheriting from `rtc.yaml#`, whic=
h improperly rejects standard RTC properties.
- [Low] The description for `nxp,interface` contains a typo ('ready only') =
that alters the meaning of the sentence.
--

--- Patch [1]: [RESEND v7 1/2] dt-bindings: rtc: Add pcf85053 support ---
commit c4402003b175003ee64d2fbdc100051ae1f80c64
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

dt-bindings: rtc: Add pcf85053 support

This commit adds device tree bindings for the NXP PCF85053 RTC chip,
introducing a new schema file and defining properties like nxp,interface
and nxp,write-access.

> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml b/Do=
cumentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85053.yaml
[ ... ]
> +  nxp,interface:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ primary, secondary ]
> +    description: |
[ ... ]
> +      The actual role depends on whether 'nxp,write-access' is also spec=
ified.
> +      Supported configurations are:-
> +        1. Primary with 'nxp,write-access' -> primary claims write owner=
ship.
> +        2. Primary without 'nxp,write-access' -> primary is ready only; =
secondary may write.

[Severity: Low]
This isn't a bug, but is "ready only" a typo for "read only" in this
description?

> +        3. Secondary (must not specify 'nxp,write-access') -> Secondary =
writes only
> +           when no primary claims ownership.
[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - nxp,interface
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: rtc.yaml#

[Severity: Medium]
Does using additionalProperties: false here incorrectly reject standard RTC
properties from rtc.yaml?

Since this schema includes an allOf reference to rtc.yaml, shouldn't this be
unevaluatedProperties: false so that properties like wakeup-source are
properly permitted during schema validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812073552.3542=
956-1-lakshay.piplani@nxp.com?part=3D1
