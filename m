Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8B314D13
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760142; cv=none; b=n9IFNeMZA+sjvT32ucmeRc5DaNdCHCKWUyFQBHtZ1KXveKqU+L4NFaZfa7pKk47WmlAfD1oygpHjyiW6upKCfnOFNn6EcmO/UAHDwAL4c9KbDO+L0PTkruaMj7tySs+gillfIYI8zc3QiWcGt5e0iOJevrJQCJQ1Qs5iGHJbZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760142; c=relaxed/simple;
	bh=RLcb/0wY9z51Egv5qKMXffYetEq0M8tCswpbwPEg+Ko=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kLGR0AbJ1Kv6LGjkzBHDQzbG4rjz7QWmHNx0o1/KCN7qhD0H9F4DB1ZtSDDmzQd2WgOArBQiR5tAzjPbHGl4SsMCgYFgdG0yXPhWLOT+mtQoTl5y6WcbsPHjkhQcsb4NfEDMuWmrtHzlj2AsZcu+qPC34/oAqT0/JZNyhETK6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz1IYYXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz1IYYXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823FF1F0089B;
	Sun, 11 Oct 2026 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791760140;
	bh=RLcb/0wY9z51Egv5qKMXffYetEq0M8tCswpbwPEg+Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fz1IYYXsjxwjAu2kOCZauM9+nflD3pMRVqMHUwCFRpxC+bnEAucKf6U/kfDGw2Zxj
	 UxfVmyyStDb89XlFndHRVE8ka+aMaQc3hi+z3uwmE/AqQKC6xfHNOUl2uah5DUgpYT
	 tgWSQMAq6fLhC6perzt0lspw+tHYK2g5xSLw6mraP8joHX7Mb64oCDWUXvnTUvp4Ry
	 KodquMvWxMHBlgO04em+7ZMK735KQrQIz26/kwc8P/uDVIm6wdW3JpsD3xkZ9ls4Ai
	 gvSTYtEJiWn//HsxcznrJzTPq50qsThoBb7fMsNSoKfJ1ujZSDdSUQfaI05fDNCS5o
	 1Zy1MsqsbT4Ag==
Message-ID: <sashiko-outbox-167506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rtc: renesas-rtca3: Initialize the RTC before
 requesting interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org
In-Reply-To: <20261011225657.rtca3-irq-ordering.1@gmail.com>
References: <20261011225657.rtca3-irq-ordering.0@gmail.com>
 <20261011225657.rtca3-irq-ordering.1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:08:59 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The alarm handler passes priv->rtc_dev to rtc_update_irq(), but the RTC
> allocation is managed after the interrupt requests. Devres can therefore
> drop the RTC's allocation reference before freeing and synchronizing the
> alarm IRQ. Masking alarm interrupts in remove does not wait for a handler
> that has already entered, and a pending alarm flag can still be handled.
>=20
> Allocate the RTC before requesting the IRQs so that the allocation
> reference remains valid until the IRQs have been freed and synchronized
> on both removal and probe failure. Initialize its operations and time
> range before requesting the IRQs as well, so an early alarm interrupt
> cannot queue RTC work before the operations are available.
>=20
> This issue was found by static analysis.
>=20
> Fixes: d4488377609e ("rtc: renesas-rtca3: Add driver for RTCA-3 available=
 on Renesas RZ/G3S SoC")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011225657.rtca=
3-irq-ordering.0@gmail.com?part=3D1

