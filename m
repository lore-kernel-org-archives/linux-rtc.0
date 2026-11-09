Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194758;
	b=zctUH4p8+4FVCOQ+vHONsLgUoQzLP78UrWz7GCrCu7XvagleJ6iJ3CakM0FabSnCX3E2
	 A8KY6aibvwc1qkg8PrR5Hbl1dgZS/mOd896Y7H8PzlR94HIqRaOLqR0NpVWWV+Jg2opma
	 W657Tz96eQWAZcBlkWPADXAMB7Mpy4q1+u4l1EDM4bNFOBcwdSFEAxxDYpyb9o+OljHX4
	 stlcEbFakxFQ4QW4yLCg1F7DYzPI9QVt8jIyN31NQSWPiT0eR4/4dMCgLNgFVtDtg7IVc
	 2/4PF9dygC9jOo0HZ5QSurg5I0gFp9Wjc/SzHswfqC2YTWGXANL6mpzFGo92TqTgwZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194758;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BKqo8eu3R9DAEJg8QDDSFBmvoabJfHV7AgS1IUzQXsM=;
	b=30oapUIgLpbpb9tOlzZf5ZmHDjgtqraW5gidolIAjSQoKVty4mlo5qtnevpF26GShjQv
	 sH15tywT93qylrXBeIJVgUrkfZJgEeLav93F2xnTb+aoqjwasc6UUuix9uk3HXqlrqqYK
	 mc7UeVQN6nVVmJ80NzuRnJWeQ0Y7934kX9BWdqJiQFWarKrS2+yDxI33fxqdCMz503MgC
	 HFk+KkmrDLFy4R58kgw416sjpuWMykJo2718JlA+tpg63JkLR7Ks/mDgQL9dtJNFWQHSG
	 ZdcXCcb0NwgUj48rZJk5F5FC2zyPW0QwnblONhcd8+gGlU8dTeLoYvMSI+g6k+iJgRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqS9Jhgr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C7606A31C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqS9Jhgr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C671F0089F;
	Mon,  9 Nov 2026 03:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194757;
	bh=BKqo8eu3R9DAEJg8QDDSFBmvoabJfHV7AgS1IUzQXsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqS9JhgrVocNi7uVNMrz9NwE57sae+acGUspbXAFliprlNZvgiYmMHqh1DhIc6zDo
	 Oh9gQL/zq71g6tWlYGdCHcLHYN1aWPanYOaX8SURn0gmdCGDQt3I7cEaSjtn3fJ7/i
	 kRTJcF/Cd878yQDq9E4WINIP2NKNwyGXldRys3rbH/sZnx5zTP58ihzkQr70SPsirL
	 BdJkUyvH6ZtDh8tlQmjYsQwxbHs+ZJ4Lpvvs0etXnQq9I0RplZQtaK6KUL5XBSxCrA
	 zFU28S/mqcAiBpTObQDCwerpXN8mx3M42DR9mvAS+aKTHHwdwqy10wH06/+QFppQQv
	 Jy1yj/HKXAxzg==
Message-ID: <sashiko-outbox-204371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ab-eoz9: fix negative temperature readings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuehong Wu" <wuyuehong@cmss.chinamobile.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
References: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:25:57 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rtc: ab-eoz9: truncated opening sentence in commit message
--

commit 672667a84ca874a5ecdaf588ad6693378fe916e0
Author: Yuehong Wu <wuyuehong@cmss.chinamobile.com>

rtc: ab-eoz9: fix negative temperature readings

This commit casts the unsigned raw register reading in
abeoz9z3_temp_read() to int before adding ABEOZ953_TEMP_MIN so negative
temperatures do not wrap around as unsigned integers.

> (-60 degrees C), so the driver computes "raw + ABEOZ953_TEMP_MIN".

[Severity: Low]
The opening line of the commit message is truncated, likely because a
preceding line starting with "#" (such as #define ABEOZ953_TEMP_MIN) was
stripped as a comment by git commit.  Can the missing opening clause be
restored?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-rtc-ab-eoz=
9-neg-temp-1-yuehongwu@cmss.chinamobile.com?part=3D1
