Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59023E1D15;
	Tue,  4 Aug 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856908; cv=none; b=l6/zJFFpI+J6A2osRXQm0qJ/wH68wPw0VT4CCCdH860TUUBELyXro3Oa6Ep9t/aEmcJQ15FwIlA1NP99UGW9xSLsKCqoP9wBsGoed5YcolNoC8xlZ04TjlYSXOoPEqskf00WD+xLpOEuehbD6tIDDziTUvzGfapvJhmpUjoQ7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856908; c=relaxed/simple;
	bh=UfwBNEhDjrEnks08wditHDlDH133ZDZtarzHi0vMRGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohCO4ErjtiqrbNAaA8J42p87UxeF6JVlabjuHCffbh0ftVpmwYzGpxzsZRuF0kFu49VFU2ZiL6xqQfmf0VHc7yB7vgvTdj7VztXb3fl/rmj6AEyqnIlg5WV5O70iW5xpT/4idCLY1KeOljO0YcieDzUzfAXTfJQ05YCSIEPAgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGxZtRbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGxZtRbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCF1F000E9;
	Tue,  4 Aug 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856907;
	bh=UfwBNEhDjrEnks08wditHDlDH133ZDZtarzHi0vMRGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PGxZtRbdtltQ7Xl8JQkL9HgS5MwjdluOXvbjtx/9r/uoKMFmtPIm0L1WIIxHI6xk4
	 oYsANHvUxKNjLhUHd4lIAbUjMRbcd2aNSaAOeXf0hbwuaRzNtRhnQC+cYsH+TIVE0c
	 e7GKDyau6LGhKwOQ4OeWxmT7g0SfD5XG0CBZOhvZEs70Qm/MU4ogWzBrg4m8LjLJX+
	 peQASWqrUoXuAwQSLQpyOhPjiognJjMtpewCrNEKDT4OLvEPUIRKS6KeB5AbcxAP6z
	 q657LnY6+M8rbBacgquCfMlynIy3XjvsubgmfOQVBvY4vKK3GevzQufJDIZm+XSK7f
	 iipIYOxfdObYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: ingenic,rtc: Use generic
 power-controller schema
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260804144553.2518722-1-peng.fan@oss.nxp.com>
References: <20260804144553.2518722-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:21:46 +0000
Message-Id: <20260804152146.DDFCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Convert the binding to use the generic power-controller schema instead by
> referencing power-controller.yaml and removing the local
> `system-power-controller` property definition.
>=20
> Acked-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804144553.2518=
722-1-peng.fan@oss.nxp.com?part=3D1

