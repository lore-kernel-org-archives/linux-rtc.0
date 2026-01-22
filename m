Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA230F551;
	Thu, 22 Jan 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088579; cv=none; b=iACaIeavhOxljyWUmy3hfeP4erAle1dbIjYy3SKlqZ+GQ8Po2mGWBWbmhrv2skavgW+cad2BxW1j5d1dSR9LGbMYZ5D2Wp5JEIa/jVWTU/Wr+b38xVeSKtbBUBgxvqIvDtmVNwcy5vHqfKQzkEXAavS9k7WSzqaRal2sX+JsRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088579; c=relaxed/simple;
	bh=asYOzDggC4n6f1UKTy8wwp7zcCLc/+oP9Mi6XOstok0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDQw17iKPkG4qj4bp0/IAa2msqHItUW/ePWlAxpm9CLxXSUSwGXp32YRrCE24BxM3i8nGk4Q7/3laED7FazdhvHcj5hM6mP8cgbeCCJljRu4rQTTWvCehhQGIuhh1+iyeskCHFQQv9glyoUuAGjjttRu4qi/iGvCN+PlRPfF/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/QAmUha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/QAmUha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27378C116C6;
	Thu, 22 Jan 2026 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088579;
	bh=asYOzDggC4n6f1UKTy8wwp7zcCLc/+oP9Mi6XOstok0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/QAmUhaKJ0KeU6STdx4MvVGjduwd8/oSAdQZHgHXVAisBLJ1JobQGBQbKp7cnzS8
	 fazNq9F6Z3AJ2iYLGVplBbLsuTpmbvKfDGP7qdyPT0c3f2WwT1+IHxsbmRt8Lnd1rJ
	 YjYOYM9jr+hJUHzKWcvxt3b+tT9i04AyiN8bYYIdVNLLtF3lZ6BT0rZJr91boaFxPD
	 veZ1pyaCvQ7iL/9X6Giaj4YgkjquHf0c11sDjsT2yW0UeqylDKOziJaw99iVf8tSde
	 WYUlUL6LNMsAGJTo3Rc6MiCnQlm40q1eAW39bQS2n54OpX23kaqZdCQQYGIu41Iaas
	 y+l4gD+uXvgvQ==
Date: Thu, 22 Jan 2026 13:29:33 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD and RTC due for the
 v6.20 merge window
Message-ID: <20260122132933.GI3831112@google.com>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <20260122132804.GH3831112@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122132804.GH3831112@google.com>

On Thu, 22 Jan 2026, Lee Jones wrote:

> Enjoy!
> 
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-v6.20
> 
> for you to fetch changes up to b31583a1a9ab32923734ceb5fc95e536dfacccf7:
> 
>   mfd: sec: Drop now unused struct sec_pmic_dev::irq_data (2026-01-20 15:37:48 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and RTC due for the v6.20 merge window
> 
> ----------------------------------------------------------------
> André Draszik (3):
>       mfd: sec: Add rtc alarm IRQ as platform device resource
>       rtc: s5m: query platform device IRQ resource for alarm IRQ
>       mfd: sec: Drop now unused struct sec_pmic_dev::irq_data
> 
>  drivers/mfd/sec-common.c         | 45 ++++++++++++++++++++--------
>  drivers/mfd/sec-core.h           |  2 +-
>  drivers/mfd/sec-irq.c            | 64 ++++++++++++++++++----------------------
>  drivers/rtc/rtc-s5m.c            | 21 +++++--------
>  include/linux/mfd/samsung/core.h |  1 -
>  5 files changed, 71 insertions(+), 62 deletions(-)

Don't panic!  It was actually v3 that I applied.

-- 
Lee Jones [李琼斯]
