Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77061D5CE0
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335799; cv=none; b=S+lBGQP52Jp2bXRZ4pbL+gvTQt6sBiBIumnlbGK3kj49izcwYk8sTcvKEenXSFgGaARJa9oiKqapBF/vTGwCwmzFXhulc6JTas5rA4YQqfs15TXbFG+mTxWvJOqIZctxBm965u3yk78JlHBJXWFq5jqDAq/jIqagCR80gx13h0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335799; c=relaxed/simple;
	bh=x2pVzOoZN6Uj+INLu+cBkxwDBPEQFtDR6TwqvAo6vcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTcjN5L2GWfRcVzL10lZ5IpnLzwsXnhZzQgwGAK9eDuk8ZfgmdK6/tL1ysxGfLElUtwB62oC26f3wuMhcg0zaNf4Wwc1sl8fkHQH3pSY9gf4+tS0mnWRdrgRcetf7NUQRZ15EQ+GnlJUGzIfAYQUyIsQqrTbHuXoR2DqbOxY85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XTaTgVlK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XTaTgVlK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B54EC4E40832;
	Wed, 24 Jun 2026 21:16:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 884E9601C5;
	Wed, 24 Jun 2026 21:16:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79617106C8468;
	Wed, 24 Jun 2026 23:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BxRZgMMcXld1GewrTn/+Bpz0RNC0eo+0XsbHRMtaIMw=;
	b=XTaTgVlKy08X8NDZtKOCQMu0BDALNDA0VYnboGRbodz5KICDzsoe4bn0H5ghMcfYsNHzf7
	QMT8V300UIJts32vRAKK3n2sFo2SrX3dkNMMy4kNW3ZcWTiYwg455hdjrmmZSwa7RdIiR7
	Etdi+5yxsda+qPlla29otIKBa2fFVLaxtJTit1ZpM7ILtmyrvF1ka/ptJCXh10z/j2Ee06
	yXaN2S8hPf4dtbjbq7roFJHxyv/6TVa2zH4at9ce7yyJKx1KCjDwRzQXuSOiYOqfYxVf2B
	gnr2CF7QMCoYoKGVEZR4R7tZQv4JfCKAtcoichw7aUXYzB2Nyqz2/jyQM2deDw==
Date: Wed, 24 Jun 2026 23:16:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tommy Huang <tommy_huang@aspeedtech.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 0/2] rtc: aspeed: Add AST2700 RTC support
Message-ID: <178233558822.1517260.6981271146090179790.b4-ty@b4>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 01 Jun 2026 17:14:05 +0800, Tommy Huang wrote:
> This patch series adds support for the ASPEED AST2700 RTC define,
> includeing dt-binding in the Document and rtc-aspeed.c

Applied, thanks!

[1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
      https://git.kernel.org/abelloni/c/5e7f746bc106
[2/2] rtc: aspeed: add AST2700 compatible
      https://git.kernel.org/abelloni/c/3319cfeeb8c4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
