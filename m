Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F335C6B0;
	Fri, 31 Jul 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524561; cv=none; b=esXTloyeLndnaqluXSuoVA5UAE6kgOMzgC6Dea299oRt6iuXPdm35Z3zP8E8fFqIEKQqQblCGEWSTtrdEB2O6WH7omGxsQxxsRNbuHv5yy7XiE4N2f/oDqGO94MCH+YGYuPK9SqtEvM+I7ITYhfGeUf01205J3k5OJmGgTIWhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524561; c=relaxed/simple;
	bh=Fiip5B9ApPpFUAp8SJewEL99QrL5Ln+vU+kzOTObLHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ga1td56vAcziZnUILOPT666tC8j08ZAActouyzlzCwShjjL1d6XgMOk5eKRm6r/wLCL6UarUEfmW6MrJHci4op4mkpaERzsL9xp0oiTYf4bWScApF3pEREDBAPIpqWOJkHUJBvcxtLpzxK9u0P2h56WnsT9ST12t7HOS1Bc7Kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPtHjtyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPtHjtyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355011F00AC4;
	Fri, 31 Jul 2026 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524560;
	bh=Fiip5B9ApPpFUAp8SJewEL99QrL5Ln+vU+kzOTObLHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPtHjtyVcTQvKixuEVIpipxjQSdoS5YAHDk/E/B++wdYIdu62LR1BU3ph91ZYVIZC
	 v6J3WeRku05mZfRywZfY6AX1e4jVaX5QvDEkRXIuTTmAStDJbQtiuJhuqOW/ZY1po/
	 /UClZisFtYgF9b0r/LLus+/8SfgIOl5fTGd/ymA6GSnlVnnNHwC2YZozTWGaxnD0hT
	 evCqdv3lSpH5UIxScur7s1MJq1l5xvo6N+OPOlg4XZTcTRiA7FVtIIIXB/BB4tkh9L
	 /YVh+celSmElrmsZxQN1kdX+XDSsd5Oh5fSlUUaWom7bt880vt9c8CU/aZg6o+GILC
	 DvZYkxpHZ/CjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260731184831.44037-8-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:02:38 +0000
Message-Id: <20260731190239.355011F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D7

