Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD8322C67;
	Wed, 20 May 2026 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779248519; cv=none; b=PNEX3uu1CEcfW4IwKLs/ZTUkijDa6jHwHMSR9e87hufDknePI5sjoNv30WZ4duyiLgwqOmI8tJuX2n1/mQpjzBWkQAGkVmPC2AmeBjetvNT2Drp8Q+xuXtbfoJE6m6D8M0h0CRUy7wIzp/vUueHnNPNjzbP3PBh6q+e4Xf82oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779248519; c=relaxed/simple;
	bh=MawxzEup9mr14UlUJeL9v8vxCHtgWlKalti1u3tWBco=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KWUyjGMCf2w5J9mmuuzcLPeuy2LFDwMEWPqjQ26uC/22KdyeOXpIYqg6BC9OR5Lan7oCBn2hTJlvYgbMr4X+uId2myAIzU+CV0kyEpTL7NYTuXZGd59m2+Wijm5MJMAJX/aTL9mjv3NULIPOIBPw8bUb5+h0hb8EmRZo7Eg7RUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpIQDbk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpIQDbk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A7F1F000E9;
	Wed, 20 May 2026 03:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779248506;
	bh=Si5C19RSZ+df06wj9kNmGn5WXTgMTXs10pq+j+vslIA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=BpIQDbk4hO1jmVPCiK2hA5hrMSglZ0wIzi2RcRHnsQzNuxmFsa9C8iUa+KA5dhZz+
	 BALEoTirljFGDurwFpkqLXiT2zkmQkDftStmiWs509DYbic1EphhDv15GjpQdW3gsq
	 PSVTQtWqaotSt2ByY8x6Bw/fcsK0pHR5SjDCAoAZCI3p76OdqOl/id/V83wS+L+HIL
	 WWF5NPPn2thDMEP+tOWtxkWIeNs+7zSpB6Ox+e2utvxq/mEogHILqZrFIc+m7MfJWa
	 0bnxtLY5/PIrio/JkjVSqsoawifJTR4sHxhYEsxW3RcBSck/FiU4Abayn2cBH1dtZD
	 LQztdiHbTTRRA==
Date: Tue, 19 May 2026 22:41:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 me@brighamcampbell.com, krzk+dt@kernel.org, skhan@linuxfoundation.org, 
 mturquette@baylibre.com, conor+dt@kernel.org
To: Udaya Kiran Challa <challauday369@gmail.com>
In-Reply-To: <20260520025131.17772-1-challauday369@gmail.com>
References: <20260520025131.17772-1-challauday369@gmail.com>
Message-Id: <177924850520.3887592.1592701829985723559.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: via,vt8500: Convert to DT Schema


On Wed, 20 May 2026 08:18:53 +0530, Udaya Kiran Challa wrote:
> Convert the VIA/Wondermedia VT8500 and Wondermedia WM8xxx series SoCs clock
> controller binding from the legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---
>  .../bindings/clock/via,vt8500-clock.yaml      | 122 ++++++++++++++++++
>  .../devicetree/bindings/clock/vt8500.txt      |  74 -----------
>  2 files changed, 122 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/via,vt8500-clock.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/vt8500.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/via,vt8500-clock.example.dtb: /: clock@200:reg:0: [512] is too short
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/via,vt8500-clock.example.dtb: /: #size-cells: 0 is not one of [1, 2]
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/via,vt8500-clock.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/via,vt8500-clock.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260520025131.17772-1-challauday369@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

