Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1446317173;
	Wed, 30 Sep 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763039; cv=none; b=MqPbhsclhE7OOWYDw69O74+YDYeS1yrhHm+G+7BZU1qt1TAPA9+DFTHNliqd9fe3R3X6Tp+isHlylzm1cmUcbtiwRY8YBfZgowi8aO8jwWXhkTZH5RiveHzRXtVviXsqYcvz+d4Cojr51oBlSUwX+SKO9x0JW6WG9kkwtRaEP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763039; c=relaxed/simple;
	bh=onxhY7qFW3wqD6tIOnfRIki+3UkB41+NNqfblBmh3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMo0f6fYLpu9qxTbObi8XB2pFBR4Ub7/QWwKAWjSQYHYUHe3Lv8SE8LSX7jB92NoKJ3H+yXEFy02iO4YhRNpNH0YR0Xug12rN4wbdHIX3mzrejkmvFdQ7eg3MqBP6SiMz8kcaivRuK5f5AEW+3JbrwIV9mXBBZokncho6eKRC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgEkZ1Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgEkZ1Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C2A1F000FF;
	Wed, 30 Sep 2026 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790763038;
	bh=vHfIlpHAKIFPPGeTX2D09og3//FoLgPKp4mRy4VEQkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mgEkZ1SyRI8K37jdaZ0dnzHrhi0Z4YkrL7rpHe1/qvh5qnww2L/4cGvKrG3fIgaPh
	 sHq1rdElmDjtY478yz461FFYX9i8EQin91eBehPi4WpGiUML69OB1/Urk9ZNQ+C+4l
	 rYhzUqYgozRhik33xsAPMhTubLycjkvwgaHWzn6IrABHP0hCFH+iD2w7KFAMTOGjHE
	 dWmgwsTARIRVkFhBxoW3baqzV3oaM2oHOSEJMIo7yF8rv1vjAVpr1Qh+2K+s3U8acZ
	 fdfD05lIscrAE4aFgN7Plo3XddfeRgYneuncnujFREihuFURjvEEgz2fSSbIo+ReMP
	 nibLEDiMIalww==
Date: Wed, 30 Sep 2026 12:10:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
Message-ID: <20260930-camouflaged-koel-of-resistance-7b09f5@quoll>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-6-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260927151016.186493-6-pmazzini@gmail.com>

On Sun, Sep 27, 2026 at 04:10:10PM +0100, Pablo Mazzini wrote:
> The B288 RTC wires one alarm interrupt, not two.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Seems like valid and unaddressed comment from Sashiko, so dropping from
DT Patchwork.

Best regards,
Krzysztof

