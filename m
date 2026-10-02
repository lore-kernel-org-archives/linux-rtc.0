Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40D45D939;
	Fri,  2 Oct 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934695; cv=none; b=Qs14IZvvBV/hlztnBCrx23rqqDVS+LSLg8SWvMoaQE6zH313UsyBiC2cERKgpo9mJQItkIOgAH57BJVbeJTcbY2XdCITojKLZqsFYT9rr+vpVFmPoDsnr1OXtVirwwiproN5p41eWaPwqBK/8WwjoOhhURcm+L/LGMvdZDFA2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934695; c=relaxed/simple;
	bh=eACyWquvsif3v2mV5pA1Mf/QXq3WJPWm97ojH2g7/qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB69/nks47UWkbWbEhmn+7OouD/xhk1LJeOTpBYRRVRMVIBf1rXNRewcnpwfKwhCNvjdirPf1+jKraQm+bXDWVO1vvVamSmPLAm9nFNAvOJs4ut0kNhD7Xy9AjgGffJCocOYE5ndd7FpuBRt6MJ06NrgdF5fkm8xll2zcZa1kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihy44rea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihy44rea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544981F000FF;
	Fri,  2 Oct 2026 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934694;
	bh=eHsZCEj85g2+3xPKItIT+ekixy8fLIMRbzaGW9CP2N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ihy44reaHxuYSczcrLLd1iNBISClgjq4j2drJ0oPWGMlYTGhG5Lo8wc/6epbZdDpm
	 yA3SYmY3A+eYAaJTWEqWLa1gZIfMB4gOPLh+3z8VcULkxUkw5S5vUKw0dk2EvRNLl9
	 Cg8/u2H+IMYJBLm4NqWnidVdbhrMil0fxNK1VY7LLSQRqK+mQDSI+i8dJnacGW0aVU
	 y9GgLtGmnkKB5GGBBcuZinAksPXJ5hLUCMXSFPkOlgasspdZEPwT3kwxYu9AYSLAZk
	 7cflJ3Z0EBeCh4VGOWXmQF2GnU6VZwa0fXmYlkyTlF7r2WMkH9hwLk0Jjtgt8Gf1Oo
	 3v1/Q00eZooCg==
Date: Fri, 2 Oct 2026 11:51:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sander Speetjens <sander.speetjens@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com
Subject: Re: [PATCH v9 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Message-ID: <20261002-analytic-conscious-shellfish-251bbb@quoll>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
 <20261001193703.734323-2-sander.speetjens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001193703.734323-2-sander.speetjens@gmail.com>

On Thu, Oct 01, 2026 at 09:37:01PM +0200, Sander Speetjens wrote:
> The property uses a non-standard unit suffix (-millivolt) that is not
> recognised by the schema tools, so the type is not inferred. Add an
> explicit uint32 reference.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

