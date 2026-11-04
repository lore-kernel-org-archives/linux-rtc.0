Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776226;
	b=qiAwWm+7gA8O7kgtNaXGHWmnGnLuwkfBmcBVvMjPULyqyT5kuPX2g2D8aVwYNoIKoeii
	 GKpiStQx8QJJpR1tKp1xdnbgP82ph1kzbM956c3c1zDQs/Yxh38g231eYawbpP3xsO1Ot
	 Y8z1BiylQd+GBx82bocF1Vk12qKB+ojhjgk6sUqf5+UZIL6FPfd7Vmo6M/r+vA5UetKVe
	 6aKjxPL2F5pZ2DShZbPzJRDszDYlUUwCK50LjRKpt4zXL4gpPF5mZc7ZQ+yeTzcjDaK5+
	 +hnkN+cZSsNWP4h66uedgOowYVh+1+bz5u2csaqUq9XsQQ0zzGChlFz27XeHCC2Cqvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776226;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IO3cVza1i0usdKIWVNIEoSXPxMhdh5D5NOd2pz4wcxc=;
	b=tz7eRYC0or+DmyjWL107EoRaV99bo/gWy08gb+ENNs9CN3KXVuAldwpy0CyGVeHSJ+qb
	 U2CnLt5Sh1XpvxIurXLB449qc1WnAUfwWl8QGks6aBDb2fnrF61yK9b/hwH1474rjxoO6
	 SHe9PkqcyHq7Y/5nH+7P29jOWpAw8+PMWPBuL/iLDL1jOyXMbTUqfkbL2/5oinb5XtsrZ
	 ad/IRjtpRHH74LaM0ee8mL1Uj9xOF+3pkgFXma1hj7JbzbbRzQGP/icvmtp05z5qiCN2o
	 O8sre3EzDcBs72XcCo1ZzmEZU5nMI0aijqDCMi0pdM7MtNTFsOgBUg00vvic9mS8j/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6BNiPhn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A2606A32F
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6BNiPhn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610C41F00A02;
	Wed,  4 Nov 2026 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776225;
	bh=IO3cVza1i0usdKIWVNIEoSXPxMhdh5D5NOd2pz4wcxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F6BNiPhnDZaAWJc3GgPxz70yZ2odm/RL4dduN5hLGpw9uVmzzsKFcdkZWxtDUAbmd
	 SJoNsAtp0gdytwx7RIcQY9RQgUm96PYsxNNwcsDPFWvv2SSI4MLKtqAoiJ6Au8tArw
	 Mf7VJS5f3x7sRRux55bs1nPumZc97bCagnTjgooa+qApazH/+Sxx2VBN0+jovzEjDa
	 JGT6YtQgxxEX9ZyRJQKYQqmR4c4iRswJRfRt3CcjqSnTeF68Kcinca9M0aQ1AiA9Ow
	 //Ru5tJfbYQ0mdMryjjSM2HsQjB0AhNhP/a8Id2lUc+QI2xLvGmUDI03zJMZyFhgY/
	 hpI2CcIFlNpWw==
Date: Wed, 4 Nov 2026 08:10:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rtc: ma35d1: release the clock reference on probe failure
Message-ID: <20261104-hissing-succinct-cicada-8dca1b@quoll>
References: <20261104025339.1527356-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025339.1527356-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:53:39 +0000, Wentao Liang wrote:
> ma35d1_rtc_probe() gets the RTC clock with of_clk_get() and enables it
> with clk_prepare_enable(). The clock reference is never dropped and the
> clock is never disabled, not on the many later error returns and not on
> success either, since the driver has no remove callback. The reference
> and the enabled clock are leaked for every probe attempt.
> 
> Use devm_clk_get_enabled(), which ties both the reference and the
> enabled state to the device lifetime.
> 
> Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/rtc/rtc-ma35d1.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




