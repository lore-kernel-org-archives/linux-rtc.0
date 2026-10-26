Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031426;
	b=m6dZxilGpSpGLk7DzaozWLSJIHqFBWv89gtNZkk/0dlibgpsQEb35IuW8cE0vOP0Mpd/
	 7tPv/PeaGNOp9tFSzsvch8xq2ZfU7T9e6ASpxrgb14xad0UKI88CbT9EUp+LAHa9Qv32H
	 otrNlOuiFc7zCIM2AYaIR3PBXT+Nw9mMFv57Ryriao7DPPuEgj7ruFZkaTwPbB0L/K9IH
	 oqCPD6FhKESbBFZ6ya34xSrCNMMTqyADHgkpAfh+JTDfliW3b0OwT/Ma0vKtBCXloTMJX
	 7QjZTK1mvOuJL+VKrBhqMeWhW4IQ08el5n3Ef7FT9ukf2znzuSaBTsAFyCTst8A7ogQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031426;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=srkU2v3Br0viqOwaNOnir8iz49640FCtGuElxRkll18=;
	b=qqFqVju5YlU3OSAORzWp/8LMeFPpaBYv+gdTl7G5LYZuvM2vh389pPGwEo4C50VU8oYZ
	 7re3XqgdmLYLEmZAKKgAS4TAp1h4+cDBtJMNzqNJPxVMVEWOSayyztcadnBf2MrclIyGH
	 aa7ssQr5IxdacySVXyjsLRyr6s+1sQLOc5EzMxS74xKj4yEpKEegYD5JBaMW1/VxD0dHz
	 1fjFKn7DqREEODKUY/UoEOxwr02jLGFxiXtXYHNpvFpWDYV2rc5Ch/vRZ3NN4NXmo6Y/F
	 Ergm+bd+BKXmFgq497I2JVM6TMZK5DgPH/joLyIIk2Ngrc8bd/rp23lsfCEhGCmpo3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kumba.dev;
	spf=pass smtp.mailfrom=kumba.dev;
	dkim=pass header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=cuG8BgoT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ADInHUwW;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EB606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 408EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumba.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kumba.dev header.i=@kumba.dev header.a=rsa-sha256 header.s=fm3 header.b=cuG8BgoT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ADInHUwW
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D2341D0035D
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 12:17:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumba.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793031424;
	 x=1793117824; bh=srkU2v3Br0viqOwaNOnir8iz49640FCtGuElxRkll18=; b=
	cuG8BgoTr2WQA8loeOeTA/PamN6Ny4dXWZA6xzS+/jAPYgfh8ovGP0slsEvHRwgY
	ziL/qpnpOK2DHlJV4isCXLds3fKYqQ7PhNRk7Vjcdym9YuyiW4EINUA5bf8B7Tr7
	zpRTqoMOXUQ/ABW4CxHn9eITDDuYddilJf04QDydQWkkWG392pdmmzXTSVu5n2+t
	etkbpiRx58+qOz5XUHSDml/y8X8cnmlwxkTREhe0x9pm0ipAWzyqS7c67HPtyvAn
	SJAxRgVvZpKudjUDmhJzdtb/TWGPJ/nFznXHufZTVHylU2n9vM8RI5lQPtnbi5iZ
	8uKFxRu5tWix8Bp0qXD4NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793031424; x=
	1793117824; bh=srkU2v3Br0viqOwaNOnir8iz49640FCtGuElxRkll18=; b=A
	DInHUwWtSjZxhlZXZeL4Hv77I7rrf6Y0ro2MKAPUCrBbpb2hlO4/pv02ji04+lhn
	nXpaGehkoI801TSYsm3u5+9figIT9y7dVHI+ELk8T6idN9FEQ+uRV17rnfgcjiqc
	44KTx1Njn8kE4RlZIra+YxWloyxV/ywsUu3ueWr2RSW/k+u45xwkUM3ZYeDbX4gH
	AlfSejLUDvMacZ+rjyQ96pcG23ZYTGMIWsI01sC+wHw2GFeZrilvDieqaY/xC6Fe
	+2r0Zz1MtT7EIokOedJNkzAqr/1F8y+9H1ItXTsCrWVbmuv/9DUfRP3HjlV99pT7
	6O87hSfYnN1pSwQUlKbWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kumba.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793031424; d=kumba.dev;
	mf=PGxpbnV4QGt1bWJhLmRldj4=;
	rt=PGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:WNzc7rVW6/qTExiuN3RI9TBEbzEwZjqFDy0BVtGKuduLSY4
	RIBHs5jZwkE7GF8L/hP3Sp4u48KYMfMCeBaybmEMETukw3llvAf7WNx39NI7FdmD
	lcypgR7GipNaLEqIAyO3EzYIzfSCDkCRUbA0zYoqWmfay0K8iXlN+/O/CNKK/Xyt
	tLuCxqykVsjSHuM5n4VhnFHS6PGmOPrU4mjCbXIfnj5UO6UqMM6sGPIaosKqVx4o
	Bna9Bgo/YdbWoXZPVP5ykw3U3KlKkymvoW9rH2XKbDksJgwxnV9nM/nvu/rU3XDF
	miC9XQu2jGGtU7owf+dc44DORx2hrwAEMheUYPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Mnj3iH2giFJ+jkin7jWV1xKAtAgetCzU0VWqRAduOBw=:1kzjDnlE5BejBrhvK1fR3wsneJAXnU0a7W8+caIwc4c=;
X-ME-Sender: <xms:AH3falxCx7f4bJm_C8YzDm_Bpq3B700ENc3L_yTWJN8ulpSn9jeWng>
    <xme:AH3fatBsECPT4-wJ6gU9qJmk41_BHL0tJVs8mM-EyldNeBd_lLfOgOEGQ_mnfcY32
    qOCd2htm0eCrD7R47X-MUKsBVJPjzLQZo1Z33xnlpdaZ8hoW09o-W7C>
X-ME-Received: <xmr:AH3faiaw4sl2eV_NtCoKf5gpQtG3GAvKu91-upRqmDwUQy0kBnXq2KIDPT3fmMiWS7j_ylaukkScFsQD_OfSz-PHtSes5LQEqCnfZXrx97rSLfyEFw>
X-ME-Proxy-Cause: dmFkZTEiBQFO3pu1TLPxZ1eR7AdbEJZBFpVhaJHnp6qHenzvs7GJPYLBV0c5+sF9eRrBel
    24//rypG4sWusaa3NdLUfRVXoQS9/v+dLtBfCHQr/k2LTOjbHTBlUaYirzP6SuhoBVVKtg
    96agq5R/7wUsq7sMkR8h5VwHcKiAUgSo3jh59BCTneAia5+FIKbbDCe4RysCBkizmu9oHS
    3lBrLzdY1haGK6QgYfgm8RM3pnl99mpGxR8iEBlFx0X3CtyMn826PYk2AWVSbkocOkXriq
    VWVh3rwJc1Y4c4Ct1mo5GMlDBPbj+vusdZRf7M8vyqGGutQK1r7r/MrBrlm9wKDdPn+CPj
    Wir8BvOyOgP2Vz6CP7FGcFhK6FLLX7g/G4QBI6v54YupCyNw9pwEHreheEvVPfxNgCJsF7
    qysFWVgc0Avn/WIShvpbSXRAmeKtyPlllU95vtPnNCSX2UAPhCvTxmqNkAMN3GFjmO14rj
    D99Bk9uhZMxH1fYWDsLGQiF0NoDiMGnZkCkG+Ui0nIOGb2ym2kfhdNYtxLZZBdmwxmh0zx
    fMz2CpKhuEIkv1FQHSOW6W99v1s3QsmbhM2+4vO61Xq3eXP+6C5a3483dW1ebyQcec9i3t
    EgRTKJwfTfJRP+2ecy9Us8yMOQIhJzN6hdeDq0kLM3Vo6o3pdcPpEvh5EwMg
X-ME-Proxy: <xmx:AH3falilYAFA1LfPrw301B3D405ImEQnmgaR4V-qtlmBOf1GdsWEmw>
    <xmx:AH3fak6AppXs94sKt6MBhasFXUzUXtf7COfyyT5Egr-BitWI-Q9-rQ>
    <xmx:AH3fas51QZ7dO_KLz_m3Q8nQMVilVywrcz6-CNA9R22HQCwBu0gLQg>
    <xmx:AH3faodKiN3qbJw1XcLEAkmNkUFkiteCX_OOKvIbrHKlJo7QvNfvgQ>
    <xmx:AH3fahkPOGvMJUkQGrrOYgsSqqiuCYvjUx6mvUgpo3zerc7X66rl6p5P>
Feedback-ID: if8114916:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:17:03 -0400 (EDT)
Message-ID: <0f7f53f6-d998-4352-b49b-b99cc31fcfe8@kumba.dev>
Date: Mon, 26 Oct 2026 12:16:25 -0400
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
Subject: Re: [PATCH 08/19] rtc: ds1685: use guard
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-8-alexandre.belloni@bootlin.com>
Content-Language: en-US
From: Joshua Kinard <linux@kumba.dev>
In-Reply-To: <20261019211827.126262-8-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2026 17:18, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Use guard() to simplify locking
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-ds1685.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 5fc8e36b1abf..284815e5f478 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -666,7 +666,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>   	if (unlikely(!rtc))
>   		return IRQ_HANDLED;
>   
> -	rtc_lock(rtc->dev);
> +	guard(rtc_ops)(rtc->dev);
>   
>   	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
>   	ctrlb = rtc->read(rtc, RTC_CTRL_B);
> @@ -711,7 +711,6 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>   		}
>   	}
>   	rtc_update_irq(rtc->dev, num_irqs, events);
> -	rtc_unlock(rtc->dev);
>   
>   	return events ? IRQ_HANDLED : IRQ_NONE;
>   }

Looks reasonable to me.  Thanks!

Acked-by: Joshua Kinard <linux@kumba.dev>

