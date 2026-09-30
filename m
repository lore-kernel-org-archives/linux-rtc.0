Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7A343D7F;
	Wed, 30 Sep 2026 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735310; cv=none; b=qO4FQSHWMylF9cT2dFaIDR5QgZDr9aR3fbev5Xq9kZvSItQyURM7EtPCPLynETuzfmi6WUMvGERf8FFYRz5kdLY/mdNKVuXzUVAX6Gx2l7hvMEflrd+gzCdGR9Ke192mtbDcmkuh0FDd/SRj7n3ihpn8/HqhF3b4dVTWMDAvubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735310; c=relaxed/simple;
	bh=G1ltNdLbTk1MiqANRahf74/IaC4m0cRv2t5VWG7A86I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dgMpGiqdEZm3nQATHOtH22FprQ7P7SJWMP0Mk2hC+Rb/bx7bAdQUjpOgbejo290bSnEHLZLyY0e8dMKXSEAWjtrMCjE6I8iHp2WRLsLF/3rQ1XxjQLTKAu1SjZlcqsu7kDslejLS6Z7K0mPTl6RhpCkYSPdtiNxTNU8nntyw2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe/DvuiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe/DvuiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822FC1F000FF;
	Wed, 30 Sep 2026 02:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735309;
	bh=h0z80SlRhfuV6jm+tJ/FKenIKEMpxJbTVR1LCLzEvmc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Qe/DvuiRow8+7bczcY/+08E4DygwWdTDlOq/ee5JQWIGtdPQjoROT6o6djZjkJRfr
	 GG62x3iwvqgCgUqYqm9OoAUnLcBseu9AUH0zo0A2/hv+E2FXSAy5cVwr8BKRXJj2rU
	 k2i+kARTgcN8nZbi5LQHiMMr4wLNZ/pRv/VC+hM8EQJoZVseIr1lWOKQdmd/kO/f8W
	 RQJNxSlxygfgsmr1xztnliI0ClOVbnXD5WSNkJip+M/OELuD6Fxp+uWyj1aoU6iTYg
	 4elM8D/Ea23xdCri3gvTLVfeox0cXtXOot6tWafmXxqlFaRlw2j2oeaYj5R0CaXpwh
	 nrgu9VStllFpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775E63924FEA;
	Wed, 30 Sep 2026 02:28:29 +0000 (UTC)
Subject: Re: [GIT PULL] RTC fixes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <2026092922000025ba1a22@mail.local>
References: <2026092922000025ba1a22@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2026092922000025ba1a22@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3-fixes
X-PR-Tracked-Commit-Id: 055ef5ce9f67a6a3a1363fa663007f8196cc0fb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 551c722f40809618230001baccf219193e22fc5a
Message-Id: <179073530796.1216333.13046033889935386729.pr-tracker-bot@kernel.org>
Date: Wed, 30 Sep 2026 02:28:27 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Sep 2026 00:00:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/551c722f40809618230001baccf219193e22fc5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
