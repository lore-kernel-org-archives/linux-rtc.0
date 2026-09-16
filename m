Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11F4AB3AA;
	Wed, 16 Sep 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574715; cv=none; b=U6XusytaK86Fnt6raIbOlG0hrAs/s2ui/hCI1EP6ZFgvvhExWUfp/r3L536bxf7fS8/GMsufVWar9x3HoRn6gXBXNyxPXHCtoQ4uqmBHppG8eRivW/UUIuezAJumO6OccDfaB/8nci0o/coSdG4ZfFOF8SiApgyRqppM9dyy/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574715; c=relaxed/simple;
	bh=HrzcyqJ3jXrGIfs71icSrxPGnBKzbtm+iRKJNKN4lt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjV3MLGioQ9/4pJM4UG4gKLx7u74gHxVmL8z+bycIywPwEYJJmG94R2QaBgnZnEvO0IdCviN+NCxEVfqYUrqULbGkExRAF2ul04v//ELh1bjPPL7UXtpXLH/hcwDTWoDc4CWcLYmGSFZWuzRKenQa6VmrYFbQ9jBDUv4TaAwwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPGC9jCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPGC9jCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C01F000FF;
	Wed, 16 Sep 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574712;
	bh=HrzcyqJ3jXrGIfs71icSrxPGnBKzbtm+iRKJNKN4lt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPGC9jCd8nqYDO9sQregkOmQ3YZz6FPozS5zblysFSskTaAyK9n9fecC8Jy5+PLbC
	 dKREnGyXCGDy6E9qlm0nri2ejlWaT0MyYvZ1I2U+v6EnYKW2HS0rzz+DH6bYafnSw5
	 dYvh+2+w4nJpn/gQSlHTLZrW3NAW2F149d07SMaPUXCEQWwdvjOKQlXNJvq3lQACUO
	 jK2fhDMYl6qyBua2RCmNMDmG2hMDAH0ZiyEqzEIEzvY/9P9LoNp4ZiLq4cO2WwJL+R
	 3YyadAnx7KLi9CDK/h/SaVzDTnG1I/tNua/rfmdmhzho3hK4ewf2OYNds5VY88tgAZ
	 e6iboYBwttpPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916-rtc_s35390a_int1-v9-6-b2567a3e4959@posteo.de>
References: <20260916-rtc_s35390a_int1-v9-0-b2567a3e4959@posteo.de>
 <20260916-rtc_s35390a_int1-v9-6-b2567a3e4959@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:05:11 +0000
Message-Id: <20260916160512.0D6C01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc_s35390=
a_int1-v9-0-b2567a3e4959@posteo.de?part=3D6

