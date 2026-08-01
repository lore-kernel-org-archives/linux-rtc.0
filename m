Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA9305666;
	Sat,  1 Aug 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610277; cv=none; b=FltOUVvfmCfPp3OyomkQ0TISHCbsW625Bw4WtKQk5aYwYYEN4XYjLtW8G6775U2l3DWz9c70S/zIUw+Qu182bvWWFA7cqSFYMH+f63RtDNooO81+r+04BIDBdJRTSrF6vLb4IVDM4jYLX2J8I7X2PE+M/HNsyHGpS+++KQgcyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610277; c=relaxed/simple;
	bh=yEt7V4YhK2iDACX/Vo2VyUwkAc9OGVzqlLzoo8EroYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eOjBhfIx40xnbpUMATOVgHcYT83xaSw4px9UcmRQpasKWRSneBO6LSSj2oDuflQWzQ+mIkDa2hQWSn/3B06GjQFERA9vdLpEgdCazp7kFUmLieJmoj4sUJwkvK9G9gmhawGKfnVYh66F9RFV6+HIf3Q/cGv/FYsnS2bMJoSje90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWDhRm8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWDhRm8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D101F00AC4;
	Sat,  1 Aug 2026 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610276;
	bh=yEt7V4YhK2iDACX/Vo2VyUwkAc9OGVzqlLzoo8EroYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWDhRm8GHoCnMlxtP/TG0OlaeoQgHtdeoXMog6QAxbTXYEKVmWVA1ScGgo3oPpUx5
	 4viBD7ORgVrdGHofEr4AmTRQK6Y8jdi1U9VHi8ge5LilfyKEYQnsaHddXIwcbDupOO
	 yJso+unx5wo4FDo/dwHUj9iOIy3ESBfVrzR9hTab94CAYvv/xhcYBPkgsXlzUphzN0
	 iD4myszD8XfYkcEH2G8JteckXwjTQu2FBCHi8DQeWZ9EXOB0o0FBCYSPiyISXP9xw5
	 N27nUejakuFV/rwQzUViwytM0epEYjaO+Xzys2v+LhExGNXGduLOCpkTbqAmwy4OV5
	 5XUJ5ojkxceyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-1-f10c99ad1d6c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:51:15 +0000
Message-Id: <20260801185116.00D101F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
>=20
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801-rtc_s35390=
a_int1-v2-0-f10c99ad1d6c@posteo.de?part=3D1

