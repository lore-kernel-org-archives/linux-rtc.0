Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884973E5A26
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538907; cv=none; b=ZAduRyxJJ0HagO0LFoC2Ib5Y65n5Rh6o/+s94WAzRkAJ4Wc2ddxdmDEtCmDl0pTGGrA+pu99vAESxwL8lrKcZRjdSWStfpPC2J8XCae19KRMbyLIYnwkZiGIkPi1JImyBpzxFi34VvkigC7N/jue+3gDBqr2IkdovwufdAq06hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538907; c=relaxed/simple;
	bh=7VjykBkVhrKbVISaKhKJkklICiGQ3evRpVCEkcfhlbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLUKv1xD8/S5NwmD7+qgskROZDmkbGq4oPsp//dGCkmJh32rbeGK2CFkPNvlxTRxOzymNqkvMKd+8tXq4cr3RnnwWJ3Uu4hMZMUlPLLVUMRr43Z1jBaRyzmndux96XVIniKw+sGbCfIjfVKZAW+G95dq+RzkjVxL3CzYudV0c8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nziQmkQm; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nziQmkQm"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7VjykBkVhrKbVISaKhKJkklICiGQ3evRpVCEkcfhlbs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538903; v=1; x=1790143703;
 b=nziQmkQmSwIyjmdEVHGO6WWO0J1CmCeRZBFFTVWRFcRJGamfStgZ+5sayX9VoIen2nuaBYAS
 AcMo+Ji8h/ssHyjo2sQivH/jkJ2Zx4YNwyjQlALlDNjEaUr07tIwJLm9w/YapTccBN6OBihE5bD
 xUORMtlleimFvTkYT9ULgg4k=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 799ead47db7bb98f;
	Wed, 16 Sep 2026 06:08:23 +0000
X-Mizu-Trace-ID: 799ead47db7bb98f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:08:13 +0300
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
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH v4 03/10] dt-bindings: regulator: ROHM BD73800 regulators
Message-ID: <0f001ca0d7463cd66777d8ad723212fadb199ce1.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8ClUxv5zQvSyuf5"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--d8ClUxv5zQvSyuf5
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
Revision history:
v3 =3D> :
 - No changes
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


--d8ClUxv5zQvSyuf5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMk0ACgkQeFA3/03a
ocXxTgf/ShxaiSNJVBUbTG0KQq2b9kKIaqnXHZe0pHm2IRhT7Nvb5PX9TpuvLWVE
BIDd49vtD4DAp4VVRM5LbQ//eEwm0rnmw0+0RJ9HWYnxPfc2nGI/raZPSLwuXYYC
U0EvNxSX7rrZsdDRksYuE+0RzuhytuGbPYxDhhmZcej3rnT6hWjSjg8kSR8xAFyb
wCdAMbhAuStANcOpDiCSIl5eDbQJITYcs7lqM46qiL0x0Xe6lSh82NDAJMpuOtV6
a0vasePo7dyT/F4JHCuALhH+FU1RQPZMQ/hC7IGuwJWqCbZNkxoTBRwrZCcqdTZV
4KziWzwrk35YgB+KncgYkFMUK2bTsA==
=vNpu
-----END PGP SIGNATURE-----

--d8ClUxv5zQvSyuf5--
