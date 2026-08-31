Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CE393DFB;
	Mon, 31 Aug 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210366; cv=none; b=hrVPUk9YWHP4uG4tZsqD7Kdoj24rVTemg7GoNJxW6yep8Z97WDunlOSbdGeavRgG/8sTzI0oPj5a/8ssCC/hbXHkF+SZ0yF2wX19LZM+4HAqWjnj3/3CFEyDXSr9a0QBJqp5X++Kgla9Cw2hLJA0ktnirJsyPt1euWsbHteqWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210366; c=relaxed/simple;
	bh=4m0QZTyVqMp9x8b4mJIfdB00VUn8ly+/qp3gUtEBOd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPLG5taqr5xyxseEpKyWdnKbGn79dgxJ42cIf7tyg9/UIWSpKLMjY0U4wmTYPHaI2gxJ8DCZFrOBZzwhFvETggP45jrXqr5mN+zUQoAcDWII6UdY9KOK0iZxKjnqTVgrt+E4pIZ6UXoKLI+k4zUXyNRVmYN5HZGBbUlmSGbwff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erkjwrpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erkjwrpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5575A1F00A3E;
	Mon, 31 Aug 2026 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210361;
	bh=4m0QZTyVqMp9x8b4mJIfdB00VUn8ly+/qp3gUtEBOd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erkjwrpJ8xFxoYvjnLmJJ62SceFgY8RmPMjPe6DKEUvGMX8eFDPG/K9SNrdXXs4/I
	 oyzVb3iK2UT6ZM3a1a7PS9c9beeuO8WKPfx2Kj5j+jcRMX8oMr3H1rqVBCaOVQrcTu
	 4T2XW13JujymNf4O8jCzqqDP1f1DItbTR+76tOEz6wtkcPsdM6NbgPh2J9NdiLKVta
	 C/qsHmgVbtn/Nnk/F0kUKibkwlGNMOk2HiPZzpHtNoJhqhQO2IG40478QyeqvDYxqu
	 wLPuLPlxAjW6Brd5GcbTzz3HExUnpNnwrRqRulU4XiOXnKAGUjT7HarnBROO/QapDi
	 pgTgGsulNrB0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260831-rtc_s35390a_int1-v8-6-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-6-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:06:00 +0000
Message-Id: <20260831210601.5575A1F00A3E@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D6

