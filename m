Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609598;
	b=x6o9ZQXl22wWfFdkM+bC+GWijxTC0183grq+2P/rdKI7KcKBPyal3VjVf1y3v6/92UW0
	 AftVpqNkIWYmI1DD0Hq3CaBxTYXyTgiSlZ0YRwt048C6374R6Y8eRTygP2mYem6TupIfj
	 UTOEEL8Ka4VAInFgRgJ2BD1WVi1o5duJMnOOQSk8uweXAAqcpA9TMANW+yg1mlvYnE+Hm
	 9pejD6nlVicPwo1rTt0iyAUbry/No5R3AFYNtPfOObp1sAOlOwFP4fEx+8ujSwcs4XDWY
	 CKQkMGtqJHv7yVgfdZf6Df0nCLvHKT+3Fva0nxWqhb0Cl3eWoQv/HWGeVPtD5W4IdEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KmmkQEMZhi/rOAJnFM9Tj/ki8ep+q5c+ZMlNYyFToKg=;
	b=sCl5dq3/ytGbulmK8T33IUW+gVuEg8nwGhDTF3dAywg/th1RZ9dW18fKalk6bhCSqB1v
	 WcGqG4yDFeD6pYsXqj/oWpWQrw7Zsj9CXM6treaan7Nl8zEIe0wAalPjPJbTZbZUGvfM6
	 gHi9z+Gc1xTEJfoqGm+LU6MHWvyBfonx1FYBBieUr5SKsTPbnuxKY03qiO1QrZALovFIt
	 zY3tdPjqgO97X+7vzGCQ33P3Ccy35gibVqOip6nqF+ZUtq59etRwdAT7bfjCpsH5NE/SQ
	 I8uGerxNOM7PXGEiJS4HMYwHw1Tsc3wEA73fcmpDrUYciYjpCR0EIL4JUO8COt/dYyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrfPvpSm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B64606A54B
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrfPvpSm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA5A1F000C4;
	Fri, 13 Nov 2026 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609597;
	bh=KmmkQEMZhi/rOAJnFM9Tj/ki8ep+q5c+ZMlNYyFToKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrfPvpSmKDXp2QladNETcOsTAA6DpOM9V7LPJEozrznIFI/iN4DyKwxDtr4tCbbov
	 6orSiEHV6BD0shOeNmD+63nQg0Iqy1LpkjUiBCMompnMNZwB2dliHF2t3s9nnbwhKb
	 Esla0nCweoAFOr3qc0vQdlkyuleqKRdMlBwmuWs6ytc5hzrniguzjdviITgKFLeGeO
	 dq/DnIRhs/2DxnO1IngHXgjMqIU/a/BZBJhBQFqf4z4eLh4Ls8o8NEUgIt68/ihkFC
	 GbcrgAWXjt0Y2+KolKAHQ1D1rh9AoCCzr5AK+wmkBDVAbfw/X9FTmRwWofpYnGiE3k
	 9n0H1V1ph3+mw==
Message-ID: <sashiko-outbox-213834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/19] riscv: dts: allwinner: add the YuzukiHD Avaota F2
 board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-18-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-18-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:57 +0000
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
> Add the YuzukiHD Avaota F2, a V861 board, with its memory and serial
> console.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D18

