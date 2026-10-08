Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006845041A
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464858; cv=none; b=HFYytxG0QBCw4SeOB1OfqzFmeyU8F/bpob2c6FCEhIE/ntz2yt+6PoxR0Hb/RrzBSpD8QTrBaaInGy1meqOvyUYndbOsJP353jLzBudEr+68xdLtL+JhoaZHmJCS/HgZaE7/+nfRlEYeUBAtRQ8efBjjhV5oJLpIKVZp2cha/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464858; c=relaxed/simple;
	bh=AMdVmFlU6LYwgavWx4TLB5/FyI1q6mdp7tce8URgStc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2874SKxxB9A8xVfDC3ttxe3b+3tjNW5mwhV3A3EaJpROZc7129e5akHKGGYeIEBq0ICtwj9miviSwFxkVX1MUjnZ6odtQQa8KPx1rcKZ5r0VJQGOB4XjZ6ESTL7KqlBVris991A7TKcmydb+dKp3bGDnHd1wjzyvhD/yBgLH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFfJpQhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFfJpQhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3081F0089A
	for <linux-rtc@vger.kernel.org>; Thu,  8 Oct 2026 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464857;
	bh=AMdVmFlU6LYwgavWx4TLB5/FyI1q6mdp7tce8URgStc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EFfJpQhXpgze3uduYu30GiDCPDAK/Hb2tH66rVpSP38vO/gC6hvRyY6PcA5acpaGT
	 XQ0zmroIUx8JcdGBVzEtXxTVPJKte/OUf0e6HzroSB62LqG7Xc1DtXPGFlc8usqcZR
	 vpvljb3xF5g6X1IF94u6w41kTwcwykfxrU4a9cT69XinEoqrGiNgQ3FLuf9ZfDo0Jh
	 KB2NViRWpU570wVFu9r/MSoZldv9wFjh5TNTiLSyjRkJ9RPKcefAaD2A/GJfcjn0b3
	 19c57/g+RkdrcDVGuCHj+a9/31zjq5cpPgfHojT7sHkD/q+Zzy/pEVkRdRGGy3XApa
	 I3sv56jfojswA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a980c1153bso23176801fa.1
        for <linux-rtc@vger.kernel.org>; Thu, 08 Oct 2026 06:07:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBywZXz/Rg/Zi1numWQMxi9C41Hebz7EqJrdh/hdz8+yGbGRGUlU65taKmDfCGXQlKuE54HuXJRqYVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7F+Pf8hB+qVLxdcm3WPItQm9wg366MWtopc/3NdNIB0zJQb7j
	0b/py6Bb4cwR1tj/rD/fzIu4fikW5yPJsIpwfT16GZgnwm97ig97VCIx7McxwFWuhfIsEH271eM
	UwqAs4Z8I/h28ElelWwgU3rmBrJuAChk=
X-Received: by 2002:a05:6512:4023:b0:5ba:429b:c5bf with SMTP id
 2adb3069b0e04-5bcd0736ea8mr1945906e87.51.1791464855540; Thu, 08 Oct 2026
 06:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
 <20261008115913bfd12cb4@mail.local>
In-Reply-To: <20261008115913bfd12cb4@mail.local>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 8 Oct 2026 15:07:23 +0200
X-Gmail-Original-Message-ID: <CAD++jLkshbEFS0-H__3AFJiRMeS0hA5F8PoqUjB7kyG_cvRkTw@mail.gmail.com>
X-Gm-Features: AclHuK9kaR_Kf0jFHcJeAlcfmC3e3ti8r1xCTi6blXcRAoYHPTBq140hETtS8v4
Message-ID: <CAD++jLkshbEFS0-H__3AFJiRMeS0hA5F8PoqUjB7kyG_cvRkTw@mail.gmail.com>
Subject: Re: [PATCH] rtc: ftrtc010: fix negative offset handling and smatch warning
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Liu Dalin <liudalin@kylinsec.com.cn>, Dan Carpenter <error27@gmail.com>, 
	Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deng Yingchao <dengyingchao@kylinsec.com.cn>, Qin Yungao <qinyungao@kylinsec.com.cn>, 
	Luo Qiu <luoqiu@kylinsec.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:59=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 08/10/2026 19:37:32+0800, Liu Dalin wrote:

> > A prior attempted to fix the 32-bit arithmetic overflow by turning
> > the implicit u32-to-timeu64_t cast into an explicit one. However,
> > all calculations still happen in u32, inheriting the existing
> > negative offset sign-extension bug, and the explicit cast triggers
> > smatch "cast after binop" warning.
> >
>
> AI is lying to you, offset will never ever be negative.

This looks like something that warrants a clause in:
https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem
in a new rtc.md

I added a file for gpio after some insane review ideas
from Sashiko, hopefully it takes effect.

Yours,
Linus Walleij
