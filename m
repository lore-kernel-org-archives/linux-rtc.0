Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281187;
	b=LbaFPgFvapDs7UYLq8Jew7kp2nJ9vvJqCHQwo5oDPYqy2bskS395jz0Hr6NMuz8OfQK7
	 c71Kjp5usLo3GzfKqdKhEiZKjgEB7bejq/UzZmxImiDyXU1gEcLTfG5Twu72tlxaDboQk
	 z30hOapdj2FvMYkcqz+UEesCWYxafHwT1YCdWiOHAhL3yWvzhiNre0IpU2jZaDkX8eUmC
	 EKL/GVcjJ8wO9HpqO9OD3cwbzcyiLqUhlbxaRWJxSDqMeBg61PYSK0gzlKn5VMHZdxJeN
	 a2a6FXJ8WluyYizHz9/5mVtFbODmqVbUPC9BxPvhOjjy1jQk2OrDGXqG7Ykb6nPUh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cy41bVdxI2ALJmETM5OghejdCnBO63NiPkE7c5FU6n8=;
	b=izPVrtTz3J6J/TjDk/xoFh/P1aRlq2qS5fgQdqSaGYFBlpGKV7gIq5yPCwcFSdPV61hR
	 ksXIacrtS9xfiSRc7+lOpD4c0vdrrPgn5WUtwh0ejeBKuigpyE+DZoF+Tq+UXOPil3nW/
	 aLEKhpIpsdGnXczr9zhwkKCYAe4Xr6a7z5ZJHZ6htFLN/6Dy5IywBFDSV7X5bM3gsS8pk
	 BSVYL4yziHQNHmhUTYm6WLrXphHMpszfcPU3QQvE4Be8O5pwiZOSftvRKydR5HqivvB4w
	 yB+m03iEUtYC1bgbrCULTk+TQ7KHmVApYLWq1iK/76Iox82zwPURteyBgPpyRn310Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N567OP8O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC7606A31C
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N567OP8O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8451F01241;
	Thu, 29 Oct 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281187;
	bh=Cy41bVdxI2ALJmETM5OghejdCnBO63NiPkE7c5FU6n8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N567OP8OGtYwD1LnQ3Jdr3/CsH/zlUUxb5jYJPlpeV1E5pSw3jUgb0O8TFtF1hwcs
	 8HZA7MkGCthAh2XAGgSOeWS1Gud1TsJax28sAj/071ul9KI3R+P2Ib+Zx9MFJJH+IO
	 sz0N2xbwQJAZIq7qlsYFIj9JF0aNeViUNh62qW9hGo2DfkaMPQJjtrbYAxzg1tnsdX
	 36W7AX2UsETT36LEaSwcf0IJDdlsDsqqu6qJD1kQ73K+fiocDvy4O3rFB31MWE6/OI
	 NNycvFmDMLVU53fsKmnt+2hwHvHq8hEcmq8DaLO+mR8N3I7KgEGME339/Pp6Ywa72K
	 9wfUcVMpxGCew==
Message-ID: <sashiko-outbox-189408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] rtc: isl1208: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-10-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-10-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:39:47 +0000
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
> (timestamp0_show, isl1208_sysfs_show_atrim, isl1208_sysfs_show_dtrim
> and isl1208_sysfs_show_usr) to conform to the recommended sysfs
> attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D10

