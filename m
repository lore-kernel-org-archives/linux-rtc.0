Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAE35F16C
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374946; cv=none; b=rR042WPT0ont5tnKR9sVMfC56ppeOi08SQSTRhT7lA/NzDuRHuqRAxXoRLWWVDRz9/HQtCi1mWNB5IMgNGqHawwaycH6AbXbr3KGXbOHWlFsM78O/jPHv1e2afDtr9r4YQm8PXASFWfrWIL2SjuJsp7dDQseLf2YWhHxqkynH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374946; c=relaxed/simple;
	bh=Li73VYRhWbKmsxVeXEnSH3QkPyObARZNy6ZrbbFDRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN4g3BPd0pR9Vl/EVABTkdaq5p4mNtdoiaxcTiSndZZZcrU0YccJG/rtw0A/juibiLsOcHmfg3tdx3o2ahS5uuZO5HbxtCk72eHENiZ0pjrL0IDR8sCe8HoIaNvAOG6dod72G1mNQE9aHtXYVLonBHbqBpopzxEJfFaZpNWm2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrXx02p/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrXx02p/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911101F0089C
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374944;
	bh=JCVjDkbQLFPdmT42ieE/D9gwThDVlwRuyUtdsBm7ClE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DrXx02p/lFBEhSn7NH0u38TVYG9WuR+dxmCWZcuPsVfVnDzR/7hsmOzbSmChbM14A
	 gkufea8hSg+N+K+fyspiEnn/DX39Rbgcx1XVu1HU2RNdVrNLramMC8ySTkv404kryz
	 XdH56e8XihY6CZYtxPUtKvcxJjqGgMeiVlbpBirvDS9RxzarWYi0ILoH39xVJoEKfW
	 30Fz8yhbWMIBLDDWWiqDluWDffgHxG08QMuZUfO5armfZ9bDpnuYc1/nftke/Iz8N5
	 3gSd9V14ONvXEGLro3UebOz9G5ZtOQ/gn7ttRaFgrmImCYxHe8hJG/dDs5H8dZPHNk
	 nT9MSC1bwceyw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso2292296e87.2
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 01:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwb8RPgFhfAk87YVNPmxfnE6YLF1mXlLAb5RFxmIoAemJQQR+7hi2JA5qy04nLr9K1uN4kD6lNDdh0=@vger.kernel.org
X-Gm-Message-State: AFuF++mbMV+GcrnkSWmoJO44uE5nFrvkpkC2bTDD/bXWs7NTV1qma/AU
	tgLpFvHitxFzSgOHML+GTRMVrXAk0oKIA/LJmzVuSHcnNwFDWloQwgWBJjbIn6FLEPHRlos1YH1
	4f+1X0GxolyT7YoUP2Im77C7lNfwQAO8=
X-Received: by 2002:a05:6512:3d0b:b0:5b8:9b7e:4941 with SMTP id
 2adb3069b0e04-5b8ae69f2f1mr385616e87.45.1789374943281; Mon, 14 Sep 2026
 01:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6A7910FC22A9FEF1+20260827015739.3314298-1-liudalin@kylinsec.com.cn>
In-Reply-To: <6A7910FC22A9FEF1+20260827015739.3314298-1-liudalin@kylinsec.com.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 10:35:31 +0200
X-Gmail-Original-Message-ID: <CAD++jL=qWv14873iDQ7vvGPtdHosZarEY2XG4r7jaBeMZU2nTA@mail.gmail.com>
X-Gm-Features: AcwNN1VO1mJUgmGkmDzeoood-mB4SIA0XA3D3cl5tdifQfTtvKGhkdNV6v0UL-4
Message-ID: <CAD++jL=qWv14873iDQ7vvGPtdHosZarEY2XG4r7jaBeMZU2nTA@mail.gmail.com>
Subject: Re: [PATCH] rtc: ftrtc010: fix clock resource leak on probe failure
To: Liu Dalin <liudalin@kylinsec.com.cn>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deng Yingchao <dengyingchao@kylinsec.com.cn>, Qin Yungao <qinyungao@kylinsec.com.cn>, 
	Luo Qiu <luoqiu@kylinsec.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:58=E2=80=AFAM Liu Dalin <liudalin@kylinsec.com.cn=
> wrote:

> When devm_rtc_register_device() fails, ftrtc010_rtc_probe() returns
> the error directly without releasing clocks obtained via
> clk_prepare_enable(). This leaks both extclk and pclk resources,
> which may prevent subsequent probe attempts or module removal.
>
> Capture the return value and jump to the error handling path to
> properly release clocks via clk_disable_unprepare().
>
> Fixes smatch warnings:
> - drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
>   'rtc->extclk' from clk_prepare_enable() not released on lines: 183.
> - drivers/rtc/rtc-ftrtc010.c:189 ftrtc010_rtc_probe() warn:
>   'rtc->pclk' from clk_prepare_enable() not released on lines: 183.
>
> Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource manageme=
nt")
> Assisted-by: smatch:2.0 [static analysis]
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
