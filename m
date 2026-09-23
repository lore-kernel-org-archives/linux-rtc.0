Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AC46E00C;
	Wed, 23 Sep 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195441; cv=none; b=V0ivf0w0tNlYogRZQIM1bzMxCM0BS+pVo10hOU02kaPXMKWwKq7X0JtCG/CcCcnOjO67iGZf0yzrraGPwdmtx8HqpLOD/rpwj57kWLQ0v2BAp12TeeH1l5iDTce/avaFeOYrv4OhZkRmLQPGkKQkOY6EWLuDT94Uo1Zfmjcd8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195441; c=relaxed/simple;
	bh=32hX1W0az2NbCGYKmlqabZklS+fQs4IhTF+VM5MQE2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SmyRIaLCZKxZnfPwJF62sNfDZ799y+0HJoPdIURvDKAZeLI3rTMycSsX4ppBoPEjd3aZpfNXfSMlRHSy3hb92aNQv4jrItiqFIkxOlMV0J/qOOTI2wZFxMaVcKdeRCBDwLHFGMqFH62JbGIAiNkIKvGbu7x3Kk+zRwAQs59ZiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc6Gwwss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc6Gwwss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BD1F000FF;
	Wed, 23 Sep 2026 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195436;
	bh=32hX1W0az2NbCGYKmlqabZklS+fQs4IhTF+VM5MQE2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gc6Gwwssb49VsCR7nuWrtRelAGqNsn0cavQJAaDFrTJiqwIIf5j8aBxqm6BsjNADJ
	 JjlrMFMMO/14veXB8ICinMmBvplarsuz7N8mwYpL2F0jkeVQuiGQV9paEbOh7oeZ0c
	 k9nRIbaZWPfkG5oYjMcmb/VDxE6Fvv5xcaqkpXoC5NyvRX78WkYYHZIK+CeMXIQ3Ue
	 7GZrTt5ShyMS8PHL1AE0uaSjCeukgnkWgP4pyTSkoGFoYQjKo7A5Vn8ytRD0Gd27sH
	 3fIWUEPCfsalwGJcuNpy1fiDVI0gahwjCLqsnHqnLfyy239zFCDVZRNkjAZ+UPAUna
	 lVGTd/fz6k/4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/11] rtc: sun6i: add Allwinner B288 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
In-Reply-To: <20260923201701.43391-6-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
 <20260923201701.43391-6-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:30:35 +0000
Message-Id: <20260923203036.1D1BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The driver only uses one alarm interrupt, so no functional change.
>=20
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923201701.4339=
1-1-pmazzini@gmail.com?part=3D6

