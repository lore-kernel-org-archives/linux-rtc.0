Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281118;
	b=dJH5+JJGDjBUc+ouGssrGqTPKZvvw3HYBSRz6yxHoVMLoCviPG4Ita2DB38DKR6A65cE
	 mxbattuYc93rgEGTaw+M2ZZxDvuzvYfx11Qd9LNsxJwV0rYt0ZLB5Qanxh86mqC9+qTY7
	 ySqYSGvMh5sKo68831DB4zjLDil3Bxz8vXAJZ9e62qHv4bhKci8JMrMOEMZKAck16m/wg
	 roUHQTvGOjfxFk/NdQa1R14VRj56rr17qroLjD/MtZKfoib49liu3vNEYMSA6rUu05x3L
	 k9ipc1hef2MH4i5yn7sRZwdcogbZ/GFdKxV8eYPDRQiFFmPFv0gOW+PqUcKWVIzM0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1SAsEhP3j6zYMKc5QCne6ROLHH9Z2WoaW/ZqJnDITQ0=;
	b=zggu9iaDYgduIAIsc+ZaW369R6L8tPFXzi+aKmQE12wvuycdrjS53C+w7XYNfwfx0Jh5
	 EIKcYOrmYyi7t26JeqROK8JHY80jogDj0UX8+EqeUPZFW3LGbSi0JDYcRdN4ftjb4qg+u
	 a2wDMEgHMNrN9GkJjxym7qiKgN7EBqi5wSFM3koV//wwXjPVdAXtnZ0pYKMCsbFeMs6v5
	 i1DuRufWtaVJK3P7cLASRBD9Mt5/E+Vf6sL2BBVD2mDgneZB7Bv0epG3PRARTESQ0YqVP
	 mMzREkkGHIEDUuUFSpNRaCu4nlzRHGpgkdUkf8/lkyU83ZfhmCEnVP764oflM0HRFsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtGjxBVb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B86606A33B
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtGjxBVb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD791F01242;
	Thu, 29 Oct 2026 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281117;
	bh=1SAsEhP3j6zYMKc5QCne6ROLHH9Z2WoaW/ZqJnDITQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtGjxBVbWBcLRfihnDZKJHWUCb7daB9x9r5X5FgASGm2p+dEbpVGKuaDf3n42Lx+l
	 u2+aDlF592LEx/ccfiJ0pJ+2cwKahFeU0I3ke2VzqVD6qHrs0vjnWvuspIcrUN6h7N
	 BguRJfpSmieGhgYJj3AOxbgKI3KUmzeIRfDeJ54J2zFduhy20S/bFfauD6Cw9D9WVQ
	 8Bj9MjCsxnk5/G4fDUk0PCFn5xOSPUUG2flHSzlrTLDYYpDb7f2pmGSaG3MBeJNiZX
	 8gcOcZ0B7A/QTG8NXi+PyfxTUe7AvJp26LCJMl1A/0tw3TE+bXSYOQYv5DXeRpYdHn
	 4Fr+oiLsM/4qQ==
Message-ID: <sashiko-outbox-189399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] rtc: ds1343: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-8-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-8-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:38:36 +0000
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
> (ds1343_show_glitchfilter and ds1343_show_tricklecharger) to conform
> to the recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D8

