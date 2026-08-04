Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3744C4F2
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838912; cv=none; b=MbSdqNYfgDc2Ol3TzA3yfhH2PYiUxzzE5FvlApt40gEZYskvLQY3+f000nGix17WStOw0g8eA0g9EYIAsE6BKRwudYdYid2LvPAugqAwZwoCimWWR5uKHl3DHOZVvtwtfalJOK2O+JQxgQRR19Q44L9MY984AZzOSADKJWvzgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838912; c=relaxed/simple;
	bh=Hh9EISXz7Odc06rTiiwt/D67T8uZpTcz/LrG82IPY2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5sSauwaTz3jZBYif+kGcld225YYjSywgvnShyT7OZD8q5DEt8IRCxTR/RXQ9DeOlUL/GCCIhe9aqybaEjvgruVOxkg+e9BsHCBmTFETnH0Jn1X9XAzVTVI4wHg6VTKILU0eqiKK7lWfbE3e57ICrdQe8zALG096LngZduBWSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AbYJTSwZ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AbYJTSwZ"
Date: Tue, 4 Aug 2026 13:21:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785838907; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Fa+22bxcHYClJ8LlD0Ev0N0Q3fJ8PtRCZWBW336b00o=;
	b=AbYJTSwZBpDH+/u2Azbz6CETiX4YvzXAxiq9uly02CC2khAX+X19ZxKtSfTNCaapR+Ug++
	oE9+17cLEK3xsqm06wd4Q6V4VZLqZUwHMixVu2Pd84Eh6P3TjVcFNbPaR9NepIOveObBtM
	GuT/JL0YJwDN5aopBisgbKiAB94phUE=
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
Subject: [PATCH v2 04/10] dt-bindings: mfd: ROHM BD73800 PMIC
Message-ID: <74468853a2c82091dfcdb2193c4eaa67f6191e05.1785838585.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V3KWYXZ6ZW6L29no"
Content-Disposition: inline
In-Reply-To: <cover.1785838584.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--V3KWYXZ6ZW6L29no
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
LDOs. There is also an ADC and operation amplifier intended for current
/ temperature measurement and accumulation. RTC and 32.768 kHz clock
gate are also included. The PMIC can be customized via OTP and it has
options for operating as a main PMIC in multi-PMIC installation. Some
of the pins can also be used for GPO or GPI (including interrupt support).

There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
the SW-perspective, similar to the BD73800. There is only some different
default values and OTP settings. The driver should be able to handle them
just fine.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Reference commonly used ROHM bindings from a common binding file
 - Simplify compatible list
 - Move relevant comments to description so they can be shown in
   generated human-readable doc.
 - Allow other clock-output-names besides "bd73800-32k-out"
---
 .../bindings/mfd/rohm,bd73800-pmic.yaml       | 218 ++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
new file mode 100644
index 000000000000..8371e7f2ab84
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
@@ -0,0 +1,218 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD73800 Power Management Integrated Circuit
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  BD73800GW is a single-chip power management IC for battery-powered
+  portable devices. It integrates 8 buck converters, 4 LDOs and a current
+  sense amplifier with ADC. Also included is a Real Time Clock (RTC) and a
+  32.768 kHz clock gate. Depending on the OTP configuration the BD73800
+  may also have interrupt controller and GPIOs.
+
+  There are also different variants called BD71851 and BD71885 which are
+  almost identical from the software point of view.
+
+allOf:
+  - $ref: rohm,pmic-pins.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: rohm,bd73800
+
+      - items:
+          - enum:
+              - rohm,bd71851
+              - rohm,bd71885
+          - const: rohm,bd73800
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  # The GPIO1, CLKOUT (GPIO2), FAULT_B and EXTEN_OUT pins can be
+  # configured to interrupt pins by OTP.
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The IRQ number. 0 is GPIO1, 1 CLKOUT (GPIO2), 2 FAULT_B and 3 EXTEN_=
OUT.
+      NOTE, A pin can operate as IRQ source only when the OTP
+      configuration for it has been set to GPI.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  rohm,pin-gpio1:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Indicate if the GPIO1 pin has been set to GPI or GPO at manufacturin=
g.
+      The GPIO1, CLKOUT, FAULT_B and EXTEN_OUT pins may be configured for a
+      specific purpose (like ADC input, 32.768 clk output, fault indicator=
 or
+      delivering power sequence to a companion PMIC when multiple PMICs are
+      used) - but also to be either a GPO or GPI. (When used as a GPI the =
pin
+      can also be used as an IRQ source). The pin purpose is determined by
+      OTP (One Time Programmable memory), typically during device
+      manufacturing. The OTP can't be read at runtime so device-tree should
+      describe the GPIO pins.
+    enum: [gpi, gpo]
+
+  rohm,pin-clkout:
+    enum: [gpi, gpo]
+
+  rohm,pin-fault_b:
+    enum: [gpi, gpo]
+
+  rohm,pin-exten:
+    enum: [gpi, gpo]
+
+  clocks:
+    description:
+      The CLKOUT pin may have its purpose overridden by OTP configuration.=
 It
+      is possible the BD73800 does not output a clock signal. Hence the clk
+      properties are optional.
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  rohm,clkout-open-drain: true
+
+  regulators:
+    $ref: /schemas/regulator/rohm,bd73800-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pmic: pmic@4b {
+            compatible =3D "rohm,bd73800";
+            reg =3D <0x4b>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+
+            clocks =3D <&osc 0>;
+            #clock-cells =3D <0>;
+            clock-output-names =3D "bd73800-32k-out";
+
+            gpio-controller;
+            #gpio-cells =3D <2>;
+
+            rohm,pin-gpio1 =3D "gpo";
+            rohm,pin-exten =3D "gpi";
+
+            regulators {
+                buck1: buck1 {
+                    regulator-name =3D "buck1";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-always-on;
+                    regulator-ramp-delay =3D <1250>;
+                    rohm,dvs-run-voltage =3D <1150000>;
+                    rohm,dvs-suspend-voltage =3D <950000>;
+                };
+                buck2: buck2 {
+                    regulator-name =3D "buck2";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-always-on;
+                    regulator-ramp-delay =3D <1250>;
+                    rohm,dvs-run-voltage =3D <1150000>;
+                    rohm,dvs-suspend-voltage =3D <950000>;
+                };
+                buck3: buck3 {
+                    regulator-name =3D "buck3";
+                    regulator-min-microvolt =3D <1200000>;
+                    regulator-max-microvolt =3D <2700000>;
+                    rohm,dvs-run-voltage =3D <1150000>;
+                    rohm,dvs-idle-voltage =3D <1100000>;
+                    rohm,dvs-suspend-voltage =3D <950000>;
+                    regulator-always-on;
+                };
+                buck4: buck4 {
+                    regulator-name =3D "buck4";
+                    regulator-min-microvolt =3D <1100000>;
+                    regulator-max-microvolt =3D <1850000>;
+                    regulator-always-on;
+                };
+                buck5: buck5 {
+                    regulator-name =3D "buck5";
+                    regulator-min-microvolt =3D <1800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                buck6: buck6 {
+                    regulator-name =3D "buck6";
+                    regulator-min-microvolt =3D <1800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                buck7: buck7 {
+                    regulator-name =3D "buck7";
+                    regulator-min-microvolt =3D <1800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                buck8: buck8 {
+                    regulator-name =3D "buck8";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <1300000>;
+                    regulator-always-on;
+                };
+                ldo1: ldo1 {
+                    regulator-name =3D "ldo1";
+                    rohm,ldo-range-high;
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                ldo2: ldo2 {
+                    regulator-name =3D "ldo2";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                ldo3: ldo3 {
+                    regulator-name =3D "ldo3";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    regulator-always-on;
+                };
+                ldo4: ldo4 {
+                    regulator-name =3D "ldo4";
+                    regulator-min-microvolt =3D <650000>;
+                    regulator-max-microvolt =3D <1750000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
--=20
2.55.0


--V3KWYXZ6ZW6L29no
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpxvSwACgkQeFA3/03a
ocULcggAg7Mp/7yCkcZS7WQh754HVAQdVnqCtSZgkgOvsSQ25KIMm48xwifvz3Hz
vSpn9jrTEhfZ16CjO0UQyL5x2LTwVX6Cfie3BPsKtsnF3X1RP9fixJX3bwoAxBtL
PN9DSOwSPMWPgx+f8gljfnOPHG0rH7kxOo/aRHTJ3saV5V4ddH2t650QA9lO4a9W
ic86gBq6KlUrN2KfPithNQ0BDTlShlMvENx1ow5RyHbvvYRpEO3He8wCuOWrKMdk
jAO2poZ9gRWacJwBdjINlPpLAR99vdVVvPZ1NWnV7+msUprqzTjwtEbsukJIXVXu
k2iAtEA+382Khl9FTyJh+URUnk5VUA==
=/cj3
-----END PGP SIGNATURE-----

--V3KWYXZ6ZW6L29no--
