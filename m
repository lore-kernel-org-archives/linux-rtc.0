Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0DF1F866B;
	Tue, 27 May 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328220; cv=none; b=sjJdcFJmM4Z7e4535/nszVFC7CiDCJzVjAIA9hhI3bzPKgfzQSognQ26EANbJRCDN00SVXhY8FO2vCXLyTLOBObcxudLvZoyiIC7I8K7neDGWcn/qqvcdC6e5SkTdjbMbAnJF/0yJvtosXrWHMHu02afzK3KV7kUnxL945Yd6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328220; c=relaxed/simple;
	bh=4jWPbRqhqnMHzaHA3PtudbhC21+e6bVmLS3Bv1eCTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSzlPeR2Qg9xoNaPjFLAIo8uYSvHYBr6Z8glDuXUZh3N+vCS3KO+rHaLMhOftbVaZeBOfgY3BPmBGOmnoMlFIsGD5PE5fmnglHdFVatoKNOr/ntT+7HfwxH/PCDUYgP30CCcgt8fJuW4Bg5u57h605dLCUQ/7+ogZf/zEUFRJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10FCC4CEEA;
	Tue, 27 May 2025 06:43:39 +0000 (UTC)
Date: Tue, 27 May 2025 08:43:37 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, Markus Burri <markus.burri@bbv.ch>
Subject: Re: [PATCH v4 1/7] dt-bindings: rtc: add new type for epson,rx8901
Message-ID: <20250527-able-swift-of-intensity-a5ebed@kuoka>
References: <20250521090552.3173-1-markus.burri@mt.com>
 <20250521090552.3173-2-markus.burri@mt.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521090552.3173-2-markus.burri@mt.com>

On Wed, May 21, 2025 at 11:05:46AM GMT, Markus Burri wrote:
> Document compatibles for:
>  - RX8803: already used by the driver
>  - RX8901: new device supporting also tamper detection and pinctrl
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  Documentation/devicetree/bindings/rtc/epson,rx8900.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml b/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> index b770149c5fd6..03af81754482 100644
> --- a/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> +++ b/Documentation/devicetree/bindings/rtc/epson,rx8900.yaml
> @@ -15,8 +15,10 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - epson,rx8803
>        - epson,rx8804
>        - epson,rx8900
> +      - epson,rx8901

This has to be squashed with your other patch. Adding new variant with
new features is one commit.

Drop the tag and reviews then.

Best regards,
Krzysztof

