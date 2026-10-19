Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444963;
	b=a5AWz6hVBb/GtqrU9kT3/eAifIPXOh6lIWNjuIWfg5kHEVsFnwOPwV+rsltxM+UVNA76
	 uux+84H/6MVNq0as58dH7r5n0OZXbQqMgTnkPb77FZK8lANM+U8byB156Ri5HHFTj38nb
	 guNRr7FhOguEYSO7tc6swwXC5hRmhZY9PzV3N1puMlIzqo7E7iWmAUKBUzvD+4fj9ljzE
	 CnklDuQj5cRhptm4TF5EPcb6I5861S1h85Aqz35p5IOKAMYx7Pj0Zty9u7YNZKnmKlCRc
	 tZ4gkdRfw//mqXqGsQm/mZSYxy2j0hcsNZ83g1RBjKxq2hCQb772X7kdmcsQRJ98Ffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZXz+AhMoInig6vmShDmOtpMdKYUGh1l6fcBNe2DC58U=;
	b=DHjVMxUlyo7kA880ahqRNZTAh3bKIk5Nrjh5yo4ssJNdGaRxWkDn9AzEDvcCgro8Ko6W
	 pTeL2doJdfuAuCSUYh5aSMTa5Ud3a1mM6z0N4+qbhtV+f045PNp0Uje7X8Eb8+loPmqOo
	 bRmQE/eSnZPHjKVDawROX1pdy8FzSDM6kCf91sdbg4k9iZSjeHL0aOy5OYBADJqoPv0rm
	 Z7MlvIhuQU3Cl5gV9NWomdBNFkmJnZwo6ud8Tf6vd2sim4CzKjpRLRhmrBUCdoPCvpCRp
	 DokV4HJb/+zppSP4v24OOeaQObYB0YFjr8jCiFaTVEIJUpgWZzAThy9oBcMg/wriBzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUGt4zlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156B606A31E
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUGt4zlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D221F000CB;
	Mon, 19 Oct 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444963;
	bh=ZXz+AhMoInig6vmShDmOtpMdKYUGh1l6fcBNe2DC58U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUGt4zlWOSGV2KbewWOLPSGVF6m5ztO3c48oCw061Znfzh29oieDYCT7hqgaVo6Qk
	 v4eqe17p4plqbg3GZI0XFqdzaoxHjkZmJEs9fa3uIqBo5cTq9uKi4l9seCbZtey72S
	 m5CjbOfkiqhOx3ZLSzI/ee2o+UeoJull6DZWKBDC6Bs9CAykUlmE3Pg1Pjc4aZTGYd
	 xLEX2zZN1l+D8VaTAB888E1ZCii/FqWkYa9F5f6Dwj/Xv6VkieYpsEXVf1tr7wWv+f
	 xIcCDuGLBAq3ULWUC5y2sSzZnyAiUxhCUMD6fQ1VHIzb2dMP4oQGlBQuQrO+dSdF9Z
	 E//dGYrgTXvIw==
Message-ID: <sashiko-outbox-178244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/19] rtc: ds1343: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-7-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-7-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:42 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D7

