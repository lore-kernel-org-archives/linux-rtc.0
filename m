Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CE36AB56;
	Wed,  7 Oct 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407807; cv=none; b=FHGEGYHIFWzgNoX6thJnrodrpj/1ML58gh3WzbzxQEApLtKrsIhJ6fE8SmiJz4OlPla/ENkQt6Sm6ieFzrNEIX3X3C02j15U0jaV46xNS6dD0/FYf4ObQBAsSyYYwuaUjvgKX9uwNcHr9AWjYz0Ejac5rYNnMBwGq8LpFLOrFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407807; c=relaxed/simple;
	bh=0wciv1LW3r58hxyaggsfufexfSpBNsmTBzCJwbTaHCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikk32oRkoWayJq/aG43LYpFJH4qbU0TMDvyH2mU90n5xWeBH+zWDBPpKhmj5patYcMK+P3eN85bl0UTtynqKYdCYnMsoiX8hK9tbQo80B7QQ7j7lMtFp6bs4n3JuY2DyuelumSheIYhlU4RS/2D5252mWHadWpw0DgEHTSpQvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEiJ2dcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEiJ2dcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55531F00893;
	Wed,  7 Oct 2026 21:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407805;
	bh=Xz6buXav5QfaxJzEdzND6uCBc83XGDCGlVkDtt0fjUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CEiJ2dcqsFhbZiLoaLAl684SkYwbahdW2iaeXPSNiXij9shN8TPl+4RxSg6Zgpv4j
	 AbkwUkKqxD9rDGSece4d8LvdYMzJmkzsFbNedRngVhAVQEeDFNe15HIqZJxAb16m7H
	 qV2YnAG1U/hYy+TDTdxr7+hZ0I48eg0R3GRtVtqYRV1VmYXF1GuaARCe3BLcXIO0ok
	 3bXbXgU5bWy5sMRU7pUUs1BJL6oWxvvdHes+VH5wV8NfvMbLgPeOFb2CBTfZrZp/FF
	 AMFyQdu1Wmwlh3AW74dHTIJJDyvlyYwJIoR1AbbaTbblYlphHr/3gOlVG2PY4Ytmy6
	 k0buwOexwssOg==
Date: Wed, 7 Oct 2026 16:16:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-sunxi@lists.linux.dev,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner B288
Message-ID: <179140780417.373527.14543472932668244444.robh@kernel.org>
References: <20261005202731.153971-1-pmazzini@gmail.com>
 <20261005202731.153971-6-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005202731.153971-6-pmazzini@gmail.com>


On Mon, 05 Oct 2026 21:27:25 +0100, Pablo Mazzini wrote:
> The B288 RTC wires one alarm interrupt, not two.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
> ---
>  .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

