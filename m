Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421553;
	b=VbdSZWzbG/i61GamkrV0IKO7+/0j2Ug+20FwJR5a9QscQefgaPoFcoht4/XwJwZ52oYR
	 TobcS3iAU4FtP6DEbuu4sBnM+tYsSTd+0ADTJHZjWlrYX+ce++I1UAp6l4ZaKP+nx62fP
	 shcvyy6NqWK8CucPkDJe4Y0zqUcoBnImU76Tn0RtIb25U9ZCGTiweUGK3Pjfr96Pk9MBM
	 7Ww7bCB0+d5JCaQ4WJg2FgrncP6e5j9zethATlXYUIdYWuks/my6q9oIg8ydp4/vRRFo0
	 jvJN5Ygv+wm101aNH5xNYLq+RuD9GezczMFwjeBf9bM9a6Dp9wCq/i293y9jsRFefCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DPKB008C8kOO7bmPJGW6c9xZipDkgxdDnf5Pxd0Opu8=;
	b=cp1Z7qSN8cVnZPtTE0hIJxp7RjjCukjZtg+KtWVdpQu4ZWXyi88jDkdyLdw0bCuXn9CX
	 ALSY77iHsIjQeyXUCWGp/gQW9LRGEoQAB6NOG4HZffFpAnVfGEBgWR5NmOjn14mai7UUh
	 bblI+SyCONDoroVULY2jZ0TSCiszUB/6oDvNryhzrLnaujFxSdXsE7i6ccjqfzEya43yN
	 MMeooo2XNKB3HV6MdW6cdmFNe60RwjM/FNWbDrN2lp2/MKZsRHjrZNmmbatpvheIV+afh
	 zhO7S6J1oc7UAejfJ0eqafWAb2Agm+Wb6s+spRbpwKyWJpoMMVVsJvqU8vTIHF3Gv5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bt+s7g++;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72501606A321
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bt+s7g++
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD41F000E1;
	Mon, 23 Nov 2026 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421552;
	bh=DPKB008C8kOO7bmPJGW6c9xZipDkgxdDnf5Pxd0Opu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bt+s7g++sTFfm1fjUMNL6knY83Nffsv0yqJaQzKiF5LjwLdAGWFhZ92GZx2rmBwL6
	 zTjNK35KOiwENHfS5S4h7TjmzGyHcrVANlSGr84MGX6HZIuJGB4gGJC5bUEKzD/xv6
	 z1/f5t3emByL+0VsG14zcC9FbRLft88fz4aj0MPMCFTfpX8SBlnBT6Wrk+Jf4ZTz0A
	 q6fmhtah0+3hh5Uqmgsu419nnv/rjnkjIZQM3KGR+b9QyVOjTEN46VrQnzSNY94mE+
	 hMY7vfSh8g7QJ7bUkFGmKBsnlD+EieDTsgQh8Ow4IIkTvTMCsgJdLt7sKlAKHBXJoN
	 14QHQH2FK8LSA==
Message-ID: <sashiko-outbox-228889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/4] time: time64_to_tm() cleanups
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
References: <20261123-time-time64-to-tm-v2-0-117cf8afebce@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:12:32 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 4-patch series:

- Patches 1, 2, and 4: no issues found.
- Patch 3 ("rtc: lib: Implement time64_to_tm() in terms of time6..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-time-time6=
4-to-tm-v2-0-117cf8afebce@linutronix.de
