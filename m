Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD724418D7;
	Tue,  6 Oct 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291973; cv=none; b=dC1XMKX8rf6fvlyiGbYoQaTqNV66l5knhSbdgeSX9EiRtBeQlFSdwoluRIq3DVFxX3EjcfyiR/f0fMkMntQzuNLX+vK6s6Q8jt127IwEG/5z+jAkYWUgbLXHzzm1BUVWRObSwhDBizCeAqrNF/Kq1E//gAuwROSUZFse1PXVGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291973; c=relaxed/simple;
	bh=L4kAmBicTl0pRpKiCQTderZIL159TxmGZUgBk9qYqrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2L5jyUvujcqbi3q+GihEhXCXzdS6huxqUL1ewQIOi0WzIZJqVTd3RlRkM9JlNIrxt80UBjYCKEZnXCl+glzMVbpUe0XrJOuyprYYMlzwAgwI3IckVFWurKkDdJZ6l2eVF+xe79cEUGs0hOfEifLiFZsXKam8oBAstTnNYO4mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNuh3wEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNuh3wEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A531F000FF;
	Tue,  6 Oct 2026 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791291972;
	bh=/ZDE1b/ofQc5+FHYtixas/9EEglj1E+MKaqTgNZXuR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JNuh3wEcshU+h7D3Xjy3UfNrTnrBGpRdoWxl/kSvhdeXg0tXVARBD7pYEL8gOna4X
	 0PfDdi5aJPNyvK//QgG4uHp27aDmp8fg3vCVaxOSGkqa+Vx5MO1ci553Sc2uL/FZZR
	 XMxmmKBM2ZLIYSgYeZrrMr/GFY6nNv98gP6RD9m6mPpleugtS3BMK9TGz2Fkr0eoDn
	 atqljn5kRrQlyJlQGoREKyD7H+J6ZYZGzZNc83wN5cO+2L9bAWNEmXDvJ+/tzDddX8
	 ll2rXkRNTl7yBXFtJeSOP9vwOgeo375LP06VPQ2W1nSZtvgH+BIPeKIrY9BCGNfS1a
	 7QbyyYn4UA40Q==
Date: Tue, 6 Oct 2026 08:06:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Linus Walleij <linusw@kernel.org>, linux-rtc@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH v10 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Message-ID: <179129196974.1658029.8967859759819960854.robh@kernel.org>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-1-e7b1cbc50a7b@posteo.de>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-rtc_s35390a_int1-v10-1-e7b1cbc50a7b@posteo.de>


On Wed, 30 Sep 2026 15:31:46 +0000, Markus Probst wrote:
> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
> 
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  .../devicetree/bindings/rtc/sii,s35390a.yaml       | 118 +++++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 -
>  2 files changed, 118 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

