Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E47421F06;
	Sat, 28 Feb 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275208; cv=none; b=JZ1oyeQ+0oWRL3rI0yVboKwN4lCbjXklwbhL8jZzE/swuZ0VKToX9EBMRnu7BJxSTQqacIHJNg3QsTRUVDtQzMSLp0cXnsbytOea+juqdJw7Ul5p56IuwkXgHzWzbI2wHsVUDGVYt/GBlmcDpeRk8DI+7mA9dZUXDXiVklEMbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275208; c=relaxed/simple;
	bh=x9rSmmOR1itaeZEY7li1mJ8Bv7mfH3OauwJg0QByaVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3gt/9YTP+aEC7zq5HgG9ULXmk/ejBz45CeP+m32dHV/h6f8DrFlbMvz1LMRnH8lSzmj9ecBgKLNH9A3YillWxIpvXmEBH0N8bw3yXUZljcy8L+Qb4wlMpYZ300a9l5uaKlBVCLxXSpw6PbnfkJ1S9SZ/r1LhuIysRW3jMNutpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAKpxg+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAKpxg+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B8EC116D0;
	Sat, 28 Feb 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772275208;
	bh=x9rSmmOR1itaeZEY7li1mJ8Bv7mfH3OauwJg0QByaVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAKpxg+sui50e8PATDOrzQ7d6FdstzMTJaYK69HfVYboRW6IwPGdCJ4Yjgt29Koi9
	 rnGPjvepV5mcnG1S5hT97fhS0muuRwJDkjIfzfABo0gcfg6J5ToCvdixjQZQrjoEVp
	 UhJlXM0GEqsMJ48daUT8RNZwZiptJWnJeTR0gXRhMnxbKCcv3/MbWd6fRsUgvgz0y+
	 dAiOcQUqZ43+OyGx3y8rqdu8WJR+zt+CDmQYVlv24cV2fk+x5n73pKiiLJFl45RuSe
	 HIFNbHbuyZ7Yk8CjNZ973jPCW2m6/pwmKD3Z6qgEIjViVlN5fROJ419VRzXg2HGEZd
	 XqZlAFrHKV1Ig==
Date: Sat, 28 Feb 2026 11:40:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: rtc: isl12026: convert to YAML schema
Message-ID: <20260228-classy-sexy-sponge-dba71b@quoll>
References: <20260227185115.174997-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227185115.174997-1-piyushpatle228@gmail.com>

On Sat, Feb 28, 2026 at 12:21:15AM +0530, Piyush Patle wrote:
> Convert the ISL12026 RTC binding from text format to YAML schema.
> Remove the legacy text binding.
> 
> The new schema enables dtbs_check validation.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> 
> Changes in v3:
> - Removed unsupported select section
> 
> Changes in v2:
> - Fixed dt_binding_check warnings
> - Improved example formatting
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Duplicate signature. Please run scripts/checkpatch.pl on the patches and
fix reported warnings. After that, run also 'scripts/checkpatch.pl
--strict' on the patches and (probably) fix more warnings. Some warnings
can be ignored, especially from --strict run, but the code here looks
like it needs a fix. Feel free to get in touch if the warning is not
clear.

Rest is fine and duplicated SoB might be just ignored due to cut
separator.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

