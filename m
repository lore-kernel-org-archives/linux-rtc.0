Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34144605C
	for <linux-rtc@vger.kernel.org>; Fri,  4 Sep 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518997; cv=none; b=jCFz7kvZXNnXPZ4OJY0jVclmGr1qqB0V0ooAhI6TKmRG/Rn6/QASaMPgVuvKwUFyMsqPrktX+SvMHT/hWsURccPim4/ZJlu23dttnQ9liGmUQUcpcXBfl2rgO/1pjcjAzS78mZKJZcfyekYfZqtLvj+wpDrgA86xr5i+nv7HGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518997; c=relaxed/simple;
	bh=Cb7IQjFeTeE3mCPKGUOpjUFOMy150In9Id/vR+hj/Zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/4+cWJyijm9Ep76qWTTq+Nck2pS/GflJjAN8zTLeBAlMXv2w+Zi67ZbY/WgC5xAKHCgwaMVPRXHXzC8dBjWqlPr/IiRqmqG73to5iQj5s41hK2h7kFQl3+eCvIQooQ3M/WpMQlrHHz8f7AnSC3/FLh+m+X8qqcUewI5cfCD6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO3ivyyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO3ivyyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200601F00A3D;
	Fri,  4 Sep 2026 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518995;
	bh=wDTE8UxQ7qPiJOIV9b5Xg9RyGrr0Xnn94bLszWT7Td4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VO3ivyyFORFscHhmSU4XS9sWYRw0+5Ux50e+QuE/kFn3QWxnnVA8SZU0IQigsK3aT
	 r8NbuWZfCEsh+NsHyf2YFt5peO73HJrG3BnLsJrkbImPOPPdDEdMQ5E2OIUCfCiWmg
	 od1NH56kR59isTUlogfmzxAB3xTt1p8toHT48/y07LbvrhAaa8uhboIy4PoxAX0vP+
	 3KvOruYmKMTnLjMSsgOpnKi58PIG22rZxJcB4dhXQYRj6soToYjx+/lUg5dbQtRFTN
	 6Een3HgAixKhDzd9VC3uXCIsWDCYiYjNssc8BRvPRgi4VlIgQ66KrSf4ZmJHXVKpho
	 mcv/9ye2BzJmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: fix typos in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: neil.armstrong@linaro.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260904104758.23905-1-hemanth.selam@gmail.com>
References: <20260904104758.23905-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:49:54 +0000
Message-Id: <20260904104955.200601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904104758.2390=
5-1-hemanth.selam@gmail.com?part=3D1

