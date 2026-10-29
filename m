Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281128;
	b=trV8r6+ag6eZXaEQk6+x/Y3pmExAQWIPbNbYXFZkNcVoj0FqxFqNflgwlVmjvPRgLCWd
	 ujyeTv943F7bSrDcUEANTliB1MgWhh2sEkE8BzTcHsRVkiUKUPOT8rd2Nc5OtNkmsTSyn
	 pSu+kO56N+aDf/rVVEPTXIdqt9HxyD9EG6+TQJWMSxsvwKeEKqCfbb0pMhA4SLgJHD7E6
	 jF/Cn/88iR1iYYpPHdDU8cC6V0Y79KWb0BrXcRrrChjykuw/u+2ZGky4q3hzY2qXUV8DQ
	 nj1eez0aSdhuolGfyAqVsw5k+DiWZ8vky+44HQHT5FoGRVzpbNqY5jrXsyiUMPzfjKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281128;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a8TzLvY+2CtIW9JPy8JSU8iyJz32kJ4deDFLFL4IcME=;
	b=uF2uG9n1uKmg4F5k8cdLq6xd1Ql598TUV7vQmhzjajUc/4k+gO8DiKvgEFR8SkE/ICXV
	 UKIJj42qZ66hmffv5QTTGReSHkpGZo8DrgkAPgWi86oULtpGzlZ71fzQdRsBsClpF47QL
	 ZPatSiw/n+EvHWQvMlYxBxU7cdVyR0ld79iCAqpvnadORLFdrphGlKSOCgeW3yqcm27O+
	 9lBQY+k6eocwCRqsYKOiT52aQzlzx25szZBCAs4Kne8XEMegDNodQuw9KqKT0bU1v9lUb
	 inSDEUBCaRHp9cYM49KCn6VptAXdoGQOKk2e1z3Lo+qL5q/3AG76wRFf5XhHNGcvINg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbrOHj9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC6606B541
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbrOHj9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FE01F01241;
	Thu, 29 Oct 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281128;
	bh=a8TzLvY+2CtIW9JPy8JSU8iyJz32kJ4deDFLFL4IcME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JbrOHj9frBjBxEHtfrkll+foIqPfJsNBSO6ulgqauycOOT+W/VmFp8i0zyBVYYMGJ
	 mruXzZ36wUSnzvR/W2axNbebo13szlbTDLJoHERtJg3Xo4T28/w3auG0Phz/gL1Xjg
	 vPzFMsanx8KZk7awT8iEnOjAf/1yWPGrYljwTJut8iYqx8zP6Pi7S3A53kUTB+9cPk
	 E9wrqER6vXI47t1wkk+IzsDOWPsqwb/EYOaMYyKE47WFxiK0IKNmSjPJ2qAaYOIj6I
	 AsbdBU29dSHhesgu1G0D5/R5IzZyk65TASQ1Gps7lyHYa28Xh8T1e76zcLtDlO613n
	 vtXA3OhSoSTog==
Message-ID: <sashiko-outbox-189400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] rtc: ep93xx: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-3-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:38:47 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (comp_preload_show and comp_delete_show) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D3

