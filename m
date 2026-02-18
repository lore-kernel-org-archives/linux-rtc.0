Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A6B31281D;
	Wed, 18 Feb 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446468; cv=none; b=a2XgBGsDCpK55qgg90whjMDIg3Etz2DX5ttAHvfsIWsb+TT/3dqGuEnTFLwXvHgRChzARftblWOfe3kv6l4IN0tobUa8KvyElRExTphs04HPLl5mmI6gFCnlCBaV7W8rFH/ej52K3AIws829UTqFlT/QbdtjY+AP8vAHw5dNkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446468; c=relaxed/simple;
	bh=ivckTole9MqJkMzdFXt3adOIGkxBis8t9YeSmwiC42Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rXlBxiSapasbeqYkAB+1l3dQGwK5f6bwyIyZ2GoI9mb7S2vvdGkLCfNP2pxynIkyMBiI4+XumdZwAvjZP9FfKbhJJmW2ckdUROFUlbzYm/Hix7bShi9EeGCLnKD/4ZYChVT0eIMEyQg4vGYA83oXwBtHVTRSoq6TWiCCQL34veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpGWIAgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpGWIAgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5788BC116D0;
	Wed, 18 Feb 2026 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771446468;
	bh=ivckTole9MqJkMzdFXt3adOIGkxBis8t9YeSmwiC42Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZpGWIAgDQ3TDHw0B2sX2qi/GmwPvdjEte+GK+lnZdx009a/inp+5Nr8CE8tVDK6Xk
	 LTRpkgcbbTE2Zf9qNpWwm8pwYrTQsjK2CcGB0gkM6VP2XUEA8Cmd6ouRISCggoNRbD
	 zOfS+Q0JXGbp7+qz4MFa3KmQfE41aOBoYWXqgBhZeZZIDMvAIRmzCPlmW/g2E/cV9i
	 rc6waH5cfy/bzl10EwcfgsmN/L8dPojmvZsMRhCEOLPVG1THvFGrbMEvCftf5qsEho
	 sIMH62XaciWvOOqpXlHO6MeIWYihDC4+QnGvqW+lbBaiuAx6zrP95htDLSSUrmsVU1
	 PgKnMQ61PjiBQ==
Date: Wed, 18 Feb 2026 14:27:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
To: Piyush Patle <piyushpatle228@gmail.com>
In-Reply-To: <20260218190213.429892-1-piyushpatle228@gmail.com>
References: <20260218190213.429892-1-piyushpatle228@gmail.com>
Message-Id: <177144646751.737382.9814420668984730763.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: rtc: isl12026: convert to YAML schema


On Thu, 19 Feb 2026 00:32:13 +0530, Piyush Patle wrote:
> Convert the ISL12026 RTC binding to DT schema format.
> 
> The binding was previously documented in text format.
> This converts it to YAML and enables dtbs_check validation.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
>  .../bindings/rtc/isil,isl12026.yaml           | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/rtc/isil,isl12026.yaml:4:6: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/rtc/isil,isl12026.yaml:5:10: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/isil,isl12026.yaml: maintainers:0: 'Piyush Patle piyushpatle228@gmail.com' does not match '^(.+ <[\\S]+@[\\S]+>|[\\S]+@[\\S]+)$'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260218190213.429892-1-piyushpatle228@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

