Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CA25DB0D
	for <linux-rtc@vger.kernel.org>; Thu, 10 Sep 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012425; cv=none; b=kIFYyyiaxdJ01LxcUHTFWO/iZvaJ3cQXTYxYiF09fP0QKwpreG6bqgV6zDOeUZKj+G4v3kTQPs+Jf4PumYQsA5lmO24jwgr9W+b+X0cRnAo1c4YoDJcpzhPyzCz6KJjnFkPIQQrVhB3OOoaRYsVQyywevT1vm54doFj9H6ZlZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012425; c=relaxed/simple;
	bh=a6CRKIzjf9L6YWCep8nsYMadMwLAyuq9IrL++etnHGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSJ1wykxxHTLERIWlvsszeytWfGBLWcvDs82Th7Im9WbrgOnr6cyla4wCuw+Egp3qrGiRQ5XYWRZN5XhmY0itnEkRQQibNHAVwhHAjjvCh2Y5EnRfvUJ8zWL9E2AfduWaRb7y4Cgv1hfGc4R/Fa4UPFo6HUO1yIS57IOIvKDCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5ZhWWh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5ZhWWh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F321F000FF;
	Thu, 10 Sep 2026 03:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789012424;
	bh=FubdtU0Ctpav8NWFCKnTwye3SlVxVWZkQWSrSsfwghk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R5ZhWWh+xW3VAgaLFlB5pb18+4NrT22AeTPGGSrUAcX+Sdmh2o/z1XwQ2cljOGk4N
	 8ERLWxgg6q7SHc1RIsrzdPPLNocVIzJDb3IITsMNQRQtN8f9xkk+ZI8bYeh3BYoiJd
	 zEMyOj861LYTwdc9BUpdtVc+hVcFRgD2aAhoQjZzlA4SPcvaoE26IaawwffNCppPEP
	 iEwqZThVLxNpr30T0YmgV7xp8clcQh6MooHaFXcKDMVJg7NTOMkM0dzaBLiD1LV4lI
	 Jms4Zmf+28GZxRn6kaS++NE29Ojw61hVdvkcdgTc7p2SQWP36WKF2qnfr17Hq4B8sS
	 cqvFc0WXSIC7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: rtc: Support harness test filtering and
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wake Liu" <wakel@google.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260910034821.2935214-1-wakel@google.com>
References: <20260910034821.2935214-1-wakel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:53:43 +0000
Message-Id: <20260910035343.C5F321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

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
> RTC device node path as a non-option argument. Also ensure optind is
> reset before invoking test_harness_run() so the harness can inspect the
> options, and bypass device accessibility checks when help or test
> listing is requested.
>=20
> Signed-off-by: Wake Liu <wakel@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910034821.2935=
214-1-wakel@google.com?part=3D1

