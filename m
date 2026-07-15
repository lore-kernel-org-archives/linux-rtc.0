Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6561425867;
	Wed, 15 Jul 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138864; cv=none; b=GN6Kz8aaqEdzXZwPOF0vc+WjRjq0yAcYITFAM3fuZotwFbfWMpfc5QuUPjV08RuBoqHqsLiEtz3T/hJlbWXGzkBkpZYCku9NdEG0ckIF0qCqPsZ5H8fCwShvBwBan33h/WyzoC2pKlNJ51b9XrDedkakXfpdbwL4XI7hvsL1H8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138864; c=relaxed/simple;
	bh=RWzn+8Z/UFihm5XoL5tzbY4Myth2k9CFGLJ3QgA8pR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pekAM/IC+hBCXHsMfmVoIU9j7EDbikhRnICKJT0vUEn3AeDD5xDKQnQ7jRqmM0bvjGIox5khoGDGLKiW/eV1TtsK92tEapF1r7MmEQMwvC18MS2xJBKraw0x+atGMxOjQJ0ep41IhjQ1SV5+tcGjb5U6lWWhG3EsR+r5Ho3uD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5MayrPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5MayrPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE41F000E9;
	Wed, 15 Jul 2026 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138856;
	bh=RWzn+8Z/UFihm5XoL5tzbY4Myth2k9CFGLJ3QgA8pR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5MayrPOJ+Dwzm1b8oPsL074Do5HPgFn4CWZJNz1RgQXN105IOopyDOswCaBX2KAl
	 /J5T2llrsQeZmwMGqo/vkFxz75+jnY+E13EdISu9HlwRx7wrEbRu5HxenCK8XtJPsB
	 ppSHXntXO9Hq7rr6V10+GUeFavN6P6vBkCHgeUO1pVtY67W9AG7Cvf1ej/vnDZyi95
	 9NeAscdehAWlbJ3jKsN1EOuWSl4uHCQscSMKvxCxhXEsWwVEhkT52sKgq7dqTT7EsL
	 G7TMZczkIC5GiW4CTTKdlmcdco1KQd0nA0ncXERHQmtYMhubNzbfObERwkRRzBni7H
	 BKmQVT9W2lm3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] media: ov2740: remove NULL reg_write callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: imx@lists.linux.dev, linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, ojeda@kernel.org, neil.armstrong@linaro.org, linux-rtc@vger.kernel.org, Frank.Li@kernel.org, lee@kernel.org
In-Reply-To: <20260715175229.24672-9-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-9-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:07:34 +0000
Message-Id: <20260715180734.91AE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This field is already initialized to NULL, so there is no reason to
> write it again.
>=20
> This prevents it from appearing while grepping for reg_write in the
> future.
>=20
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D8

