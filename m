Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444934;
	b=mA8YDHTRWSE4ocbGHNgyF59Qxkrnwzn0S27FY8uz/XMErXe3/bB8LBSRYDSTxl2B/tBo
	 9Ico9Zl5eYv15MM3nOkf1UzpBg5OaELLkbVTX1g1bEZ89RrgbAktCcDYHofl00FlEnoHC
	 APF+DAO/oPsUsEEvGA1n+OxfRGBaSVssV1I/0/MHG3zi3Dds1EKKyDefpfcZpahkaBCrt
	 RTuWw2BSrOZNtR3kDuHNo9AigOfd0vwM7ATSGN8ILhl9Hr38MQg4VzExswllXZ6Ng2HJD
	 ru1Qd1gYxjZ/Lu7qgb4URgtRXykV6ay+nxejkL7gLUaXi65B1lcerWbZ4x70Im1d64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UE/vuSlfhZZxm2lZFTrez7Yzmfa9s8T36jCVr4q7UsE=;
	b=SI4M+VdhmzdcpgKnnEV4cLADC0HGvwGd30SDn7vVDlwuJtuPQ4/CxZurX4LL5gktZqh9
	 OueeyIqG5z51tSBS3BDYMrxYURatf2ZzeTazMo/A4iym8ABQyw43N+YUDa5T4QeiiRYBj
	 x1avtbR4SDNZ1S4hBaDmRkdN6WWQ7Yhe/C/kZe6whnYZS3UKn/p4VweWkdJ/1M4zp9qB+
	 Ifi6o36AD8gmlCQ8f7uzjzzqNF945mg17b4i/TZoSOzfd8n+9LShz3FfSu3Hec+RQTb3O
	 vp4WEGD4Y8HTOQbouF9HtaFfOXn4SMLGpsW1XOjXdjwPXXthrngZYqaGLq/El93RJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QL5L/enJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E48606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL5L/enJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7291F000C4;
	Mon, 19 Oct 2026 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444933;
	bh=UE/vuSlfhZZxm2lZFTrez7Yzmfa9s8T36jCVr4q7UsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QL5L/enJb40r0ptLeJt1wBG5pfYF1udtq11a4PERaLwteP4FB1P9GeuE2D7ELralF
	 +bWSn3bFa+3WHA/5obVaKkX+T8cke5+eiLuxnFKIfQCwoWQ2TS1FaIcBFq968D4V6G
	 0RoyOb43WDQK5sOS/5RMmZUDpWWnl3d/dFHP2pANnhDu5I0LwxpZYZP6QymyIEoeTy
	 KGmRS0il0vpFPm95UCEh5BOiWZU5u/AwZkqZIgWlhiZqjyzsvXDbWTae+Lf2y2Dq8I
	 eYFiLbhfn0eKciYwNksNG2UFrxIFvoJMCXQw7j+/JJRFklUnIL6H/PCTdNIp49Sa7Z
	 HdokYN6cW/7Sg==
Message-ID: <sashiko-outbox-178237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/19] rtc: ds1307: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-6-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-6-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:13 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D6

