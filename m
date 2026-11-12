Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444359;
	b=eMre+zhbagAIov3sIEZujwCoUVGRuaxEHj5C0bCd51dZbzc6rW582VJrrsXHCY4Fs+Jh
	 +2Bi+4ZfaRtQr5vrK6NHcICq7OmplHNkAygQQLd+4o+Ulp8HaEuWT0yMj+RXUkfjrDC6s
	 eLXhxIbzdqvT3YYPpyzLNuLb/11ppXc1zlwDnWgSSUSk5XA8qdlt2v/lA2mqUGjUsK6q1
	 FDaHSPIrc1ywOSXX99jF+AoOE+GlGiy8st5HfVNVvXhWyGS7AGkTVwPHnPSIJvu3X526p
	 YdF7NuGru8Q2qNsL4RYOJ0E88c6j1zAXZPWxRTNT3PoNv5IlZxEXZOhNJtNz555yL7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444359;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5XXSMu8maMZ5nqUNHDQL8vXfVPzm7zilcNvMh1o+A0k=;
	b=hs24X+gKMLxfqiMF86DGqc/fNkhnw14qLk6+cs+igLAkVxhyvROGZg6hJ0k25fbSu3fD
	 cLSd4XBS9Gw12EB8vTfTrhYINnM8EpZxKztHO1zHt6Kt4An3EyrDL59ZfCUyhsdTRocGh
	 Zn9EtoiTKYu8V64f7j+qhDX/VpCHh3av/FZa9O++KgA2wexK2tq8fpmZPARBO00IDeQdl
	 nIzbqeigf9fclJc6zuZocARWaqaRvpsA5BSnYmqAKXsenaIo6+0SRowaf2pw2tY46avi+
	 +pG10NQJ2uRiXXKSG4c8pEkk2mF1AOnEUB4Zd0YRbeJMSxyeuPgGfHuQwvSpEgcNPWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSSqD7gm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEA606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSSqD7gm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91FF1F00A05;
	Thu, 12 Nov 2026 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444358;
	bh=5XXSMu8maMZ5nqUNHDQL8vXfVPzm7zilcNvMh1o+A0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSSqD7gm4JCSGyzPS88Ao9lO3FchtgBcNQobbUmQVosQasE1lfAJKtP9KMsz5/H/c
	 mO2ZnNojjUS63hULJ9wp2vWmtP+ZA7Aclo8AD501QztCmF3PcfCItZG2uW2WMoDHpa
	 EpjwfxwfE9r27FeTHQ8u/EDQw1BsxKhstYHgII9wOdn/yEsMBkN9Fly5l8UP20f8MG
	 GaZVuu2lnK2AmhJr1bZuB+R7az976oBByQmTnsl0Gkb9zpCXXDPhqPoJY2bbEafakz
	 IlNSDaDMryFFKPCHmdH4iebPgWleHaCRHP1xoPHrPpUo/MnDClx0vHbuEuBFyv54wS
	 7LrWm5XeNPApA==
Message-ID: <sashiko-outbox-209985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: interface: fix wakeup source leak in
 rtc_timer_do_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jesse Casco" <jesse.casco@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261112002125.24566-1-jesse.casco@gmail.com>
References: <20261112002125.24566-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:45:58 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> rtc_update_irq(), rtc_set_time() and the -ETIME paths of
> rtc_timer_enqueue() and rtc_timer_remove() call pm_stay_awake() on the
> RTC parent device before scheduling rtc->irqwork, and
> rtc_timer_do_work() balances that with pm_relax() when it is done.
>=20
> Since commit e8ba8a2bc4f6 ("rtc: check if __rtc_read_time was successful
> in rtc_timer_do_work()"), a failed time read returns early without
> calling pm_relax(). A single read error then leaves the wakeup source
> active, reads of /sys/power/wakeup_count block and suspend cannot
> proceed.
>=20
> Seen on an ASUS Zenbook A16 (UX3607OA), where reads of the PMIC GLINK
> RTC time out and the pmic_glink.rtc-glink.0 wakeup source stays active
> from boot. With this change the source is released after each failed
> read.
>=20
> Fixes: e8ba8a2bc4f6 ("rtc: check if __rtc_read_time was successful in rtc=
_timer_do_work()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jesse Casco <jesse.casco@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112002125.2456=
6-1-jesse.casco@gmail.com?part=3D1

