Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471587;
	b=DBr8UMYW4vWbIaaqaTVCNtOlou/wt5Axp3zHJW7uRZW8QRY5o+HlDa0FQAhkE+7ySziZ
	 YGT6sYBex52i2+opcIihQ4KaAY0n2T11DnN67MzKDAwW0T76KKLnR6s1IBDT+oy9I4MPn
	 s6gU2EYGLyPq3OPfw0r12jj9gDdRRsOT4KOpfhI+y5KbC6YEVKEZ68DUSztITQdqSGVeY
	 pa5uPwqB02hBRqalzDA6XTALKm26rmO5WfBaJCER4Fgb+2478O6az4m/ZUHayPhMmXBKL
	 r93crW3XVsVeKlbLLPNMMR+hiIyq1gvzLOi73XvWneUxqNcy10Ec6/tQ2dXyh6ikuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aOxXr+qFjTVddx9MHMmpoHXvX/AcBdqm1oxv066TJlg=;
	b=LrlsTJrkrRklK2SAGdB9EeLKN+BeGts2Zt7FZjls4K5ToNZWJPOpk8bBbsmDVGFOJ7ux
	 5+zLTvpJLuQU/yfeaZ1nXVu9bpJJ3HCF4YJPha7h8epiuPyYbSSfYnc5WnaGQxMYrkx1+
	 o76iMhHqdjimw5l4C1Q2mJNBj4mTnfK1y88qR70wrmqoH2nj4Bxpq7a/UQRPOXTwaRIEA
	 dC3/H7uW0455kCu76byQJzeDuGhsUSLS1nLZiIVLCCmhTFdqq0HPfoWu8mqUkq+lK6U2X
	 WO/YS7mLByAhnsPd/PkP+W2IT3neN2RBjIzR+7eM2pwl1Pl93UFv7m+1+e75vjno4Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/hG3CaN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63483606A321
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/hG3CaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9458E1F000CF;
	Mon, 23 Nov 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471586;
	bh=aOxXr+qFjTVddx9MHMmpoHXvX/AcBdqm1oxv066TJlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/hG3CaNZTn4gDxGt0xXwVyb1Zvotkhbe43Z/mjQweJvruoCB6iYLuJ0RU2DYW1kl
	 2PkJySddtZeXns2IBQWL2E97QeS5BlLTXxn52ByHrzPeAOLyPuChBE87bgIHeZA+hF
	 qcPloeM4KTTRNdB9Cwy08KZ9Cy5kGdFSkMVnCrx6ZLXVx9gcbY9LwYp1drvS671AkN
	 siUte94RxP/i0/VYfuFGZnKGMHu4FoEzwathKkAtVkd0mk+9v7NWljUxLVJylws4Q7
	 DiJJ7sMy98cYk2Ujlb+IkxnhZF+zF/xP+oSvfpo1pgS8rOcKCUGYbgS7p1+qEzz2kB
	 tQuGuNoYy+wDw==
Message-ID: <sashiko-outbox-230104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
References: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:06:26 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patches 1 and 2: no issues found.
- Patch 3: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-b4-cs7542-=
rtc-v3-0-53902bfbe0ae@gmail.com
