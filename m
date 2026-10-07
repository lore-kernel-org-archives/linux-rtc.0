Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7444A8A37
	for <linux-rtc@vger.kernel.org>; Wed,  7 Oct 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372053; cv=none; b=uApkErXXxB7xNKcO/IS/LEEcBTHCqZrFx3fHtX8efbKDNjqBfS8MVgxoeLJHU1F4gXDNk0fbBmvn0FTsOyRhrdhxGuIsCjXdGt2rcTgLvHOniH8/c4hbDkxQv141D7oo2qbIZa8y4PQdeVjtts5Cgf+Do5XXgL1qUsUz4UIJApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372053; c=relaxed/simple;
	bh=N+I06WX6uvgXsj2pG0cG7jPbgC7g2G/YZnXLAPs63BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu7/jKYa9Duxlmx4Y4n8g/ang6t+Z9ezNSoKNYKNzFImWx6/mPgC6pTQBK5xckPRIsuLFPVUkU18xLsiP+F2415/sm4LkMn7SUw3JerSs15XqOU280chH8n/LJ39x84o80DulT58VfqJ+3SVPKMyO5o8Fnq0/+QTA9oQsuZk0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI+ikhRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI+ikhRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF0B1F0089D
	for <linux-rtc@vger.kernel.org>; Wed,  7 Oct 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791372027;
	bh=N+I06WX6uvgXsj2pG0cG7jPbgC7g2G/YZnXLAPs63BA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HI+ikhRSvKZku8MmsDlBqzGNw59T4jYp0Jw8nQ5X18KF4HbdJTeNTaWRKI3tTduXn
	 Uqe2vdMzX7bS2HxqXqxuZnK2M5TPsBueP0MvVMcrixJJuMKZ8D/lgZJK8d00s3f2IE
	 8LAamNwTHuqqpE5Z87nKexMVjxFrIy29OQeRRuKAf8Z5lCyT78P3StKOK9PgPD4rT2
	 sar/t9oM3Wt88ftfEgtrxWuWbeYguninBqBW2yVTZ10ieTpzjcoz5BfB/bZ/LDEz6n
	 xnAZ/BMmCnDRa/cW+g6C5Sa20b82hECP1D+R0yeHw2sIYNz3Fl6hZSZr0HdcLSqrji
	 Nwh3OuthhwqUg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-49e0ee9e7afso591188fac.2
        for <linux-rtc@vger.kernel.org>; Wed, 07 Oct 2026 04:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwHUyh8pWHPfkEnGdmV1bBYU26MlyLu4spyKTdHZ0c1XNgNtroObKKNvvXEi7YPyoXA78VilHwXrYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkfHD/V9LmJDEFX0M2D2BK/XrB1ScHfTvvCTiGs/5J3PbEpqbA
	BPJ1oo6RGbh+Ouj9hBVMPW9i995Ozt1QYA4pkub2F69yasx0wvakzCCmXAvf99sDrud+NiCAoXa
	nCdbgLxHORHSdTLFit8lQSoKVHLstUug=
X-Received: by 2002:a05:6870:912c:b0:494:5ad9:dd0e with SMTP id
 586e51a60fabf-4a2591cc842mr1730209fac.3.1791372027081; Wed, 07 Oct 2026
 04:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20261005111502.159855-1-alexandre.belloni@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:20:10 +0200
X-Gmail-Original-Message-ID: <CAD++jLnuk5Lb+peZu=njvqCMkZ7Kskog6-KC6CPF4TWZ20UA2Q@mail.gmail.com>
X-Gm-Features: AclHuK9m5JjEJQsk3_xr16bnFnuTamplu6auBCr5yRDhyUtfMaO-VORIR7NkSHA
Message-ID: <CAD++jLnuk5Lb+peZu=njvqCMkZ7Kskog6-KC6CPF4TWZ20UA2Q@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: ftrtc010: fix cast
To: alexandre.belloni@bootlin.com
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Dan Carpenter <error27@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:15=E2=80=AFPM <alexandre.belloni@bootlin.com> wrot=
e:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> The hour and minute registers will rollover before the multiplication to
> convert to a number of seconds can exceed an 32bit integer, there is no
> need to cast them.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://patch.msgid.link/20261002105946.8rdteIpO7uWGEcTlS65F8iSi4gs=
RoXi2kgq8FTSaDPA@z/
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Thanks for fixing this Alexandre!

Yours,
Linus Walleij
