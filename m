Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165E39EB59
	for <linux-rtc@vger.kernel.org>; Sat,  3 Oct 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050183; cv=none; b=s2u464xrAbL1OMQ2FdJjE8mf99Jy1vKtNmN8XdNAWDR9rQtqYtDDoY5gNB9Dim1GuPvXl9BrdV7R2u745lXA57IktTZuhmImI6AD6eSWuGA6dXRNv1bKrWgNb+J4z2J12N1X+AMjKqbpPVf2XiOU98Nhaaebylp+fF1HblcVw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050183; c=relaxed/simple;
	bh=JT3hkcx33L3xXmMsWUfvbRq3NCx+hdL8SUTLmLrzxBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqu0EiVrv1XJE0hboMCOdM5l57ARDea9sLuZ6limo4ldswl5N8yRKQFyOgpDxCLKf1Z287VImZ/yw7LbxVs3AT9BxzTxTcWOFgRfkjtw+kMzKFOdP3inKbJMjsPbWoW0DkeM3rjHrYVG/+Upxo0fLTVBLoV3fYDpcWDUfQ7QAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn+ojEW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn+ojEW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807371F0089C;
	Sat,  3 Oct 2026 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050181;
	bh=CsACO+F1qmLRanPlBqhUXC5T6S3QGtGz/7XiPfscKxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mn+ojEW78oh143v9QtEV6ABZvxrgNcmLzzdqjdpOtIt9Xh7AxIU84fgpC5x1b32QM
	 l1IpoVaQ/M1r2d6RASguLjJu4ss7qgwlcCSYqlcOvasr99oYCG4+E3+XuQZ/SFT+F9
	 gF3eMq5fDf6nBnNrRLDIa/IV5p9d+ZpV7PLEE43tj+9j6sB6BfL4Pm4r0QRCA5gnkf
	 QxXkk1VAEe6KcPWhyWspR6YKQmJe6FeLmG9fcSCX7tcNlD//l2mQLJPBIpIXiH4xzy
	 5H2fkkZqInDhCHybHoQH3K4pgVGjewxbOacquiwEXQwUZCfPm63iFyOacxtyh/9iY1
	 rR4ZvpPVybiDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: class: Do not inject sleep time without a suspend
 snapshot
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxwZXJlbiBLxLFsxLHDpw==?= <sabri.alperen03@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261003163138.14221-1-sabri.alperen03@gmail.com>
References: <20261003163138.14221-1-sabri.alperen03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:21 +0000
Message-Id: <20261003175621.807371F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> rtc_suspend() returns early when timekeeping_rtc_skipsuspend() is true,
> which is the case on every system with a persistent clock. old_rtc and
> old_system are then never written and stay zero.
>=20
> rtc_resume() is skipped under a different condition,
> timekeeping_rtc_skipresume(), which is only true once
> timekeeping_resume() has injected sleep time. timekeeping_resume() does
> that if a nonstop clocksource reports elapsed time or if the persistent
> clock is ahead of timekeeping_suspend_time. If neither holds, it injects
> nothing and rtc_resume() runs. With old_rtc and old_system being zero,
> rtc_resume() computes
>=20
> 	sleep_time =3D new_rtc - new_system
>=20
> and injects it when it is not negative. For an RTC kept in UTC this is
> [ ... ]
>=20
> Fixes: 0fa88cb4b82b ("time, drivers/rtc: Don't bother with rtc_resume() f=
or the nonstop clocksource")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2543517
> Cc: stable@vger.kernel.org
> Signed-off-by: Alperen K=C4=B1l=C4=B1=C3=A7 <sabri.alperen03@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003163138.1422=
1-1-sabri.alperen03@gmail.com?part=3D1

