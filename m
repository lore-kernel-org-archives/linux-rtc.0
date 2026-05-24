Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF02D8DBB;
	Sun, 24 May 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627306; cv=none; b=M/Y1w/IXsGTnJJX3mVAItOEXsTl1yShr8UYrpcNSmRe5T2zJz51kw7B9onjAzsjjjODmGbw6gitd6YZ7jjPXe4WVD+HDBVDF9JcOidDqwEF1TtY+PjfPT6rTK239QRONMQJ7jV/G//CvumV3oFVUkq39GclXLPmXXfJN4+Ti+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627306; c=relaxed/simple;
	bh=2MmTYYmNMdoy9YDoTAuniLeIxG02J7j8NpdTUNIlBN0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NwOGEZlThJpFQRlLfrXPdvDR2CaVUAB2/zsmlQVen3GryLGgOfwiEXJQSvE98a6s88jxeE/jY4e3inXVQhKDpT9Rhnhn3xxc+kPSmG/A9EbDKa5SPcffjAD1or7msMDeR64eWzytAgsxp9k9zMWdpsn7r4TPhzK3O61Lx4XphXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5zD2G5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5zD2G5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062211F000E9;
	Sun, 24 May 2026 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779627305;
	bh=JiuDywnm3igzdQQaVPLFAQ64QuF8vXCtXGCdgupz9Ro=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=l5zD2G5MSuD2wRs+oGzjg/O5h57w0+02gobon5o9WMW0CREXLHDjB7sKo6E3RPlP7
	 MpNK6N8KUypIcWKhum5KjXT87zcFrwMvq5aAetYLYQn/gOoEfSHUOrJbygIG0UXv4N
	 m9A7/sOfmtNlZvuOvBh+Sl/5PsjOUATrj1Sq48FS54C2kNtblZB2t8xVIa0dh61adk
	 gKp9CXabFHioesBDOFDabidd/ic6HTQYuvgDlPi2dhgIYFDn2VGxBVdlTnv9aNTpGg
	 nzRL5ILSuc3XtsS8cbwuVZ3l3dtnWlwEE1E3nZozohh+2hn8zRnj9qh0pr5pXqmb6w
	 gLmZ8Qvmkip5A==
Date: Sun, 24 May 2026 07:55:04 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mturquette@baylibre.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
 devicetree@vger.kernel.org, sboyd@kernel.org, linux-rtc@vger.kernel.org, 
 me@brighamcampbell.com
To: Udaya Kiran Challa <challauday369@gmail.com>
In-Reply-To: <20260524111813.39810-1-challauday369@gmail.com>
References: <20260524111813.39810-1-challauday369@gmail.com>
Message-Id: <177962730423.2180503.17189385178806268512.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: clock: via,vt8500: Convert to DT
 Schema


On Sun, 24 May 2026 16:47:57 +0530, Udaya Kiran Challa wrote:
> Convert the VIA/Wondermedia VT8500 and Wondermedia WM8xxx series SoCs clock
> controller binding from the legacy text format to DT schema.
> 
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
> ---
> Changelog:
> Changes since v2:
> - Drop redundant description for clocks
> - Disable reg property for device clocks
> - Fix schema hierarchy to match actual DTS structure
> 
> Link to v2:https://lore.kernel.org/all/20260521170810.19702-1-challauday369@gmail.com/
> 
> Changes since v1:
> - Add default value for divisor-mask
> - Add required properties compatible and model
> - Fix example node name
> - Update example size cells and reg value
> 
> Link to v1:https://lore.kernel.org/all/20260520025131.17772-1-challauday369@gmail.com/
> ---
>  .../bindings/clock/via,vt8500-clock.yaml      | 179 ++++++++++++++++++
>  .../devicetree/bindings/clock/vt8500.txt      |  74 --------
>  2 files changed, 179 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/via,vt8500-clock.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/vt8500.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/via,vt8500-clock.example.dtb: /example-0/pmc@d8130000: failed to match any schema with compatible: ['via,vt8500-pmc']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260524111813.39810-1-challauday369@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

