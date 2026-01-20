Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5646AEC7;
	Tue, 20 Jan 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924368; cv=none; b=IIH2yepQsWouVWhpigmmkFEYzJ5FbEAqWfYPHASv3SOSjAgYO041o86MHExuZs5/0r9aj5Eng7j32WzW7csOanBfWOWPowmPRRPN3E0pnt/qkYT4BXXKEEpOOTywHR1Y1OwiPxgNxQ3771/oNtdySHHvF/kKQyEC737eqnVoBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924368; c=relaxed/simple;
	bh=uG9SUZ9fmv9av9UYqizYrCWuhGaplTAmVrUN6tX0q+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXDoX5BOaBfAsYmK2/JWnkFHgYIT7dJKjW9mGWk/Wf1nAyBECLZ7ht4nSYb9BiuE2NJNMi88dRbDLVEf0DGuJwlPzTxUxr46Xj+J4QsMNr801ED/x6KQ77QSqwy95Qn3zMIugxPANVVAkjgyeSJodTLDc8a2I1sn2ytZoyTKV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u45QXdnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u45QXdnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D0BC19422;
	Tue, 20 Jan 2026 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924368;
	bh=uG9SUZ9fmv9av9UYqizYrCWuhGaplTAmVrUN6tX0q+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u45QXdnbVwJqCVCNuu6laAMvyjhuoF8aTfampzfriGuGVTnW9VIXzOb7MVDXTgDwV
	 gdlDjNjyoNC5WbmbNpqfKgf/ks2q8DMK3appC96mlOWFlMl06jyNUaw/vatQfKI0uz
	 7jmRaiePv6TgFVyX+9dEn84ii8VfuQscsUU5IsH1SYJNL9uwwYqwgFpiYV4V/DzjT/
	 gFaoyEfqdCRCbThRdfsxyGMYY68kGQLpT9sOJa1h56RdhkoyHvnvtyxJAVYWPxPrQo
	 UGYm41mQoLWl++rtkyuV9EQyL5ivtt31lYFRke9yvWRwDNgTP2hzhi3PwAiRI3j8T9
	 a3vnK9eZ0cbiA==
Date: Tue, 20 Jan 2026 15:52:41 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	tools@kernel.org, users@kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Juan Yescas <jyescas@google.com>,
	Douglas Anderson <dianders@chromium.org>, kernel-team@android.com,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Samsung mfd/rtc driver alarm IRQ simplification
Message-ID: <20260120155241.GG1354723@google.com>
References: <20251120-s5m-alarm-v2-0-cc15f0e32161@linaro.org>
 <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176892415694.2292562.7457528145774108517.b4-ty@kernel.org>

On Tue, 20 Jan 2026, Lee Jones wrote:

> On Thu, 20 Nov 2025 14:38:03 +0000, André Draszik wrote:
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
>       (no commit info)
> [2/3] rtc: s5m: query platform device IRQ resource for alarm IRQ
>       commit: c70aee3dd85482c67720eb642d59ebbb9433faa5
> [3/3] mfd: sec: drop now unused struct sec_pmic_dev::irq_data
>       (no commit info)

Looks like b4 is having a bad day.

I just applied v3, not this set.

-- 
Lee Jones [李琼斯]
