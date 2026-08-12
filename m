Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCF36C5B2;
	Wed, 12 Aug 2026 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498965; cv=none; b=gCtd4q4yLeAf5klIuXpEuzHDVC1mqdPDLdaHDQMvfA9WgQH+VfPXYJrlBl1PDKo9mn33cSNhPPZWnEOC+Z24sS84spDA+dj7MzWObj2VSO8yrvyCB/CmXL3omIk0d2wryNNixjdUp1R02l3YsDp8MD6ZoaBRIGIG2/TU+XO38qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498965; c=relaxed/simple;
	bh=zuQhurCsfWxdvg9zqWCHnLnAH5PZOQZQx/7vnIyAyJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQSxFXCo7alASs9/HH8V2Tyzq72fsFwuVTi5AETEbA80JdPgvOgbDWglHXIerAJnQ0eAfLovBIZq+FJDwJxbbgA9aLERD2MoejkLt6wZiQ7D6JuYICqw9Cjaa9VYtjFnLmMDqBVKAnv1WA90wJciJbH/fOidozxGzS3K5lIw8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf1a3Qh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf1a3Qh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F2D1F00A3A;
	Wed, 12 Aug 2026 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498963;
	bh=3Gmxd11Q4KbmcVTQRRbhyX8PuGieLvmY8yQOB2QE//4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nf1a3Qh3X0Rz+9RNU/1Kkvsy2D1TkQyPyjk3fGR4fIH/JCdofWAXi55uwPVUZpySo
	 ndlgdeLVu0EkKXsamkh9miBo6nShMH5Pmx2M8U5GL5mM1qzmWQ4amw92E9cPoZ2P8P
	 FgabNDmRuoAhL0rp4g+ca5zms1ouJzrRmJIqTP3a5QNO5U5MDzK6gYZcCfKcB1lznn
	 mCildU5tHOCWz2q+ZjI2X0UWGR3w8+QjtRJUiPba6felOhBQYhxXVXSom4IcKBBesA
	 tAR2j984YYHUKzIGrfi9xhkSMtmdA4SfCAaru9SUoOnBOYM+/eccqThFJnn/AIZ5GN
	 xfZwe3CKP6DDw==
Date: Tue, 11 Aug 2026 20:42:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linusw@kernel.org>, linux-clk@vger.kernel.org,
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>, mfd@lists.linux.dev
Subject: Re: [PATCH v2 01/10] dt-bindings: mfd: common ROHM PMIC properties
Message-ID: <178649896215.484116.4065648692098277062.robh@kernel.org>
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>


On Tue, 04 Aug 2026 13:20:20 +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ROHM PMICs keep having similar functionalities from one generation to the
> next. Keeping the device-trees describing these functionalities similar
> helps users because:
>   1. They can re-use existing device-tree properties when switching from
>      one project, using a ROHM PMIC, to next project using newer
>      variant.
>   2. The users can find and re-use examples from old projects - even if
>      they never worked with ROHM PMICs before.
> Similarly, introducing new and different properties for same
> functionality previous variant had, will be adding confusion.
> 
> Sometimes the existing properties aren't 100% what reviewers would
> prefer. When issues are minor or just cosmetic, changing the existing
> properties is not feasible. Reviewers can't be expected to know which
> properties are new, and which are existing - and this can lead to
> unnecessary review discussion wasting time and energy from everyone.
> 
> Adding a common file for re-used ROHM PMIC properties should make it
> clearly visible that a property is re-used, when a new PMIC binding
> refers to this file instead of (re-)describing all the existing
> bindings. This will also help keeping the common properties identical
> across the variants.
> 
> Add new file listing commonly used ROHM PMIC properties.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2:
>   - New patch
> ---
>  .../bindings/mfd/rohm,pmic-pins.yaml          | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,pmic-pins.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

