Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F6407579;
	Tue, 20 Jan 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929852; cv=none; b=bk7vHyA5GtIlDDHc2Uz03yQymljVP0NANZ/6Z8zkdYEHenvp5xQwFp3xA2LZfyUPbj1yCVJYy+t4EIhZBwl85Nva99iGsJhpsat99Gux5yVlSrdYKY6Lo4XUGKNjyToOvEt/lFxvBVGorE3JDWu2l36LAC019+7Jl3IfmeiZvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929852; c=relaxed/simple;
	bh=HFIXnBi56RahEekvfAUfCBDF0A7Oz9lhHVNx24C6Xl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR5AjMM1FO3057fkNY+2qf1PFuellNRmVgz4RxNauxQQfLYDi2sPHKfgrToDdt77N9Mb1VT10/q8mOgfooxlVyEPir1hm9bF7jJP2nPh/7Won8wmeeeZbE29Ql8faP80PSnrNdDnQ26FZhntSo0iksfHvD4VLMjszyvrehHgi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec+Huq2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec+Huq2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95953C16AAE;
	Tue, 20 Jan 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768929851;
	bh=HFIXnBi56RahEekvfAUfCBDF0A7Oz9lhHVNx24C6Xl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ec+Huq2Tg5A+LCCtb3B3lgzufbvcZUBCvFSi20G849JHpV2Pw0U8Ytpx9tnoFtoMF
	 ZJCkWnGeMg4WQVGe2RUQ4pz0VsI00fNdrHdoEDFcP22VYRqdt0Zl8GoBfLjRjX2Onb
	 pRfLcN8LX/GLdzAU+LrzwXdtUhbZKEVXULlAHvEvk/NtGNUFHIneFMLBcty5Due/Pg
	 sn998kqBmh2f62OAv+sqj3/8Isi0tLINBkx7ovDH2BDkAC6s78uHJHCFDi6z7hOld5
	 6kS7D3VnLlKV+2KKI1NvfMSuWHH4uA65yHTQRwHjnSbA+GQEcdRoD9T8rVrAPvpHqY
	 b1piSIs0IQGzw==
Date: Tue, 20 Jan 2026 17:24:05 +0000
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	tools@kernel.org, users@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <20260120172405.GI1354723@google.com>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>
 <20260120155241.GG1354723@google.com>
 <e9bde783-42f3-4f28-9a5e-aa65f36db9ca@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9bde783-42f3-4f28-9a5e-aa65f36db9ca@sirena.org.uk>

On Tue, 20 Jan 2026, Mark Brown wrote:

> On Tue, Jan 20, 2026 at 03:52:41PM +0000, Lee Jones wrote:
> > On Tue, 20 Jan 2026, Lee Jones wrote:
> 
> > > [1/3] mfd: sec: add rtc alarm IRQ as platform device resource
> > >       (no commit info)
> > > [2/3] rtc: s5m: query platform device IRQ resource for alarm IRQ
> > >       commit: c70aee3dd85482c67720eb642d59ebbb9433faa5
> > > [3/3] mfd: sec: drop now unused struct sec_pmic_dev::irq_data
> > >       (no commit info)
> 
> > Looks like b4 is having a bad day.
> 
> > I just applied v3, not this set.
> 
> If you fetch a series but don't delete it from the database then (with
> b4 ty -d) then b4 will remember it and if any commits in what gets
> applied match it'll generate a mail for b4 ty -a.  Usually that's when
> some commits didn't get changed.

The last attempt to apply this failed with conflicts.

I wonder why b4 stored that as a success?

-- 
Lee Jones [李琼斯]
