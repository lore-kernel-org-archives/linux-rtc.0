Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281146;
	b=A1z20BDfHwSn6T9L98KUJm3DkGnxwJxhSsRpQTRQ+MlBXpkaPmdQeEuP14nff6UGKk9T
	 SlqtyzmTVIhZHpEoPw+LlMbQmO1Izf+/9vmi3PDtw8K1RqPSaljdN4JTA85otx8N0gtME
	 cVI0ldjJJkKi/Y3SM25/PpMEH6M/eKn5nUWszsnqnoGIwC3iW+bY76XxzaIVSF0Cz3ioh
	 YlaZXY9ecQuGL3pucEgIlLKIcXLJX8iLuLoP6sGmFS8OJOH46lhGB50FDGbYAYUWXF/s1
	 6HWfuTVrAh9bX41JyCeb0zrWdhrjh3hHt7myQQFU8wzD7CXtpCqUUhVDxIjVVmrUtfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d51dbXyZRHssasnZxLNBtwupRN9nqV3MRPyHtb9AkuE=;
	b=MwdLZdPskPXtWtwdS83ze/xqK8yggh5UPFXjqpL+4mbpXsK6kQysbnmemsUnLEpaqrek
	 oZwq0MWj7h6dCS2m6fwMHkhqQRbVdN39NLobPHS0JhpDcu7i6euqebojkdq0aPFc7gj5I
	 IoSe58YeoM1W5bxAa//CBeIShHMSSgaaW1OTeBFEjB3JUrOD6fXSoMVQAMHJVotLjrW8y
	 WiuAQ/vuDGwtBiA9WtRmK6v2+Xv9mCnMvUD63E1duSE17PB+K7GGLHnFCwKnwOmSS2gzG
	 OkvbZj+8SCXGjM2vLmGlyFVnpoRb2ePei5THbfDpcYkOHiyLhW/3tk7IUaZvXdq2nkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqciMM0T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49026606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqciMM0T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8AA1F01248;
	Thu, 29 Oct 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281146;
	bh=d51dbXyZRHssasnZxLNBtwupRN9nqV3MRPyHtb9AkuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqciMM0TjNw9408y0XsQ8XTWnmV2Npz0u2TMzKIgYK85UtclzP5Spegc/jsqOz1GM
	 2ia9oMr8v3YE2hP7CrYlcXMhEgKJmEOzTCYxjA/PnKbaAVmh8TZbormf4jgRslhjGk
	 F/i2M5YOahNIX46APBMioFbUQF5qfrQZcVo1YFH5yooVH9kOx+aRSTyxt/wG9hpnq6
	 WvfmbSVIt5QOncro9qYezoCS8CxxbDwnEA2dkDhzchmOb/0qmWk9s6hKODM8UjNTwQ
	 vJXp7F+hJlBupjM0rSIYxAd5vPWJeZQ9SLy2mXrsMNqJZ31rSCQaV3XuQRpiT817Iz
	 +pCcea0lS1WtQ==
Message-ID: <sashiko-outbox-189405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] rtc: x1205: use sysfs_emit() instead of sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-5-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:39:05 +0000
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
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (x1205_sysfs_show_atrim and x1205_sysfs_show_dtrim) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D5

