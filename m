Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092867;
	b=4FtIrBPgp+id0CvcleF3HuHciguTsNT3w4hZbOVAFo6ZvafJWh0veOyiWhWlJ1HwJ3Zf
	 MXlqXGn4CRHftVPXfMqAIvg7X3KwvhDA3tMTgG33M9UorLsRVx62AwMA7aoQcWtWh9nK/
	 CLwTjIzxGHXfgAWgEnH1AS4Hc4c29AhZAKvKlmQqXTK/nRg54ddUGuPP5Zo9ignf2bvaZ
	 VL095Sua1gd+9+1quKoWlIN5UDjv5fEiOV4xrPJGqlM+QlLpVnWLciaHmKNkgyv3WNxDp
	 VRurLqHzNVPlevcvUPMOUzUdZbFlpUNyyC3bSNMn1hl6o9ef/P0A62+QvIVcnWGy4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lcwwA6pqqkzJbPYCrO3y0/SMRPliECFVCn8LVkSgXdc=;
	b=qkecZSekx0EXLvHfJpr3xhBG0fdmIrktk6IdW6RjWe9lFrYR4Edt4HFTiKUivmn+gNSi
	 pLP/bf3B+7LMWwQChMcY6VtOf/z9LE9/3Q3ysFziBIYfHU4FEUzMTGz2X74vqdLteiw0x
	 wMVJJjWPvqB8aWs0NbVyp8T+MQxBCLf8J25Li+VPecgwEv52G16Z3LhcavVwVcyajDzxp
	 7eHE/V9H+qejCiTsi9XDlQXeKqgcr7EbHDiK8N+MK0/N0y4VLQ8OhOZXliWs5/v4C5d3h
	 N9SMZiQD/BWrZNAkO3rjBUOEW6QnYfDKvRYPF7KTyyu/tnF6twYLXa7yVI39f0WKUXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MePZG7EN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9313606A320
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MePZG7EN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550191F000C4;
	Thu, 19 Nov 2026 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795092867;
	bh=lcwwA6pqqkzJbPYCrO3y0/SMRPliECFVCn8LVkSgXdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MePZG7EN7X5Hmuuc2JcUdc1v9On1qRJl94RP6Yv058LF8DzWLETzwb+/DCJNr+x9K
	 Ap+aEwDpIG6h6Nn12zno6SMmPjmljI6ABvnOusANOU7JfI1hhwmvpckH7Kc7t26xZJ
	 3N4cp7EOlD+IH2bXYrckKV9ZTpAorweWxJJDrbJgV2JWISOUK7bRY/NdH6ixvTXN1w
	 Ft4aT9dANQ/+koIEU0EZAfCWJZfQVJPebf/gFKQODomkfzLAnXJ0iGGHgLGq3Ma226
	 /+IQx1maUMzr2TsIrboF0Ylo3QZNTT+nGjD81FwKiB18smcjlFW1jlpspu32Nm1hm4
	 hkbMHgLKdpQUA==
Message-ID: <sashiko-outbox-223121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Reply-To: sashiko-reviews@lists.linux.dev
To: pjh456 <pengjunhao409@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261119125125.75912-1-pengjunhao409@gmail.com>
References: <20261119125125.75912-1-pengjunhao409@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:54:26 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> VDD is the HYM8563's main supply pin.  Describe it so boards can
> express the regulator feeding the RTC; the property is optional
> because many boards hardwire VDD to an always-on rail.  A side effect
> of describing it is that fw_devlink orders the RTC probe after its
> supply.  The Purple Pi OH board DTS (posted separately) relies on
> that ordering.
>=20
> AI assistance: the supply description was cross-checked against the
> vendor schematic with Gemini 4 Hydrogen (Google AI Studio); the binding
> change and this changelog were drafted with assistance from the
> Qwen3.8 Flash Next and DeepSeek V4.1 Flash language models, driven
> through the OpenCode coding agent, using the HYM8563 datasheet as
> input; the submitter reviewed every line, validated the result with
> dt_binding_check and on the affected board, and takes full
> responsibility for it.
>=20
> Link: https://lore.kernel.org/all/tencent_B11DE1495C3C54CE186ED508E2CE5CE=
41106@qq.com/
> Link: https://lore.kernel.org/all/tencent_9B1CC4BF39DFA325C2B5384EA8B0319=
BAA07@qq.com/
> Signed-off-by: pjh456 <pengjunhao409@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119125125.7591=
2-1-pengjunhao409@gmail.com?part=3D1

