Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF341F5DD;
	Wed, 15 Jul 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138940; cv=none; b=Vusr25grZKJ3ENjEkxbaVVxeumfVkJszGuX4GqsL5IJ9tSDO6skkAWbsLHol56wElrUn4O/HdWNQDijkb6uFKkMQCvrXhjP99qlf+lzCAAcPTt6vH+BXlrxDPFaotSi8xk1n+8Bx0Cpbkr/4M5TBeXyreEyOEpOR8kaxrDtcYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138940; c=relaxed/simple;
	bh=HPaEd3alxnd78b+P7ZccisPYvTe80C6W4pU5K9w/bD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lX1b+nuSYVxZ9hmAAb+ghgTGna0rSvjMZHf2f8/jypx9gpe4Mng2Hk4NWDQrmkHcOhstHUNuSAH3snrIFaxz0tzdanU27cMp0/QoVEh7I0PsEiLFV6IHDGMEia+joOHok/WqhtnmyXNGDnr5ro9ehY+6ogQ1g5AMH5hr/A3KO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNqO+nw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNqO+nw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5671F000E9;
	Wed, 15 Jul 2026 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138935;
	bh=az6A+r5sV1xM8anb9eU0+PGR2wIcnyNZ2dPn/ThWLL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNqO+nw8Bkk2TpyUjJ7VhYmd+ZjPfelOhKRWosJrECDZ84XrANXi2OnBIKDebUn8w
	 J2eQrKXxoC9mOWTmvHCwxAM5ms2bWzCHGgfvr1y4u9IC1hSZSEtciHbkjgkYYLmdSU
	 o8qB+/3RI3En/zS8aanRMcx4thoh8JFVkeF5dhD3JasbsXebwWjbSkthdij7zZEmA6
	 BAsEozCI+7Jq+uaj9MibgI0hHUqzg9rgLqU2/+aZSRLAeCraRjK9Sz9ralmShoxN1r
	 il/T+MIJEOySTvoWINhAI2NN0X8UtuX5D1vC7JP7KyP6gH8Mw/mLZ89xIluBXemwU0
	 Cs+FUMDcEM+vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] mfd: twl-core: make reg_write callback take const
 void *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, ojeda@kernel.org, neil.armstrong@linaro.org, linux-rtc@vger.kernel.org, imx@lists.linux.dev, mfd@lists.linux.dev, Frank.Li@kernel.org, lee@kernel.org, linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org
In-Reply-To: <20260715175229.24672-8-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-8-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:08:54 +0000
Message-Id: <20260715180854.EE5671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The commit message description is not capitalized, violating MFD su=
bsystem guidelines.

Pre-existing issues:
- [High] Probe failure during MFD device registration skips manual resource=
 cleanup, causing resource leaks.
--

--- Patch [7]: [PATCH 7/8] mfd: twl-core: make reg_write callback take cons=
t void * ---
commit 5525fd3bfa73424e942892bd1e1fb2d2e9554159
Author: Link Mauve <linkmauve@linkmauve.fr>

mfd: twl-core: make reg_write callback take const void *

This commit updates the reg_write callback to use a const void pointer for
its data argument. It fixes all users of the nvmem_config API to accommodate
this change.

> mfd: twl-core: make reg_write callback take const void *

[Severity: Low]
This isn't a bug, but should the description after the subsystem prefix be
capitalized (i.e., "Make reg_write...") to match the MFD subsystem guidelin=
es?

[Severity: High]
This is a pre-existing issue, but I noticed a potential resource leak in
twl_probe(). If devm_mfd_add_devices() fails, the code jumps directly to
the 'free' label, skipping the 'fail' label:

drivers/mfd/twl-core.c:twl_probe() {
    ...
		status =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
					      cells, num_cells, NULL, 0, NULL);
		if (status < 0)
			goto free;
    ...
fail:
	if (status < 0)
		twl_remove(client);
free:
	if (status < 0)
		platform_device_unregister(pdev);
    ...
}

Does this bypass leak manually requested IRQ domains and unmanaged dummy I2C
devices by skipping twl_remove()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D7
