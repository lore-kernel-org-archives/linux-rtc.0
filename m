Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609471;
	b=DB8WtOgwExoIuxU1MEmllsNGkysUCABdrxd660Y2cDbXiZUGBzpspb20E9yFF2dzzwUC
	 IyHJYsnmr0FFcFLAZvSC3G7EzJ14kq2p4TnEWsIXZn6ZcdtAfh7Vqc4kVKLPbshmzbYBl
	 3VxOyzGJSszYHkpmJdMKTW5i3HW4Clvv4w0uRzw2Exd1HPrsJzs1teA4fTsj+0jjDjekW
	 HjkJdgDVmGFYPvERcakzwQpOgffc7Gqgn3Cx0tLgKDKR8G6dzmIQvsygHYwmXYfL4JsjG
	 or3ZP3EkQOoRBu9YnKE3XMRHXob1OHeGqOr7fgG8JqVarY88ZjRWzpMmhXi22JApuAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cByIZ6te8b1BpWkxxbPayIE0/h2hnsqgx+pb9Y8GIRs=;
	b=0SeZyCTjuHa89Q3j1cqXvKvSW9CIZAB2EV6SgEwoK2voV/F4vopXnWDiTBYirmk0MavU
	 rPcQM8RqGHiWrFWAh7BBYkD+1kAMSa/RbKqdfrxMsw1GpzPYCCrL2285VSuozlLDtQ7KJ
	 8MYrqWC31vW3JXEfqEvHyuaOHfwtgr2qXAbNE4Qo0+mVs+FcKiYwLumjmk5IJN//kBya0
	 /daPNaOznc/slKFVvA040aRIe/PZjsIdKkbSLnlhQfjMnLq+J6NoYR/67TtL0IlzdOcUm
	 nuxlhj34J2FLcWg6u+3yPNiGTodwRtsK8GLL8le1V+J/wdpQsfZv1ip0ETYeGUA/rsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYmrrSK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B62606A540
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYmrrSK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708DF1F000C4;
	Fri, 13 Nov 2026 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609470;
	bh=cByIZ6te8b1BpWkxxbPayIE0/h2hnsqgx+pb9Y8GIRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYmrrSK0QWiWrOft5PxHyQ9oFzrdtAYHvYk/VfImq2U0P46UomUr7eP3VNkcCgY04
	 gaFxtGfLjojbjs2tFqcDlGAW1bwq6px+4/BZbvxSdNG7S7BIHqOubqMlXbz/b7Wd4C
	 DH1v4YiuSfmEvTyIHWDiA3HHYKK+L82xlr6Md2LReMbWQq0zzGVgH9lCqMgOHEZxwC
	 JeZTgbntPgc3UeGr29/2bopJubNVwxEWp0AhEiYm+yFjoMwbY93/1YBaWlel434enl
	 GiX1sSyXJxMaz6E/1/mhn0aTR4PrvcRCfveWZkG7IJjtgAWlFObDDSidP5q3iKxeSm
	 cGRryserZCz2g==
Message-ID: <sashiko-outbox-213826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/19] dt-bindings: riscv: sunxi: add the YuzukiHD
 Avaota F2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-17-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-17-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:37:50 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Document the YuzukiHD Avaota F2 board, which is based on the Allwinner
> V861 SoC.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D17

