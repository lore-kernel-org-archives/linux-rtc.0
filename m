Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08415C14F;
	Sun, 23 Aug 2026 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523533; cv=none; b=MHvwd7+MOct1tyItLTKFdZOGZEZNSwB49bkLQOwpCQcctxIRU5j15Ok1f1vsDYtb4vRUbcEwLd8Bdvk0AjKgnXGTwPlp2MVHAQ0KzpIUvCtAhtsvIV5CGhEy9+8tbmyz7tU9a8I8gA660gknlyTHXL2EPGO3JAIL4JY86MxHT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523533; c=relaxed/simple;
	bh=U8OThpwQflylxmABUThUsG41TZaYBQuCiY1yr9quHt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rj3ltd1GPiLwHcZ/ByHtlD/GVzbbYrH67DEZ4lDvrZqJzvDGWbKuJ+26iQE482Xh/BhDDM6E2WmUGhtAiV9CbT6cyuG0biBlOUHx6Qylow7uVFxuPasxnEkW0V3eZVNohGjIehmnjSh2cldmD96D4QVBML8n67NN5XoVNqXaxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzKyM3k+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzKyM3k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A2B1F000E9;
	Sun, 23 Aug 2026 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523531;
	bh=U8OThpwQflylxmABUThUsG41TZaYBQuCiY1yr9quHt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UzKyM3k+PzOttMsm0LU9oZHA6ccJQmEYBd5rd2Wk676jqEWBmO0nzIFQtlVCTuewf
	 cyNLbN6AXfp/utlh4nXIPhpjunLZMHeprGDCjT2D4xduU4Jf+Tk52AWCIkBgf8lZnv
	 OWxs4Vey+2JsjTspVA0orPMMTp4y+V2vdIYUhbbsyQ7Mf7NhBpEOebP9gYhMtdEmRa
	 YVHC2cpy1xFACTTgab943vyCGiBikJj6LjhrPi8GaTdkZrMtHZvTDSZd79MtoJowI4
	 Xsr2fainVL6lMGM1WSSE8FEfTL7s/RlyFGFRnINfLzEp1D1u5A1oJVn7MbaIPFjzpu
	 lXQNtGguZDIDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260824-rtc_s35390a_int1-v6-6-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-6-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:18:51 +0000
Message-Id: <20260823221851.80A2B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D6

