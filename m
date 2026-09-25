Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC17352037
	for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321430; cv=none; b=OD94v7WYgzL084UGfm0aD2cKiePRlGRkvMT5+OkfbL3WJp3Xkpkbtt1m0I8UvEm8xMc6qfcF1AAIz5uwNsRZeaIcouLgff/SOhXPCZ1K9kgYlc1kjNtjq4J0htjYHPm7eZwQ4Pww/jDK6aTOiTeCXMP35FYxrUQTOVI9GYUqjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321430; c=relaxed/simple;
	bh=kUfO7c9SNRxF6VeHsFriDyux8hyKy08HpoA8irIYN3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l5ikWHsRjkUzrVoF7DqJIRgg2XEbOPzt/EY+UPuFoJK8Wu3jb2KMV1ehN1ub3utc6/5jtAqdlih7rNx02Qwjc5rNeI4EOjx3f5WBAgH02x004lp5AEpgR9HgbfeCK9hIhZqWjYnApwmc6HJ3UqIkwG75//ooI95Atrx+ubj+uUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMem3cWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMem3cWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F41F00893;
	Fri, 25 Sep 2026 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790321428;
	bh=kUfO7c9SNRxF6VeHsFriDyux8hyKy08HpoA8irIYN3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMem3cWz0YPyDXupPweQgTMU3rJjhynSMPw/THWifDvgtUz3FO7bb6umbXfszNR9G
	 lTeoF5fay+ZqvR6Mtf0rY4JnD4ZBPBTHhLRf1dk+yh8f4hWHENvdOnl8CmoV4OtH91
	 OSL6h8aHmJeJpRoO6eWGgObX0OBzI/yX39UbC0A1PSF2cDG5DrP46a8I5xFL0WOmjY
	 BWqe3EO3URMArQYKryYA92JQDQVoT7idJKHew7IWb2oXa9colKFkwSWiQJGhSZF5EB
	 UyYqHaAGpGQ9Gmd4lPRDs2Ol9Nr+2gu9SIOKm0gVJkDKSbKD+NeJaniZB1QlbFDo/N
	 7W5nTIpcJg5fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: ma35d1: fix unchecked IRQ error and
 IRQ-before-rtcdev ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260925072345.2632042-1-congnt264@gmail.com>
References: <20260925072345.2632042-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:30:27 +0000
Message-Id: <20260925073028.743F41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> platform_get_irq()'s return goes straight into devm_request_irq()'s
> unsigned int param unchecked -- a negative -EPROBE_DEFER becomes a
> huge positive number, so probe fails outright instead of deferring.
>=20
> The IRQ is also requested before rtc->rtcdev is allocated. devm
> teardown is LIFO, so unbind or a later probe failure frees rtcdev
> before the IRQ, and an alarm firing in that window has
> ma35d1_rtc_interrupt() touch freed memory.
>=20
> Check irq_num for a negative return, and move the IRQ request to
> right after devm_rtc_allocate_device() (its irqwork is already
> initialized there) and before devm_rtc_register_device(), so unbind
> unregisters the device before the IRQ is freed, not after.
>=20
> Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260918161925.2639130-1-congnt264@gmail.=
com
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925072345.2632=
042-1-congnt264@gmail.com?part=3D1

