Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308143;
	b=VAjjK+vxmbNbqSRtHXOwnklmNrQxOuLPCoIFOM7+meAZhM0J9AyQSkVg8cp2geRA7aSE
	 VZDAczodEcdjVBlOok5XqWgSXRhVOYyzqIpO4jOak0BWTM0DohjeGSpGJh7zg1EM1m7H/
	 ANYytYaICsiNfbfr9PhtX7tKg9y+FdEJ0T9olHkkqcd+pICluqyUJKpH5QNWyxlR8DLch
	 ouBLalXNDxnhoGO1HxdeISkMR5XMQ0jskjZ4WWouvpiLQSmiCMM5ClVC6E3Ybq7WRUFvd
	 S18Vldej9vZIUa0u1nA9B9+ulbUgv9UpqUn3EPZB+VU6R5IYCz9afAee4C6O8lkTTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/XzigedCSyVRYsOOEEptJNFaQHMTDqb/tl2qAhrrD4Q=;
	b=On/dQ0TKiXq1c9svbYmvw2KtNLvpmeEOxQRQzKWbsEdzHZ2a6HCrtb5yQp9JxQ2H82mj
	 u2DsmA1+cgj5Gm6ROu2O4sxKim9XjTQTZ/yD1AN3pJkEu7ag4hkkhrEwsJRrkEZMLFiMi
	 7hlSgPAGqnaX7hn7qQyOwlLokABin1GVLpLY1VoMBalMDl3HdjAP3RSryM7kjyo6I1PO3
	 0DfB6LK3fUivDY545zxjdBeWqh92mM89tXGEky/EDZvvS3pQ6jF2quGi0UZtvi0F2KXC4
	 LqTtMWKt16OmjQ/2OkyfoGyhr5OdKqdyys6AFpkaSdnKF7W3pyy6FDYX/csxy5ER8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWiy984o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3660A2601
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWiy984o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A34E1F0089F;
	Tue, 10 Nov 2026 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308142;
	bh=/XzigedCSyVRYsOOEEptJNFaQHMTDqb/tl2qAhrrD4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWiy984olTlNaaZT801rkM0fyJ7cS+KygGmpHHjPA1bTGya1FqvJEG9071y0MrXEh
	 JpnVSc+I+ZHVinSpFVSzeSJNOdc2vYGoOvCKQzzG+w1PFEwA7Z2V72tzF5ifOBcuji
	 SNZefkwb60EX9rSj6NdHAMPoKpmxmBS+qQf4+LQPbONuUZEVg424wRwAcy8M3RyjQD
	 tinvuFeJKuvG2AknEbT5kMOJtxF/aVmm1mIhqWXDcMdQkQcAV+rDwcYCuk6byOmeKc
	 9l6q5sGaHzh4f1ywdSQi+RYoh6zTpYnAq7wPCOrq/1wvb5ERZ16Sm8P3Hn44PencgC
	 rD9mFU2Et9BmA==
Message-ID: <sashiko-outbox-206905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] selftests: rtc: Support harness test filtering and
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wake Liu" <wakel@google.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261110105158.975652-1-wakel@google.com>
References: <20261105030834.3318480-1-wakel@google.com>
 <20261110105158.975652-1-wakel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:55:41 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> rtctest implements its own main() function with a rigid switch (argc)
> check that only accepts an optional single argument for the RTC device
> node path. This prevents kselftest_harness standard arguments from
> working properly:
>=20
> 1. Passing filter options like -t <name> or -T <name> triggers a usage
>    error because argc is greater than 2.
> 2. Passing -l or -h causes rtctest to treat "-l" or "-h" as the device
>    node path and fail with access() errors before ever reaching the
>    harness argument checker.
>=20
> Parse command line arguments with getopt() to pass all kselftest harness
> options (such as -t, -T, -v, -V, -f, -F, -r, -d, -h, and -l) through to
> test_harness_run(), while preserving the ability to specify an optional
> RTC device node path as a non-option argument. Only reset optind once
> all options have been parsed, so the harness re-parses them from a clean
> getopt() state, and bypass device accessibility checks when help or test
> listing is requested.
>=20
> Signed-off-by: Wake Liu <wakel@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110105158.9756=
52-1-wakel@google.com?part=3D1

