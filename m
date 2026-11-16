Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854966;
	b=iXovnX15PtddsIi9bRCqe/2vq+Nwrgun++UCFKZbWEZjWV4fyROJGHy813BjJQLHkg4D
	 Yl1LrpvAb6UCqC88BCUpdAk0/9rWCAqW84EjUS4Ngngf80BSwqBovr+lH969Z/FmOKndE
	 s1EyzD4zN62BS+nr9N/tUR41/bQoCbR6N6WLXnJe4RuNW8J69AVWEx/2jZk4M3BhkI6Zf
	 fshW2/57uQvrBmsoNJgEExOU9++l4sfhSU5Tuv9mQJC9wdZTzYIEivxYQardA+9iVaijm
	 8XIb8+e6TFdoE2BzTy/Z9t/RIkoD8i3er7WbIKTnQz/qcZ+dFvf+5AXkc7TDiwwAeKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5m+lyqj0ejLH3bdOs9tcHuPHmUx9AHy8cl5yBJ7IxXk=;
	b=qWuhz7Id4ZHB/9lwb+rmiPMgC6p5YLuQavdVZwujlMh39Ap/ao6sEyOHl2YkquXH2BAC
	 kre0oFPIStKO3eJ+LD9cb6y6XlZNwANHzwiFzMl0IT5c+0FKKe17JQATtLta5yFkzfdIC
	 f+1/EJvZ99um/xq8Yx/n46Zmm6d0Wp+E2Zu0rx039zVTdjuYjsGD9p1P6CyLKJ+dlePTU
	 49RVzqA6AvLrrvQgm9F7FA017jMSVIg2v9/4YSjL/NL33cWaiXGxA6JyT41RSAJ2WaTGp
	 sMrlGhw4pq+Up1Zed5KnctuQjR/DEVuq2Bcqa7FBTLGpHMEClfcrQRi0sEy5JtzI9AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCSRmEKx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F4606A31C;
	Mon, 16 Nov 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCSRmEKx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE61F000C4;
	Mon, 16 Nov 2026 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794854966;
	bh=5m+lyqj0ejLH3bdOs9tcHuPHmUx9AHy8cl5yBJ7IxXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCSRmEKx5/6xB7zYb6WppC4BRS5LN1oIpKV64LGYvSV+ZydEJ+Q6Dl7ewO0pRH8Tj
	 79y3j2mhZODiB9wHnDMk1ZNng+xPBprR3yveEklU4kspqCLZFdkkFEc+BlcbkUBuAN
	 MdHkwg3j02idHmwhNAOPRUsh3AG+awJpUIDo1CofkjJ+JElHmTWRV5jyTtKW0B5rNJ
	 cNJuRLD7GiiBwYjZgdF/XHVIXk1nOmm6GXSs9JtU+b90mdlwtiTzsQ9MmnfaL1wu/r
	 0RuK97gBJJLWEuh5EeOFhZlJA8ZGydhx54AoLyHiBQI6suH6mhPFpKjCUjfFW1pHc+
	 jtqVgscPfhFuw==
Message-ID: <sashiko-outbox-217514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] rtc: mt6397: rename the write trigger register
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-1-179145eb7e89@gmail.com>
References: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
 <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-1-179145eb7e89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:49:25 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> struct mtk_rtc_data holds the offset of the register that commits RTC
> writes, in a member called wrtgr after the register's datasheet name.
> Call it write_trigger_reg, so that the next member, the control
> register's offset, can be named the same way.
>=20
> No functional change.
>=20
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com?part=3D1

