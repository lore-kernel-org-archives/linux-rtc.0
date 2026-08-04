Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02844D6A1
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838897; cv=none; b=AVaBvSYX7JnGssdhLbu5X17DtNUudIDiZi7SlMqoe3lE5LS7iO1ct5hhSSiLrpDWiI0eCETTRd7tkHuPOFSU5wOysd96K/Ghs4iQpwLAjILdJePH/d9NbP0mD2izBuCbY+cYP0eb5ML0f+AXX9oIK3tbjEEdrXZzw2vRrob5m54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838897; c=relaxed/simple;
	bh=TYn9534koPntwEU0A1jh1Ijz45EBoPYn9r3izdk8K1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6jzNcm+cbQ3jHhTqFqSelRFJohdv9P7J157ZsQtZKLfdW5/HOXuy+hxUVRzZqNOc4yWZ6tvqzfAIJR/wlV/UwTjhH3uCpdm0eFvnm8nhZxgmgtuvBG6uuqMsRqENNUkkZJLRyNuWadiHdTBhEJmoU4aGmKtWes2qCQpdo9cs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gnyOERKW; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gnyOERKW"
Date: Tue, 4 Aug 2026 13:21:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838883; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=fn8/UUd9pmG3qgXNkAMA4D6XiFg9oK0f3kkMh2zRsdQ=;
	b=gnyOERKWKddY0Fjtliup0m1MFXmlWyQl0pdgcmD3KV7/5cIjNivMfwAgV2MqKp9S2hjt9I
	r5lw/XNeNy2Zj3jWgz/5A6KRhJ0pePs9mDisovsQqWzgP8r9B6ivHA2uwVDPPdLt3yTtFP
	XXoDvbufHyJpF+pNTzAlthmK9+S44NY=
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
Subject: [PATCH v2 03/10] dt-bindings: regulator: ROHM BD73800 regulators
Message-ID: <e1ada83ee4bdc1d1718fa81c335c741771ab57c3.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W8nRD4g4ROPUDc/o"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--W8nRD4g4ROPUDc/o
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
Revision history:
v1 =3D> v2:
 - Description of the state specific voltages moved to own file and
   referenced from it (because multiple PMIC bindings used them).

The dt checker's documentation reference checker warns about the link to
the MFD binding - which will be introduced in next commit. These commits
have kind of a chicken and egg issue as MFD is referencing regulator
properties introduced in this patch.

I could squash these but IMO, this is clearer for the reviewers. AFAICS,
Both MFD and regulator subsystems tend to be busy. I could also split
adding the MFD comment reference to own patch which would be after the
patch adding the MFD binding, but having own patch for just adding the
comment is a bit meh.

So, I decided to live with the broken doc-link between these two
patches.
---
 .../regulator/rohm,bd73800-regulator.yaml     | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7380=
0-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd73800-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regula=
tor.yaml
new file mode 100644
index 000000000000..2db4585272c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.ya=
ml
@@ -0,0 +1,99 @@
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
+    allOf:
+      - $ref: regulator.yaml#
+      - $ref: rohm,pmic-states.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-8]$"
+        description:
+          should be "buck1", ..., "buck8"
+
+      rohm,dvs-run-voltage:
+        minimum: 0
+        maximum: 3500000
+
+      rohm,dvs-idle-voltage:
+        minimum: 0
+        maximum: 3500000
+
+      rohm,dvs-suspend-voltage:
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
+    allOf:
+      - $ref: regulator.yaml#
+      - $ref: rohm,pmic-states.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^ldo[1-4]$"
+        description:
+          should be "ldo1", ..., "ldo4"
+
+      rohm,dvs-run-voltage:
+        minimum: 0
+        maximum: 1
+
+      rohm,dvs-idle-voltage:
+        minimum: 0
+        maximum: 1
+
+      rohm,dvs-suspend-voltage:
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
2.55.0


--W8nRD4g4ROPUDc/o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvRoACgkQeFA3/03a
ocVAXQgAhBrGuWatoVJAfu08Jl32JO4/n3fmoqqjcLrbe+XR/m6m8UswmDKz1xy1
EAcmBtEmTF+WezJqUovT15mbh+mZ+ZP+YT7EOL1fwXkwCvKuyVnXLdKx+o494kow
frEiapSBO9hVFBohqyJyMeWdcojwpQZOEpuDemlOfl8234jQ0WJ+6MdU8hPR3Nus
7h38D/Ts8pD+4s7982zAD5oPI34wxk2+FKyYUkiZ7E/Fm2nxm+4Sm3NhJJZq0qlX
c9+/9wjHyzKVct+Ei2hNqF3IZd2RC5JgJJIYDu8TQJKnRW6U96m5ryFrvyvEGRif
cjs4zL6cSgSLAi+INoJDSX2iybV/cw==
=HZMF
-----END PGP SIGNATURE-----

--W8nRD4g4ROPUDc/o--
