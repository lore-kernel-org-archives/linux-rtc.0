Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CE466B09
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347026; cv=none; b=RcUlo8eyCBZ+PvLL9lQwhnHf2x7zkCEu6XYdmW4yYVKjGhx1oS09LPTpxXP3nyTUXK+3sIK1j8lHVU7mfrQsG3aF98IR5EdzqTL6KY3On68Cetlg5Hf6/Mn4oHUrrZhmvUtQPAWTTHiSNXv8jaZu9KaKl5/tcUAp/TX/ZgEER+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347026; c=relaxed/simple;
	bh=fGZT7zNeGmflVJxOVQMCTUZjEBSrvoWj/XRw3c0yCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMRdpk6aNwLMZrjGANV5sd6oliHLwiEamm1wQmpoQ7GVNGUDgWB63loYWOreZuQFQHJX/hyz7DCnv+gOZ/s6j7CLP27STdgQ/LgH/g7czb8Kup2rBn09LI2AUNNfyWYwDoUcLE1JMpxwHyMGlxdIY2hNMY18xSHyAKE9+NSU0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kK7ukstL; arc=none smtp.client-ip=95.215.58.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kK7ukstL"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fGZT7zNeGmflVJxOVQMCTUZjEBSrvoWj/XRw3c0yCrw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347020; v=1; x=1788951820;
 b=kK7ukstLN0ADSdHwHB0YWJtzTymUX7YZaibG2PM56oCp2W3456Cz5NXQmOIZzYEHuXkea4Uf
 YRX8gIiiPU6OWBYjAQOJqvPFqdE2AKauXNoKFaTpSj/KWaEFJ2nyqwAHVuMezJjX6DOdpHw6E7N
 1cTSFZ/ZrQYW8rK47bUfzHng=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 848de4a5cb6d0df7;
	Wed, 02 Sep 2026 11:03:40 +0000
X-Mizu-Trace-ID: 848de4a5cb6d0df7
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:03:35 +0300
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
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 01/10] dt-bindings: mfd: common ROHM PMIC properties
Message-ID: <dd3dce1f7dcc53aa3b8c3537f02e28957f5f8a11.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LIWGryBFmZ4MVgCn"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--LIWGryBFmZ4MVgCn
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>

---
Revision history:
 v3:
  - No changes
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


--LIWGryBFmZ4MVgCn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAocACgkQeFA3/03a
ocXNKQf7BCBsapKSYb0p4RgN8PZ5U+BoP7d5dpvO7ov6WTU6pQS1IkqJ5nKKyOrL
XIwhMgl1DUjWpQZR9iukb/TOoBTD+gO0iMIcQixBUWbW7cstt/v5OnjkSmw32exR
G0YybNBbSIfpb/7FZyOUP9l8wkGw1cozyo6IE9OlMgwwVikmtCbYmQTc1jY38IUr
lk9hkBtz2Vyf5ML2pGzBjhGnYCzUTUj7j5ApVpyJeSn0VSseYdVJzRkoKZCM2QrC
YGHn2Mw+9zJjbVPkX41a5aRR/47C/i3SKXCAEXU//n3hj8SA4HbJ4LskSafxa3LW
xkj6MuuJobJyw5qsoftn5j/sTrbZcg==
=CMo7
-----END PGP SIGNATURE-----

--LIWGryBFmZ4MVgCn--
