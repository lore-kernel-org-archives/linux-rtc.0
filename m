Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609448;
	b=j/raKCGtTV+s/QeTXRENowcUXtHUezqFf1KACzqrY+0WJLZMASy5ubF5FaffVHC3qJm4
	 lfSXAlcQ1JDvBAoH7r/scjqDzV62kDGQjcBtr7JoNvpqR6d0LWtILewmbPlOPNM/EKJCA
	 GBAjhoTktp6PzgR6TTegECD/lridn9xTyXeQ+k5aP24BApnnMY2MxWhQk0mXDUd1DKAM9
	 ba3u7z0TU++NXoGhM/Z2NO7ScvrJOI30zb70kmeZVpdtjAaduFl1ldcxog/d1DLeoUnpM
	 eWOy8ledmHqcISAbeViNivBsV8JWRCEmOJtXKXr9kzyC6Vxxz6+HfL/HMGf2Z/xVn/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=liownonsW0RWZYVP+AHU/wzVSAOaAqZkceq3sRKnKqc=;
	b=bg8GHgPk+xSOqetWBQHQK8cqSE29FsAI2jwptXJCiLoGd9yJJflItBnb55DmDeX0NTRu
	 B3Jdh3J7FPoiMV+aFzEGuViO6nZJ0D2zjwYUzfXlQIiijUHZYrHVH1SiwI/BA5UzgJ6lS
	 K5tBxQc+EE0Q/FvRq+rE8SqzULfrWsfKUrxDkjfCAZsgsc21lBwJG4TQ5qUkkCCiOai2k
	 D/tOPv4lINiJdQQXxLZTowKgbSSu8QFDcJxKi4lG7SRGIONNiUdErut86rlGGnHFnoyzH
	 T7CSz374dd4BBx+Tw8PFWvEiJqKtg0z4Ir5gVmlZbs/V5SQDHVY+JRcQjXW+HLZIcmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmoFcfuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F9606A33F
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmoFcfuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F641F000C4;
	Fri, 13 Nov 2026 22:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609448;
	bh=liownonsW0RWZYVP+AHU/wzVSAOaAqZkceq3sRKnKqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BmoFcfuGa9KhyoZ0373Ckbj7KkZPBGrXDfiZNdM0KzD3KbZ8wN5/mBwqywzKfM/fJ
	 TDyzh6H6/S5dNX4XpLJIVE65hdCCTHZWjs6kHFHvW4JadkUUK4MRJVV0sWjT0dy9SV
	 1JTG61KSouSasKafmRyOyG1DbjXospgv3GBN4BsxzsLIQX7UDPwd1HewysSwPyyctS
	 MKX5jLqqr+BsTVa68EBUP4mgn+uI+KdVShiuXK22bI/DEhA+W5AAWagO8kREP8zH61
	 akr9AgPw/8aHX+6C5MCkD3PFOj0Y+NTanCVfbr/Ok5bpW1vbcDLB8l6xlD2C0IV04n
	 j13w5jlocTvsA==
Message-ID: <sashiko-outbox-213823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/19] dt-bindings: interrupt-controller: add the
 Allwinner V861 PLIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-3-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:37:27 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The V861 uses the XuanTie C900 PLIC implementation, like the D1. Add an
> SoC-specific compatible with "thead,c900-plic" as the fallback.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D3

