Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A851C01;
	Wed, 19 Aug 2026 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177783; cv=none; b=hFTPfcnb0Gt6Dx7pDAAWdu2EX7SJc4KgYBXsv9NCDqS3q4qnRUF0KfDBEeRLAHtMRvZjbTLfnkWlDz3dGcMhwAhegs58kCoLoB/quzbcLhj5fnIePbwy3frDMERXGueIbf3Q2JuM4KXWuHaqsA9xz6OteY/VXkz6w6ukO33FO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177783; c=relaxed/simple;
	bh=10L/UDAWDAVJ1tsZfvVG3Sa22wsWO5+bzdsxuxQrwbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKtgCKBMnGLXSQJnBGQdBIanwlGuhZFqrDgyD95oauYlyNMpdvTkel3I8pbBG1jAWkFBa0uje887DrBI8ORuM/VwLEqVoCc5pZUK84IqrtDrO4ffQNhplIYIA7nCon4hyVHyKyRw66wdKTI8egcgAuX4VdxwY1ODN/7jxN6dMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWxxpu1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWxxpu1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF91F000E9;
	Wed, 19 Aug 2026 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177782;
	bh=IwTYVlSQ5QoAvhojVLwHw/EoTm2SxS50p/xljkuL0Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWxxpu1tubSH/u7faH7XhYbaSHMIRjCk7NE6bbjRyizw3rdGx2Vhvgewxs2qybWW7
	 ftATe5z/KgR2M0krGb4wgAsca882qWYxi7mxyQ1Q+HpmEXbfXiG50FiXPY3ryhi7BS
	 4ZPvDLGbHx31gI7pSddtere/Ajs/IuUoo/JZkEjRXU2lT/QArOISzpNZA2EPsJTCqT
	 qtezomcbZk6zY8ExxIbHl3gR3fDkY+9nFtdzoUWw9RVfHpzBf2b4satJEW0/m/xtkv
	 WQA3loUT18FUJpdw4wW4L3FjrDDAAG8OnWbXlFYpd2jFNEYeVdCpL6s+ukVkpY3rbi
	 cmvmwHRgWk5OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] rtc: s35390a: Add pinctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260820-rtc_s35390a_int1-v5-5-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-5-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:16:21 +0000
Message-Id: <20260819221621.D2BF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding `depends on PINCTRL` to an existing RTC peripheral driver b=
reaks backward compatibility for platforms without pinctrl.
--

--- Patch [5]: [PATCH v5 5/6] rtc: s35390a: Add pinctrl ---
commit 83e265d25d4e043f28a3074886c0f8157885c331
Author: Markus Probst <markus.probst@posteo.de>

    rtc: s35390a: Add pinctrl

    Allow configuration of pin functions, including keeping the previous
    configured function, disabling output, waking up the system, and
    minute periodical interrupt. If no function has been configured,
    fallback to previous behaviour.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 01def82318731..2d79710c48375 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -668,7 +668,9 @@ config RTC_DRV_RC5T619
> =20
>  config RTC_DRV_S35390A
>  	tristate "Seiko Instruments S-35390A"
> +	depends on PINCTRL

[Severity: High]
Does adding this hard dependency on PINCTRL break backward compatibility for
existing platforms that do not use the pinctrl subsystem?

For users building the kernel for systems that have the S-35390A RTC but
without CONFIG_PINCTRL enabled, the new Kconfig dependency will silently
drop the driver.

To avoid link errors for pinctrl core functions while preserving RTC
functionality on all platforms, should the pinctrl-specific code within the
driver be conditionally compiled using #if IS_ENABLED(CONFIG_PINCTRL) inste=
ad?

>  	select BITREVERSE
> +	select GENERIC_PINCONF

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D5
