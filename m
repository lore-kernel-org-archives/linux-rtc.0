Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DC44C4E9
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838844; cv=none; b=FHM9cH0M7HZ/bE3QhH9HuiylacLU4BQ8bfmvPj8dhgn/ptwd+ovUsyxesbZ31M3cFD6YjdtSxxJlgi47QzgGH7sxam/A3gPWCLPV59ItXMIVfYXJeCMAIpVcJXyrl1lGjIa8xL8JcRWGp1eM4QRFHWMf3wVQsqIoMLPuVIDEY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838844; c=relaxed/simple;
	bh=8U51xgiJ8uLUBMTcobAcJjKtBtoL/dq8oqjF6t/JarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0w1NXdazUSVbguKHdCroaocUSjGGIkoA9XGYrUy3eSTLcl7wUhfSjcY6fxggJDX9J9Y1stR54Q8eyHB9dgmqVj82qFJPmMuJyguMYure3gJKLv36ke3HbtwHqB53g73ANyJGIEPn/bB59jbutFBe6TWAyo+ZlZQnIqQP70wslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/xyZYas; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/xyZYas"
Date: Tue, 4 Aug 2026 13:20:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838839; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=C5h10Om4GrPRnYSNyOViF/nqPXgZgAQQnPrF7JfdjAk=;
	b=I/xyZYasKDjz33Qto8XtzBL37h55ZBnO+5Ud/OXntts8OI6zQn8N2AzvLZueIE9C0yM10b
	aZ6Wu7oJfYfZ2sescVQLY7X73FPOMj+wDIi4ijMWq0yo5BwewA/1WWdtfYnvJoGfrC3PDS
	Zg9Jf2mYI2qnT6bGjiZp/ZRPVANvxAM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	mfd@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: mfd: common ROHM PMIC properties
Message-ID: <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bO7XywEwPhKvaTcN"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--bO7XywEwPhKvaTcN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

ROHM PMICs keep having similar functionalities from one generation to the
next. Keeping the device-trees describing these functionalities similar
helps users because:
  1. They can re-use existing device-tree properties when switching from
     one project, using a ROHM PMIC, to next project using newer
     variant.
  2. The users can find and re-use examples from old projects - even if
     they never worked with ROHM PMICs before.
Similarly, introducing new and different properties for same
functionality previous variant had, will be adding confusion.

Sometimes the existing properties aren't 100% what reviewers would
prefer. When issues are minor or just cosmetic, changing the existing
properties is not feasible. Reviewers can't be expected to know which
properties are new, and which are existing - and this can lead to
unnecessary review discussion wasting time and energy from everyone.

Adding a common file for re-used ROHM PMIC properties should make it
clearly visible that a property is re-used, when a new PMIC binding
refers to this file instead of (re-)describing all the existing
bindings. This will also help keeping the common properties identical
across the variants.

Add new file listing commonly used ROHM PMIC properties.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2:
  - New patch
---
 .../bindings/mfd/rohm,pmic-pins.yaml          | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,pmic-pins.ya=
ml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,pmic-pins.yaml b/Do=
cumentation/devicetree/bindings/mfd/rohm,pmic-pins.yaml
new file mode 100644
index 000000000000..0d1082804f5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,pmic-pins.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,pmic-pins.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM PMICs' OTP configured pin descriptions
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  Collection of properties which are commonly used to describe various
+  ROHM PMIC's pins.
+
+properties:
+  rohm,clkout-open-drain:
+    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos"
+      a.k.a "push-pull".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1
+
+  rohm,pin-clkout:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The IC has different OTP options to use clkout-pin for different
+      purposes. Set this property to indicate the OTP variant.
+
+      Many of the ROHM ICs have pins, which function can be defined in
+      OTP. Some of them provide no means to detect the pin configuration
+      at run-time, leaving software unaware of which features the IC
+      really has. These properties can be used to inform which pins
+      provide which functionality. IOW, these properties aren't used to
+      configure pin, they are used to tell what functionality pins on
+      this specific IC have.
+
+    # Supported functionalities depend on the exact IC model. Following
+    # values are already defined: gpi, gpo.
+    # Please, re-use them when adding new ICs.
+
+  rohm,pin-fault_b:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The IC has different OTP options to use fault_b-pin for different
+      purposes. Set this property to indicate the OTP variant.
+
+    # Supported functionalities depend on the exact IC model. Following
+    # values are already defined: gpi, gpo, faultb, readyind, pwrseq.
+    # Please, re-use them when adding new ICs.
+
+patternProperties:
+  "^rohm,pin-dvs[0-1]$":
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The IC has different OTP options to use dvs<X>-pins for different
+      purposes. Set this property to indicate the OTP variant.
+    # Supported functionalities depend on the exact IC model. Following
+    # values are already defined: dvs-input, gpi, gpo, pwrseq.
+    # Please, re-use them when adding new ICs.
+
+  "^rohm,pin-exten([0-1])?$":
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The IC has an OTP option to use exten -pin(s) for different purposes.
+      Set this property to indicate the OTP variant.
+    # Supported functionalities depend on the exact IC model. Following
+    # values are already defined: gpi, gpo, pwrseq.
+    # Please, re-use them when adding new ICs.
+
+# The schema is expected to be reference by IC schemas, which may introduce
+# other properties that must be allowed.
+additionalProperties: true
--=20
2.55.0


--bO7XywEwPhKvaTcN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvOQACgkQeFA3/03a
ocXh+gf/TikZS5vONWYI4gF9eVnIqmQ8PR5sqjNvGaurLgaGgbncjg65witD7KyX
Wv7a7urQ7qQqD62ud/Kn8+7qrF0k3MJd8ekw6LaZhlft2Va9/i9+dMvHhNzvZWXQ
PLQzr2fHqYLvt5G2YANUM2NVgrB+T/bLGlMKKlaKdmcVo1MyKKpBtmOvWnY//GKR
5PzONlLPIGMBdSlVQvAiAsuWx4I87Q0qODX2sEfwkj/s+pmi6iKSWYQYs4zhONQL
aTxMwaFsc9DfQLtlpgBSW1tKxK56xrnFROyVv1QuGRz/hFGfzIPwRjubWGLMUmZX
kXPz9wlZhdL3nXRmV6IArcyd8h+yQg==
=qPF1
-----END PGP SIGNATURE-----

--bO7XywEwPhKvaTcN--
