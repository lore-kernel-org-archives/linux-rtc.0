Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD223366557;
	Thu,  5 Mar 2026 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754973; cv=none; b=U/xi23Kf8NFHVyIFW6UrPAJEBK2iwc9a14P21eDVtes09XRdmbTCMJqgegayPZU8ZBxbojZPhjaPgHylquJReE8l9lC9lxnecc/ctc496B/T8EOSsZDjc2YT5ChCQzsGoEjVCpLhdNNs526KrfKdK3IgRqmIskSDBkzPkQtwGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754973; c=relaxed/simple;
	bh=P1cJDOv3b/ZAmsFBRMV4gqQVcaDJlvO93WuX74LTbCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DifWIwyI8B1G+ZZ5+dIanW2oSYIdOLdCyn13Bowd8xxEQ1rHjtc6+cwqPMe8evVvoRB2aKzmbSi8/E84Nmds78apbMO4FP1IWc57mkvoAh2+/MARKZcXznpdKC2vFgYDbrq1GQcH+6LD9wlRMwNJE3wrQSbVyYLY3yzIXxtdhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc6U6epp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc6U6epp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8E3C116C6;
	Thu,  5 Mar 2026 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754973;
	bh=P1cJDOv3b/ZAmsFBRMV4gqQVcaDJlvO93WuX74LTbCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc6U6epp4/aONO+4QPcEsSw46hUIzgzu4SyKdCBFLTJVrgHyh4So4CMB5+I/YYiYV
	 zmhHgoObEYVqxCEsCjby6rIiMfrL43WgIfzLb8vRyHnZNtZxazIgGtoLLn0jLalF8O
	 UtP6gvv8x2MXJgLHebG0SFpPekF9q8g8nLZZVYgNo8JDzpccugfm9khQs94Q5dSTTc
	 +THBVJS/BvJYTZCOgr1/dhEDRE9XMd3moNxLoJ+BdMpk9KllZi2geSNFqjTRVPLsTM
	 eC7KAEnJu8LR+1XufzxXA+JNh60HgQcnOtBzIPBLN2Bdf8Z5dLQIGtMzd0fVhpp33U
	 OoRztgFeninBQ==
Date: Thu, 5 Mar 2026 17:56:10 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: max77620: document optional RTC
 address for max77663
Message-ID: <20260305235610.GA807544-robh@kernel.org>
References: <20260223064343.12516-1-clamor95@gmail.com>
 <20260223064343.12516-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223064343.12516-2-clamor95@gmail.com>

On Mon, Feb 23, 2026 at 08:43:42AM +0200, Svyatoslav Ryhel wrote:
> Document an optional second I2C address for the MAX77663 PMIC's RTC
> device, to be used if the MAX77663 RTC is located at a non-default I2C
> address.

No changes to .txt bindings. Convert to schema first if you have 
additions.

> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77620.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> index 5a642a51d58e..0bbb42e5dcfe 100644
> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -6,10 +6,12 @@ Required properties:
>  		"maxim,max77620"
>  		"maxim,max20024"
>  		"maxim,max77663"
> -- reg: I2C device address.
> +- reg: I2C device address. In case of MAX77663 there can be 2 addresses,
> +       second one specifies position of RTC.
>  
>  Optional properties:
>  -------------------
> +- reg-names:		If 2 addresses are specified then, must be "pmic", "rtc"
>  - interrupts:		The interrupt on the parent the controller is
>  			connected to.
>  - interrupt-controller: Marks the device node as an interrupt controller.
> -- 
> 2.51.0
> 
