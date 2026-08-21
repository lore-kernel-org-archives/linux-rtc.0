Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7A3B14DE;
	Fri, 21 Aug 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321235; cv=none; b=KCLLVKedvsZwQnC8B2gVtFinQrZwwLR13YeDE97OybQb2sqvd3KuRUH6alYmz7rvqrlfqwq+3aQGbLtFL90MVyceRS5ytwVRUP/xc6h8QiG9gNn0g7q7KRZEuAl+R6lCN1NUkLq5axL5PoP/Mc1IuWGtnQFIy/BAzsuB9HCKP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321235; c=relaxed/simple;
	bh=F7FPBHA9VBdiciRpMG69GcdeQk9NurG8gjny/jTPE3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NULPG1vX0hBOPhPsYor39iuoINxKXfswjWFUbltBiy+wPv+BTUX3D54B1Z0MdcEEeDywJ4b6JDh7PjvT7afXbcF1e4yle3TOa5rAStSsa2YZS6Ui1XxSlPAYaH5CfYvmtr04fWRnt75gdZL+L0vlbwU7xri3/UnULWWyAJEIfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsjQs1Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsjQs1Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F208A1F00A3A;
	Fri, 21 Aug 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321234;
	bh=F7FPBHA9VBdiciRpMG69GcdeQk9NurG8gjny/jTPE3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsjQs1DqJNcGtMAmq/s41wYVOISh4v2m0OSNZlfkwwY9wMdRHVM6Tt/5zM4Hqg+pG
	 OpG16x+eUdSQCbDqzK3J8k8QSaaHtz1GXcDqEnPf1StQqjT4SBR/SGxqsPwkJbCHk0
	 cfJdfT7XEIeY/bRdig1/PJNVCDrXUDKvTnqwwlPinUPWRR7Q3FyLjQbS98aLt0L8rA
	 1gl1l+MJQYZOYMLF6QtbXI4zaw5Gs3smcYAc2uByrtiddiNXaxWsZKiDfIN3fchuDF
	 WwZcoHbeZB4Qtu5jq1PwIat4Zkc0cgbcvAeL7Y5y0Hw2Ie53lBALt4jeDY3i3YaZ8N
	 8/bWXTekbBc5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] rtc: rzn1: Handle EPROBE_DEFER for optional
 pps interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260821135608.275233-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:07:13 +0000
Message-Id: <20260821140713.F208A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
> the deferred probe request properly.
>=20
> Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
> indicates that the interrupt subsystem is not yet ready. Intercept this
> specific error condition, assign it to the return value, and jump to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

