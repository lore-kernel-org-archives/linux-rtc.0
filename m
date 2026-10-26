Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031341;
	b=kCSgJFc4eh3EBtnJOEmY6iGy5Ml9KFgXAT2ny6vS4IuoT65cRXDiRioSqZuFImjHlk+F
	 qmALZejA2xb4WgdbcNcZrlxcDnB2LwkmNqY1v1Y6sPJLJ6gAtLjbiOsx2szU6iebN1JhQ
	 L9Wtet+em+rzCUwRiIGTy95NcxxvhHTyH2szr7njg83dkhUHEIfvSD+xwr1ICFq7E1euy
	 2Nc4hnML/MqES1nu8iV7miqwt5mmLjo340eO7vKTXqWhMMiywkDOTJ6Ib4qM8cuXHp7kP
	 cNQpqTEFoylIQ3zds6axVtzcWsWcTxrHmD+wkf82ueIvKpVM5RAPeKcHrPH5ZJ+iVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031341;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LadA7oSFBe2MnzmMMCXptSFizDKk5wHQyhypwaSRsbQ=;
	b=V3VnSX6JyqDO/FICTqPyyn2h0EjpAepx2sIyRKmhouHoEAXmv3rwPMC4jzPt16jq+q6y
	 Ww5kel+IAmuwQ/bMeUsqgh3pjU5nLh1w5dN2mPut8WjyB9PjW+ueTFXKdp8sNBiudVJuz
	 4Xqy1yJLX2aKra1G6Eyqb7Kw6MtipIOzSy7hWG0tudY4dOMQVDciDJeb/oHRMwh9+CDAf
	 SxLiWHMk9G6Nb0ktIynAkjKiURqJ/qWxSeAssMKzTyqR3QZtWzfGqzTIFpCWyWQjO9a/v
	 zsIbivcM2SeCCIyIZiHI6geCgK8bw3ZU2lus54nSJmajEypXUJPPf0annLt2zCDoing==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kumba.dev;
	spf=pass smtp.mailfrom=kumba.dev;
	dkim=pass header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=jR2Juekp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ju1ZMT7J;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B3606A31D
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562B3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumba.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=jR2Juekp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ju1ZMT7J
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AF8B41D00377
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 12:15:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumba.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793031339;
	 x=1793117739; bh=LadA7oSFBe2MnzmMMCXptSFizDKk5wHQyhypwaSRsbQ=; b=
	jR2Juekp0hCO/rHrFgF6MebMkBHNq1nNFrGxlhmGxwFHtHUkukCkhkLKupog8VQL
	7eHulNTUFC0y+hgPPi0TlGkaWHQ5OqdypjNRWEzQM/i3QT89aezGF7EJ6rAmunxa
	b5x6N2QtsAQc+StsYvfE79oLPTGr2i9Dv+tOlnUQkB2NSAVH6NEoBELdq5aV2BC2
	8ndAsjIA6fRkmrwD66ksj9Z53gsHL0IWndtM+RACCVXW5qvvivEyWH/Kypg6Zzha
	kh2X9EyAUzUDN/w8nMNIXEjNi/i6cyViF0of/gMnqolae4PBmuf8WTMIT248unb7
	iPk/bllXC/H/iGtuK++DPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793031339; x=
	1793117739; bh=LadA7oSFBe2MnzmMMCXptSFizDKk5wHQyhypwaSRsbQ=; b=J
	u1ZMT7J8s2JrzhXIrWw9EiTEICXl+CJ5rho2HEhuvQPN/KB/KDgu4X4t1xS/rNpG
	wjyd3rwrH8FwgVd2Hv6AxuJQkXV6PyWLK5utTGsc3otaZzswwxaOvBcYAxy73X5H
	8dydz7mxLGGF7mPII1+WzKCr7eGouGPrdIBARtPktRWzlkQgsBG77bWSWSR8awQe
	dl4uLrkE9vPRRn6busaUgkpsOmTCU6whmY8/ltD9Jhe9LQd4dgbM1VcK4owQz+e0
	+apQug7ie+Fh5xTavCWpMJnYW856T5wPUq+Bimty07eM3MpSeexnN+mOrki7pcYe
	Ot4x5lFCOlJizkthICOsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kumba.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793031339; d=kumba.dev;
	mf=PGxpbnV4QGt1bWJhLmRldj4=;
	rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:P72wWj62rZgJSAWogaj2uBf10iwgSluQHqwapI3x7/6rPwF
	XBL8w0zED17E5RgseL9HZLyeGnyO8W9A/hrVBmQjwnL0dpuFN7Fhv5YBOCIEJf8i
	4riCq7mBWdoxdf2LC3twTSsIxs2tXUEAXOKt2UPWcp17Sf/IJx3XyLc4hGy76SFt
	FDykKYsoFkvvCKjXMhZQuQnqAliYFdiySfcp/COLHz3OZnw8RFa46FF2nIMoPBL2
	agMbV80r4QVKMbIjU6gP0Miijo7XBXFBsWteAgf1J4kI7nXHK/SBB16aoLsfTG9J
	41Nw+Y575yL1s9Hto6Yv7WP8MWOnyYmbPq0oqpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kJgPRr3LRcWvsxBmdUCuCuy6DPRECUX+RDWXJyBVy0U=:epsfrOmRLCX2LpJzgIWbHF79T0AJrdEXA2bMPxsAc2U=;
X-ME-Sender: <xms:q3zfajdk9epvqGs3vk1DOrTqfLuYvzkJdwnEaEDhEwICz6R7mmvfJg>
    <xme:q3zfanAjWXAfjviw_k30HOpgpyfyJBAzwMEjenppfaCdj1gAKxExOqKREbthRXc_4
    YFhEwVI31iI3EfnQ6yW75jZSHu5swMESfBi86fyPH3Km18wad7sEEB1>
X-ME-Received: <xmr:q3zfam_sS2SkzVXehqsdHF8Xj6dawkiO6rFQDqwpQtKoUsNP7z3WNDlyjS9As7-h-40ggntTfw17FQSn1W7P37cMDmVZlYHgKm6cBmoauPNy4Dju0g>
X-ME-Proxy-Cause: dmFkZTGO9rLPf+4qiqYFulg8Z3hp3kVUeyI8L2rVif6hsVF6VH0vYNyY8ZT6NrWn7jdo4P
    sCgJEWIfEK2T90jprMBEhQt6C/K0KRQlgqpa+AbdbCy9glAu/KNl8zVIN72rL4q8iaxqCY
    +CqZSKayJojbqhqqH9Y1YqP/HdlsaNEidbSaw9E4e5hOMyY4PL1jHoPF+uobvgPXCIlcOh
    Ibdf3IigrzPBYH5THpu1r0I8o1VFqRRz2Bp98h1lVHnlFJVyo3pHwM+R20scdfm7XLeUyU
    OxPyoVN+mtbw1XqDuNhbMel7y1sR5SHD/iu/E061iNObJTmGORaM5DD8FoX9ImiWbtvGlJ
    oU+o2LMENO9PqqjJM8wGZgUjP3TU+wsFX7W6oZVnmPWUCBLH5vDfOgWeQmKYYw2fj8ErZ0
    OTJgYxsB7OdBSJ35VKTnJzbaceQXDwxL+aRYvx7frrsDD1qvTrlaCUDWVbwXk/vetu964z
    mjZe9b9xZ5vter/rarmx/vv1Fwb2yPh5dGFtKC017OLQsOhyIaJgcgAaM869MAevsM3BY3
    d1fclEferufy9p+YU8bwWHpxU5jjp0yPw25muvT2Gh87UCVhaNamTZxDDLtS5KSJDovi/R
    HQR+R/RtXFDQ92u2zEpzDE8PFk5ShAoJsnADAt9jfxfA1T6W+bMaaS3sQRaA
X-ME-Proxy: <xmx:q3zfaiKzqXFyxoQU5MQnoO-Z18zr1NstxgGwX1sY2boxzzepxJz7yw>
    <xmx:q3zfavjkdAOWzJznQ6ivWEryznH4SRAkhmqg1qsvLhI9_YvX28OdvA>
    <xmx:q3zfai40Sb6sLNzVe2euWmvoBJZW3Q3jaP0VgLAJl3FpvTuLWfH7WQ>
    <xmx:q3zfanYeh2s7hwXQC_ErBCxH9X9rfg-sKg39bkl_eWdnbKQfC9dUDQ>
    <xmx:q3zfarqAJwGG9ty4tT4gGEXOBuknm_LTbTlSlhm5mdt30rNJKiOhIPLK>
Feedback-ID: if8114916:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:15:38 -0400 (EDT)
Message-ID: <35a6296a-332a-4e7e-a199-26b99602caed@kumba.dev>
Date: Mon, 26 Oct 2026 12:14:59 -0400
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rtc: ds1685: power-off fixes
To: Imre Kaloz <kaloz@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013094930.574-1-kaloz@kernel.org>
Content-Language: en-US
From: Joshua Kinard <linux@kumba.dev>
In-Reply-To: <20261013094930.574-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/2026 05:49, Imre Kaloz wrote:
> Two fixes for ds1685_rtc_poweroff(), on SGI O2 and Octane machines.
> 
> Patch 1 arms the wake-up alarm only if an alarm is set, so that stale
> alarm registers no longer power the machine back on.
> 
> Patch 2 repeats the PAB write, clearing the kickstart and wake-up
> flags with it, until power is removed.
> 
> Patch 1 was tested on an O2, patch 2 on an Octane.
> 
> Imre Kaloz (2):
>    rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is
>      set
>    rtc: ds1685: keep setting PAB until power is removed
> 
>   drivers/rtc/rtc-ds1685.c | 38 +++++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

Both of these look good.  I am unable to test them right now, but it sounds 
like the second patch might fix the sporadic issue of an Octane sometimes 
not powering off.

Thanks!

Acked-by: Joshua Kinard <linux@kumba.dev>

