Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA247F2E7;
	Wed,  1 Jul 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909702; cv=none; b=L81fJ4DEsfE7BtMRyhRydED1bKDzXltjlt5IXhGveyE7mA/8o9g3LTHVxcOxnpWjcH8799Km4CluWUFmIvxyJnaFRh7MA6AnzURebyw1KNvWihJoRLYbqLTl9WLw9iTnDRIMvTT0HkoxEG+vpVC4FxGnfxTa37cLAhf2i9SGz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909702; c=relaxed/simple;
	bh=InBLkfXjp3T1Zwtd+0sckVRf5My5XuAqvJacDWEOf7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe/An042dPwZq9e6hnilZuNsftHNOIqgn0EdvGnN43r8VEW/8tvk1moUyy4EtCAcQBSKNtwN5T6GET4tSaoCqod9m+kVHNtZzJxdF+ScZJeQj2r8kR4MDyO3Ho3tieVBa6J/+K1tya+0w6Q7kB9gDULUbOUyatFFAGLctqGRh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3D4uGO3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3D4uGO3"
Date: Wed, 1 Jul 2026 15:41:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782909685; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=W32RUxeDi1R2eooDgqltvM+rPOaIvVbXo7pvR37qo98=;
	b=G3D4uGO36bv0J+XWYw+QIjayasY9dt9ovvA7Twtf+vaWUn1vUmaQQBV5kP4zo+WUroTjZM
	/0Jw5fA/PFE0Wr5/XshYdCgZRcx6OoTrHE20dWGgcsayZa6/g3+r5CcJkabnqf9XQGZkPB
	EolngxIPXwyrdqD+0cFbO5gSiLQVPhs=
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: regulator: ROHM BD73800 regulators
Message-ID: <67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vix9+puGfqriyr7Z"
Content-Disposition: inline
In-Reply-To: <cover.1782909323.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--Vix9+puGfqriyr7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Add bindings for the BUCKs and LDOs on ROHM BD73800. The PMIC state
specific voltages can be set in same fashion as with a few other ROHM
PMICs (for example with BD718[15,28,37,47,50,79]). Same properties are
recycled :)

The LDOs 1 and 4 can use different voltage ranges depending on the OTP
configuration.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../regulator/rohm,bd73800-regulator.yaml     | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7380=
0-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd73800-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regula=
tor.yaml
new file mode 100644
index 000000000000..c427a04098ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.ya=
ml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd73800-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD73800 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  This module is part of the ROHM BD73800 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  Regulator nodes should be named to buck<number> and ldo<number>.
+  The valid names for BD73800 regulator nodes are
+  buck1, buck2, buck3, buck4, buck5, buck6, buck7, buck8
+  ldo1, ldo2, ldo3, ldo4
+
+patternProperties:
+  "^buck[1-8]$":
+    type: object
+    description:
+      Properties for a single BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-8]$"
+        description:
+          should be "buck1", ..., "buck8"
+
+      rohm,dvs-run-voltage:
+        description:
+          PMIC default "RUN" state voltage in uV. 0 means disabled. See the
+          explanation below for regulator specific details.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3500000
+
+      rohm,dvs-idle-voltage:
+        description:
+          PMIC default "IDLE" state voltage in uV. 0 means disabled. See t=
he
+          explanation below for regulator specific details.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3500000
+
+      rohm,dvs-suspend-voltage:
+        description:
+          PMIC default "SUSPEND" state voltage in uV. 0 means disabled. Se=
e the
+          explanation below for regulator specific details.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3500000
+
+        # BUCKs 1,2,3,4 and 8 support voltages 0.5 - 1.3V
+        # BUCK 5 supports voltages 0.3 - 1.3V
+        # BUCKs 6 and 7 support voltages 1.5 - 3.5V
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+  "^ldo[1-4]$":
+    type: object
+    description:
+      Properties for single LDO regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^ldo[1-4]$"
+        description:
+          should be "ldo1", ..., "ldo4"
+
+      rohm,dvs-run-voltage:
+        description:
+          Set the default output state at PMIC's "RUN" state.
+          0 is disabled, 1 is enabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 1
+
+      rohm,dvs-idle-voltage:
+        description:
+          Set the default output state at PMIC's "IDLE" state.
+          0 is disabled, 1 is enabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 1
+
+      rohm,dvs-suspend-voltage:
+        description:
+          Set the default output state at PMIC's "SUSPEND" state.
+          0 is disabled, 1 is enabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 1
+
+      rohm,ldo-range-high:
+        type: boolean
+        description:
+          LDO1 and LDO3 voltage ranges can be "high" or "low" depending on
+          OTP. Indicate that the "high" range is used. See comment below
+          for voltages.
+
+        # LDOs 2 and 4 support voltages 0.75 - 3.3V
+        # LDOs 1 and 3 may support different ranges depending on OTP.
+        # either 0.6 - 1.8V or 0.75 - 3.3V.
+
+    unevaluatedProperties: false
+
+additionalProperties: false
--=20
2.54.0


--Vix9+puGfqriyr7Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpFCucACgkQeFA3/03a
ocWfSgf+JDZdKCG82CyT9JwSIX0usDVLf+GGrv/78ITz/Lf63AJlM/e+urj/zoAf
V9mEf1bAZhJWmjIvlw/cjvHx/C9VbLEL5iMMnPQvDahLoWUekMH+VjxE3PFWdwSc
xiOiBMHIlf2qUFnIoC6tZu8SmIQk9TexKLW+DE8uasXeoC1frryu3cAPzfKyGFuD
50gZMbNV8bCBK+f0uOngP1nn2kCmh1TGlcjhWoFczRgljZnDOQdmpYxxhM8bbulF
ia4BUq7wjZD750OETJDJnTkEbTIead0MqaSfhzZa67kBbR6vJWoWcxKjTy/6EtsS
G4l9zhWHnuwzj4kYIQcLttGz09CHBw==
=vu4f
-----END PGP SIGNATURE-----

--Vix9+puGfqriyr7Z--
