Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AC4D179B;
	Fri, 18 Sep 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747297; cv=none; b=oLxXtqiDHopHzUxIkXBt068jg0vmg2vE7Qgs5fQd1shmln72MiKo6QTZGQKgehKidRd/SlDHBp9ch1cTqMwAtvBgHpNr/i9Z/Q2r7i7MxxhFr+PxLNoqfHoIi+Ye0AwtAixJrdMVVZApTSKXLegNgVO7DcBAp4SYlQvRqLa2YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747297; c=relaxed/simple;
	bh=ZHg1YFIxEWI8N4PFWsFrfQ3GohGX695C+7Er+cLG56M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WiWHcwRrhv9GfaBDYVGU7jmO6f8wpt+oS+UPoChG3vxHV048MLlbXFcH1fWRegV++x/aDdT7VzzXyxMBHHozfalBDypSyc9d95ZNmaWOL9IsW84Z5kFOTjXwPPSl23ZnOo5+cipPlbpZIThazVJ+fYY0mM/OvP6MHJUTO2xkNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8jwphxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8jwphxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959841F000FF;
	Fri, 18 Sep 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747295;
	bh=ZHg1YFIxEWI8N4PFWsFrfQ3GohGX695C+7Er+cLG56M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8jwphxtWaqhRgIApI0wz1kvaY15qhMG8HfLS0tNBaqoeg2XM0ivaaB1+PcrzVs2D
	 cN1BhGj2R2+KIPZqu2uMEQyIU4EtUvbAC67+tE8A+r2vLboWKeQ4bDt2tXGKQN4MLk
	 Qjvq4ae23pXnrqs+6k4VPsgiKk+S90lbUvf3lRm7+22AhtJnfXtJwknL8LcotUMU/4
	 qwGYmqrklp2kXr65VcrtT7dQ3+4dzxsqspWXcSgBtTW5L3pPYb6MXCK92eLz2qvF14
	 bOtQsTq+dpWbZlxViw2ha6RG8SzmWrZAhbRb/exL98QOAknmDz3M7LJmGCEsMzns/K
	 sniNeGXD8X0Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mxc_v2: fix wake IRQ leak on probe failure and
 remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: Frank.Li@kernel.org, linux-rtc@vger.kernel.org, imx@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260918155429.2549137-1-congnt264@gmail.com>
References: <20260918155429.2549137-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:01:35 +0000
Message-Id: <20260918160135.959841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> dev_pm_set_wake_irq() in probe has no matching dev_pm_clear_wake_irq()
> anywhere -- not on later probe-failure paths, not in remove(). Switch
> to devm_pm_set_wake_irq(), which registers the clear automatically on
> every exit path.
>=20
> Fixes: fbc5ee9a6955 ("rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify =
code")
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260914134826.EC26D1F000FF@smtp.kernel.o=
rg
> Assisted-by: LLM
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918155429.2549=
137-1-congnt264@gmail.com?part=3D1

