Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311723;
	b=irPIcpAxNI00PCRzY6ZPaMfYuvRc0iSu06MrVrtrCs/csqjYmrAVxZras4JxS0DbS6HU
	 0dg0plyN148mCSYOBKJeoXOTn/2Lm4K9uhvI/gt/6p1DZ4E+JHMKO53fYaeT9mmQ4h8X1
	 IL8T40BnuHG5YyB9Md4PVIiu0jpFpDrnPygnk0/za1kCLEayAjsCMwFl3JA/YiDFLngsm
	 KzBHxiK6zZmqJm+dz9VTpQR8D2LeG6QAU56XYsgdPtvxFaSxvhmy2Qs1lHjf6XiL7TMcZ
	 euRudhFcNLpQYWz686IsTLDSa4QAlmmj4PcK2x1vXZchNl/SZDQWhO86aQpESGpy/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2R+pCgHKZ0bswFzRGYD/aZSxNJMUNxjGeJPVpJytDAw=;
	b=z80YTtYPMOaD6czrGJOCiL2z7HRA1PQbAs91YDOmoe+yMIGM6LxRmSxzQq5qb6e/hCh2
	 fNpzrT10ZxpkfsofuXKUw0OWlB44yqiSHiYUP/FWikAKSdiRkxbIR4utpzOfYXWgCscpE
	 GPPD827Xj3YwLsHkwCQ3pw/pi9Rf5FScxlGix+IeV5v2zLFdr/giHDGi4JSeWqdj5WkSW
	 MPJ0Zj0C7NltPh7JFqalGPaQdAs0/+ZeQjdbsEWr+KyRCfPt/B7scpLoaSpc0ZaMy9p+q
	 79Z627VjZ29gArkLBgIQeFxiAu4mo/WIQOb3aYXxyYGYrUKMfHrJWNym6xc8rf3vnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jS2OM92v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B6606A333;
	Tue, 10 Nov 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jS2OM92v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B891F008A1;
	Tue, 10 Nov 2026 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311723;
	bh=2R+pCgHKZ0bswFzRGYD/aZSxNJMUNxjGeJPVpJytDAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jS2OM92vhGYFLQZtgJ17ES5I2SoXGonxOLA7ySexc1gVBw34/i50QgPMhWtEJkAys
	 RhP2CxLM4meD+xXi1lk1WmT888/peHhJidvH+Q9HL0FJMvzeP9b9kVrcrBZ2TebGt4
	 f2DYc0xq2IUrRFF+OODN8Caq9vATVSyIJqV4KIcoj2IbbihkA3PMQezr190in9Dx5U
	 em8n+aSTQMk3hPd7bNlyAzNjhySjzdQR0MS1icoWls7tbWPjLzDdKbtFxmzL3IU0Do
	 7Vn3uMYpk/a/lPlJJfMdoPNnvlSzVO0l2kKsMbyRvHAusikUvQpQna2cUgzZVgDVao
	 PZ93koTOVgAWA==
Date: Tue, 10 Nov 2026 12:55:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Rea <rodrigo.rea@marsrover.mx>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alexander.stein@ew.tq-group.com, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rodrigo.rea@nxp.com, 
	daniel.aguirre@nxp.com
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Message-ID: <20261110-provocative-voracious-parakeet-dfc33a@quoll>
References: <20261109152352.6335-1-rodrigo.rea@marsrover.mx>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109152352.6335-1-rodrigo.rea@marsrover.mx>

On Mon, Nov 09, 2026 at 03:24:02PM +0000, Rodrigo Rea wrote:
> From: Rodrigo Rea <rodrigo.rea@nxp.com>
> 
> Document the NXP PCA85074A real-time clock with nxp,pca85073a as a
> fallback compatible. Both devices have the same register layout for
> clock, calendar, alarm, offset, RAM and timer functions, allowing the
> existing PCA85073A driver support to be used without a new match entry.
> 
> Link: https://www.nxp.com/docs/en/data-sheet/PCA85074A.pdf
> Signed-off-by: Rodrigo Rea <rodrigo.rea@nxp.com>
> ---
> Changes in v2:
> - Require nxp,pca85073a as the fallback compatible, as requested by
>   Conor Dooley.
> - Drop the driver patch: the existing fallback match provides DT support.
> - No runtime test of the new fallback DT has been performed.
> 
> Link to v1:
> https://lore.kernel.org/20261105215204.2446733-1-rodrigo.rea@marsrover.mx/
> 
>  .../devicetree/bindings/rtc/nxp,pcf85063.yaml  | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

