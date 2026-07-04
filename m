Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89731ED81
	for <linux-rtc@vger.kernel.org>; Sat,  4 Jul 2026 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167564; cv=none; b=H9JuWp1v7737VOfwz7XyVCOSdGjloJ3o8ZDZ8dw7mbVA2q6CNnaaYX9C5J/tRN9c2A2whD6k0ufe38r2tAQqEkErehrAIXLxDMA8lCMXMQV8iu4oHvuJdPtsvy1uQwJ8+kEgBhZ0rN2irvon1QgriIExEIGBDSjynaH0HF0PJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167564; c=relaxed/simple;
	bh=x1wXv7jNByols2U0wA7Wcg91MLd5wpEhGgdRWMBstLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eA+mZlZ6hnhTpTjsG4ijXfHkDvEgLevrj3nASEAseMXhrFU3+fWN9+2NsvyPb/R7XKtPbzxCjQ6cIBHSDVDUvt/WvukJGCKNm8aPFHuOwApM0k48K38Kc7QG7G7qwH68anAcGLwQrTPlSHPzsSd2SLU31uVDxoAIsvstx1ZeILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEx0jeWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEx0jeWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC3B1F000E9;
	Sat,  4 Jul 2026 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783167562;
	bh=nQ/zSEq8M29mqMgBtIQx0uORkAw70waKJks4S0yeXwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEx0jeWHzMK4Gj/cazT032IldabcqE2oOZ3ao0qlu45RyrfOmE2mU/gE9OwN5X+DK
	 b8T//dLWBMVOukTXAYg8zwYuaRXj/zlZFzfl7Op9PxEQP+58uyoUrOxSSJ1IIKRxHj
	 Cbbbbg+7WDoyPQwpaYQ+VFZ7tWngoq8W7z5a+mrXIIHMaTWahEOkHA0m2eqiZ2GcC5
	 8FpzsAxueKumwVOjml2/85S52hMDFI4i4rLF7BKkRWgcWSlxzXrK0DnngwB5XjuxX0
	 73fy5E5G/ja+DgFTaKF1Urr780k4YlbXIjBDRTheANpISlrB74K4IGthSrJ3JKZJPH
	 V6rNlh0+MU5Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: brcmstb-waketimer: add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260704121734.54941-1-pengpeng@iscas.ac.cn>
References: <20260704121734.54941-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:19:21 +0000
Message-Id: <20260704121922.3BC3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704121734.5494=
1-1-pengpeng@iscas.ac.cn?part=3D1

