Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00A45D901;
	Wed, 30 Sep 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754628; cv=none; b=UQG72uAw+z4fWDsyvj/I1L5bSNsMv9BtY55ppnmarVokWI3O53oRAVFq1GjIJ2aVm/3irokkHyhGol5ljAfAQuJcILIXwXg97KlLYRLwGqUJ8NEqVIccwryie0pQgJIpZlCYXkbjurEDTapjAIILrggBUxl/hQzwKtN3y3MgMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754628; c=relaxed/simple;
	bh=9rdnnumAftz6vbOysclTgr1Sndjgjt1rGHrkV5ZGC3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MecbpDM5WKa5ayBd0qjjrzwQwKjgtVmrzERYKfaXN0jYD/eYrh0YwvxPrMmXaXOFMZT+5kuMgVTuAGlojoBbBDS3rSR4NkMTIcZhQYrjcTty0EAl7UVps0q8qPmoxLzgbCpg7+M7OFtVGlTq6IoY/ignLkgMVpmDacQNbfLgMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeHJmzJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeHJmzJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E831F00893;
	Wed, 30 Sep 2026 07:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754626;
	bh=9rdnnumAftz6vbOysclTgr1Sndjgjt1rGHrkV5ZGC3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeHJmzJEansutM3F8FZxC27ndODKBtVEzP4ME/MYhj4voexaXSCh3g9Rhv7C8YGKn
	 rgjSYibkYxd8XQK0ZswYtP2Jk1Xq/sNVxaHWH60WZq244BjT5sy6wd4oZd3cX402gZ
	 0q1w8/N4JF3m/jqOQxYyVARRKlXaXG66CL1jmLrXOqrDbztX7JBzqNOkbC/4uIrdEs
	 3XPDlBn0r5H8LqDyE9ajmseRbuG5ECSglt+g/zBKxZpyEoTc6P/45CpiUbepX0NerG
	 MM3fNMfYvDNeHwAnx0GCMAZf/ZelpYOcewYXDclPLaek5mYxbQUwIt2nH47DMBF4OJ
	 a3jZseCCDViwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260930074608.479089-2-sander.speetjens@gmail.com>
References: <20260930074608.479089-1-sander.speetjens@gmail.com>
 <20260930074608.479089-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:50:25 +0000
Message-Id: <20260930075026.59E831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930074608.4790=
89-1-sander.speetjens@gmail.com?part=3D1

