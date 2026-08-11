Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EE3911BC;
	Tue, 11 Aug 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478055; cv=none; b=tN3ehfAruPF6VmYP9kKnAHJmtyMOQdcJ8NsRA3hPyGQiMOEdcsMce1P/luj9Zpo94rR/zKVaUD8DpxS5Ntx4i/THM0LUIOqFpkLBEN3mCXh8UMpIxkIqGwkatco6npfM8vdCEXNeMckJlr6EWkvz0+Zdv+1n+fx5pKR7Vb/BkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478055; c=relaxed/simple;
	bh=M6DnuQUuhgRCra8TIcss+h7jyiqdBZ5x8yieJPhd/+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VFEMbxJKkxXT47AKlOHhg+kJTA42FEEXPYxHT+7zHRHxVotvVrLV0wurf9kxTqT1DJNr94CGc3s79WP4Ftm/Sd94rRQ1wwLJkRrUUBdwc2QThEagm/2CUsE5QaC9o+z5onIa/WNDXHq9VuWcvoCBpS2pLtlJNZoQ/FyfttLYt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQmSikzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQmSikzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7411F00A3A;
	Tue, 11 Aug 2026 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478051;
	bh=M6DnuQUuhgRCra8TIcss+h7jyiqdBZ5x8yieJPhd/+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQmSikzdQ9pSr9UFZz374ZRwQ/gcxH2uLr/EyvJpbK7IF17New6uS7R9G6lNyjaPl
	 zhKGldaBFid/87Z3btyjRd4jO1uiWTIdCEjfYBQ8TVDBqWRuog/nEae2g6uwVWUarj
	 TzcdsGE2/OR2SrV2BSMkfYehS7u2FqUNDXhlkyqMqFhfT2GLGd4kdDnAA1p0L2mOMi
	 dJhUOLkTVWziTf9J2JB5IeAFWarD5TqWmF5nnP/r6cNy/ZrNhJyMSCbFxVrverP34K
	 3OL9bB9hCV3mWGryc/90hjb/sz3wfGEOaR+4zJREd4gn7N0FuPLeSVOI5ezFgzDs1Y
	 lruusBoJ8gLXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260811194034.28937-9-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:54:10 +0000
Message-Id: <20260811195411.2A7411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D8

