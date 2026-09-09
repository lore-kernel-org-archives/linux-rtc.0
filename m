Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE8493D55
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994567; cv=none; b=jxH+ZhiocLrK0MMwL3g7JWwXbjDibT6W8RfzhlVsh7026pTn6R9jktVpmSv8HCqBifh7L7OUz4BOvJXILpyMjnUwfA1GNm8eFw6zytxSL9gWXl53D2DAeKMmiRhntxMpQGuYZoBWsGRjVHurmZMRh4dVlf5DFA6MGmoxUJjWV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994567; c=relaxed/simple;
	bh=P+nMG3eyJ1op/Xa1d/F4BQJKJos5QNsCWkXgxch90EE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BN05M7mLxNF0ehvEmFr5AHy4drhwpMrNE4v2TmqFLc02HZOq90Vy69TXSaBp/1iNJhtvltw7jGgMchXidzwFxWzsWnwoRafJXUWUkYcoPstPSQIkZ/p7Oeht0njXMKtYMBLyRXsmd+CvyfVgsSoUwvFLLmdRzrtKQivrd8mc+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNtf85ke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNtf85ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA91F00893;
	Wed,  9 Sep 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994550;
	bh=P+nMG3eyJ1op/Xa1d/F4BQJKJos5QNsCWkXgxch90EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNtf85kejj1Ee4vrCz/UxWXzucREw5RWRr5UfG6zPBbvLcuta41n82R/t8Z5BF8fS
	 BR8lbOYxGIzKEwEU+i6XBRaCbQY6R+4oJuOJQ/QtOQi15w0+AJT/vo51JLR3LqhBuR
	 zC4B08P7ac2dBVzR4hp7PbnI/vKtbuuJm3/Q3LmPHuZC1qUaxwtJiOjWKUmWbpi9X/
	 K6gcVDOVCUwe8+lJ06wq7bLSNLSyf46KGJpOA25a/bEHeo51FOdoQgoL6+CXk3iRyG
	 bMNZkXJsnjU+27+wQJzOQkQRLSgNPpius2q4+FiSfmxt0lysFux2v4+PmM/i2kh87p
	 7R5Cz2tEgK7qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm parameter
 value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260909225132.1392883-3-gourry@gourry.net>
References: <20260909225132.1392883-1-gourry@gourry.net>
 <20260909225132.1392883-3-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 22:55:49 +0000
Message-Id: <20260909225550.43DA91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> An explicit rtc_cmos.use_acpi_alarm=3D0 command-line argument is ignored
> on systems where use_acpi_alarm_quirks() enables ACPI RTC alarms. The
> argument appears in /proc/cmdline, but the read-only parameter reports Y.
>=20
> The boolean parameter defaults to false, so the driver cannot distinguish
> an omitted argument from an explicit false value. Use a custom setter to
> record whether parsing occurred and skip automatic selection when it did.
> Preserve the bool parameter type metadata. Automatic selection remains
> unchanged when the parameter is omitted.
>=20
> On the affected system, the explicit false value reports N after this
> change. The HPET-emulated path completed 100 test runs without a failure
> while the ACPI RTC event counter remained at zero.
>=20
> Fixes: 36d91a4d401c ("rtc: cmos: introduce quirks to enable use_acpi_alar=
m mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909225132.1392=
883-1-gourry@gourry.net?part=3D2

