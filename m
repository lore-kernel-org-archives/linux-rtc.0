Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C74324B22;
	Tue,  4 Aug 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846694; cv=none; b=qNYwMd0dmwu9FgwFNrRdRIduRi7qbN1lfvMAGCcGUm3A66gYlR+Yw+hxYewjkdHlexvGLqTE+GwKPW6CKuTaqZ3y+IMx2lEdO5vahbKmzC/vZJ69Ccn8xgqC6D77k/6/scIc9248m0XFdMRB5ePEtCD59z/0xVaxkXAhXpVixAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846694; c=relaxed/simple;
	bh=zhmILJFeH687gl0qZB4h8j2X8MK23jdm7gaOmy62XgE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f4lei3gv2NGRQk1gKpJorZ0D2UN2UNOSjl8kiKlSpFpwlcFoJu1XiTeO7MIroZkE3wErB1jGqjxAcPHFj95Gy5K5owV4v92ClCA2k/67oBvU5hZ3jikIqveOQv6RaWLtOR8zKsiPjX94hoiWFsjcfu9ih0pXNgiXUd9jGqCL9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=los5lZCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="los5lZCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD61F000E9;
	Tue,  4 Aug 2026 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846692;
	bh=1th4MRdrWEXVS1CdRQMmq+8pIN5tPBGnhYNWdXQzIRc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=los5lZCpFK8+ONp4q4qoBA6AWquO+EJzvUjmANhCFBRV/ofJFEQcsU4r/atx0P7nX
	 r+lJHN/yUWzfxJBByVyufaP26PggrxmcEv9WqYN0/CTDE9rnbaV5jzzOZlRHIrZ/nq
	 Gr6kd/sDk6Jtr+C3L+IBsJuyHUMUmZJHVALmNf6fiqerMQKMzN+QXu+OK+9RH6fPEK
	 zb9lXAKKQXdySg8CADxAzjpUldssdy5q7YcI+24fu0YN/sQWJeEk13AcHQAnNYG5Gt
	 GqO2+jE/3b7nFjsrWlexKrjTrStW3a4Z0LNMI20IWJEtieDlvbJs4D/n03/CuOkJX5
	 pMi5dDFFC4SZQ==
Date: Tue, 04 Aug 2026 07:31:30 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <e1ada83ee4bdc1d1718fa81c335c741771ab57c3.1785838585.git.mazziesaccount@gmail.com>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <e1ada83ee4bdc1d1718fa81c335c741771ab57c3.1785838585.git.mazziesaccount@gmail.com>
Message-Id: <178584668929.3596441.16841432061647404160.robh@kernel.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: regulator: ROHM BD73800
 regulators


On Tue, 04 Aug 2026 13:21:14 +0300, Matti Vaittinen wrote:
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
> 
> ---
> Revision history:
> v1 => v2:
>  - Description of the state specific voltages moved to own file and
>    referenced from it (because multiple PMIC bindings used them).
> 
> The dt checker's documentation reference checker warns about the link to
> the MFD binding - which will be introduced in next commit. These commits
> have kind of a chicken and egg issue as MFD is referencing regulator
> properties introduced in this patch.
> 
> I could squash these but IMO, this is clearer for the reviewers. AFAICS,
> Both MFD and regulator subsystems tend to be busy. I could also split
> adding the MFD comment reference to own patch which would be after the
> patch adding the MFD binding, but having own patch for just adding the
> comment is a bit meh.
> 
> So, I decided to live with the broken doc-link between these two
> patches.
> ---
>  .../regulator/rohm,bd73800-regulator.yaml     | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml: Unresolvable reference: rohm,pmic-states.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml
Documentation/devicetree/bindings/regulator/rohm,bd73800-regulator.yaml: Documentation/devicetree/bindings/mfd/rohm,bd73800-pmic.yaml

See https://patchwork.kernel.org/project/devicetree/patch/e1ada83ee4bdc1d1718fa81c335c741771ab57c3.1785838585.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

