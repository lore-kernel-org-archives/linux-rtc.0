Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8E466B45;
	Tue, 20 Jan 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924217; cv=none; b=RHZaYDzTh05b4M9euildMtgEDhpIp0sosyLEu44IXMf43qECrU0L3NRb4bwb5xPOq0+vELq3UGegIfpWx93yCoPZ369QDBmTm0rGpeJihgTYzZcK0dxNp6s2Qr/GAdYHcB/0KZ59Cx3hpoDIQhXDMuiUo0oKp3CI+ptcnW1Ujwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924217; c=relaxed/simple;
	bh=8hGTla3jguuKER47536RO1Uzq03fB7ksJDGgFYzNj/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdnNvxxpNXd56ppiQT6O0GfTT76x9Elr68LlEPHgpnSSb7ImofUuyQ68Nb6wg+tEbvuoznjoFftNsuQ+VICN6SZeCXDa51I13jIUB09vtWHCgm+z12teefWF7V+10MziSTvicshV1UHLuHANnL3eM3kpzqSnW15hmpc3sHvnnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/2zufsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/2zufsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1469C16AAE;
	Tue, 20 Jan 2026 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924216;
	bh=8hGTla3jguuKER47536RO1Uzq03fB7ksJDGgFYzNj/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/2zufsrp1H7QVsu3dAdn8em4wplw6c9+Xw4tCXjhfke5o/lTon8yms11b05tABCj
	 j5q9vYDSl2urbPYUEBqBHaU1FxgyFQ1wyWhhqO+0XWM3+wO2n0nLirvIePE4pkWUlw
	 fvNVON2qJKyr92GdEmHz+z4ttF4EcyO5MThBvBAq4EaAuPn11XCprdIDL2lc3aGkms
	 +bzKkNhqpypT8aSdkjSe9XPBz7pkypdbl9Lt5rsSzzkWlDPKKYOE8i8PHl6s1XcQVG
	 BKqVjywqV+Il8d9WaDH1sv60ERHl7+6QmBDhA+6iBzWkjV6zUA6Rp6GeZ54JcUlx4m
	 beSbcd1B3x/5Q==
Date: Tue, 20 Jan 2026 15:50:11 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <20260120155011.GF1354723@google.com>
References: <20260113-s5m-alarm-v3-0-855a19db1277@linaro.org>
 <176892416020.2292562.12972171855041051987.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176892416020.2292562.12972171855041051987.b4-ty@kernel.org>

On Tue, 20 Jan 2026, Lee Jones wrote:

> On Tue, 13 Jan 2026 14:03:10 +0000, André Draszik wrote:
> > With the attached patches the Samsung s5m RTC driver is simplified a
> > little bit with regards to alarm IRQ acquisition.
> > 
> > The end result is that instead of having a list of IRQ numbers for each
> > variant (and a BUILD_BUG_ON() to ensure consistency), the RTC driver
> > queries the 'alarm' platform resource from the parent (mfd cell).
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] mfd: sec: add rtc alarm IRQ as platform device resource
>       commit: 153ae5c52b7063ac0926926d0cc9b53ee9d7fed2
> [2/3] rtc: s5m: query platform device IRQ resource for alarm IRQ
>       commit: c70aee3dd85482c67720eb642d59ebbb9433faa5
> [3/3] mfd: sec: drop now unused struct sec_pmic_dev::irq_data
>       commit: b31583a1a9ab32923734ceb5fc95e536dfacccf7

Submitted for testing.  Pull-request to follow.

For my own reference: ib-mfd-rtc-6.20

-- 
Lee Jones [李琼斯]
