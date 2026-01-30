Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397F350D70;
	Fri, 30 Jan 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814963; cv=none; b=BwiiKkQO1DNnGLne1V1Ax77I6SVGkMUkvvfxb3OKhb48hJQ6+TgaW+K4Os0+DBXFVHy/stQF295t2IU4YNcWSxrNFfv8OtYjpigSDB4p6Cs9lPlNzTMyorB5xNk0qF2BTxt/CJScP7WJneUeSwDZXiZghpyfO0T7mo0dz2GNYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814963; c=relaxed/simple;
	bh=on5Dq7VlB+GWtzXBXz5dK9cgfOkPuxIAyJOX4UrdVC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciG8OkhF2t6KI933S8CbIO/bcKxYaQ1MHSFpmAPtH/eQbsvIAD+1QI/YTLxJEZNmzkadimn2bCS0QsdMiwnfkugIR3X/3N7on3B62dKGvi+QrOdNJ46WSIjwbqhZF+KYcBkHNNVBWETziDae2X51ecgjz9Zq6T1SmNXMpUoZQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oftoXtUb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oftoXtUb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7589CC22F6E;
	Fri, 30 Jan 2026 23:16:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB5CF6075A;
	Fri, 30 Jan 2026 23:15:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5178119A88ED;
	Sat, 31 Jan 2026 00:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769814958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BdLkYmrO18kHYLs8UMBmTFJsMPGtqPyIHpXjs8+vkt4=;
	b=oftoXtUbi+/6QwseNIz4CER5OCynmyr8l6b07GL3SFui3O5i4iGN1BT9uQ/V+NqRt825hj
	+X/Gz4V4o4CO9ihUUDxmz515egtrxJH0GvjamOTF16CTgshePuLZQDyFvFZe853SixvXos
	TVMTYkQLpPTxJApGLX4d9wKtv9IKxzKdkYHjRTO1FjsjOTBsshXI49UuysPfBV5cXvFdf3
	QUSvVfwt9exG04qK25cffruybKNNopTUdVRdxbACV75d5/+lplTIpWV6uPfK5U7Q6He/aC
	eWd3UCk1d+wx4h5Fb3PeTIrhbe+1V6RlcfFKPj40OSN9wOJpVkyr7zgmcN/yAA==
Date: Sat, 31 Jan 2026 00:15:55 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: claudiu.beznea.uj@bp.renesas.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH 3/5] dt-bindings: rtc: renesas,rz-rtca3: Add
 RZ/V2N support
Message-ID: <176981478046.2227007.5874729777206051126.b4-ty@bootlin.com>
References: <20260125192706.27099-1-ovidiu.panait.rb@renesas.com>
 <20260125192706.27099-4-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125192706.27099-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 25 Jan 2026 19:27:03 +0000, Ovidiu Panait wrote:
> The Renesas RZ/V2N (r9a09g056) RTC is identical to the RZ/V2H
> (r9a09g057) variant. Add the compatible string for RZ/V2N and
> extend the existing RZ/V2H reset configuration to cover both
> variants.
> 
> 

Applied, thanks!

[3/5] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
      https://git.kernel.org/abelloni/c/f3ac75cfacc6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
