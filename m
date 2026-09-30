Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A84ED1AB
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774902; cv=none; b=hLet5Z/JZNOfqu1BLzEznQofFSAOJGakS0n7ki3qx1VkX1JTNjbmZzX1O/oEHhBah3M10+GA6A2egEsrLDqYaO3F+gDWbUWH/fmxuIHYBi+rK/1CvpP0F9R0gbY1zOVHjAeNsIUqRVUFys6TrJ23kAisuwXZrGczpK88G7+ZXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774902; c=relaxed/simple;
	bh=GmzZfGHoDgoAyrR9m4mtLd61BdqL6boC1QSPlsKB1BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwWiMmBu0/DNO/w26Hc7KgG5gVavEaspmDOyiFoFLSJdyf021n4Gwd7J5EbUczI0ekirOwLxffBuGRrl4xejy+tTtq/ViRJRFKxtNFnO/uHBWo4TDCwbhcO5gSfCsUCO/p1s589E1MgrRuRO/nIrjLluAjXWXrazJB/aR9Brb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzH1PSXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzH1PSXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8963B1F0089A
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774893;
	bh=GmzZfGHoDgoAyrR9m4mtLd61BdqL6boC1QSPlsKB1BU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IzH1PSXY8/0oM/wtjLZqOcgTL5usqsaiUZN3/ApGwSaS2xyj5OEg85DPdwqtTlSje
	 iEDeyyTR+NF2EZw/9pcdPRliTndfjUlqeUuDggGVYxFnpWCDLm5lhUFVCan0cZNhFa
	 4mIQToGL6gbqb5FGv/CGzxerjo3+isn382/UdV+Zc7Sz2DeH4Fij+FcR9TIDawfPo9
	 FsKMW+4z0FE3NJpZFGECYY/22XVSEn3JRQX5vRZKeppzLlpDuJvAdZELvdML6ua42L
	 /U239Zz4jeq4Vx4yzGsFKsHh0PBwc202MdH7PVegzc35K6xBpti0lWToDn87daHRDy
	 pCPQjuqGgyqxQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b78so4880329e87.2
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 06:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwpYAYlX6KkufaZS/X1yZzpwyoX7qhl/mrXf0EBP/lbgYpgcMKYdkhaqk09Z6hDCYoJMDnuqyMG8aE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvGu2pI0ODieNPw4+YkyUqnIkhO6QmsOyoWlf2ewwkEiY73coV
	SwWbnwFuVwaKDxndp1/6RiDeDhiziHzCUjhTABnh4HimisDA9roDF/0LSBBswzpwSWTctz/ZEOI
	Jpx3OaoPv4LoupZANS18FfXf6rvtyYGQ=
X-Received: by 2002:a05:6512:3b9c:b0:5b8:bc5e:b574 with SMTP id
 2adb3069b0e04-5ba40612645mr526612e87.44.1790774892330; Wed, 30 Sep 2026
 06:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918095853.1348694-1-congnt264@gmail.com>
In-Reply-To: <20260918095853.1348694-1-congnt264@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 15:27:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLmc6GJP07DJQxH3OGJ1i-6+ksMu=1gEeWkr4JR4xvh29Q@mail.gmail.com>
X-Gm-Features: AclHuK_-hjzb_iqjk__PsBqyNlJIrjqhdhCusnJbaUiZ1mRhmBrwCTww1yq5FOo
Message-ID: <CAD++jLmc6GJP07DJQxH3OGJ1i-6+ksMu=1gEeWkr4JR4xvh29Q@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: stm32: fix clock leak on pinctrl probe failure
To: Cong Nguyen <congnt264@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Valentin Caron <valentin.caron@foss.st.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:59=E2=80=AFAM Cong Nguyen <congnt264@gmail.com> =
wrote:

> A failing devm_pinctrl_register_and_init() or pinctrl_enable() in
> stm32_rtc_probe() returns directly instead of going through err:,
> leaking rtc_ck/pclk -- and since -EPROBE_DEFER is routine here, each
> deferred retry leaks another.
>
> Route both through err:, and move the pinctrl setup earlier (right
> after stm32_rtc_init(), before the RTC device/IRQ are registered) so
> disabling the clocks there doesn't race a still-live IRQ.
>
> Fixes: 16ad2bc09efb ("rtc: stm32: add pinctrl and pinmux interfaces")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260914135401.373D91F000FF@smtp.kernel.o=
rg
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
