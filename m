Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724636F414
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329378; cv=none; b=l9sR7vAJpaLecxef6aWJ3ja71MDREE8BODLHYIeq8SseNImZZeZSgeuvHK4eW+KYpdWju7pvpFOC2dVEJHPmILE+kq7XmPIQF4ag8/MxS1fHXgCoQJ3XCNu3ZEqEsu5xd69H3N1PlQk80DUdG21qo7ZkhpcX6RP+F+VMZkTLb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329378; c=relaxed/simple;
	bh=c4Ae7fWeZ11sOhVqKE3/si9KeTiMCx/DY8JCJjC/rgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6Xftobobs/zpWcB68IwhfpVsFDCKMMV1tj5xq7fmdoHf8BfQYvwfMyW+97eKnSH98sJZP2rPpQYKfBHphZcGhVYQEONkaio3qC75I/PrNsPQEeUfoSS4K5MHImcDj8fGBUS0KuGw+tM9vmN9LjsovMvT4cxc3kTw+uDucgj/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSCaY93O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSCaY93O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB41F000E9;
	Fri, 21 Aug 2026 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787329377;
	bh=TASK092qBb7KSK9V3+MnmGw8xjX41ZneyKArpmgoNAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSCaY93Ox2ahhGdn5EbybyltyU5nYh0FIULMl+Pa3B/M6M1DAdps1k4PwiFjfy7Uc
	 4IhD1wf8WGQk9V3pNIwzH6cKxICGUaJXC1yEA5g7lSRf2fv7FjwzjlyBGIfN3h7nrr
	 5kU/LWCAMrt37GrlSg8r1eLSh2ZSzl/i1tEZj3Yiden3OOY8ugENb4DRC8pdZU7J5P
	 ivnBpT1/rFLzoxnK0VRadJWanhcbkSAg2aAlVU2bEBa0PYGH7iP/STVcG20vyhC/PA
	 G/dBUi+z7HyVoMUePz1ApjYhRMXwyAO1qt9tm7h71yU1YSW2wL+xhD2gTGgWUXKsFJ
	 8mg066dMZTELQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pm8xxx: do not fail probe when UEFI offset
 variable is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ociepka" <greg@ferrisoft.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821181148.1642208-1-greg@ferrisoft.com>
References: <20260821181148.1642208-1-greg@ferrisoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 16:22:56 +0000
Message-Id: <20260821162256.D3BB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On machines using "qcom,uefi-rtc-info" the Unix epoch offset for the
> read-only PMIC RTC counter lives in the RTCInfo UEFI variable. The
> driver reads it at probe time and treats every failure as fatal,
> including EFI_NOT_FOUND.
>=20
> That turns a merely-uninitialized clock into a permanently absent one
> on firmware that never creates the variable. The ASUS Zenbook A16
> (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", InsydeH2O UEFI) is
> such a machine: qseecom and uefisecapp come up fine, other variables
> in the same Qualcomm vendor GUID (882f8c2b-9646-435f-8de5-f208ff80c1bd)
> exist and are readable, but among the 110 variables exposed through
> efivarfs there is no RTCInfo -- and Windows on the same machine does
> not create one either. Probe then fails:
>=20
>   rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver rtc-pm8xxx
> [ ... ]
> following boot restores correct wall time from the RTC before any
> network is up.
>=20
> Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")
> Signed-off-by: Greg Ociepka <greg@ferrisoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821181148.1642=
208-1-greg@ferrisoft.com?part=3D1

