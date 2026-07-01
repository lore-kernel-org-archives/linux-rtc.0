Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03434CFC2;
	Wed,  1 Jul 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916785; cv=none; b=YawVjjH7mQBCXBizPQUrN2RK3Z40eTY5GK1HejYq5cE5TI1RKUFlC5eJIopS1esXcxMyiGc+tIscCSA8Isb1v0OFhPkdYhFZDwaQR1gY/kpmPMq9xV+rGK5oUinDvdBSNxBMKMretHq05uHZ3dnXbMHslzyDJolQ16tk/8/Rv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916785; c=relaxed/simple;
	bh=AwT5jHczuFsyL24kzI0tWJ4zJxW9vzjzRH6TtZXYya0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ge2wrizVnTW8kYl/N11Ls6kfVaEI2KFU6a2n3KbzVgJWpYluwRIs8dMDWeEaOiYbr3sU7xRrtJYPM/31DWgTPmt0foVVVNgFgEumdZhxrxJ1tFvs6NlgioY2mcmmHYgj7m65CAqfpu2DAnk3udr9CyqvqKrntl6I2o/Fs+FBojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyobOuTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyobOuTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE731F000E9;
	Wed,  1 Jul 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916784;
	bh=AwT5jHczuFsyL24kzI0tWJ4zJxW9vzjzRH6TtZXYya0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyobOuTXc0JIJOUp5XX76Uvgu3TzZx+w93jn5VJdg+m+E8DZrqkfDAKaka8UkxE3H
	 ra+rlQ/BxMSW0Z/kvZkAsj6zZT5DMi4cBZuY4b3b/hJw+TM3aTuL7jIv3NVONsS5Q5
	 CPmzULRRKXVOPqkY38/9MOLcOJsv9bLiYOh6JvvnbMAOce8gALFr0DlYmMUZ4risOz
	 tBjizHw/d+7G4QmX/Hyr8TJSiC1zsNWPhqWtJUalxhakTLKoWUWOjdceS1AZ2/Q2zy
	 SkbrGfRJpdshkmZRiHU6ds3bhTVyK0cHsjOwnnZtroznE3/Q0A+5eKmKQ5h3jSy5da
	 cp11GbMO0BMVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency
 to ARCH_RENESAS
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701142953.2014895-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:39:43 +0000
Message-Id: <20260701143943.ECE731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
> config option to make the driver available across both ARM32 and ARM64
> Renesas architectures.
>=20
> The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
> of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
> and expand the Kconfig help text to allow this driver to be selected for
> these additional platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4

