Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA53E1D1D;
	Tue,  4 Aug 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863774; cv=none; b=dxt2ZXnO1qRWWk8Swj4oNeEhdg6rD2JuR5Y//hOE1OwdWOGZjqJYPE6LqgvDXoR564AswKXIGMZhBPRvWaOpGBmgXuEP61D/F3NHLXPzjkC8SsNDs9hHhjZ29HlzTD4qLp47La4JHc343zU83RnOdTwwq0sVIOqAKLGG4X6K+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863774; c=relaxed/simple;
	bh=6sr/x+fQR2AEQJTqvRvdaqXDLGk+X1zGeYBTQScmqf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJCB/z1IGUJD9E6f44/WCX/K9LP1eANi8j68txIuGvifFxucoTW/EtW/ScehSnT9TbRqzL2Mvs1bpPjgxvvZ9GrQe+o0vCrpOgi8lpRc8AOaLrrG4L1qhWW8cFRI3ddhOMwtdnq1caB+sDVeS5KzPLO4Im6vrJv969CwvGNhyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdSFS+LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdSFS+LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3CC1F00A3A;
	Tue,  4 Aug 2026 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863762;
	bh=6sr/x+fQR2AEQJTqvRvdaqXDLGk+X1zGeYBTQScmqf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AdSFS+LOYXTechutowbQ6s65aWKlYCaswC+fEDrTHxO9OwbhMlRwivlIrQL1tkvhO
	 hS7mXtg9//c1CW0nE7LbNse/IgM1xcwO5lpsUPoNOS9kSdMmCw/X5ylztedfxHzEdH
	 F/wKAiikc9w0imuPkpASewKVVbRfZSgRo+1py/2puDu27JAtaEfFpBvqy9T3UNbuw+
	 Qs5sgc5pgJ7GlHwH2eKSfTm6hd3VjYhM7nStZ2+i9cEzB3WC3ecH3TMzDbvdto9nOg
	 EF1qK0XEeVXd1TjARuBDaQ9QYjOGBGP1Jg5bwHZqtRPgkrlD6atX3CcjxHDL580t9A
	 TY0zqHug5l9rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] ARM: dts: omap: dra7: add da830 fallback to
 am3352 rtc compatible string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260804-ti-omap-rtc-v3-3-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
 <20260804-ti-omap-rtc-v3-3-ba3bbd8af570@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:16:01 +0000
Message-Id: <20260804171602.1A3CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The AM3352 RTC is compatible with the DA830 RTC. Update the compatible
> string to include the ti,da830-rtc fallback to align with the device
> tree bindings and other board files.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-ti-omap-rt=
c-v3-0-ba3bbd8af570@gmail.com?part=3D3

