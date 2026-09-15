Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2443F8CB;
	Tue, 15 Sep 2026 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451318; cv=none; b=s9XYexTUyrb2adbj+ynlvJH6Yje3LzQd8gAP4aKbHTeizGULHdnN2sadUT0O1sAD/YOfhYB+Nstob/zTyr/kbEsKSEASEnxJmJ7wiPFkjJkwvcI4Mo2MXL0e/vp9bZ2gD8BQlEv5ET/DRlWlIjJpaBR4kfiJaYrRk1Dd4J6isa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451318; c=relaxed/simple;
	bh=2YdqfE4W/M6GWy2Z93LWlX8redjhoSEzxzkkdSHgm5M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EaDu2OZgehEMzp9xWA2Tz/ki0sFQP6I+ikxZAv0kG/Sattjp6X/SrLoXE3M+g6L87eEqwY98oWcU6qPz8HtX2PVmpYUJFvo399BXSfON5mavm5swLYrWIfOlN2h6HlmZ6/EnwasQx6R7gBAJvmFQa91ctMW4rktlNPE4wVI9axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MZrdwxAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVrSd2ol; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MZrdwxAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVrSd2ol"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B47C14001A6;
	Tue, 15 Sep 2026 01:48:35 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 15 Sep 2026 01:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789451314;
	 x=1789537714; bh=FI+a7IE4f2WsMNjssnCOFfk93UX5wc9at6Jt16362O8=; b=
	MZrdwxAmf89L10jIxTJh+HqypSX5ohH7OevL4s61XA22Ewrg0OBiJgI0RhwH8JMz
	htthIMgPKdkNKXKrlxM5lPDHAelwuHrAkapFTa/toZnbY/hVo7bmPX4b32/dAg1w
	HwZhBuwpKm8hK0cXig917SitHsTw+R22RpwRJkiJHtxwcKz6DwCEVdD2phGRFCl7
	F59rwNd0WKoCEaWxt8QsN+CspfDCOt69TukzwnxOt0PWa1Lgi/+x3+9Z03ZAfGpq
	8zzLBxSx+WKSn1/mAbU1tHt1wnHdtiyvR2sI8KEO6yHe6p3XVfEzinP8yXWI3rji
	UuiS0S7NTjbH0uOloS1n1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789451314; x=
	1789537714; bh=FI+a7IE4f2WsMNjssnCOFfk93UX5wc9at6Jt16362O8=; b=g
	VrSd2olYLSvAPHeojHLV0nz4sNNJh7pulTu0C9VKjj92ricB895+QlfwoX/Twcc0
	KfVqyicP1j2U1WjpHgaFVsxH1ujL9Ac27uhuIheOypkM/r3zx6w84iI1m4ak/mn8
	5jbRnM14I8pLCKN2J1GS2uqw11fhCmN9ZJezocMz3K+V/bndwY5tMAdikyB7ghbw
	MFjw8r5zBmaYCzhgVE1JK6YL/9mW+lC+bI9cUChcoG2H/Vk5A+Q1Q56kwZkhqbcF
	iTJcw9QNXmp3/AKcS9ZtpG38EbV/KVT+7Xpa6idqAsbUCKy70YABiUnwopsvhvEt
	DGsBKO7K/oeVuvnxBj5pw==
X-ME-Sender: <xms:MNyoapToh2O4UE3P0-oRUXoUFGdmw0OIrpZDIRtaYc1zr7NI7xaUpw>
    <xme:MNyoatnS0Re5z6myOAiNWNDU4n0I0pTWAO9dfu2n-mVByf7HP1SaCW5wtTtbuyWmQ
    MNED5KuFFKgZ879ShGS23ExGKdQ12_RikYvfxjS3Enczp5Ex3w6IntX>
X-ME-Proxy-Cause: dmFkZTG4jI5J0ajg+XHjiAO7uRJKuaLRxoNRzWZeGjSA+XiarCh3hJ8cBQpGVABbQdqksE
    Ge5NbNjmWENILRmgWK4AkF7CHEnag7xyAQTSpWmhVc/tPmWAiUy092lgs1Jodmg8mgDobh
    Zxcn6Nb/o4rZNGZYmyGsriqyk5g+/6AIDhvMibzyMK1oSR1rqoOLJNCq11zwQJI71h6Clq
    KQq4nzmUfl7uVSzToozTmHq7mr3G/s32n2yvMVqYP+QwZH/VnaJO5oRWAQYbNEll//vc/7
    OXA1rIx2qkQlv7P3wsi+peyO1WE3NXI648RlafHrcfC/6rOtVu2Il5E/Lvifx2Fs/s5nTK
    NTTj/P0W/ghavgz5IjP4+UJ4M9C2JX1R6GROkcbyo/eNOfl6hmB6QDl2np7osnG4u5hR7K
    5T9ZruuiWzhCcjfvQZuyCmJB07/FH2wnoLL74ZWgedBbpLya5mA03WfEPUE6GqnxDO/jBO
    JI/2gjjmHxUareOxr0Np3rnfRhk8N0B1GzgDJxLperbEPrL9csXx+mVsiQFwTG7J4cgreg
    YZx7nWmpeUkvy6ypQfc/HsJjMAcyE527ahDaXcii6nCJhVA92Z291IzHIFidhQQ/9sWgMS
    OqSEcwLGwMjgrLH1/dvmmiKyDjHWuYMAwfx+b+jQZgp1Md3J4YH9n8UOj36Q
X-ME-Proxy: <xmx:Mdyoag5Gdg6laD94qlR7Bdtpp4K-Y6q_6jpN3RK8CzSWGFamvJqMTA>
    <xmx:MdyoatW1ynLqa3xohSqSRKO_DUsDcRVdhbWr4HxHOSdQeN_MNhLh9g>
    <xmx:Mdyoai_d893CzABPOUcoLqbyc8Lon8IVGIzSSmI1BJNf3i9BgumN3w>
    <xmx:MdyoaplNDl6mDcF2VfYBegmhr9Z5AKlL9he0l-VnqgJ25pa-C2Gd3A>
    <xmx:MtyoarU9V6relRrxq1dvsx5EjPpANCWhpTlNs5Md1jNl_lMXb87QKY8P>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A332E32A007E; Tue, 15 Sep 2026 01:48:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDcdGHCsDIN
Date: Tue, 15 Sep 2026 07:48:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
In-Reply-To: <20260914212537.1452-1-kmehltretter@gmail.com>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 14, 2026, at 23:25, Karl Mehltretter wrote:
> On 32-bit systems with RTC_HCTOSYS enabled, rtc_hctosys() rejects
> RTC dates whose seconds value exceeds INT_MAX, even when userspace
> uses a 64-bit time_t. This leaves system time uninitialized by the RTC.
>
> Commit b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
> time_t") introduced this limit to protect time32 userspace from future
> RTC dates that can break boot. The same limit prevents systems with
> time64 userspace from initializing the clock from valid post-2038 dates.

Hi Karl,

Thanks for revisiting this!

> Add RTC_HCTOSYS_TIME32_LIMIT for 32-bit kernels, defaulting to y to
> preserve the existing safeguard. Allow integrators to disable it once
> their entire userspace, including init, supports post-2038 dates.
> Warn on rejection with the RTC date and option name so users can
> identify the cause and find the setting.
>
> Keep the option independent of COMPAT_32BIT_TIME. Userspace with a
> 64-bit time_t may still need legacy syscalls for operations that do
> not represent post-2038 dates.

What about the reverse: if COMPAT_32BIT_TIME is disabled, I don't
see why we'd want to allow turning this on, so maybe

+config RTC_HCTOSYS_TIME32_LIMIT
+	bool "Reject RTC dates after the 2038 cutoff"
+	depends on RTC_HCTOSYS && !64BIT && !COMPAT_32BIT_TIME

[Technically it would also make sense to enable the option on 64-bit
kernels running 32-bit userspace, which some users do to reduce
memory usage. However, we never supported that case and I'd rather
not start now.]

      Arnd
