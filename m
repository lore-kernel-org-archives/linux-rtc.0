Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7373E5A35
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538938; cv=none; b=gO6v5OcA4DkoHOk9OFYun83dDvTp0E5y7J8eX5/kcDEl8oo0FExjJ5QqbhaoXkuNwdZfol+/BTf0nueyJA+7J4FwfJi2oqVHr8qOqr/A6O6m4owF//4OeRoKLFuunEDP+qVWHu5mlnwYrJusXoFNIw8o9Yl6ZXrpYv6Y2dgKFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538938; c=relaxed/simple;
	bh=0w29d9bvlQRko0lAj81LjQT4MWt53D4XvfhY4T+CXuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNaE/jjVWojA0DWyU34icEmz8/QqrFVKqd7h3BmsUl1GlLggOjseCrA6/pUl5wIluAbvmNFE2EknukRWFefQBqqs8Dofhni3VufRofw/W+/WyvwihMUD9p0EgRYTpsldBPZcG9xf8N/RMH5zx5C1iQhvfmy0nvNy1/Z28qbqxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJo441yx; arc=none smtp.client-ip=91.218.175.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJo441yx"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0w29d9bvlQRko0lAj81LjQT4MWt53D4XvfhY4T+CXuY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538934; v=1; x=1790143734;
 b=aJo441yx3AIDNO7OH9EVpNgWekq8htDvbag8GDjTnIP4XiJe2emqpDgainsT2pW6jsSDJvRs
 nyAn6TlF8sDUubYcxhoEmX8w88WsTVCpTsLLxpQSIGZ3FjbBOS0OPf075R0EQZImqgz1T17qFsG
 Wr7HoPvCHNj5qz/XKqcFtipY=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3955a8dcd78c89cf;
	Wed, 16 Sep 2026 06:08:54 +0000
X-Mizu-Trace-ID: 3955a8dcd78c89cf
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:08:47 +0300
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
Subject: [PATCH v4 04/10] dt-bindings: mfd: ROHM BD73800 PMIC
Message-ID: <2bf2278e66e106aa9550ffc43197441182388572.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+zUBCGGM6IU6fohx"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--+zUBCGGM6IU6fohx
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
Revision history:
v3 =3D> :
 - No changes
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


--+zUBCGGM6IU6fohx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMm8ACgkQeFA3/03a
ocVsCAf/Y+TNB19qvhIp6knmQdGi4LBHFhqZenhsj2GvWrcI6F0r4FxYSJMCGoml
wAUL/8Muv5GNiso5BB7amYRdbTEv6MDhfKEsEYoqoNPk1XFNnQqUC0wSbZbafAvb
8svtD8EJZnk4i6DVlSk4zGNprotSCfCFjPz4viJgx6/tTD5d0YZLowYlOGh/SLQ9
Zj3AqK7PRd+sRyJbjoDiuXAYnfYaf6cEaFFB9ef7vcANxfzz30pfMMoSXcP/fblR
c2UM/2yMaK73Z3GNhGszce5SQJKfuDTD43wh29z1VR5fEvNCqJ+jsLXgA21FP1gD
WNe7UARnMfzzH4iLvJi15q5jk9dtvw==
=mcLy
-----END PGP SIGNATURE-----

--+zUBCGGM6IU6fohx--
