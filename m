Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445129;
	b=127hsuPmO/2ijmRK5Nh6tdtZPkC4zY9oMaZqM/aY3BopGhuIQ0KvCfq/oeaBHo8cetHu
	 Et12gQ740nw7pujZrDjvO2TUayDbczfx5hzex0xuUKKlKdc3cdr7kwE+7S0leUxjs+s0F
	 +dN+WaF9fMo24NGakHnx3FknGmUJhq0XXmn4x1dWjelvA1O3Zs2PPFCmBKIgoeGOF8/Vl
	 G4xszVoTWPxUw7v0WAxhLvmXoowFagzGjJl+S2xYdY29HdGWp06u0OwlhnQZo9Vt3eI3d
	 fNg7UxwCl7m9225yZ4hBzk2lri2KnN34zJR5hOOglNjTdlyRlYMgiBIoy1g4NVc6BcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nn1l97NFJZ931OyFMqD6jHoS/Uy3wMTe9Fcq6fr5D14=;
	b=CaXpPWGeaGqtM7L47fpLblm7kK1lh8FRnaXK2OUlubAScy4cmKs0qCCY1W5ZlpEHtc3R
	 c72iPrm2MOWIhF6GukPnBc4ofgUMxAFhT1+zC9AIxjDadU5X2uIOfWa5oD8txB9/FlXC8
	 XhCzgXv3Nz8FOS/M41YITUZdSVjooJQe/7Jq5UtILAmiZ3v+UvUm+GqCcQDit+wESpd5B
	 rEuz292WbfO5XDUkRb6nfuwoR6NLNGVK26enhkEecso2IIQU8HqF1LiTIhN1ZmXVdRfaN
	 DfsrYBIu/4Il7j5jC4xqPS7PMLxH2tucxZP7eEjuA/C5W4iSYKpY3lkC982CsyralXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNQQbn2d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E5606A31D
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNQQbn2d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC42C1F000C7;
	Mon, 19 Oct 2026 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445129;
	bh=nn1l97NFJZ931OyFMqD6jHoS/Uy3wMTe9Fcq6fr5D14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNQQbn2dw1X86IElFkjrGJJMn/gbZ8YVFM73YM5AXPCddSRzwYjbrgi/alQBqOUAL
	 JDeiGKhMIMT+udFSo8RsKvEjzjIB/anHbr5BrUeZbwNW6Z1LTWdSxx3P8iEOR03Mk7
	 ZYxrh70K3vvRI7f3iTDL5nLv66BDC4PwmdYm3mIGL6VOm2bewsVXmCZ9oktzpswfWf
	 eEq/2dRYIcKx3HM5K+Xd10nGAc1q2n2ElMFmjbQMxJXvLrz38P/1M8iL+1JFbNuU2+
	 W4tBi75XBOt3gkAHtO7WwrnndlX+ufXZ3JdTVKvKG88Ulow3nB5FdVGfgTf2occQ5U
	 tO+XMZwuE9/fw==
Message-ID: <sashiko-outbox-178253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/19] rtc: abx80x: simplify locking
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-19-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-19-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:25:28 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use the ops_lock that is used by the core to lock operations. This ensures
> we will never get any ABBA deadlock.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D19

