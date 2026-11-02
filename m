Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659735;
	b=GUBWUQuygAIaNlBB7gT1kMOPqKqxhnLiSsASkAlegx5O7MTS1tZKYLXn5iTR7QDYjCPZ
	 +7yAMwsKRh6xtmtSse7TlJ7Ph7W1lTlqzW+ATR+lCdXPee+QRvDFBua2U2QMDbw5ywAcU
	 bLZm+bUk6VeTp8K9uSVZqEJbPGIeci6RWe0r4404uwfLrfwGVyVCWlcO9AckTzAcwM0zP
	 anmvuolFOM/ysGEUnWQTESEFT4N21jY11g7oAglyBdsUw98UfXh0GhRu7XaOBKy83j1E9
	 wkCO05+eP2WcGHvMBbhdzxs50I7DXCJaJx3dTtZS637nZVgyO2AWErY1bYPPwDmmJZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q729qlvVHrUEJC/f4Fz4oWGs4xFHUZxO2WszUDEaaqw=;
	b=CQCIBgKsDT/xthU8uv7Iz7cGYTaeKsqhCpjnJBEVJW+nFXvlbJob3GPDQ0U3QdOm4QWm
	 cOZi+lE9qxH+UWDop1KweCmsuj+hvHUNmCLpHCthESPfSkXWGF9pnqEV02lm1n9fL9jK/
	 lqjjg48AOaCOpeo4HvkLPJhvMnWW4gJm9UUB2Ozg/fSZGp25xmX94FIjm8SVRLdUzChig
	 BN5QA1/SXFJZsh4SwGBa8tGBEwhhn5j0wP9jy/rdlGmqbVYWRt3wG1VGps/tpuKUo1aGj
	 3ypus6XxX1Qmg3NKJILsH4/EWjm66L4mf1sZaPCksWLqV+SIVrXU6MxTlVg1LZCkBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8vcoTzC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312C606A324
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8vcoTzC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C071F00A17;
	Mon,  2 Nov 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659734;
	bh=q729qlvVHrUEJC/f4Fz4oWGs4xFHUZxO2WszUDEaaqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8vcoTzCp5CA5sHf2lYx5ZW8Tpd7SajCZ7JZUYHW83gy+HCtOg2ro53f9j09ZSwSS
	 gdExtSdRIQjPs6LxzICQkP8v2KtKS2xjB3i3g/z8Di/1zydRjH0QAqQtkChSTVELsk
	 j7bmjVFxZ0zhjnKBlz90kE/nDX2lRHifSxNsoepmRS6y0lmplL9xnWt9BNvroN8GZU
	 5H9SUJWqAo+egVjBHlJJdpbpqnQReeIzADmKGESKGITeJPsRLEbhNuP5hYyI8b+w5n
	 xtGQmy5rg0QSzSz2GZoZva9C5r/8qKgwsQ3PIC6P8VcSWpJ1e7Letr1jeqlhSbSzLR
	 3+T6n8MNA8oLQ==
Message-ID: <sashiko-outbox-194304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] soc: qcom: pmic_glink: Add RTC client support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kamal Wadhwa" <kamal.wadhwa@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261103-rtc-glink-cleanup-v2-1-895eb6e8d890@qti.qualcomm.com>
References: <20261103-rtc-glink-cleanup-v2-0-895eb6e8d890@qti.qualcomm.com>
 <20261103-rtc-glink-cleanup-v2-1-895eb6e8d890@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:48:53 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> On some Qualcomm targets like Hamoa and Glymur, PMIC RTC is only reachabl=
e over
> the GLINK interface, so add a new RTC auxiliary device ("rtc-glink") to l=
et the
> new RTC glink driver bind against it, mirroring the existing
> altmode/UCSI/power-supply clients.
>=20
> Also add pmic_glink_client_unregister() so the RTC aux client can detach =
from the
> clients list before unregistering the RTC in order to avoid use-after-fre=
e issue
> in a scenario when an alarm IRQ is received during teardown.
>=20
> Enable the RTC client on Glymur and Hamoa/X1E80100 variants, as only those
> currently support this RTC client from the firmware side.
>=20
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Raj Aryan <raryan@qti.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-rtc-glink-=
cleanup-v2-0-895eb6e8d890@qti.qualcomm.com?part=3D1

