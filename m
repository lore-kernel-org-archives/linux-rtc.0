Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C64363097;
	Mon, 31 Aug 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205957; cv=none; b=ZVf5Bqj0cC4zADvODAeKXh3YMV9VYzfkrIgM3rR/Yx7JFSoJudoytrQ1aUPu5am/jRxLHwsSTvKcF4FFdjUczZ5e8lliwTT6ZD4840pAJ+jh5vhunEpR4q+LUG3bqTTMGZJ6oumNP8kIoyc9kR5Hz1G3Y21NVQYJJ9coLPu2RWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205957; c=relaxed/simple;
	bh=HdgAUi44hm/dAz3t4RUJqQExo58IkaxT1NgHpln4/o8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pe9EbPmzXdw9UaSEKI65+iznAphuaG6U4vtCkTMDxIxAtsyiGqq+ifgsEBfvN/jLsMJhOiFtp5OXH8Jy7glWODt02LU+9sXMz/mOoJ6V9ba0YzMVmpHsfQB6q3mAJfo4NrF4TDxLQ1WF6UklXOAnUWPPomjOuNgilWbcnmNdjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faulY5hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faulY5hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4931F000E9;
	Mon, 31 Aug 2026 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205955;
	bh=XYY5Se71lSs969cwbITA7wNwXcMc3+hYPLN+5dg8Nuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faulY5hrLcWjPvsLQAGzPwBeu6w+/KXqOpW5uUTbAIZWsM6V+OQzHfz4PLTppf0gZ
	 ZlYtLdImJp0b0/zJmIyT8HUmbP9Rmj0hKUIrz7H6C6U76ZopvPMv5BBPY1XsWVYJd8
	 vAMASOyTR98voY1R9Vl9PXuQjWQUT1XWWByOJbBLFfHMFGEuXMVmYqYLEDYg5AwUWN
	 l/aoGblHtQmdFcvQauxjOqTBSGYkNkibyh9t7sH1UEVwOL63vcMfMOay3yrZVYiB+P
	 7LRShwj7B/aDGUP4WjzgZPoJ9tjrIhH88QLvKK5nfhzmoqoFUSfqNbA/HTcPa8XoKZ
	 B4lZLxVwVX8Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-1-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:52:35 +0000
Message-Id: <20260831195235.6C4931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] DT binding schema strictly requires 2 items for `interrupt-names=
` even when only 1 interrupt is defined.
- [Medium] Incorrect use of `additionalProperties: false` alongside `$ref` =
breaks dt-schema validation and inheritance.
--

commit b7c0d2bd5acb5ccb26e8865062b4b49889e6cf5d
Author: Markus Probst <markus.probst@posteo.de>

dt-bindings: rtc: Add pinctrl for S35390A

This commit moves the devicetree bindings for the sii,s35390a RTC into
its own dedicated schema file. It also adds the necessary properties to
configure individual pins via pinctrl, allowing the interrupt signal to
be used for wakeup alarms.

> diff --git a/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml b/Doc=
umentation/devicetree/bindings/rtc/sii,s35390a.yaml
> new file mode 100644
> index 0000000000000..dfe632c4b2c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
[ ... ]
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: Supports up to 2 interrupt lines via the INT1 and INT2 =
pins.
> +
> +  interrupt-names:
> +    items:
> +      - const: int1
> +      - const: int2

[Severity: Medium]
Since the interrupts property allows minItems: 1, does interrupt-names
also need minItems: 1?  Without it, the implicit minimum is exactly 2 items,
which will cause schema validation to fail for valid device trees that only
configure a single interrupt (e.g., INT1) and specify
interrupt-names =3D "int1";.

[ ... ]
> +patternProperties:
> +  "^pins":
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      "-pins$":
> +        type: object
> +        additionalProperties: false
> +
> +        allOf:
> +          - $ref: /schemas/pinctrl/pinmux-node.yaml#

[Severity: Medium]
Should unevaluatedProperties: false be used here instead of
additionalProperties: false?  Using additionalProperties: false alongside a
$ref to another schema strictly rejects any properties not explicitly
listed in this block, which breaks the evaluation of inherited properties
from pinmux-node.yaml as well as generic dt-schema internal properties
like phandle or $nodename.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D1
