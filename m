Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609682;
	b=KI/zwUWNWYErFtZi55Mqg8E8kOyAN2s2kIQ4S6E4KmLAf7CG6OsRo7afdUfWtY7Ur96K
	 HUmryN0Tvr1SOe6IO1m/Q6lljE2w5XATPgP0dsTff4MZ+pikYQUGGJhf7YETIdckSxr9j
	 SfSXaDfVLONpQJDopx7uHxY6MqI5Wc6bYYMZZpTbEnWGZACF2qGTCH/Im0EMs56wt04MX
	 hv0VB41c73PcesiMCp1asVELkkV5w+8eycOdFSWj4xeX+7a1ZZP8kZVzx+oRcziENxxjz
	 b0TUIQQGHXFcEVxugFKmEUd0AwZWbC2v4yxXAIehbutGXJjqmSaGG8YUW7b/e1RdnCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609682;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pd8+LvCn/fTQJItd5fAc+3GdEOtY8sMMAXYAkzOCV0c=;
	b=dmDeP/UflfMbHG3ByoWCepJ60/mlV7JtPGQh9FCty3VV1cJTGKVFnDVFgQ72UZ92SZ24
	 Rx/6ozGQyAiw7z38CivpMEXsfzG0JATeUJ9nbjyv1LhgCFU5GzziKXQboIw7ehElXyJbv
	 M/detjZKkHJdolOuApUP54VOMv0/X0vHR69NU2bcgyLHXkf1t+K9sSssPxJqTGopWRqiJ
	 iOHzxKxnV21Ugpm8HEUoQtkkQX8/E3AXzg6Q6NYRnxrs2O8DFqFWJit/q2gQkmcFx695k
	 ivAHRW69eIg5IzdJhXQUStM09xdFNzgR/HsGLjyv0bojyDohvng4p0sI8VAPwKXC6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+QX0kEz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485E606A541
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+QX0kEz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F20B1F000C4;
	Fri, 13 Nov 2026 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609682;
	bh=Pd8+LvCn/fTQJItd5fAc+3GdEOtY8sMMAXYAkzOCV0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+QX0kEzzNTmDI0r1uR9Kx0nGznjkDTu7UWbR6dgYO6FvlXv9NXyyTtY//1Rw0fS5
	 JjPF9KLYApaIc049EP0AshulK/6hfMG79QB3F6AkdGWdQSVjh7rYMEGvsVbiJ/tFl+
	 BgX0zUE1QwSX12BH6q2DxuI89q4X0mzW1jqRhZD4yP7FNN8vZur35QDMzIQQjyBXIR
	 Hw7z0HcebWdlMuqAEFHXnwyBAjeHqB/GEnCkKZY9W58CenVBHobtzBr4F8M5JOrgl3
	 GqmajSDDtyxNhn1RPIelChH0diHiL2pMomgbubL7OZWIZbe4arpkI5ptXP7aPpBcO2
	 sdpBxLL1+setA==
Message-ID: <sashiko-outbox-213835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/19] riscv: dts: allwinner: add the Allwinner V861 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-16-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-16-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:41:21 +0000
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
> Add the V861 SoC with its two C907 harts, PLIC, CLINT, clock
> controllers, RTC, pin controllers and UART0.
>=20
> The cache geometry and PMU events come from the V861 and C907 manuals.
> Zcb, Zbkc and Zvfh were also checked to work on the hardware.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D16

