Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E62DC765;
	Fri, 28 Aug 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939423; cv=none; b=eYChYdnMNWlmVtr5G15OsRWNLEv0zuP3Uktgoc8bkILT6LzYxeLCDueSp7TmWnSlyRkjWai4OEvSZKj9uZ7MhImm5Cp1GL7hXt7cKvoRgqA0wVqga1lrp2qJsxl9/nSIAZ5xFs26zk8zfaU72hSzfxP67qapeEJXu1Z9O9ID8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939423; c=relaxed/simple;
	bh=f05MusBF3ttH6Xr+sAIcBQcZ/Y6Fk1/dQvqbLSTgZwg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d034mnQBZ448f6Ro3lFB/mC/kzyaFPYd/7U4x5cE04BgNdWVWrKrOfVZVw0ZxvN/P8UZloFFuNg1jvleCgb4tZt88iZjTzqQyB5yeLXVpXqfrCVLEIdu1QqRF6ziQFpsVFW94t453ULIJ1L7PXvESC0OwsMeqnpWZvKCnX5jAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfdAj9Wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfdAj9Wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7751F000E9;
	Fri, 28 Aug 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939422;
	bh=4srhiZt0mWd0HA02ityJkdH3lv4dCB2lmOuaQEynI+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZfdAj9WpYUSOGl5BSpBh28Fq8EdbeaudM/iLK3E9XIM51gQULoD5vBmpln2MVPjnx
	 nVSnd2bkRhblm5v/gyhDp59ckd93MpLTk152wU9vX5Ed4FXYC+sxptkX73Ux2CuiWq
	 yoXJJMlnnusUTW/knONTGP/JOKf9GPjauBnncW2qjr0t0GoAjZLt2hQ4TaxBDTWEPv
	 6P4xsp1UanIM0uNnhtKvVAJLUJwNCoS/2DX5tKoeaH5RDfXSD755i3zzkzn1Wgultu
	 2zd3RoT+iBpPqT8gN6oLvPuOSJ1pd0Ae7a6tw3V7sBi2GAQdv8AemBhiSODR1JegbJ
	 d34QExemHjDUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A54380AA67;
	Fri, 28 Aug 2026 17:49:28 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <202608272227121fa40dbe@mail.local>
References: <202608272227121fa40dbe@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <202608272227121fa40dbe@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3
X-PR-Tracked-Commit-Id: afce9701d6423a63194a349d2f1e34c50ce76482
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 275bc4eedf2c6081200998954efcb5eb90413a41
Message-Id: <178793936749.2708560.15059559258192838181.pr-tracker-bot@kernel.org>
Date: Fri, 28 Aug 2026 17:49:27 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Aug 2026 00:27:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/275bc4eedf2c6081200998954efcb5eb90413a41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
