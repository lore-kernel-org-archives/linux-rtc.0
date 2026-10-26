Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031377;
	b=vSkjE4B0jLyuLXybRyV3j4Y1z5Qx22ZHjPfcboPmuB9cy7uNySezU2gpxRmcicYQwgT6
	 pR8LfzICKfCn4hHU+HXYExghF/TD7QQZupOrRrbmm9lDnEso0n6CZgm9HzFx3+OEGtv/l
	 HJtx2LKQz92os1TkVpogmp5KFFF/qxKD3A4oGB1x2GldgWc52rZSqdTpM15KN138jSRSp
	 VjCKL7pEByjSSM3La2dL+oCOeoxJTha29WUGclYwNuU+1bHs7KbrQPHAPujb6iTDvLlI0
	 FwH5gX0qB4P6Osw1pby4ud1PrvTc06heAOMr15XivPtiEQU3HdGusAY5Eu9M+NJDk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031377;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0nm/zKltl+3JgnGrNgoqTrjeaQdzViSBaGY2KoLrCDI=;
	b=T18GHBMDyez1yQgCaO7XkuNX2k0ZYUhsfkUAQfFEZSqMeoPf3gYtf2v+z07fnpx31yzR
	 hnthbJVDoisp5TrySSfDAbO+xqdR4T8FsOuAwzpb2Wbs6NdUwTaWZOb3Pft0VV/kpUzv0
	 /FfsuubIjI7h2M8D2ysUk5MFhQTX3mSf+R/xmDoWVlyce76B35/PnBS2iYxqyKu4HPVy2
	 we6NHcFZdKOTWqEUIrCa0k77VeG0o/4duJCfPKgMvWR1MFnW3eqbWTVXWDwRbWuQ/YPjV
	 IMLP6e3dQtWjGcd5/c6RnCtkHLjq0EincPG08Tk+Fiq3ih/p8vjabkZlz2njLNKBUUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kumba.dev;
	spf=pass smtp.mailfrom=kumba.dev;
	dkim=pass header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=eOVuREVL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WdkLTGmb;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF8606A31D
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 16:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EF8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumba.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=eOVuREVL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WdkLTGmb
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA0FD7A0401
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 12:16:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumba.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793031375;
	 x=1793117775; bh=0nm/zKltl+3JgnGrNgoqTrjeaQdzViSBaGY2KoLrCDI=; b=
	eOVuREVLSsat2BhOPpgHLnKAvmSaRrV9Ko9WB32ZsZY+T2vRD4jbI9vcOkyZOocU
	eIrfaeroPSlTKKklDjyin71Jy1FSiX6FCWUT5JWmuYOFtkARLZx9UnGlfVy2SKgf
	DHqqzqtrw5Du5EaEW/jwElR0Rq3hECbdSyuJUJq+k1KtfAH7uT6ilxz7bA0qN9Zn
	uix6O4wJTQQnDF7mAyNNhG8IOnz4mTGL1eA+6qL4Wr8MoukDhSMCX6AFWsxHXNm0
	q9f/wku14nGpuaxkaWTekQqmdlTwIOmA0mrxA9isBVf2nn25R0FfJqlIXSI+RMUt
	yfEYMhEyfUfw65JoIm7F2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793031375; x=
	1793117775; bh=0nm/zKltl+3JgnGrNgoqTrjeaQdzViSBaGY2KoLrCDI=; b=W
	dkLTGmbVqe/YsfeX1H9CjBgWu9/6GOEyLLEWk8moimC6LLIKmiFRQXvKj0IFYfzH
	n7T4gWchI0Wm/hgTGO8FkyVXZi8utm7QmLXtgCRc7XBMK/iyEk+b3BUFziLEk5NV
	EsFwDqjS5WmTKV7BFI9euXkychHWMjuU3haP12nNTRNUFxLCb+2vuDt89qEkAYXu
	EoLMcTQXQbTKKk2uNIHsqVWyJbaSZs4s/fsFqWLzSmUDQKwoy4VItkiCoTUG/2we
	btZcd+LR5P+hxCXaBsKIMGBJ1xBQfYvHkQk81jOtgzos8XWi2GLGTbGThzMtSL9j
	L7UkPdl3DuzqNXsh1T5lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kumba.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793031375; d=kumba.dev;
	mf=PGxpbnV4QGt1bWJhLmRldj4=;
	rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JPLus5u8zcOFpEtcEj+TWYGXPpdrznEc1VrM8XCu1DX1y9q
	13wRFr/kaakWX4nYJ8rKPEXtWP8SBa0Ok4+XGzU4yIWqs0HiSRMcMVEY6BeXvUDE
	5KhnLk6BHdaeguRYBTGX0xUf+Ovb7dDkTFoZPO90b/OtTEFbTJdwpXiJmH0VvW3S
	QS/sdM3H6K/DRpVbLFjSXYZ8O9Uo5PkXf/o1mOV26ACqm0wBlS5drCvpn6837TQ3
	4iYkcbka6QPKTJdfNOutke/fOMjUUC0GKd9rUNgslX5oxvHBFV0H5wC0axvoMmIh
	RsdCmljXygEEHLU3vQnpk8HTIqY160qBbA7wDLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CGNC7+wGguARpk4ZpPjQaVDtzqXyoGtqR9pUvgOtgKQ=:cWvI74xUxpl/aF0NF/OTEuespHFD3g/VECtKUF9q5gc=;
X-ME-Sender: <xms:z3zfaiBdEaPIvI1Aw0sRp2RliHy4KW7O_3oh1GWEcFspNecqthsEyw>
    <xme:z3zfaqV0r3p5HzIyka2TGyb7EAM10352VvmNfX5JyJR-lX7ETOs-ibA_lTvSMgEIf
    sv_XpD0P9VSwKE3k82539xzC_0t0fEzARbNkaoxQk5TBetBy8njUg>
X-ME-Received: <xmr:z3zfagAe3iqT4oegezmKo6BzWM-bPny2m-mJLuNlYNgfLxhq2pNASp-Up4peqnupRi5KeLTfGNy23yJ6OuxeAKFuOJ0p8WrI_7Ldc0FhIqQ27WaXhA>
X-ME-Proxy-Cause: dmFkZTF0Wl5oyMHxOZCStGaRgNPPgT5ZrY97mT/gl5aLuoGxW8UmvEz3iaSUCvnjEWfdcu
    ZE5rCbhb4WSEftdLdluPknJE6vEmp706voyY7pgGltDFrQPp/7+wKmdoFqmIS9ae+wy3p2
    +SEK3Cbdx9STsF6xuPWMvY3GD5ypAYC34pMTGuQRz/ALQUiE7kDHugRBAquyZhjE7PNs5R
    ci4gOGCyPnJSuAnKGgHlEtNLmVj6qRiUTDxs9TG1yfalDm2OC6UK7fPOYsuTdTiA0ovIvp
    HZjpq1DW7uG0rE4/OA2nlR75cggDf7p1dqSD4SoXTzi41mKqncIc4LLOpEa4k9RYayX+Cq
    uHTtL2CPkNxjY+NHEW8sXx6lCs2duHPymmfjIi1Ge+VCitFrlXIjeGYQEMZ4ue5lEaZpZe
    pRz7QOcS6GL2Z0MK/K4HH9I68+XyZPZ1na0dtQ8xuPAD6YFF1DwhKKZMoBFnA3NTHUs3FB
    BTtmbLPY88sjs/Jv4rCQMZPyoS6ZO1Tnlzh5ZdFhDNG72MlQSOjFlIWfNtl2GXvaoFjqRG
    0rR00TfHgldcCIRIj4QEGqlUreIADR2dKmK3WJ46+SgmgUDipxrKAlc7jYT2bek899kG8p
    Kcoa/QTkxl6tUbTV2biyfTkMFxyVUIXtCyKNy80LEK3vwq7uqCPIXDfTmlqw
X-ME-Proxy: <xmx:z3zfat8THca3N8aRuxH_ffUOcrSLgRwB5rOZ8EK6S4caXE6zwRit7Q>
    <xmx:z3zfanHjurV0TMDaXZeL0xVuFG4Veb_LcpfIBwDeHfyJzYDaYVv6Ow>
    <xmx:z3zfarNDQw4jpMi9of5AYHSOehlvuiPqNv6utfqX-nvPCP8RWQSIGg>
    <xmx:z3zfahc4jcfgu6GdrqfZIE1moGkB4Y2ZtzA5lsS1TOpGeCC7OVm3Bw>
    <xmx:z3zfapV-6Pyb5HBVo8f0D3vPQVEAurkwMvzSEiMSPwI3lPf_qM-NBC4l>
Feedback-ID: if8114916:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:16:14 -0400 (EDT)
Message-ID: <c5319ccd-162a-4fe5-ad9f-046f6aad0c1f@kumba.dev>
Date: Mon, 26 Oct 2026 12:15:35 -0400
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
Subject: Re: [PATCH v2 0/3] rtc: ds1685: power-off fixes
To: Imre Kaloz <kaloz@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013120208.11268-1-kaloz@kernel.org>
Content-Language: en-US
From: Joshua Kinard <linux@kumba.dev>
In-Reply-To: <20261013120208.11268-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/2026 08:02, Imre Kaloz wrote:
> Three fixes for ds1685_rtc_poweroff(), on SGI O2 and Octane machines.
> 
> Patch 1 arms the wake-up alarm only if an alarm is set, so that stale
> alarm registers no longer power the machine back on.
> 
> Patch 2 replaces the sleep before the PAB write with a busy wait, as
> power-off handlers must not sleep.
> 
> Patch 3 repeats the PAB write, clearing the kickstart and wake-up
> flags with it, until power is removed.
> 
> Patch 1 was tested on an O2, and the whole series on an Octane.
> 
> Changes in v2:
> - New patch 2: use mdelay() instead of msleep() before the PAB write.
> - Patch 3 (v1 patch 2): use mdelay() instead of msleep() in the
>    repeat loop.
> 
> v1: https://lore.kernel.org/all/20261013094930.574-1-kaloz@kernel.org/
> 
> Imre Kaloz (3):
>    rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is
>      set
>    rtc: ds1685: do not sleep in the power-off handler
>    rtc: ds1685: keep setting PAB until power is removed
> 
>   drivers/rtc/rtc-ds1685.c | 40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

Whoops, I meant to ACK this thread, not the older one!

Acked-by: Joshua Kinard <linux@kumba.dev>

