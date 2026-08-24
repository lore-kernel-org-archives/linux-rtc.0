Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E4405C3F;
	Mon, 24 Aug 2026 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569704; cv=none; b=q6BzJHuMqrw25bLCQp3NZbmyYvafqpgTrXwRSps/MOYAUT7nGxOf28724r+gUd8Ntanvi5O+y6nPUAtlHvzCz7FK8GtDA3sCNQqpdc6tMUF2nAF5YNnhV6AFiHO7x19gvJPfQ4BlMAsI4zdnp1iifE5rxgKFrv4S0ybiLo1dSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569704; c=relaxed/simple;
	bh=4QejIWfy1nMIRZAn5ivLWvwhOenqOKQ0ToXn9jsU+iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/3wqrNTgrtJpK+eySCOI4J/VqwpChKzkST7vuIXZQQEbzheDwPmymDuoC3W7tYuOJ8KZSeelE+/bXfpngc7xVJS9sFRbzg0ji06pWzbvU2HLXKphck42RnpYqwV4PmPJAK1h7W7uZSviCjxTGd0NIgeWboMwRMZHzswih8Nghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU6byNRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU6byNRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37951F00A3A;
	Mon, 24 Aug 2026 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569703;
	bh=HMlFC/meyMn3Zv3vepvB4iC/jJfRaaxi8jttld/sG3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CU6byNRrFsapoVgHdON2deIq5OsIMZpT81l6Isbr9ADWNoh2UzDKP+k51B+Z3ZAhi
	 HfoeDZknMmQvqz2Rtf1Pnd711C2QIw7pZo/ZKcy+gY7Yqc+Bps0LV4RBqCZ0E+NJ84
	 i0ogo+qSiKaCNFjAJ3elJr7SojhSX7XMGLlzED5QPZSez16noQAsTaCBuwrEZ1GLPg
	 RBHx8Xq88sRS7paguqZrg4lSil2CdupfDXuXSmq1brsveQAI8hIC/+M7oP69/iW8LO
	 nd/mdpwZMNFN+Zfflq+aGEj8i8H21OKanEh0iIxCooDIMpHE2Rep0Mg/dVE13kt39I
	 Q2RNTGZKIhAEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: rtc: add ricoh,r2223x binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Schocher" <hs@nabladev.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260824110452.4038870-2-hs@nabladev.com>
References: <20260824110452.4038870-1-hs@nabladev.com>
 <20260824110452.4038870-2-hs@nabladev.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:08:22 +0000
Message-Id: <20260824110822.F37951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `#clock-cells` property is missing from the `required` list =
for a device that acts as a clock provider.
--

--- Patch [1]: [PATCH v1 1/3] dt-bindings: rtc: add ricoh,r2223x binding ---
commit 650ba92edebadde8c761f1e4168721297f6edde4
Author: Heiko Schocher <hs@nabladev.com>

dt-bindings: rtc: add ricoh,r2223x binding

This commit introduces a new device tree binding for the Ricoh R2223x
Real-Time Clock. It adds schema definitions for its compatible string,
clock provider capabilities, and an eco mode property.

> diff --git a/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml b/Do=
cumentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
> new file mode 100644
> index 0000000000000..e64a1ee378e64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
[ ... ]
> +  start-year: true
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Since this device acts as a clock provider and defines #clock-cells above,
should #clock-cells be explicitly included in this required list?

Without it, device tree nodes that omit the property could silently pass
schema validation, potentially leading to runtime failures in dependent
drivers attempting to use the clock functionality.

> +
> +additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824110452.4038=
870-1-hs@nabladev.com?part=3D1
