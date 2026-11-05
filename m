Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864872;
	b=uPTZpsaBX6n9pqEIaPvJ3FXj6frROsPrKQnLncNcj/w9lMnIM18w+wak0s5ZmnV7+4FC
	 rCv1YxxkEuTH4D2AuCCzOfhRrXypGFJyJCdURdPC+iu6BPtgRYninq3qUqGRVh6cxo026
	 /VuvdTBhzfDA524NSTcrc7HpFRQ22CF4MYbkyeSWB6NYTyqqXEBXQOWLxO9dG4Fzgvgdn
	 E5nu7ewqiytOj+lpsNLsp5qzJzfqzL66C0HfOl7OzIXIrrumFknkGVTkaVaAbJahUgoCd
	 C2QD7sUVr76/eLvp7ZZuAl1DGcF5aQsdx0c9hae6ajaTTVEwg8Lt+hXeqw4zvKNd5iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3/Ag+eTQ9cQSEenfBHygwhIfbH0DbI5tUvl80Bj9Gf0=;
	b=R0NUA2GUf0PF0T5EPQTNnDCHNVyyj873+cxcPhlETEuHIMkRcAiesSbVzEVjz2TIH4Ff
	 Bw76jr9yWULQLL20h73GBlDssCMInfctjJq1p80XKA+qCLP9itbBuD3oT/dNN2RYmbQDq
	 tCRps+Axd76r6AtmynxV42pkRoji6N2twX6q+p8UnSoeJyAl9jxHZ/gVAhce4Ci5gI1ZB
	 tYPAjeNeMyxRdpSEUgNPloFpV3dL46eRH+kEl1dAksmMz67cOMQ6oEVjRlSUI5UTPaiQO
	 t7QvL4W3wPypKa3aKvQbql6kCdtrhrliooFH+Fj5++T/Q9pOqAHO50L/0F73w9oQyGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zihxeo7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF252606A332
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zihxeo7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA91F000C1;
	Thu,  5 Nov 2026 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864871;
	bh=3/Ag+eTQ9cQSEenfBHygwhIfbH0DbI5tUvl80Bj9Gf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zihxeo7j1lAfr/sh/LPGrQ7xDWLjdgONphJ2wlDwiOoqLhrH3svR95xWuIAGuqY4n
	 4vR+IyUsVLVGZ8xKKczQc0EQAt09AXYgSURk5ZCjojUshwyokiBAtb+iIkzbr1pBXB
	 VleGvHQp8AmIF16QNzunJNaP2f5Hd8yjJTd3rNSV7kbRuSubgjgDYcS0g8h2E4FY7/
	 6yeyavye925lRQYYytEHBOazPBdqTwumPusAETWJXanFEVhG3N8wosLt2xrVKT65zz
	 H1pgNBMNu5iF0Tz+S5z074B97aIOCLrm63dvUyxvInkQN4D5gMKL2v/lhon+qk7a0I
	 TPN7ApkNoAXmA==
Message-ID: <sashiko-outbox-198697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: interface: skip the RTC read in
 rtc_timer_do_work() on an empty queue
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261105073742.2193-1-lirongqing@baidu.com>
References: <20261105073742.2193-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:47:50 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> After rtc_set_time(), the RTC core schedules rtc->irqwork to re-read
> the clock and reprocess the timer queue.
>=20
> When the timer queue is empty, there is no timer to expire and no
> next alarm to program, so reading the RTC is unnecessary. However,
> an RTC read can take up to 3ms on some systems, blocking the CPU for
> a significant amount of time. Even on faster systems, it can still
> take around 50us.
>=20
> Check whether the timer queue is empty under ops_lock before reading
> the RTC. If it is empty, release the lock and return immediately.
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105073742.2193=
-1-lirongqing@baidu.com?part=3D1

