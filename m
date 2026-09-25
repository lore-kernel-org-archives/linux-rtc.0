Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DC3CB570
	for <linux-rtc@vger.kernel.org>; Fri, 25 Sep 2026 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314068; cv=none; b=OdJxIHTXKIUUiikmfSKJTEZy0v9/Poc7qNZI3Q7Qt6f2oy51PnVZtFk4nfQpjIvswJE36OcJVNWchLQvDhfKiWTnyc3yoYBZH/HTbEExBDRi81XeS/X0ushb5ML8muakC8X+S/aauXe3U7V3eJdroglJW8V6QaaBw15XRWJ34MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314068; c=relaxed/simple;
	bh=4sAMW8pQdL+pfsgQDKnNF7sDYTbLcAnBWH//GnyRufQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VX0cf4ZQOF5R1y/fp0qfaGpGMj/fVBuvJvl94CACvWrQG3tfOBgwNpLvsANtOZMz+42iX8rpH6jpKC1Zv1ruI4oX9h7M9GNCnzzJQXWW0J1EpErnGl+wm+y9g3w7kpNhf5RKalnYk8n9yCN2eb7fIi2j2bs03Y0ESf9scbVxJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNYtwWQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNYtwWQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E44A1F00893;
	Fri, 25 Sep 2026 05:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314066;
	bh=4sAMW8pQdL+pfsgQDKnNF7sDYTbLcAnBWH//GnyRufQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNYtwWQTTmMHa8FzoQZ4ioNIL062ekxZtrIi/PM7uX8ou6PiMkXvzU7F5931ampuU
	 qSx1j19BFjNn0n8kJfnKWq8VP4Lbs0jVeKpxxkwR+l7se/zy5KpDj0wTfJGfRnjOha
	 Zjn8cxkIts4ArJQdqAqQ+PfQuleOqrvgB145QRAbYr4XEabVPV8+EQpHLq9Dx324kW
	 QaLvqP6kLbyEMg46PIR6vdpLJcqOsQi8bfRewg08tdsevO3z6H6ijGbv1kVz3fIiAP
	 3s/hrHfyf7ya3TNGbVLxNdNlHLnves9sYgNTfn4N12yZFEqkZ4uSin8SKSJcMvvQbl
	 IyY9pVzUTed+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: zynqmp: Enable crystal oscillator when setting
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGFuaWVsIFZpYcOxbw==?= <danividanivi@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260925052015.22019-1-danividanivi@gmail.com>
References: <20260925052015.22019-1-danividanivi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 05:27:46 +0000
Message-Id: <20260925052746.9E44A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The RTC_OSC_EN macro was defined when the driver was originally
> introduced, but was never asserted by the driver. On cold boots, after
> battery exhaustion, or on platforms where firmware does not configure
> RTC_CTRL, the oscillator remains disabled and the counter never ticks.
>=20
> Unconditionally enabling the oscillator during driver initialization
> would cause the RTC to free-run from an uninitialized or stale counter
> value, reporting an untrusted time to userspace. Instead, keep the
> oscillator disabled until a valid time is programmed: guard
> xlnx_rtc_read_time() on RTC_OSC_EN and return -EINVAL when it is not
> set, and assert RTC_OSC_EN in xlnx_rtc_set_time() once valid time is
> programmed so the RTC can free-run.
>=20
> Per the Zynq UltraScale+ TRM (UG1085), bit 24 (OSC_CNTRL) is a static
> level enable for the crystal inverter rather than an edge-triggered reset;
> asserting it from set_time() is non-destructive and will not glitch an
> already-running oscillator.
>=20
> Tested on Zynq UltraScale+ hardware, confirming that read_time returns
> -EINVAL while the oscillator is disabled, and advances reliably after
> setting time.
>=20
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Via=C3=B1o <danividanivi@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925052015.2201=
9-1-danividanivi@gmail.com?part=3D1

