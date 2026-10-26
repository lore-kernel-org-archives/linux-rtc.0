Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012164;
	b=k26ipFlrxzvEaY3OeKehRt8MkO44DXfCQu6cLEYJWs8uircSfSNFlVBaFQmzymoRItsj
	 B32eAQIe//UaAAGSj07DqUVFnx35ioS6e94pKOnAkOIJAso5Pi52W7/yCtmsC9vj4FFeS
	 r/ZBWVR+9EKRbFwq6mwdRbNlY9fF+Sj3SA1H9iXYZXWkXK10giY7uVH3m6eXY/iK1UaxB
	 le3IAUuOHXphW98CRpg2r0uaqlnBD9JSwHfdIDYySgPCeMXDgGi5G12pRlmFvZ23/hVIZ
	 KyDsWRq2wnYcyu6u7TMqD1i2s5ysetrWotImGB7rwSXNzgmFR4u4HqWeJEH7cCH596w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sZD5QgUjfD8KgCR4ipUT5m3K+aXeZDU1wvaJQuqYzPU=;
	b=yQGTsL+nvEJ814FeyWdIuG2R7AWqD+UnGH3MgTIKl1okcwJ3kGRWi7LxY/nV+zV8SVyM
	 g+xrUjyJrJi69/jxuvZuRet0ZVtqTN60QECYh6mIwKq+al7DkgB0Ij4OgMtFPPS9A/xPZ
	 UUlhLJmcWmCgFYYtn/liMMWvQtm01y+OeAfmnCRPiKhpvNUItYLF4eT4q9PpglSQyYWiS
	 zIdDHbuGb+FwlicqQVi+4qi9ntZRe3YCptrj9LMrqcw7E9zmiqQMDWVwxpibDC5cAqmNJ
	 VHDFwIiBaC6fJivG1fJlCcF285Xb8FYYvM/jJZ9BM99DS3sCfcIBY0fSVsfOlbOxcfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU7hEV6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1D606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CU7hEV6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D161F01825;
	Mon, 26 Oct 2026 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012163;
	bh=sZD5QgUjfD8KgCR4ipUT5m3K+aXeZDU1wvaJQuqYzPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CU7hEV6aqYdG5DA5jb7F746S+fiB2EqjTR4lDtByfoZYxaEOvazT2Ptty1EVYgEcL
	 WP6WUC8kAjeTgJD1MpcgmEWTxS+hbURZoT5EZI5GdQdC5+1N0W1vopiUfhIhZrSMFs
	 zSP6h1mPr1NqDNolO42JeXb78+GaLf7Ee1p6Vzai0Tq1HesUM1q9CrVveb+djHx4Hx
	 cm6JJdhFtt/790TKPmGpKuMi5cefwrwitYayNYwV1kl6kpkjiIgGvNSBcbfkiXybtP
	 GxnwcfNG48+N5NMyuRasfhSw+gJzIw2t2vP3DqkuPtjn8H5bDivuSeJIbV20jAQFJ2
	 Y9jJdLZHvtXbg==
Message-ID: <sashiko-outbox-185026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] rtc: pcf85363: add oscillator offset calibration
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026094712.205214-4-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
 <20261026094712.205214-4-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:56:02 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Expose the oscillator offset register of PCF85263/PCF85363 through the
> read_offset and set_offset rtc_class_ops callbacks, so userspace can
> apply frequency correction for drift compensation.
>=20
> The offset is in parts per billion (ppb). CTRL_OFFSET is a signed 8-bit
> step count whose size depends on the OFFM bit: 2170 ppb/step normal and
> 2034.5 ppb/step fast, the latter computed with an x10-scaled constant to
> keep the arithmetic integer. Values are range-checked before that scaling
> so the multiply cannot overflow, and out-of-range values are rejected
> with -ERANGE rather than clamped.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026094712.2052=
14-1-lakshay.piplani@nxp.com?part=3D4

