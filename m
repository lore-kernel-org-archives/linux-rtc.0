Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CE30CD81;
	Fri, 16 Oct 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792192265; cv=none; b=gDO412l9PA1808DZvkG1zKx/ND8GOH4psJVDM+6o1J4/e9/KLemnbXmB/Nb84aP0PC19UPMHYJIvXjTxeimHdoVV2R3fn3HvzPKyydajzwf2PZFpcSlkh9ZHcZrQ+qlyLAcM8u8GE+NNizqIfPggskk9FpAhvtM60qPpgaygHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792192265; c=relaxed/simple;
	bh=RyAJ0e0U+Cf17qyn3E9P05x9ivfs8oTxhiBSAoU9TaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XQRfaM/IZYwzWRB0sWKupt7hDCuuwXg43gjFMdEmDs8QDxbXR1iEOgnozVM+ESsh+H7KDOJ1aKOBQO6pMzVP2XmGNbXykhN/KQIUDTgMnCt47Jp+889PvU8BbL07aJiWkOOH1ADR8c8vAsV1tgYBMYYSfsV1nQxwC41o/8d7qZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1cpPaJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1cpPaJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504121F000C4;
	Fri, 16 Oct 2026 23:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792192263;
	bh=RyAJ0e0U+Cf17qyn3E9P05x9ivfs8oTxhiBSAoU9TaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=X1cpPaJ5diezWOSDB96Z3yaCIQja0d091uSpZipHrpCr9lOM7SZrUaAxqPmQ7sz5x
	 9UcGiuLaUWHukY+/7vRdmvB/0L2jeeXgtwTOj/FAn+G9VStyr5IbqLHEiBm17GRsAx
	 16WnqaZGzVUxR5HI0oa+YDFRROPdUWDTo42KyBMIC2mFnPMinWhwUiuXtOXGD3FnmD
	 NMNZwRAZ4IQ8LTbeZhcDjaF9Yw1gZ95MbiEbDg4IHQJKp1ViXBjCPf1sSMriEYW1ei
	 aE7ok9IEjy92L0E6Nq45Zmm761C1B0QcIMbPAdrUU4vqN7Rf+mMesgGQVfhwqXKWr6
	 CgIZckiHQ2K2A==
Date: Sat, 17 Oct 2026 01:09:58 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lee Jones <lee@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 30/53] rtc: m48t35: support the SGI IP35 timekeeper's
 1968 year base
In-Reply-To: <2026101314285588f70d85@mail.local>
Message-ID: <afff29f4-c16f-beec-9f59-9a7baa9c7355@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <271bf55b479fbfd9b934e93a13eb8e96eb64e9fb.1791890466.git.kaloz@kernel.org> <2026101314285588f70d85@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hello Alexandre,

On Tue, 13 Oct 2026, Alexandre Belloni wrote:

<snip>

> Instead of open coding, you should use start_secs after setting the rtc
> range in probe(). attached i a patch I refreshed for the
> devm_rtc_allocate_device/devm_rtc_register_device conversion that you
> can include in this series. drivers/rtc/rtc-mt6397.c is an example that
> should be working for you.
>
> I never sent the patch because it is not clear from the datasheet how
> well leap year calculation works. My guess is that it worked in 2000 but
> fails in 2100.

Thanks, that is cleaner. In the next posting I'll take your devm
conversion first and set range_min/range_max and start_secs in probe
instead of open-coding the epoch.


Thanks,
Imre
