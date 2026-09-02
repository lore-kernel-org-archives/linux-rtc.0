Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAD46D566
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347051; cv=none; b=XfPGotVcftX7HSQnryALsNEiv+0OCJo1utznesk+Tu3LlBynlwVZZJD1VS/ZSjLqGmJrsLRdOh7/DVziSbpVtcIUf8YqKiR7bo+WIm1qilOjQSTEfuwlb3fnG3x6Sjch6nwlO9zN1Y3vI64q70NkBivVHJGco+Cb1SexDQIqqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347051; c=relaxed/simple;
	bh=boIFzYTONzPjf+AA8M8c6ELFTdsgpE88c0fvNdrnXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4TSVwvtFRmsBP+H9OP5pVeKShI03wfk7EmEDWLbsSr7bDoc+RThWZKvY44Wbnkeojj7pLdX5J4xQfnntRP9lyYgCLfSYU002eBSpL9OFGXa3thgDEk+J9LxCPNRNgYQ46s/K2a/e8Xpcow8e0cMxMY6RKLy0fTcOIDFlv+BZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HMZvCZ5e; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HMZvCZ5e"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=boIFzYTONzPjf+AA8M8c6ELFTdsgpE88c0fvNdrnXTM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347045; v=1; x=1788951845;
 b=HMZvCZ5eEeU1lUVybsBVcRqPH1B7HD2NidZv1OwcsnAlvhP3THSDZMv/JiCIeCAmJl4Yicl4
 GNkY4HaQ27zrh/jo8ASGLeiPdThVFafsYmO9iL8zecKx5/TDec+VeYSrap9g72dOrMNBLC82QtZ
 9ygp/Q2WYJaHf/Hg0x7l50Qk=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1656e6b9af72c2cb;
	Wed, 02 Sep 2026 11:04:05 +0000
X-Mizu-Trace-ID: 1656e6b9af72c2cb
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:04:00 +0300
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
Subject: [PATCH v3 02/10] dt-bindings: rohm,bd*: Ref common ROHM bindings
Message-ID: <14c3341d84941e13a4b41420e115e016f377d662.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NafCu4dhMD20aIpu"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--NafCu4dhMD20aIpu
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>

---
Revision history:
 v3:
  - No changes
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


--NafCu4dhMD20aIpu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAqAACgkQeFA3/03a
ocXAbQf/Qhh2rVBCFE5RSUkIKcIrGJuDA7vzUcILuYXekdV4WthPMndaoCU7iMji
yUd8cxeWsL9j2v6LspHDsIdKjcAR+y6tnW/1uOSSjsTIL1w6e8LprJAmXfwkKcgq
npON08qeC56A0+HGpfP37G9fmhj45cC9Z7EZ9t+2p/jcQOntm2NhLIm81OAPJeQy
k/rOtBCkBaWDIABHf4tIyj6kq7Q+SXzED0HpWaONdwGLf6l45LJrUpLS3YobNK7O
iapYdgvyPWi4oQMlgoOWOcu5Lc6Z9P2X6vJkJtV498jeXtPVcWCm9HtPCrMR170/
cKZX6c6aVPwJaLYt5j5HgVQKxl66gg==
=T/Zy
-----END PGP SIGNATURE-----

--NafCu4dhMD20aIpu--
