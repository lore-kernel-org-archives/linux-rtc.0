Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB2276041
	for <linux-rtc@vger.kernel.org>; Sat,  4 Jul 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178897; cv=none; b=JON7qP3ItoxaIc2KieN0jXY3kVyfyRrn2YHrBTnaaeWZOM4dwoxMUXGb8bKHvbTOF+b1On0nVZ296g5cBehNvYbFP83rzZKkqkACj1hl0AgY4vxOybCtRPkUhfqT1tWLUyl3m8qf+Hx1ne5O69hgINmQBZbXi6R/Vwxh0E2U4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178897; c=relaxed/simple;
	bh=gaqksQ95EwhfYPuP0Ws+q93jNzSFQ1hTYU7v2u0niUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=suGY23iik8kW2ThEvmG2Jl2gvdziaK/DR77BHHKbsx4Bf2+Ykxbb50WQPy1OjYhFqVG2PRoTuR8ZjIU0FSEOX8LXLptF1+Ye4iD+8bvNKeYaxZ2DUFICyEeH3omVbmPVMzCzlluuohnkwVCp4DhHkr6kZrDWCZsdWhD3liZp2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUV032Qj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUV032Qj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D7D1F000E9;
	Sat,  4 Jul 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783178896;
	bh=sZJ2qV4xaP6BCNo97hI71zRxA31STeTcTO4pYBVFVYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUV032Qj0tw5xMMJCrlgrlWTH9J/+/RkMvlk+TnZyauL6geUkA7PVPpgS5AwtPlgs
	 +dfyhP/eFWHgw23JY7ZOPP94mogpGH8Z1A5JNjAgHBmAsxt122KyzaElKsVTtkw06L
	 YRxOD//wrWEj2uPh0eYf+Fy9CXHimSdIqrNkup6rZH1Qf3VeLPkPaNrbeKyyOhgWTD
	 gn5Gr/pr6VtYaCsZ+ZOtedX4d6CJ9hMY37fWlyAUXH3aNvtK0kHLqA6m6IWniMlM1K
	 BlylYLJNlH8vzA8dFuEExyT66bmqMcGbIeut9Q08GKtff1sETdVLKqjUIaOxnD3XZh
	 64Buxb5NfAnLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260704152528.53258-1-pengpeng@iscas.ac.cn>
References: <20260704152528.53258-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 15:28:15 +0000
Message-Id: <20260704152815.D9D7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The driver has a match table for the i2c bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704152528.5325=
8-1-pengpeng@iscas.ac.cn?part=3D1

