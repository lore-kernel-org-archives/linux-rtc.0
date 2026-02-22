Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998F18C933;
	Sun, 22 Feb 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791515; cv=none; b=uew7wqd8BQ8+T/pdmKEQd55DL3qh1P/znXHIix1WeG/aVEGt7aJsN3x4uGHz9lLpV1Y1QO0m5JPBJ8c81dyftjs2TQGqIBNSnZhxiaHyfWezhUt2o4NxTLN7dBk1o20r5L/PuLtecYFHDVOsSh9cavZGWT5lwaPW4XLiJWR85C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791515; c=relaxed/simple;
	bh=WBUIUbwiVSjKag0CMM55Smv5XiEKAsR83tnWcKvs3LA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HMLrQat8nWYQpWzM/U+DqILm8+lGbsGP++Ue4sbBve4qViwU/Y5ARAIiLrvBt5eA9habeJIC3sVywWooW1U4YrKbNJytgVgcWIFH4kGpNGABtme2WnOqhNadOE4jXsJDFoarkMAOUysO+T/B14+okEYRbYiX3IzfrT9C/vkIi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSpj/LM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSpj/LM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9C3C19423;
	Sun, 22 Feb 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771791515;
	bh=WBUIUbwiVSjKag0CMM55Smv5XiEKAsR83tnWcKvs3LA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YSpj/LM5QRRlCofMkC2XBcoawm4ZSsAwEwAQWmg3YAWCa9M+7COSXy6xT/QGH1p9O
	 CIln0waeITT88x3lcd9NfbiDDtT6NDVmQv601d0ZBeWhFQ4nOOiLMqZRn2xUAFhQ0a
	 c9nRMqftXivuTm+PFoMAAlTs+lr93sHSApNDdtjP9FuQUlyPFcm/moNvf+gqmug2eK
	 MLUhFzTi5O+2LxI2ORpgaOINu54/ym8DEHdtdSwpD8YogwyoduoN92iOyEFgB/kEXC
	 Mv51gLP4eBw4BNscnb/RPXB3FtKaKRDN3MH2W/LWLrUhWG68ku8wpGmT04Sj9YIgP8
	 TsE9YYeWPY8RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403BF3808200;
	Sun, 22 Feb 2026 20:18:43 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <202602220133264688bffa@mail.local>
References: <202602220133264688bffa@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <202602220133264688bffa@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.0
X-PR-Tracked-Commit-Id: 969c3cca0f3b88682cd833cee4cf01b0915629a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f2eac7767493bf23e6552db82ab25de0dccd54f
Message-Id: <177179152192.1490320.8083253920291635755.pr-tracker-bot@kernel.org>
Date: Sun, 22 Feb 2026 20:18:41 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Feb 2026 02:33:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f2eac7767493bf23e6552db82ab25de0dccd54f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
