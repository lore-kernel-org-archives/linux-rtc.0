Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F6627644
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418697; cv=none; b=fwFNvjXXNXUvQfSyMgPEeb7HMeWr5ZUV/FIjW9JhQ+lddL2ODtVy54zjl3k3GfSCDZRNUs5abB8iHm9fG5Z9bXSGshAULsX7yFMEa+DDHe22D0/VQxc8vuXnDyBst9n8FuD+KnwnFVp13apmYNGn9ZARnk6RvK1/XPFMpNiee3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418697; c=relaxed/simple;
	bh=B2PoRgPlF7jkE1tkCbpv9fMmgAnz/+XIVJa184jUPXA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RTs8iyIGhlw/j+GF2jkXawHh0w6DK/IwbKIP65+u45RVApmaqn9AW2wHIdLVy7nw9w695oh5knxMbITOT7i42Nu/oM+FLEUKwNCI3qj7dxP9mXHBgmcX3XSh6G5Ud02mGznlg6dFHlKR3ghMm3h7+94IwE7PVMJAAgdm4Mec2DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJVZ4795; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJVZ4795"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0B1F000C6;
	Mon, 19 Oct 2026 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418695;
	bh=qa8un403CCFrBwh5EmQBG/NCeQiiIO+7hrqG4I66N2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJVZ4795cctMCoT4RVql1E8lku+a7tnNEvh8b/DwAO0rTKb3LwVKjPCUMpZnotybW
	 hpd9LYGgL6WOwtdejiGMOAmYzqE4bZOqUcWR79Gh2aCDnXI+euNXh8CddL2c/EXRpQ
	 dISAvhoixEOjFivArPI7wZizWfULwbRU085KhSNuHuGKD9z3UmnHLhinrGSJJZ4Nrd
	 ljhFhBeOuPa6EskjinwTuyzOVY7ufm1Rvq+gygYEWv3y6OVSM+jZ4/uUlsdB1Ce83o
	 LuGkOE+Yxbhxzs4HCiZSZLg2zN80w098BP2thwUW79DNn3W9eSw/UCYeCYDeVx1Jg1
	 tmQuMTL9HvpKw==
Message-ID: <sashiko-outbox-177277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] rtc: ds1307: fix RX8130 wakeup alarm
 WADA bit for day-of-month mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261019135441.1420968-36-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-36-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:04:54 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Robert Leussler <robert.leussler@leica-geosystems.com>
>=20
> [ Upstream commit 878d93aaa596a861dbc8d71f7c38e62a2e805f01 ]
>=20
> The RX8130 wakeup alarm never fired when set via
> /sys/class/rtc/rtc0/wakealarm. The root cause is that the WADA bit
> (bit 3) in the Extension register (0x1c) was never set before
> programming the alarm registers.
>=20
> Per the RX8130 datasheet:
> WADA=3D0 - Week alarm: register 0x19 is compared against day-of-week
> WADA=3D1 - Day alarm:  register 0x19 is compared against day-of-month
>=20
> rx8130_set_alarm() always writes a BCD day-of-month value to alarm
> register 0x19, so WADA must be 1. With WADA=3D0 the hardware matched the
> day-of-month value (e.g. 15) as a day-of-week index, which is always
> out of range (valid weekdays are 0-6), so the alarm interrupt was never
> asserted.
>=20
> Fix by setting the WADA bit in rx8130_set_alarm() before writing the
> Extension register back to the device.
>=20
> This is consistent with rx8130_read_alarm(), which decodes the same
> register under the same assumption (24-hour and day-of-month mode).
>=20
> Signed-off-by: Robert Leussler <robert.leussler@leica-geosystems.com>
> Link: https://patch.msgid.link/20260721081907.3518648-1-robert.leussler@l=
eica-geosystems.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-36-sashal@kernel.org?part=3D1

