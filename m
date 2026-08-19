Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48081304BB2
	for <linux-rtc@vger.kernel.org>; Wed, 19 Aug 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144879; cv=none; b=T8g4OC4qDqaEfu4V9R6yGCDu0GzsvR1wVV36Sehy8iTg/M8yt1gEwz+P+Be6G67pUNjq+OkIaQjD5xCbE+wpINvpNQ3Avi4sutPAXbFofbvxEVUTivjlQQv+2Zo4zqT+VDLra2XQgMTh9dqMCRhVHZQKQChc2M2bpZmWiC3Umq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144879; c=relaxed/simple;
	bh=yrU877nWPcdWrhrFEP032pKtkLUhwbTmK9dYjjs+wt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6a1bX5gIw0VDxzDgCbkEkw+UESFqa4fh3Xhfu6/I5aQMLtPOuKk6eN8oXqbhEXtHVWdbL/plWjXHb2y4nRogfUSj39F8s9Fzp5yT6Z6V7QpcfZ7987pXyS4kKLJMa3D4ExFy5MN/pP2Q7TWppdcl+rFfz85irOwjbHMqfFPbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CLZtqwei; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CLZtqwei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=yrU8
	77nWPcdWrhrFEP032pKtkLUhwbTmK9dYjjs+wt4=; b=CLZtqweilI10G7sI/z9d
	9R9vRHCSFJ28J7tv3t29Qz+OXiY7/HzpmZi8RrjuTX3/4h7ocb27/Sy6qi6CaIeF
	VdAJ1WkmYPDGYrC+MHo8KxwDpbRKGmM/IdPGMHeMxJDM/ZhJnhcOMPrDyIzH8A5O
	ptE1uL31USLSnBgWks/2KycyVGMxWsM9jRiYuhYw2YuubaPXxhpdTEH8l9ptQ8ct
	98Mlbt93CL+V0IEfPy5CQXLlIQHbQgND3SJt91w4DphJrTqOElf0gdMvEg0DxjTT
	qzaNYXum901qhRtnZwywme6vrScXwaQ9Ka8hX/Bb16eo6yq+H3bkhpTFHy1uaXip
	dw==
Received: (qmail 4148039 invoked from network); 19 Aug 2026 15:07:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 15:07:55 +0200
X-UD-Smtp-Session: l3s3148p1@Go9sF2ZZdnRtKXGR
Date: Wed, 19 Aug 2026 15:07:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: sashiko-reviews@lists.linux.dev
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org,
	linux-rtc@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/15] rtc: rzn1: Use pm_runtime_put_sync() in
 rzn1_rtc_disable_hardware()
Message-ID: <aoWqqoOpIukOZBFo@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105139.4AB9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tZlar7s9kFKAr6FH"
Content-Disposition: inline
In-Reply-To: <20260819105139.4AB9F1F000E9@smtp.kernel.org>


--tZlar7s9kFKAr6FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> [Severity: Medium]
> This is a pre-existing issue, but while reviewing this file I noticed a
> potential race condition in rzn1_rtc_set_alarm() that could lead to
> spurious hardware interrupts and lockless torn reads of rtc->tm_alarm.

Same issue as before? Just disable the irq before updating the regs?


--tZlar7s9kFKAr6FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqqoACgkQFA3kzBSg
KbZnOg//R1v4bAq1nbKDMh1INq85KL1uNIv3S2OjQUCDg7i9Y6t1mOzDfpTHZOJ1
BIkOsoyuzUCebWloy9VVQXSKEyWpjkODRMydv2wnXWBwpBDQc97vRp8zpZ1CqW9o
HDbGelsEVSY+8W1Euz+wPHEI8yqXvR+t9cUmJsh1Clz9QyqQNXGYXXIFC4b716e2
E6zzOPAZVP+hdaqH80s7WWGxqAfXCC51EuA5MU1sgMwuI4jsK1/HVmyqZmNd8INf
fZxlwWO9le6E1C5IxJuU7yekTtxBWnRmuNUtfRZBpEUph3nTqd2KdBcwrfXL3J1b
9O1M8lNdZPZf2p97H0Bkc3Tn+jymg+IIudfXupZo5QE6BntePFwypWNAONXgIsgQ
lM3Hk6fH0dS7g+EipsZ2NXth6IBTlsxfWx1dMUV7YXr81OjwWeg4ai9I8M9GanN9
vJu1bc03YLhKUoFjuu0JmlHEOaYJjHFCmQj/3YjZJ9g6IbXG3kAiobfxRlUnVPdM
wlKN3q3OxYOsbZl7ylDRJf8PuLGQz19mdHZVvq/2Y2rmHkfnXfWQqRsaYjd2RYUL
I7J9dXXooOJP7QwmitrHiVnYW3f97bH7r+hF5/oPBXxqdtFPlVOgFzAhIVJoQ5+R
50pBvvNcDFJQujbsgKShNdtA2YguDWdg+MigIg3vFk49rYqA7r8=
=rn9y
-----END PGP SIGNATURE-----

--tZlar7s9kFKAr6FH--
