Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9F2C21C5;
	Fri, 21 Aug 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321412; cv=none; b=dy3Ne8jHnrf7vinbQN2m2wrfwEPA9hhmj+emTuSftR19syewfEAIqkspQbhkqJqG2pZpfYHoQA12oFnhdbWxYkMbLrqDfrx0co3Oxpvuk4zmlcU+rqOYNI8lcXEmD+pBefgUQP1WwFSq4eWXXg5ajkDZZGGIoPXMX0J7hCv4mkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321412; c=relaxed/simple;
	bh=DcX7y6KCV3o7jNXzRjtp+OHytEp/FbUii6KgZEJB8bM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDkz49zu99R1nqnmFMUqHj7CGqvm0dsn0hN3I+w3CoivpQgoFwYoF9nyz5vBSveitU5/P6qRFKwIp/K01DwjldKdhjs6pHb6pqvIeN270oOm3+86uw4dT1MahvZiT2mUUiDGW5e1Sx17fI/f8mZ+yz8NgDSzci9IGNGi7pwW5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeZiE6mQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeZiE6mQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDB11F000E9;
	Fri, 21 Aug 2026 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321410;
	bh=loP5chJ+lTLLwZVUzfv8lGaMZcx9mQkM5iUDVl7hwkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XeZiE6mQNnllMVw6oSRvey5UGvgr2+ZnvU7L6FMiznqXR9WhnB9/Ye1ReSTWJwF0h
	 R7J52UnPALlZVQCeFA8pFALoxkMtuQA/iSPiTLHttgfgvflAg9FDOxD0evqiHwpH1a
	 27UweNVXHHPXnHgw4q6pVOvJPp6bXyqf9LA+tf9Asaus4N/M34XMEPdRj9clGfCN+0
	 tiiAOhBQq/FYB1phCScHz6CFn23vvDKHD5mT12pQMA/nWv3bqBzXwIJ6uN7nBtsD46
	 RMyPsP5STz1LleQnpW4YQhS6oTJuLqyqp5yTq9wmQhl61GUQdOBAy64OqMQrC6mqUa
	 4pyXuRLKqXBpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in
 rzn1_rtc_read_alarm
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:10:10 +0000
Message-Id: <20260821141010.6EDB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The RTC calibration offset cannot be reset to 0 once configured =
because `rzn1_rtc_set_offset()` returns early without updating the hardware.
--

--- Patch [4]: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in rz=
n1_rtc_read_alarm ---
commit 03655d07aa4a099ff33de67c8c707b707a119002
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm

This commit handles the case where the alarm weekday register is unset by
returning early to avoid fabricating an invalid alarm date. It also moves
the control register read before this check so that the enabled flag is
updated properly.

Cc: stable@vger.kernel.org

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

This is a pre-existing issue, but I noticed a potential logic flaw in the
RTC offset configuration while reviewing this file:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_set_offset() {
...
	if (stepsh >=3D -0x3E && stepsh <=3D 0x3E) {
		/* 1017 ppb per step */
		steps =3D stepsh;
		subu |=3D RZN1_RTC_SUBU_DEV;
	} else if (stepsl >=3D -0x3E && stepsl <=3D 0x3E) {
		/* 3051 ppb per step */
		steps =3D stepsl;
	} else {
		return -ERANGE;
	}

	if (!steps)
		return 0;
...
}

[Severity: Medium]
Does this early return prevent the hardware register from being updated to
clear the calibration offset when steps evaluates to zero?

If a process attempts to reset the RTC offset to 0 ppb, this early return
prevents the hardware register (RZN1_RTC_SUBU) from being written. This
seems to leave the old calibration value applied in hardware, which would
result in persistent clock drift since the offset cannot be cleared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4
