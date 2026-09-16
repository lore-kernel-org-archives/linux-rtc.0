Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621353B42C5
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538778; cv=none; b=HDRHUc01sayRgo6iZiP/i8//ylEQlUGlXJCPryx/TA568pATo9chfJ7ftqcVjLZxK8lyclpnln57MnLxrSvZ0m45R3iO9pWkVsEGlLNag5ZO8/sGHssL+Rv91skzRHHZZfflH/0x35uFbqtAsPWy0gHeYWySO3w3wKn/G1c+lYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538778; c=relaxed/simple;
	bh=Ukr6y4XLfKUlxOmqpgrmjGL0z7vvmtgskLrrpGGW1XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNj33SWYjUcfB6/Z9TiC5lk8HnBObZvRMPrpX4jLxfq/jIHE6QF1Go1NEwFgz0f51mkaXNi2PYWNbN56i0hEjovXNCTwjJtVDYqsdQUb67oIUj3nuAnuEtZxF+7Zg4+lrZropcrUxUdAQ6dJQiD00B7p5nzIlUCnWnQCyOtGURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEzYs5Ae; arc=none smtp.client-ip=91.218.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEzYs5Ae"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ukr6y4XLfKUlxOmqpgrmjGL0z7vvmtgskLrrpGGW1XM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789538774; v=1; x=1790143574;
 b=VEzYs5AehOWRykZRE/24hpEG3Wyt7wDtoG5DJ4LwVoauOVhYy7J8CTpaccD6dCVIY7KM4O9T
 KD/0cfKIJGtDQKru+VVzlMA6y5f+MW+lbqGdCT24mFRAQDDSAlwPOM0AY+AEzvh3W+R2sZYhTE6
 gLYbE1mcuZh1Te7zaafZowVk=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f56b5d1fb3a96d43;
	Wed, 16 Sep 2026 06:06:14 +0000
X-Mizu-Trace-ID: f56b5d1fb3a96d43
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:06:05 +0300
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
Subject: [PATCH v4 01/10] dt-bindings: mfd: common ROHM PMIC properties
Message-ID: <114ad461ace2f76e6a04a482d3c31ee0b372e672.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Y22RcnxLJMQzg0o"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--9Y22RcnxLJMQzg0o
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
 v3 =3D> :
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


--9Y22RcnxLJMQzg0o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMc0ACgkQeFA3/03a
ocXgGwgAlBpf2U0tTAkwpJNB2SxZksXew8Nx09U+kcDTD3jKIUlm2tq6makBLhjf
Q2jBXbM0DiJZQUNkOsKIDk2aKU88YSIy1TSs6Y9BFnoW8IKSD5MEWeumMvnq0C8y
Goxsvr67h1q77eQZOxaoMpxN8CeGgvmjc6V8+arSqp5DyhaTSfymcs8x3VAelBK/
xfYvf+bGEGpifUPfnCnRvVFuJM6+fTLWTcrF+p5qB+EKoVIgGBhjVXzfruvup5+R
1xVURmqrwrRSTFViCDMG2mCPFubNpcoiBsMhDuZ1nr6anAEIBR45T0Xfyx5Eihzk
mMoriQj/L1zLUkAaypfpM0a8jfmmJw==
=SM9Z
-----END PGP SIGNATURE-----

--9Y22RcnxLJMQzg0o--
