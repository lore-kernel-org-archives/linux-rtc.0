Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555852;
	b=5mZzQn3+LB7aEmcjbVo9Fd0Gn4r8/LZdEYvIJpcW3QD1btNWCLyLh8PhF/TgGingTj6o
	 3gbCkpngyRVAiryR7nzwlaEOFVoAgN5ca6JDRt1rdzLlqKAOj1VG4fQC3pWQZm1uLHvZ9
	 kLbRTBTvK5YpLCSJoyc+XJUltLBDR867aJhinqrBQmBBtOp04Is/pI8wBW0gHFA24TRc2
	 p5NzTtIVbQLgCAbMJyZaTkHZUd88llAberzZxgFhW4LySouA1Db2OMeVhtqWyrKQyiCam
	 6Ud08mOfDdUBgqxIEmlieeIQ3eLqzQGf7ewlySSnQujjntiBuJ6vYSz9/6gmeVrt21Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555852;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=H6dltsimAn1vUiuyzS0TosY99OK6JSALzJ6pEoHnQrY=;
	b=aNXsr4EqOlKjSozDqYci9WhOd3r7DsMJh0CrPsbzNNWgMu1EVfWXeuuQ7E6pAIkfUwOP
	 XQ0BD2oGdidCUNl6EVxwA/pNlAMlYnEFe8JtwuehZoDLD8CpOcsDeGeoP06H2n2RzJmEE
	 YyO/EyKqPA6D17jnAZ8myBJFQ2MgxT9khZ7Z87fiiODPDDjThF6cMx8r8WZ0kawpdqko6
	 wrzVcKAt3r8IOQybYHxU2mQt55NaTCQ1OHN13e0vKgSdU8rgckdIEen/dy+Evr8o2maKK
	 IOrW1yAc1z74jJHaziDghpvHimiXlm15enqI6Oyee2M/okrXvBUkQgYE7leZebBzFlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm3gZJPP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A39606A324;
	Sun,  1 Nov 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm3gZJPP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA361F000C1;
	Sun,  1 Nov 2026 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793555852;
	bh=H6dltsimAn1vUiuyzS0TosY99OK6JSALzJ6pEoHnQrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jm3gZJPP/nlD2y76uuhozjk2ttQC5OjL5Z/eVJteksK/t4BZMxFnFrTabzpmkbWE3
	 4VtCKzgrni9f4gxcffMoRAOj76pRhEDC0wJ5Jduzr4LlFOsktMAzjuQgihXQWKQJ+G
	 6n7U9L1nhyrgzGB8cFKX2oGIUCLMh1kCF2g3mctUUE/lK4WkxQ/21oSj0/mWBdhGLF
	 tMOdrp3t9Tli1/RDpWTIZ7wjHDyyxmYjDlDxE9/LkVsQePNtFhjlBNsn6yzKI2OE+2
	 UlZVl3OC8TZGHbfiadfJodFr4uQt85Ni7FlthuB8dQy/yHPeKNWAwcRFJNK2SokYo4
	 Ys3RCibdd8JMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0335538003F7;
	Sun,  1 Nov 2026 17:57:32 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202611010328159ca7e972@mail.local>
References: <202611010328159ca7e972@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <202611010328159ca7e972@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.4
X-PR-Tracked-Commit-Id: 7485659ecb81d5fce3a3edf2cae9fcb29c17b1cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b6f2eabc8371dea951c244f4aa9e013f36de9f8
Message-Id: <179355585062.2549645.15368749411829677851.pr-tracker-bot@kernel.org>
Date: Sun, 01 Nov 2026 17:57:30 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 1 Nov 2026 04:28:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b6f2eabc8371dea951c244f4aa9e013f36de9f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
