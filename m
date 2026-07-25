Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB78635D
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939619; cv=none; b=ehAnN33eoE1aNmDpuYwSREqMFumj8zjmveSilzgHf5H+sW3tRWLq9Rr1xN9Q0aaXpQEACOEUvo9oYpojB+fa7cwQsG2gfrGmp5tF+3nhO46xPTmayiZA3U6XnllizH28ijvtys6iu5zMNtiB3iE5k/IaGYrKAImZhcTGt+ux9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939619; c=relaxed/simple;
	bh=RYpQnPZ5JbcDrzitp6TUiNDLzCM36ewNt/7wyz7r6hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M4rKlAAUXGhnlkt/6pT1LNn/K5wrdAqkkFGJ4r+LjF1bUNd/HJyiUm/HxB8q/1U8ooXHCA7oLohaME150Y963fugQhziDZctbDJzXeE/UoaEsNg3goxO8+9PbvKD+xD8bOBk1ke4ey1romlQk/aG/JB+3tZ1IQsY55Io2x2El9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiRl8Z8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiRl8Z8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA871F000E9;
	Sat, 25 Jul 2026 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939617;
	bh=b/ArlgT3d2AFhTrgwc8YotjdCFUbqo+wCJZWIFITHOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oiRl8Z8MHGBqhseUfQm4XPQI96biaV+3Nnaz+b0P09GWG8M3nrcV9Ay5aD4MZdRpk
	 TD+QDNq4zmNo8PEzNt5POcjEp96vCim4uzmjqwkTcdIMsZ6kpNY2Q36fLSSDKsZRep
	 xzmFv0W2eiRmd9h4sHnbwV00EPnzb5cPjL4WVlsaYF40h+ojOZOyfITjHipABvNbCi
	 eW3JgLitgRFqZ0+RwYMl48vdGdQhlrpe1K9nYwjUCb3UmXmdcQbg7mHk31yw0Cox/e
	 SQI6AWiWMeViXEjBe/7gK7pRcwUnaATWqwVrL6KGuqac8mNMv0KQG7TGd2BTHovtdY
	 txIjSn8vA64bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] rtc: abx80x: Don't warn about oscillator failure
 after POR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260725002320.96660-1-festevam@gmail.com>
References: <20260725002320.96660-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:33:37 +0000
Message-Id: <20260725003337.AEA871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Sean Anderson <sean.anderson@seco.com>
>=20
> According to the datasheet, the "oscillator failure" bit is set
>=20
>   ...on a power on reset, when both the system and battery voltages have
>   dropped below acceptable levels. It is also set if an Oscillator Failure
>   occurs....
>=20
> From testing, this bit is also set if a software reset is initiated.
>=20
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue, such as an oscillator failure,
> instead of a transient one, such as power loss.
>=20
> Because there are several other reasons which might cause this bit to be
> set, including booting for the first time or a battery failure, do not
> warn about oscillator failures unconditionally. This may cause system
> integrators to waste time investigating the wrong issue.
>=20
> Continue printing a message about invalid time data before the time has
> been set. Only report an oscillator failure after the driver has
> successfully written the time and cleared the flag.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725002320.9666=
0-1-festevam@gmail.com?part=3D1

