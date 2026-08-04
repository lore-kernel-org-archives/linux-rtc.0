Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88A3290B7;
	Tue,  4 Aug 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846696; cv=none; b=E8xlIHnmF7AYApC16DYVZX9Cp4+dKEY9WA/oASZPzIDlxuxJClJA19MKHOkYiHDPrhHCokq0BZbc9qmK1lJaUMb1itmKoOMYx1wjfYqvZTYowzAkLOUnRlZMH0mKn2MtwZkIIfobFDLhmHtRTB+ERjZ8TF1ha60X+eLpJYLFAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846696; c=relaxed/simple;
	bh=oP8YS5Y4Prbf7fMbNjvr+fz0EC6STQbBZaUUgpU2AYQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TnHzWkg1JtqnbDZrISXbiVn+e58Tt2+sG/TSfg86NnwZE+1LZsmz/86/4hBuZmwCgpBbe+MPBqk+7YTO1VReEG0mKdADxMu4gTUqcaYd2gvHFV5n0RVKNc8hWw9QhqzB4DAI1tqYGJ677AyAu9gEalu/d81Ub5JpcOhtIGIwv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh5Hh+HB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh5Hh+HB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9B31F00A3A;
	Tue,  4 Aug 2026 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846694;
	bh=EdsnwoIbN4QAiRauL90Wp1ACQDxjp0zDCuF3xMG1hxg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=Dh5Hh+HBL8S3SHifzCAAStTiOe9FBAolFNC3rTzESlBcjetsyJqH2j+Arox48d3H8
	 SL9qXu0Q27K1jMiIFGZBC3FgR9lWxD3v+DKjgJcqCX4nReD5nUpVrx5j+imYmqOqZU
	 L1Y7BjpCAvp4GFgeHZWJ/yLWRoQeRinQ6aGS1844tihB/MEZO9DyvRps+W+wNuyscs
	 kXJHw+fnqHqo7ksEqT/6tNen4+EcjKyRLFOLuzwQ+d78z7YMRotqr3RhcC0rw5/1sC
	 f/7PN4drDo/249tWcnrPTqmGgW6kqSgiebLt7QOq4RJOvWR4m440gs0Sz7c2ML82lK
	 PNDr/NyGki4Lg==
Date: Tue, 04 Aug 2026 07:31:32 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@kernel.org>, mfd@lists.linux.dev, 
 linux-rtc@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <74468853a2c82091dfcdb2193c4eaa67f6191e05.1785838585.git.mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <74468853a2c82091dfcdb2193c4eaa67f6191e05.1785838585.git.mazziesaccount@gmail.com>
Message-Id: <178584669046.3596669.1414001628924966753.robh@kernel.org>
Subject: Re: [PATCH v2 04/10] dt-bindings: mfd: ROHM BD73800 PMIC


On Tue, 04 Aug 2026 13:21:32 +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD73800 is a power management IC which integrates 8 BUCKs and 4
> LDOs. There is also an ADC and operation amplifier intended for current
> / temperature measurement and accumulation. RTC and 32.768 kHz clock
> gate are also included. The PMIC can be customized via OTP and it has
> options for operating as a main PMIC in multi-PMIC installation. Some
> of the pins can also be used for GPO or GPI (including interrupt support).
> 
> There are also ROHM BD71851 and BD71885 PMICs out there. These are, from
> the SW-perspective, similar to the BD73800. There is only some different
> default values and OTP settings. The driver should be able to handle them
> just fine.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v1 => v2:
>  - Reference commonly used ROHM bindings from a common binding file
>  - Simplify compatible list
>  - Move relevant comments to description so they can be shown in
>    generated human-readable doc.
>  - Allow other clock-output-names besides "bd73800-32k-out"
> ---
>  .../bindings/mfd/rohm,bd73800-pmic.yaml       | 218 ++++++++++++++++++
>  1 file changed, 218 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck1: False schema does not allow {'regulator-name': ['buck1'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[2000000]], 'regulator-always-on': True, 'regulator-ramp-delay': 1250, 'rohm,dvs-run-voltage': 1150000, 'rohm,dvs-suspend-voltage': 950000}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck2: False schema does not allow {'regulator-name': ['buck2'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[2000000]], 'regulator-always-on': True, 'regulator-ramp-delay': 1250, 'rohm,dvs-run-voltage': 1150000, 'rohm,dvs-suspend-voltage': 950000}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck3: False schema does not allow {'regulator-name': ['buck3'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[2700000]], 'rohm,dvs-run-voltage': 1150000, 'rohm,dvs-idle-voltage': 1100000, 'rohm,dvs-suspend-voltage': 950000, 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck4: False schema does not allow {'regulator-name': ['buck4'], 'regulator-min-microvolt': [[1100000]], 'regulator-max-microvolt': [[1850000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck5: False schema does not allow {'regulator-name': ['buck5'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck6: False schema does not allow {'regulator-name': ['buck6'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck7: False schema does not allow {'regulator-name': ['buck7'], 'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:buck8: False schema does not allow {'regulator-name': ['buck8'], 'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[1300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:ldo1: False schema does not allow {'regulator-name': ['ldo1'], 'rohm,ldo-range-high': True, 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:ldo2: False schema does not allow {'regulator-name': ['ldo2'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:ldo3: False schema does not allow {'regulator-name': ['ldo3'], 'regulator-min-microvolt': [[800000]], 'regulator-max-microvolt': [[3300000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.example.dtb: pmic@4b (rohm,bd73800): regulators:ldo4: False schema does not allow {'regulator-name': ['ldo4'], 'regulator-min-microvolt': [[650000]], 'regulator-max-microvolt': [[1750000]], 'regulator-always-on': True}
	from schema $id: http://devicetree.org/schemas/mfd/rohm,bd73800-pmic.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/74468853a2c82091dfcdb2193c4eaa67f6191e05.1785838585.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

