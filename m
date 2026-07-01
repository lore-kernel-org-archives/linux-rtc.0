Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFF43637A;
	Wed,  1 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920347; cv=none; b=TmWTmdYbqmyQv8IItejan21IsykUQhtXDxVLZFLJLaLTkGbYcMUt33MYO82fLKBKtF2AB3nFyqdudsPX7Mz+B7TxXNjgJNTBLdUBFLPsW8ov+knaTkt3tWXMlxNCWTH4oL+ivzaBGGyL9OrqaZ0vBx/JSlldFeGRmA2Thygjp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920347; c=relaxed/simple;
	bh=0foiH+ij4RI16jN7GIYYVMnnucuAlbGDmtr8OzsDHQM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RSzFN96svECCY3qW2bdFRfw/uQIjmktX6hpsj89p8W3hCtqk7yJ933UHRdSf5ppUk35R8M9+QqFmXJYRq6kVwHnTfBelJ6NDRBalF9fCAef+JMLw3Y6l67q+tSZft/LqZEsincZgkeX8Dh9W1GgmvOK65ihfXS9nbeF3WXx6u+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DujIxa56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DujIxa56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD351F000E9;
	Wed,  1 Jul 2026 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920346;
	bh=T4AkqOupu39zAwLHhbxL17u3PNcF/dLuQZhEPfCEpxU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=DujIxa56mkQBTupP60pFDJqQAyLW/1zOOWC1/apL3X8IDByXPxwDJodb9IEQGEME3
	 FoKyLAivNNaopZLzt0+KydLO16sHRsxIsmhZO+iFizerJOCIM6UwjUvzLUU8w4MUx+
	 L0r2mZ2PiSqrYQA2c/tVJmZT5VV0zpkq0bEgMEBJFuJfM5PMWn6IbH+0x4+bkY1dgK
	 yMhHkPUkC/GDWTBfvhRI0hzngWqPnQtZeobkHfZv7C78/4t72DNO5GjrrOekKKlrkm
	 Su8s8UqF74+bRMry01QATLOj+NLxrEOYFEVBCXtA16XJapbeZjdNffKYtykd3Prb6F
	 HaL61ZNzqZI4g==
Date: Wed, 01 Jul 2026 10:39:05 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 linux-rtc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-gpio@vger.kernel.org, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
 <67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com>
Message-Id: <178292034520.501377.15267936510733753810.robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: regulator: ROHM BD73800 regulators


On Wed, 01 Jul 2026 15:41:11 +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Add bindings for the BUCKs and LDOs on ROHM BD73800. The PMIC state
> specific voltages can be set in same fashion as with a few other ROHM
> PMICs (for example with BD718[15,28,37,47,50,79]). Same properties are
> recycled :)
> 
> The LDOs 1 and 4 can use different voltage ranges depending on the OTP
> configuration.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../regulator/rohm,bd73800-regulator.yaml     | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml: Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml

See https://patchwork.kernel.org/project/devicetree/patch/67b42b5363533f11c22a6421417c3345f9872aec.1782909323.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

