Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C1369D59
	for <linux-rtc@vger.kernel.org>; Sun, 13 Sep 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314371; cv=none; b=BvZplJGG4bopAAVZmFECzTecBwHtwKKGubOOP7EcNg/fb9tucwXjpL6auZ6TgIXBPvKfuXKHuX+/O/8yaTK6e/z9nDR2ter3nXnZMJL0pc3fKxAeq6UhnhEPNY8y6zTEC+/4k4nSEBYEVRqGC6PUbJlSmvp+yjrfoYnu76/shyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314371; c=relaxed/simple;
	bh=eHhbJBJEScMwwOpFI03/WBevKc+GD/HGfdsXGV2CSB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5JbauNeeL++6D2ir7tWzPt24C63T0Cf4k+1NZ36ViUmXfX5izrJKnIx3smyg3E+gZZabyJCRiIM9VBmAjkZmxnuLGLlFb7/4JMO10bGrYaaLqC8WY3VFkKZppVavz4r0O08Y2QLYEGWHsOVFBgJ8p5SQVQ5gCA/kkooPBEM7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGIUutvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGIUutvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAFE1F0089C
	for <linux-rtc@vger.kernel.org>; Sun, 13 Sep 2026 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789314369;
	bh=eHhbJBJEScMwwOpFI03/WBevKc+GD/HGfdsXGV2CSB0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=PGIUutvfasqf3X86OXbWO408i0ZRBduh3L0fHOKpdN3JPF5lUC3Pc6ZTu9d/pyPo+
	 o/p0BHyE0QM55LbAdPX6IhbOixR5wC0DqNQfF6NLq4GxYWXIbDDrhDqiQAfw6TzxME
	 hUe+oFg7s9hwXZzEkTwD+qDiZqUsHYtxi/Z94Du69oRS4cixoViodqgHn1rh/ApQDf
	 46JFO1Ytkfa1eEzPHeQufrAs2T1Fs0t8XQ/YxeKtjoNFvXHvUEinDcNc6gzTdK0Cxi
	 eqSkbaI8xSvG+A2Oz6FmM6fRwpBJn+rZEbsDWeqfM6yFt4nb3xf6gI7xdpvOxG0CUR
	 G3lRNygsNzzfQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a20367cf82so20007471fa.1
        for <linux-rtc@vger.kernel.org>; Sun, 13 Sep 2026 08:46:09 -0700 (PDT)
X-Gm-Message-State: AFuF++nDf5txVMLaINYbR+nLSnws4k4U2uSkpcq1NYaFa80jMnMKvf6c
	FnUGIMJ6MePtiT5/aaMhsPutpPlUHQw/WowVZwTlvnOSW5jFwHno3jf0TWzdYGCtJsZZIyzkgZg
	4yozqdJ6xK96SrIUAJtZpTZl/I2Eo054=
X-Received: by 2002:a05:651c:19a0:b0:3a4:d4de:bad0 with SMTP id
 38308e7fff4ca-3a5a5022d47mr17692041fa.19.1789314367478; Sun, 13 Sep 2026
 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB00013E724A77A355668B6CCEC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 13 Sep 2026 23:45:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v642g_vRUmsaM-G+VP=e1ePmKnNGxXpp6ns475FVBN_WQQ@mail.gmail.com>
X-Gm-Features: AcwNN1XRBaNDhEEGFuvJdFg63n6MOjJUU82Ly2PgZqYal3wEqs83Cf8POQRGn38
Message-ID: <CAGb2v642g_vRUmsaM-G+VP=e1ePmKnNGxXpp6ns475FVBN_WQQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: ac100: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 2:40=E2=80=AFAM Aamir Ahmed <elb12345@hotmail.co.uk>=
 wrote:
>
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ac100_rtc_register_clks() due to .num being assigned only
> after every clkout clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps.
>
> Initialize .num with AC100_CLKOUT_NUM, the number of elements .hws[] was
> allocated with, right after the allocation. That is the value the loop
> counter ends up at on the success path anyway, so the provider's
> behaviour is unchanged.
>
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __cou=
nted_by")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>


Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
