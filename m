Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0831A065;
	Fri, 21 Aug 2026 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347573; cv=none; b=ZK2lNOIsHkyBxjDx/VWxoCOn5O9yzLQDXppYGCKyaHgjDAxR/Z8UK20+Qp9tO8u3tluOcEugr06GWHzvl7a1q0FjAIcPa3igtGaW/AWGamtV94OCexMYx6229WaEMIJvHv0lL6wnOjPzQ6QEQbcJOhxfXzAb/3W1G2RAGgDSjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347573; c=relaxed/simple;
	bh=h+U3Qz2R1PmqCh8c2kvk2YDLAtofe1WhEx0LY0KCz4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hINOlcTy9URD8LiIdDLeuNgqTLVAPQXSKa3X4jG6F4K/q0JgEFNVLJHpgXoLo0nveVccOeuVgfaH08PBI0C3QmXInEEl/txW6WP1E+9CwnBrWj6xL66JYDtqFBhJ4xRNlBf991Xz9nNbcufMnG5SjTyKmVXs6Tu8/1Uq2dvuAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ+YHlD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ+YHlD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB921F000E9;
	Fri, 21 Aug 2026 21:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347571;
	bh=h+U3Qz2R1PmqCh8c2kvk2YDLAtofe1WhEx0LY0KCz4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJ+YHlD8jsUG8Xc0+QAPJD2ahwVFDOsHBNm1G3PaJLoTT602S77a8Ow1XMLGXMVw6
	 LpILUGXYSxeggAu1pEVm3rvlmWHl6TxxKLHVCGVwPu76DT9WNgTxcPkG3ed6q05zUg
	 34fGC3+Ir+qclQ0uf7xIxWUCmVniBwrenD5+M8LXbIdxuR9+EFjDVR3Sb2XXgS8/4P
	 2OYBagU5uiMeyzDIWwmbvDiTDNg6C6xvHpp1685FugOOw6yTtKiFDY5z11N01y3mrA
	 p46909LwsP0zm/IGRzMtvzKPCcSq/0cethk9CRymZgGV9aP8bWmvQcRDNj4u9Hb/wn
	 XEPam4urpkVJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/17] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260821211032.13554-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:26:10 +0000
Message-Id: <20260821212611.2FB921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rzn1_rtc_set_alarm() calculates the alarm weekday from the difference
> between the alarm day and the current day of the month. When the alarm
> crosses a month boundary, this difference can become negative. Since
> days_ahead is unsigned, it underflows and results in an incorrect
> weekday being programmed into RZN1_RTC_ALW.
>=20
> The RTC core already provides a fully populated struct rtc_time for
> the alarm, including the correct tm_wday. Use tm->tm_wday directly
> instead of recalculating the weekday from the day-of-month.
>=20
> This avoids the underflow and ensures alarms scheduled across a month
> boundary use the correct weekday.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3

