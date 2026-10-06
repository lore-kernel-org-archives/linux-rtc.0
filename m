Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75040A929
	for <linux-rtc@vger.kernel.org>; Tue,  6 Oct 2026 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290062; cv=none; b=O0JNMh3Y9tq9u2opzsCVfJAIMlkYpHDo/LPfhOBaQeyLLJV2H5XQqYmMTpsohyATKk8vSIcRX8DlemqZQ+wrGfmuyEBS6l34KvVjJjXQGujENj+iPJ+eJl60pIuFSOyZwQTjl6gXIibrWZDvtgpGkjLXlzFFdZ+NowTqSBBfZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290062; c=relaxed/simple;
	bh=9ctN73TGCjWxiv4YlXHJU1PdzvATsPWWSGxUdUkbdYI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RP0lqi7tlb10lnDzM56U8YGiRkzz02hQWC8rJxAdL5CSCnvwYLmbOZREU4XhlyWS6jE26cgo+exwFFqJ7e/6xLgLqnvEIBEsEhViPVb17Qty990zkgmce4QoX4z05+5a0XAx33siXEY6+anoggpRswmBBiOnkK3dhhxW0koZ5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lmT4PeCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OssAzv/e; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lmT4PeCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OssAzv/e"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57BD77A017A
	for <linux-rtc@vger.kernel.org>; Tue,  6 Oct 2026 08:34:11 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 06 Oct 2026 08:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791290048;
	 x=1791376448; bh=hkIuxcqcXk0pW1RoPdYLN7kYT4Z6JkXVfbeMoVWxw6w=; b=
	lmT4PeCDrFlnofGZ4PBEDIFUMZNzpp8rG7og00jC9m9ETbkxtbj9wptM40vdFTUy
	Cc/ZAV67esA7KcaDwcq3Nrw4/f8Hug8snlFtzBJHnPj1jM+OiLjuJCLB3CAyG+0Q
	S4xd2fybHWdzQIOJ2/p9lCOJBC2LJhWP6n0GPfh+c+Qi4pkX3z/l9M1SbMsvfTAq
	vtOW84Q1+CGOJpCToWBFtlhhC010mCXLdX+VPUHwzjW4S9bDN41g4xC9DlzgfWc+
	s3ls1lCQ+aqy6FZgEEJBwwSvrv6wXGsCiqaseaO4ATJgo9au8BTTROHg18V5rsuC
	vlqfs8RVtKbzJVhbqhpLRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791290048; x=
	1791376448; bh=hkIuxcqcXk0pW1RoPdYLN7kYT4Z6JkXVfbeMoVWxw6w=; b=O
	ssAzv/eSSgda+pz9KkkreDIc9XV3fkAVwpMo3Z3Zt1D56RfEVx8w0CpYVNoEEVyC
	NVvejob2+crWMm47b6GpPmfFpMevFoaK6BQxa4vOXDDGuR33BnO0RjwlXevzfG2e
	s4thV3qd0yqDGuVu/PbMv2r47NHfg8WSb1zTljkuI4kpJo8J25s028vNeLXEII2E
	FPrUthW0Rwya5cwlGZ8FqwozeRBS4RsDS1vk/MKbOB1SCI3tRqQgy+BxjNbbJSwe
	mT9ZrQ+liMnMwFmF8X+D1DvFNWwF4vwcdtjaxMCW0wX5SKjVJrF6/huakqQadba0
	sQLh1tdK5DrdO0N0fONMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791290048; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:R/ZcSJGoK2DIGcupd7ZRZc6/D0alrf9zNYAFViAKhRZWgz0
	aGjbWOz+9rCUuRmIXBExyWNoDcHfzGi6gfB/h68hTD1rEFN1uAjEY/YqrF/G41GC
	1IuWWV4L1ITW4Zvkb9mM1qqmTiOmilMCWYSQ8MguD/R4mK5mhZtLQmQ5K6wxbedo
	uFz8T22UCV9SgKV5F59+PdTfKpvclp6XtTlJAMCl0g+taLpQjoJD9Ngw6EIPy1px
	5hGocFeGXcNI0EiTMK3BVVgroU8RIjQgvul3BQTnSZVJ1yl9JDwh3RQ+ECalopjr
	lgItnqVE+iFTDyzpVuTQLhHftfYOhQXdFMzRaOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OgKf3LlVZ2IcwVn02qzWo3jRGu3vyQrO4/N+iq/uEqA=:9ctN73TGCjWxiv4YlXHJU1PdzvATsPWWSGxUdUkbdYI=;
X-ME-Sender: <xms:vurEau4W-GVGs5GKKb4aPU8yRXIE_spPsuRUuBmpnTnOiU5gC5b6qw>
    <xme:vurEaitrMrJqt2iiBTGiSX5kMCcxX104mbIXiJ8k5YlPBHqdR_iK8LwgeJZ6HoroL
    sRcMGvHUeFtxO1MdTuRpwxJxLxsz8qLssJ4pDwbL8FbtNEO80T4oCvdvA>
X-ME-Proxy-Cause: dmFkZTEapourW3Q5EdHjUkgnrE/J6kkwZGn/UfF1O+8cWVux1TWFiaqNkq9N45TtdTFu3u
    SINqCFn1Oq1xhezdWmyiyGJcCWf+Ccx+rqWlOfBxtDpvzpfBB0QZKgEcKyop8fU3OHsWOu
    gcLqtfNRvSq0Li7jyc9azj+tT/344IHsp+8Q89VUIGMMfvfBKJxcIISpHVWpmbkJoNQ1Wi
    K1lMCXV+yC0k3wDEcRZmflvwEj06geJw0DdfPU+BRgWhiqc0+WP8oV5zJL5jp2CtAUcx4W
    iK5Si/mUmhZh/GcgC1XljN/wmPhIUCx8RvIz8tNPDqb1UBR4KUlfMu9hdnX+USsRUB7UgI
    TXXQ1yl2TEcvVi0Z3YYYbD6m/4R4GH6aFw999OuzQdDSBF/wYFt9KYKfQgAhP9T8oMlbA7
    L2TMgOBJiA5G4CVOT6rhFj/8UYA4CS6i0MQgbnoIwjX6k/hdb272nCjzSBezj6S4Mr8U7V
    /OlDLr+N+LsIh6Jq6K4eCSi4h1leatolW11h1LJTe7Fz0hp+J+G50D3uTx7b34O94kGOhU
    vVut0zQEJ5dA+5Oi2RrLZdP3xa2ppfi0ti++aOmCwt2MBOdfr0WFVeoF4H8FExWHPE/PO3
    rpCpIAs/cmQbmH+VC5yTmnVEcbyW8wEZeWdfvnnfXwsyPfM4gqR2ZR7CJAmA
X-ME-Proxy: <xmx:v-rEalh_OnRD-O3zwvZJXRdCzFmFFU9AA9Ss4alN5vQKD3GlZMFaQg>
    <xmx:v-rEaleWBw_8SjXLdtnEjXAvPl12Pquw9djjaIc-Uwo29axA2-4XsQ>
    <xmx:v-rEaolAbMk8Ild5V7wwxoBRXX1HHlZZgTm3_qLkjsJ23ykL69HdMQ>
    <xmx:v-rEaut2i2wHbPJphixOHSAcjfQZp025AK2-8VkIuqtkUN7sOGHtYA>
    <xmx:wOrEamfIe8IF_evoymfMg0o3LzJP6WIZu_5hxFWPpURk14kJeS9j0e5m>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7F98132A008E; Tue,  6 Oct 2026 08:34:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDcdGHCsDIN
Date: Tue, 06 Oct 2026 14:33:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc: "Karl Mehltretter" <kmehltretter@gmail.com>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d07b4229-a5f8-47fc-9b1c-c4a7096959b4@app.fastmail.com>
In-Reply-To: <202610051349454ed35b56@mail.local>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
 <aq3R5QnCpu_fOq8g@gmail.com>
 <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
 <202609222137059e745547@mail.local>
 <d7825e87-93f2-4444-bf3b-45a4127de7a9@app.fastmail.com>
 <202610051349454ed35b56@mail.local>
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 5, 2026, at 15:49, Alexandre Belloni wrote:
> On 24/09/2026 17:07:30+0200, Arnd Bergmann wrote:
>> On Tue, Sep 22, 2026, at 23:37, Alexandre Belloni wrote:
>> 
>> Not sure what exactly you are suggesting here. Do you mean we should
>> try again to address this in systemd in order to no longer need
>> the RTC_HCTOSYS hack?
>> 
>
> Well I guess we'll get the same answer that this is too late in the boot
> process.

Right

> My proposed solution is to have a way to tell the kernel what size of
> time_t userspace actually supports as there is no way to automatically
> detect it. That's why I was thinking a kernel cmdline parameter would
> fit. This would allow us to be 100% correct.
>
> Else, I'm fine with your last proposal.

Ok, thanks!

A command line argument would work for me as well, if we can make it
have a working default for the COMPAT_32BIT_TIME=n case.

We could of course combine a compile-time and boot-time flag, but
there should not be any need for that.

> I guess this would leave us with
> two unhandled cases:
>  - 64bit systems with 32 bit userspace that you said we don't want to
>    support

Right, as far as I'm concerned this has always done what I want,
so no need to change it.

>  - 32bit systems with 64bit time_t userspace that would not work
>    properly with the default configuration.

At this point it's just part of the platform defconfig, and
users can pick the setting.

       Arnd
