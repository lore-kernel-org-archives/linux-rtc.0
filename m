Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794788963;
	b=kZSxdfNxjku23qebkQgmcFf1BmPlc7KaI0JF0aLzEBF9IjybV6Xfjyykzdrkl22PP3EN
	 cNgpDoPE3C+iwcuHg6uURsDVLTXk4LZ6eSdXvLPsulmAVQftukSnM3uUitHfOJSBPy2Sm
	 0RqVJ9h4DecOsGpdVWnwZ1c99YVbvdtlj1Lctx7+siDDwdojg+/M3zRujkC7cXFcqDiph
	 zwCOphDtKeZNA/Rlsw/nU2psC2VaqzDIu8gyvF+F0qyixRAXPS5Owcw8YhEt9y6g2Wyms
	 HKu9rvuR9sjn+a7d4tBmq6nGhncWC2C1zrs0ZzQZvk8c6sbYPdzRnqjl/5mERWnYjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kvkuHhWvPt1rPxLaAxH5Gqgg8GgVwxzeCIpASfa3ZxU=;
	b=ebOJ+rNs/aQxN616A26YV3aCM+QhCh5Tzs5uWRLGEUEkG7EWHoDzU3fnY8kjW4VPk9v+
	 j+AuK1p+8F/cIuFr39w/SgVsjE23D+mEelS8ipnFWyov8K2/QHZhoZd6YJG1w5FL54e8/
	 hTgutZUWxMxpOlT4zPvBNUY6UeTm3NOnlBHvQvX/q5k1+naZrPr7BtiZNZWYP/Cvt/NqA
	 koW0Rq48/w/OuvdOpQCd9sOi4TUC0qqfpmcqoMLkWVRrikHMW4mCMzluAncZpaBpcVblc
	 Ym7XkKlp3nca0LPu4VNc923ENAMjAW+1m47UwxELptTBSztUZxggM0x3kHqpCJTjbxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SoMvSOK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C765606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SoMvSOK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050C61F000C4;
	Mon, 16 Nov 2026 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788963;
	bh=kvkuHhWvPt1rPxLaAxH5Gqgg8GgVwxzeCIpASfa3ZxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoMvSOK6v3U4BgRTjXk/l7cOoZ5Q9mhM+7VNdV9f5itKXl1b4s7ii7k5mthNVNcLO
	 /wbITYtEVA8uQH3lJYVIy4BvmuzJq4C7dm85WnbHbpOST9djFzrrirwptN0A9SlnQl
	 m3zYcZX5q1spwga6RJFnOPrQ9Vr9f/Mj1Xcvtsy1ik3g83jURwdwNSSozixy7A61jT
	 Z7T44exvSBEHGBdqidKgr87MSwkC6WSs1zV696ggKyP716vqgjO/VrHHzy+PwAwi8q
	 aeUE3G4YCjqsKQlLW8hBO3Ncz4ZRW0Zz0xTGCWDheJc+IxXFlEtvo+5EXKqI1OlW1U
	 UhEYeEnRCT5MQ==
Message-ID: <sashiko-outbox-215946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] alarmtimer: Move the wakeup state into struct
 rtc_wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-2-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-2-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:29:22 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> The RTC and the RTC timer which alarmtimer programs on suspend and the
> record of the clock_nanosleep() call the freezer interrupted are separate
> static variables.
>=20
> Collect them in one struct to prepare for an RTC per suspend state. No
> functional change.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D2

