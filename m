Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AB466B79;
	Wed, 17 Jun 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715349; cv=none; b=QBXkBzeNStFyPlY3cNoi02oRNerY8a6xO3iFy6FKgYAhyiszOxHQeaMDLHdXqyvTQilvqme/R+86TDRJNWilJVed9cC0E/vl5h8iIY1D/PNJKO5u1UNqB18eciY7IDper5j34CRGrzpCP1jDs8DGBdtq8O8VmmY5rm6mXeNHeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715349; c=relaxed/simple;
	bh=9vGdkw/aGhNbVXeunHlKe0fNy+NzRG8qPyNsujXL9qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3IuEN+lPqH6xUBKLCERlUslXKgV7tO6kCnt5LeNUzHjKXsgPq+Xpcdi9cbwoCwBsmHl3Q/+dN2aog/qm8MsXkTSJe/Qp84MzNm7EVwICt8a1S6oLmnMblFZupOYQAFBMiuQpqj6EbzyudNreMtR8Ny26DUcs45YwpP0m0JAilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wWXCFRxD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wWXCFRxD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7C76BC2B9E0;
	Wed, 17 Jun 2026 16:55:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54818601AA;
	Wed, 17 Jun 2026 16:55:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34AD3106C81DF;
	Wed, 17 Jun 2026 18:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781715341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sy6hwesGGOgjk2y/HCTHs1UinrRCEe2r5WLpgpf9Wt8=;
	b=wWXCFRxDuJt47+WQAowlZGS29/iGnukVp+hTJ5wuexBJaBfToi3eMeMbR4hDffdgdxh8aF
	pF2xI8KrunRQJAT27IYzKtIMujinvTmQfYrSsUDjab4MSLyaGbNH2DIkga4BshhWCSz7y8
	NpgO6e6zqJnfDcm/PDLLoW10GyD9me/U4nTWroq5UWkKcND3GN48Q/DdYoAwgy4HvNGMSv
	mkvdYD7o2fxEvuoWEpMDUmCzaFTdremOkzUHwpDSyuZ0vWt0TwW09haBZrsZDuUHyMN2qL
	vQZsetHfbYpDM5FAwyF6qzYRbTWlvYbq8M52BQbNoSXG0eACA7uNYHCLw/bcnA==
Date: Wed, 17 Jun 2026 18:55:38 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 07/12] rtc: rzn1: fix alarm range check truncation on
 32-bit systems
Message-ID: <20260617165538dad7e36b@mail.local>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3

On 15/06/2026 16:48:00+0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
> 
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
> 

I'd argue that this is never going to overflow ever as unsigned long
gets you to 2106 which is way past the usable range of the RTC so there
is a trade off between the size you are going to take on the stack and
the actual usefulness of the fix.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
