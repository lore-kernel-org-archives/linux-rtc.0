Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459880;
	b=zXDjPYeiuC4vbag192KhlFqLJ2Kkd/Xg6KdYopX1djcescmUqQ5AUHRAm4ESpNuDCIaz
	 FdT1cqR60bbE045TlfnIEjG/QrSNL6HZQOGeqmIexyb1E7GpMAUge9DM6ivmQD3+i5G3j
	 LUEqqoOLW36HJURQBsF86G9T75EkZxI5IYNrtW9veUl3iXPyu+qqG0PoSq+SDf6MmBzkK
	 PikzBVjpP9XbNZARQuSfEQX7zNRky0bPgXEnekveVLKnSJhuteMiivwd08vH4QMAeFy3t
	 iCuaHBjpi4CfSNKUDqpnBMwtKTkKKc24LqydntrEXhqBmUaiRIVLy6OubkN0SuSyXkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=daVByn7j2jR8uaMd7QsDo8jLwI0iHI0JwdjkAQGROP0=;
	b=4ESn/oifMGni42kbZOeSqMNEdVSKZjBRFHzncIOPMj5BmXIZRF6yhL309ceJbNSH2YW0
	 4Ffwmg/6YLD/wLXAYp+GTf4RweCAHizMp48SuVX4YlaGQME0MO8EKRRXiyRfegAhiLOo/
	 tDa9gNzE8l5Qx2GHCWyYK6+eEBBG2tkrya61mAdZys2KlYgKJxS/Kig7BAX4bdI5KVbhz
	 NM/HsObuRrunqoC8TKk2WD4yDFMjucizs4yc+H23pwClcsd2rffRR2nL2h4KkD5kco5nh
	 rt+S6D8JZCMDgsjrEGW8Yslvr5wgr2ga+1lNIMCyzsyujQEPR6lNMnE2DP16EUfseeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iy8eEtZC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C6606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iy8eEtZC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AA81F000C4;
	Mon, 23 Nov 2026 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459879;
	bh=daVByn7j2jR8uaMd7QsDo8jLwI0iHI0JwdjkAQGROP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iy8eEtZCJps5w79Py0qVATmOygA3Bqc7F+QtSmNdFQM8OyOjQuFvh4lA8zw08MGNk
	 9poX3wpoJi8uCwvaVKkFhDt48lA9y4bChzv7LPMUrQn62IuPkodvJKq1R/apRDzCy3
	 XK+VskypAD2FiQ1cxz5WaxROeNNN5J+Zrekq9FacqerTNZEK/15t0MTScM3UQ9QgJF
	 gLRBBu9GUTI/c/Io2jF+jBKKQAITuZExUMmCaSqM3KqhK9CBAzUoFJBmITklc05aTl
	 /s20NPg7rRIswFZNUo7BQBvBnFAl4BZ5OTDpeFPLu2l6q5Qv8FF+D2ZmRwGxmWkkar
	 QuNTKgJQHw2zA==
Message-ID: <sashiko-outbox-229880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
References: <20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:51:19 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patch 1: no issues found.
- Patch 2 ("rtc: Add Cortina Systems CS7542 RTC driver"): 1 potential
  issue (1 Low)
- Patch 3: skipped (not reviewed).

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
rtc-v1-0-6c53761ffa03@gmail.com
