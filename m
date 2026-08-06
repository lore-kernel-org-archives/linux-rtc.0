Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7283B42C1;
	Thu,  6 Aug 2026 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050148; cv=none; b=DtUksqakyAJTBWVOJdB731TIoWpYD1hJrXG37ZguO7ShkBbqWY4NKd8a+PF2YgvB/mLIbDG6dV1/FeUVbdnbgYr/xW+YFDNS/KGZCzJgAw5pMtvqz2NJaLTpGUBPztjOG6M9daUd6mYwGe+IKXEIUL4f6d/sOOFbQWgrbBRQ5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050148; c=relaxed/simple;
	bh=WLGXAgc+s6BvywZPViWetcQlvvpPwFkqP2mEEcisqjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HmZGKL3+J3338y3Prh7fdJNLGtgRBsYWoOawPZzPaYUKdPpF3XmbLUzz//Bv4dBxGlFMqaR+dTihbtjQjzGjtJ8Zs/nMqUQCI3t4V5jPHLPxa2Gg9gLmTNnOcA5V04AdacjFacfBsF9/qC9QLTsVIlhyKGUi5f41Txyj3gicDuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIhSiOqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIhSiOqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DC51F000E9;
	Thu,  6 Aug 2026 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786050146;
	bh=WLGXAgc+s6BvywZPViWetcQlvvpPwFkqP2mEEcisqjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIhSiOqa0kWH43wePWG6Nm+sieZPgA8qsBAYh65rJwDILGywMcDw4BNWkomB0RF5T
	 aiwW4ZV5i/mxR8i6NM8yX442THM+nd3e9iGnFmpKB5Rm8yQofU6s3E1Pjk1cHd+OOD
	 YQ92IvEnO02zV3ifl3TRP3MXxe3LCp9KKPcSpNN5T+43IoidhmTLLUZeKO61DMqqsu
	 CHmJnhzqlqXQJsPprg/lSuIUSz56k2ecqE8O2aq719BKULOpHBC11hQG7EzOCDQ2zS
	 I+rsmQl9/KFw7KHM3bYY2Tz1MQAGk5GKvsaNW+J3m1fc0u5w6i9VCRkV+6WvBcMs+D
	 HcVtFoQKvCKpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Document
 RTC client properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kamal Wadhwa" <kamal.wadhwa@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
References: <20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com>
 <20260807-rtc-glink-cleanup-v1-1-7801e4d69c4f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:02:25 +0000
Message-Id: <20260806210226.59DC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The pmic_glink driver can now register an RTC auxiliary device on
> glymur, whose PMIC exposes an RTC over GLINK (see rtc-glink driver).
> Document the allow-set-time flag it consumes from the parent
> pmic-glink node.
>=20
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-rtc-glink-=
cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com?part=3D1

