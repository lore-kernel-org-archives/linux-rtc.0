Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8F43D508
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838867; cv=none; b=t21opDCLZlXKdLBKoTM3qNYdAv166I7NcSYZo7DNnIX/XgOLOtyifiCBeTegtuEPkrqfM99kWZOUXNGy2LqGDWcKH3sCGALTT4bW7V6nS/omWMGvkkQJQPH0RutMWD5MiJmsyBTgy34qNe2hEfqfd5x62U3NLgUpHseJfvgEjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838867; c=relaxed/simple;
	bh=CNtF6oPi+Pt6b14mHvrUhbJOh8p3oD03RVe4X1cmBG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSmlQQFfULIG2DIyA2gVRLVq3wHMk66SH+Z2f4+5oolaaEQiI8TFlk7y/58Dj7POAoheaZbJ1HVtQ5vMZh4eMo1zEXXreJI6TKD4xKxsSizDBD2eOxpOwECN4oiXXiCRhEwICvA5USulBZjTnS3evDxK3qacPBcma5f8KAwEVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tvJ7AmC8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tvJ7AmC8"
Date: Tue, 4 Aug 2026 13:20:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838862; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=zW2JPOJF7gtsxC7jH9TZy8uREGvlLaqQaqGXqyDo5MU=;
	b=tvJ7AmC8BPJUV100MY3E6nOP3O5BHjryacYTTssjjEZF4hFahh3+1GqU2fQuWgLoADYwu+
	loWgekPRAkYRQ68wJQw7QDZCnakuJV/rnLqcSP3QK47M9D0mIloAtupVPbgpYnzO7bClzZ
	Q0aP3vyhn2kqixkLcagS8DwRVqazR9w=
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
Subject: [PATCH v2 02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
Message-ID: <d419dcf8776f7ea88e4a66b9a0f0087f11e6622c.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqYa52Yomtnnw5JL"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--oqYa52Yomtnnw5JL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The commonly used ROHM PMIC bindings were added into
rohm,pmic-pins.yaml. Keeping commonly used properties in one file can
ease both the maintaining the bindings and the reviewing process.

Reference the common bindings from rohm,pmic-pins.yaml, instead of
declaring them from the scratch for every PMIC using them. Keep the PMIC
variant specific information (like supported pin functions) in PMIC the
specific files, so unsupported values won't be allowed.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2:
  - New patch
---
 .../bindings/mfd/rohm,bd71815-pmic.yaml       |  9 +++---
 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  9 +++---
 .../bindings/mfd/rohm,bd72720-pmic.yaml       | 29 +++----------------
 3 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index 4fc78efaa550..0a67de054674 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -15,6 +15,9 @@ description: |
   for LED and a 500 mA single-cell linear charger. Also included is a Coul=
omb
   counter, a real-time clock (RTC), and a 32.768 kHz clock gate and two GP=
Os.
=20
+allOf:
+  - $ref: rohm,pmic-pins.yaml#
+
 properties:
   compatible:
     const: rohm,bd71815
@@ -44,11 +47,7 @@ properties:
   clock-output-names:
     const: bd71815-32k-out
=20
-  rohm,clkout-open-drain:
-    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 1
+  rohm,clkout-open-drain: true
=20
   rohm,charger-sense-resistor-micro-ohms:
     minimum: 10000
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 09e7d68e92bf..e5043dec990d 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -15,6 +15,9 @@ description: |
   single-cell linear charger. Also included is a Coulomb counter, a real-t=
ime
   clock (RTC), and a 32.768 kHz clock gate.
=20
+allOf:
+  - $ref: rohm,pmic-pins.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -49,11 +52,7 @@ properties:
   clock-output-names:
     const: bd71828-32k-out
=20
-  rohm,clkout-open-drain:
-    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 1
+  rohm,clkout-open-drain: true
=20
   rohm,charger-sense-resistor-micro-ohms:
     minimum: 10000
diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
index b094542339e8..52d0f6e4ef0f 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
@@ -15,6 +15,9 @@ description:
   and a 3000 mA switching charger. ICs also include a Coulomb counter,
   a real-time clock (RTC), GPIOs and a 32.768 kHz clock gate.
=20
+allOf:
+  - $ref: rohm,pmic-pins.yaml#
+
 # In addition to the properties found from the charger node, PMICs
 # use properties from a static battery node. Please see the:
 # Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -80,10 +83,7 @@ properties:
   clock-output-names:
     const: bd71828-32k-out
=20
-  rohm,clkout-open-drain:
-    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
-    $ref: /schemas/types.yaml#/definitions/uint32
-    maximum: 1
+  rohm,clkout-open-drain: true
=20
   rohm,charger-sense-resistor-micro-ohms:
     minimum: 10000
@@ -103,14 +103,6 @@ properties:
     $ref: /schemas/leds/rohm,bd71828-leds.yaml
=20
   rohm,pin-fault_b:
-    $ref: /schemas/types.yaml#/definitions/string
-    description:
-      PMIC has an OTP option to use fault_b-pin for different
-      purposes. Set this property accordingly. OTP options are
-      OTP0 - bi-directional FAULT_B or READY indicator depending on a
-      'sub option'
-      OTP1 - GPO
-      OTP2 - Power sequencer output.
     enum:
       - faultb
       - readyind
@@ -119,14 +111,6 @@ properties:
=20
 patternProperties:
   "^rohm,pin-dvs[0-1]$":
-    $ref: /schemas/types.yaml#/definitions/string
-    description:
-      PMIC has 4 different OTP options to determine the use of dvs<X>-pins.
-      OTP0 - regulator RUN state control.
-      OTP1 - GPI.
-      OTP2 - GPO.
-      OTP3 - Power sequencer output.
-      This property specifies the use of the pin.
     enum:
       - dvs-input
       - gpi
@@ -134,11 +118,6 @@ patternProperties:
       - pwrseq
=20
   "^rohm,pin-exten[0-1]$":
-    $ref: /schemas/types.yaml#/definitions/string
-    description: PMIC has an OTP option to use exten0-pin for different
-      purposes. Set this property accordingly.
-      OTP0 - GPO
-      OTP1 - Power sequencer output.
     enum:
       - gpo
       - pwrseq
--=20
2.55.0


--oqYa52Yomtnnw5JL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvQIACgkQeFA3/03a
ocWBigf9F3DRUvFc9xawujie4HuzGb5jAh5/9iH/YVCQ7xXq4mz8AfLf1+eggjey
qAO1+FXlkX7pSdSopqV0V+LxTTAOTG+N5zSSXcm6PwpAgOCnkosWCP43VIWhym2Z
PbkkBRYi6icaabad5po9X7/cLwLz+gXhgHeMt7sFIwi2r0+Kjlhe7UlTm6NMNxVY
zKE1lP0LmQ5569AhRDZSS+vBgtNK9kG3yafDexhRCOzG4VR8o7Yi7JrmrRcLcj0/
Htef2ooI6PBUlGRbcm8hjDPnJcTs/mZULEyHoo42dcHtEwwR86PEXENGO4UflJ05
JXUNh1vXSfDbHpCrvzzbnvhWr1SSrA==
=QB21
-----END PGP SIGNATURE-----

--oqYa52Yomtnnw5JL--
