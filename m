Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC33CF662;
	Fri,  4 Sep 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508123; cv=none; b=o9oE5pOliWex33UD1XdKcuOoUWQRviikOxQeSJoQfM2015bMGjPtcRfKP5/E7sohD8WgcGFUrxDwWrbKSDRhIeNXaeQ9RwCl8C16fqbXrwtRV8J+ONtIWp8i6sZb4x/z3LcJX3A3IVmceDp5mgkHBEaVYIbXTFDxdkR8mHJHU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508123; c=relaxed/simple;
	bh=QzL32nQpWaBJ9GvchkBcc+mbTnA7VhacGXtzqiEf3tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mbClmiWOKgKn2eSBKOAVuXIPp762S34wrRi3yv47yrs7Up2tzLqamhx/RM6OqfW9UjokmXWPzeCHqUp0I9Ax3l3hFKZfmwPFEDUyxah/mqQvDAQFdVe65NdhmQnGFUtw9sbTgKGroT8xwp5+67O7yV50JK513dZ1h4qzQpw8Ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7aNfNPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7aNfNPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6511F00A3D;
	Fri,  4 Sep 2026 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508121;
	bh=QzL32nQpWaBJ9GvchkBcc+mbTnA7VhacGXtzqiEf3tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7aNfNPi3iIJkZtuyKqr2jG3fwHlPXXLK6B+16UVIdjacxSeEW1qaWhtH0HEJYiPD
	 b7IECZ9lPKiuElFMNy2Nge9yZBbHADKSQp4n8NgS/Pv/4QpPybeSXOELnCxsmbJOGx
	 bwHfgy+C42Rvcw1dB4dIZxO6Cmt3hzQ/o1pHdpEygZ3YRBaq0cL6PCgUTxlNkSgU3z
	 MrzjlcoSS2PnZRfhnKu/8cPCx5qbvMQebN0Q/R0ZHjv5VdToXIOCpyNA69eWIIKVSd
	 SwOuUdizK+RL7Zg/ZUBZ5e70Ay53UXZmqug37nr0I4kOoqnTDMH70j55Zq8fkB7OEj
	 hVhUjJwNmNIaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: Document PMM8654AU RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Guo" <shengchao.guo@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
References: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:48:40 +0000
Message-Id: <20260904074841.7A6511F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Document Qualcomm PMM8654AU PMIC RTC which is compatible with PMK8350
> RTC.
>=20
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904074541.5904=
85-1-shengchao.guo@oss.qualcomm.com?part=3D1

