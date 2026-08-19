Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2527A47F;
	Wed, 19 Aug 2026 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177476; cv=none; b=aDN/+Du2o8EMB4yL/VjXQQP+zzjOBJ9b+PxCmttTmhksDn7EgWE05Varl/YU7y26tBlMn0bR7+yUqu2Ja6RrkTJPbz9wzd/Uzd1SPYRrdgD836cURZIwebqxHaWS7LFT45BD17tTtu1DfSjHtfw4goDdHMHXaPvV4+PR6D03sbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177476; c=relaxed/simple;
	bh=IygrwwS8sNDtRaYsGCZIBNMNk721aliMa/9o6pu33QQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EwYkYMTz/pUF24r4PF99VJdMbiKIW/Z+GWMVMsyArc5QhwPE91sExKSDjFKgn6UmfF681Wjj2ejhkxBW/58FJBHJT9j9xWZ2MiI5GkT11EMvA5q01HnrdR/XoYjXtJzn6ILLvGM6cMdhY54MSfEin2cjpnfLZBXV4EvOFi4T4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTGyqlVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTGyqlVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D2E1F000E9;
	Wed, 19 Aug 2026 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177474;
	bh=IygrwwS8sNDtRaYsGCZIBNMNk721aliMa/9o6pu33QQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTGyqlVF7OI34HV/dOQNEPL5tq/QuIKVXXEfqwlLWeBjeQMFzpNGe7TXETN7G0xEh
	 ysWEVqNXbnT+voC9nc9/1EgcffncjNb2qF8E8rA43ezOhqWk5RSzco2vOgg4ZHGuuH
	 A2iTAAZ+VR9krokDt6KW7YxxhOCLNVDxrZMVksXqqoWN8X6ldZ79Rzovaci0j74tmu
	 IxxuOEPXiPEE1zj7XYgIcTvK18dMDYzU6S1Pbt7KaSl5sFsUBWE1+R/+srybezuAmf
	 v2+41sTSIfbq5Bv9dKvnWul3eVbwOcyyx/28SRyLmggy1N4BCt89O/BdKxNl7hWd1+
	 76XByfl+5jPsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260820-rtc_s35390a_int1-v5-6-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-6-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:11:14 +0000
Message-Id: <20260819221114.88D2E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D6

