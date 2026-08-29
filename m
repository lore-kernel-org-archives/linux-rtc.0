Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2E2C11F3;
	Sat, 29 Aug 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013805; cv=none; b=d8wlANCCEIYyJuObK/MesxRhK+ZWrlsSxXBoH/b7z3wy3EIDB6NWhQdxs/d3Ge+695rU7qzwrpAb8Iupb3kYffRdVJcC27CnW0y1VwTyTN3ZMlEzqaYPKf34ZGfhniziAGrBfW57IQuc9GQI1NCBujDnQt9gJJZxA8rMVj+cJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013805; c=relaxed/simple;
	bh=nNfmwmxalP2Q3LNXkTqCArsU2oNZGe7TNzimsQSwGg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8D52TmVNlBjKGFlK4xNg5cNmrgptSwE4H+HB63+aReyXw9M18bvnp/nRteHR+s5vXKSG4k7KN2Rvl31JvfxaRNm+8Op+l2nYCMVUObJJEyRQmCka8QAkQk0tZQ/7FoFNGSNAu0AbGERaf85UnJdIST7AWwsXT1po80BIgiaphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkOHD7Fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkOHD7Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D4F1F000E9;
	Sat, 29 Aug 2026 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788013804;
	bh=nNfmwmxalP2Q3LNXkTqCArsU2oNZGe7TNzimsQSwGg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkOHD7FyvY10rF82iUZLFmsQ/4ePNWPFfw4oumE37+i/V9qovctG4+LKLq9aNfMy1
	 9/7nyZ/6H/YB8dAtgOTcLaW8JN5ASOat74j4Za3I53AuSk6aslmahnvB0RbW76WMlY
	 GkdtCCOuaZ8K09J11hZk+UmmnMFytanXrOChf8Y1bugtq2cRnMTfrfxxkAZ+T+RaoY
	 7ZIkj4uqOdk1bgprxfB5x89k3S5BqH/8imG4L6LbsDztZaf1CA9Hp3wQX6CNX3Zkk2
	 SqCO5gIHl2pRu+a0x6W3DzDmt4i8cycLQsxVSTdmLb4hzYBRlSXzhm0XVvC02Ti4wi
	 ViOPhEM0GTKDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260829-rtc_s35390a_int1-v7-6-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-6-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:30:03 +0000
Message-Id: <20260829143003.B3D4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
> it is not possible to configure pinctrl.
>=20
> Use interrupt signal 1 for wakeup if no pinmux function has been
> configured in devicetree and dmi sys vendor matches "Synology Inc.".
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D6

