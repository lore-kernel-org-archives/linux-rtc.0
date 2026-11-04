Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776157;
	b=W2zbU6Su4jZba8rVvMxyqgFpaRql4p/44RgJ3sNfi2T2wdDx3A68VovnW/p1iDmD4LJR
	 BmBxqq7ZHqMyjeE682fQc41DP1EfA7XHa6Mu9QsuSgOxMJCaJlXW8HCxWTctJ8Nm2oXy4
	 GDMQMtkfRShQ+K5lWD+uyJ1chQc0dQcsH/FevLw2txIgJHc4XAGlhut54caZKNbwZvNDT
	 LwswHTykL3CGqyvD2s42VUBa5pQO8gqSLtOHYsO4ac28YPjq3gWmE7gvAm+P2ojNX5kIm
	 x8bDoGk3IhulH3p9oPHx5hnRJUHtCv+Grp2JzrzlQP1kUpLcJ/xw+EoxTzbnkID54NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7eT1V8yEbeP02/kAK/JAHS0FjI0gb4G0LG678rGgJrw=;
	b=sM99ErxO8nt28ACA6ygYwS57uXb9NZkBNY/c5N6zLqpHEwwswCTpwxk/ZKctHYmeCFW3
	 +iUkw5qR/ftLNtj8/VsyfUomO6d2ovuSa0s7CeURO2pU+aPdPb1tGPpp+OM/gbOyf3FMV
	 3eKlC4FU35ASzediIOm49AhNm1wDJVCtgWgGnPVLQasVZ8S02IcoQodC7OC+ChMKn49xJ
	 oUvKvtVDlaBk4Mh3mmOhGzAaqNykP9v+TfrLiSyHJw5svPhuixMO/nuVxutg6gy84sIhC
	 4hSd+xe5TkmBWzd0omrEpCFXWD2vewFjGbQJwW2HjpZwR+U0n8FkHLsOPvLV6TRCW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4LUHt+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3D606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4LUHt+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA161F000C1;
	Wed,  4 Nov 2026 07:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776157;
	bh=7eT1V8yEbeP02/kAK/JAHS0FjI0gb4G0LG678rGgJrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4LUHt+vAvdE4t06uLOvyC0TBuvZw53bw3fABO9rCDd7tPfOjcrANO1Am4fr/YwmZ
	 ZDbpwUIVRa5wZC/r1Kn6m6HA19dR79SJOE2CGJoA/bF1dl1l04fTNMK62bPC0kFlQL
	 heolYVyUqL0s0tTJWJo/EkmZ8IZFU6j2qn8M/cUaPSPJBkve/ETwrwddKIkfxaqMkR
	 aO2ms1ZVtFXpBSmVwJDWMd8ZgNjycierqWdlvS+1w1qBPdJo6JvRNgd+VmJZqqgvVQ
	 Ggvk3/H7r33jiVxntFwQmZ7KqE8dN3Gs+zbpSn/5MwXSCaNJeky2LpU3W2Y/k5pP6Y
	 FE5SNnP8Ipb3w==
Message-ID: <sashiko-outbox-196777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] firmware: qcom: scm: Allow QSEECOM on the Surface
 Pro X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104070441.74127-4-val@packett.cool>
References: <20261104070441.74127-1-val@packett.cool>
 <20261104070441.74127-4-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:09:16 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Add the Surface Pro X tablet (all 3 variants) to the QSEECOM allowlist
> for enabling access to efivars.
>=20
> Signed-off-by: Val Packett <val@packett.cool>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104070441.7412=
7-1-val@packett.cool?part=3D3

