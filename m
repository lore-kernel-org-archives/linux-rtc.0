Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703956;
	b=xHhovod4geEqAx9Qbbu8qNKVp2SHAy6Yrr7FhZDPrIz1tSxE1B8SRLQBTF5Mi/t7/KXM
	 Fa1cZyN9MnpUMvFXz5iuGAk1R5Lu0vPW0J5qKXWeUg4+W8VlroBnMo3GhoKLUNoETenmd
	 7OMME0++cA4LPd73ND7r9NMm9pOSd80tBLq1/6aA2gBWNtgpuSBP8DBm6Oy542jVLt7SU
	 BmmRxEC3FSjgeBtDJ0h15lwOnm2meXT6pbvTOnBf3BJPQWWamLL74pt1wkt8Y/1RHeGYN
	 ydOk8mvVdx0o6BeAv7SQTmKd24QAkkZAJEeStj5VGSIc0Q1V+YgzxsAdyhdgD9GyUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LFK+bH3SvRencKcligDBWx/d7MFrPfQ+t8+A1yXnygk=;
	b=lwfu6GUbzS22+fb7XcYGMCHok8sjvvfEYYtP0Rk16m3e+2O7pbqaYhsR7+4XPb/2sTVc
	 pQwvAXTZ7c9NrCrMniJjo7ZGZZPi1SOWFXcqiMOQRi1vXaubbBLVp/qM9I7za9d4uqboc
	 RXrUx1cZpE4wNRp//VdgSbVnxDk/S69gvWnPj/xLfgFrrOXoq4YD2vuUKPOr5LZrlxB0k
	 /Pt/lxSk4HusWZevRTplw8TRJdqcOodOfhEanm2K1GmFT5CoCF/YolUrmGI7RK6Ps4U9a
	 Zu5eqGqcrYbGQNXehnL0bvNQrhTye6O+Y22N8f8i61aUGjZSW9VNr+s5wPUbSChaoCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECqiyZnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE7606C58B
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECqiyZnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ED91F000C1;
	Tue,  3 Nov 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703955;
	bh=LFK+bH3SvRencKcligDBWx/d7MFrPfQ+t8+A1yXnygk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECqiyZnVJ7R7TUBGFabzZX2KnbKmc4fhjMLkG0Grh8OSFEzfueR4Ik0QR48/LEPpf
	 2tWRqMNPBgDU+tZDbyauZIFxo8XJG21JRZcCXPTXukrP5cJCyoa+XTh6idywr8h9Xz
	 Nyt18dKgJDyKeDBxWHifSohqhZhLXZ5GM/4nugL4KDgre7yIYMz7ytbSJNXvsB4icl
	 CUyw2uv61we5PWn3VMaeLc93m9mCKb8Bys47yfplIK/x+uf1R2CeYirKzb7VkaiaAc
	 sPW+2UaCL6pf/20wmdJMZH40KZYj4Sn37bptPIA1Xy5KgpmRwsgZW6nO/yveqL1nym
	 pGROTZPZmX/vw==
Message-ID: <sashiko-outbox-195106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: stm32: release the LSCO clock provider on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261103105546.1394618-1-vulab@iscas.ac.cn>
References: <20261103105546.1394618-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:05:54 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The LSCO pinmux action registers the rtc_lsco clock provider with
> of_clk_add_provider(), which takes a reference on the RTC device node.
> stm32_rtc_remove() unregisters the gate clock but never calls
> of_clk_del_provider(), so the node reference is never dropped and the
> provider stays registered with a pointer to a clock that no longer
> exists.
>=20
> Delete the provider before unregistering the gate clock.
>=20
> Fixes: bb7b0df2be5c ("rtc: stm32: add Low Speed Clock Output (LSCO) suppo=
rt")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103105546.1394=
618-1-vulab@iscas.ac.cn?part=3D1

