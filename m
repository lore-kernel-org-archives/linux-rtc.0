Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475119;
	b=SUd70Og6MhfZed0r3rmhNhnj/0TVpRLrzGxpJcnNgrtRMDV6I9hqIQk6H/YJNh5rsOsq
	 dmycr7b+hi0orIma81zsLnF69iukjNx6XDJqj6s2VXlkOuRV4BPUZoxlLHUwyqijlJz1/
	 bNsp19DP2Qnx9yQAI+mBdR8KObCV8FwLRAe9zl8ml0uiZKHomrNiXxMQlv4f7f5oNZB7G
	 IXtX4lHSY7vN81upRMh2HRLJhnxdggLhmwNgbwZ5IavkWhTz+kEITThVj5zGceigxHwXw
	 tSFKK/3gbr2mXe5eyQ2idFMHZQRCbOEdXtL3TqGKfFbbBdY/tQ1aT9+XNqaPQAELv8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SyiKFSYNBIayw2D4mE3/Cmxuo0t8eYrEEnmtU6117Yg=;
	b=QNIlLJZ8A+JMV6UHzgguKzEx1ZE6qlQAB56zVBIyXtPiENDLqCLTQwon4LYn3bu6StJX
	 piPTqanFl1fTUERluJBNEkLBeYGTsUpGhqq9Apl4ZpnYeffE1Q0N0zq3YhbINEneyeXAv
	 +BIFUxi93F/nEa4tE1rOT/Egr9IXq7heHkwg9N5L3f/BD1dpaXygh0PPbwmDbwlnck7KA
	 1og8WdP5vgkLskGyqU8O4CnRm8EYFmOh48feLMa5psqGWkXxE1ekRYPvBTJy5PfnM0VNE
	 odql36p6W5yY5VibQXQc6q8G8h+VEUlDbN+j1yEL4txSEWAs1EFvh8CEygJXXKbCcIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpF3CjQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E02606A321
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpF3CjQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534B01F00A05;
	Thu, 12 Nov 2026 09:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475118;
	bh=SyiKFSYNBIayw2D4mE3/Cmxuo0t8eYrEEnmtU6117Yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HpF3CjQRPkcv361OrIKrrywy66W/307iJMZKhcZG5wduey4Qpo22ynPtNB7VnHxHR
	 cbnA8wMzb1OFe1bhm1H2M1CGGMD1OgXGQtPB69QpXuHDQ3r4+azXRgGCjRDn1zlLRZ
	 EkRVPwnAKdB2zw/mFvq9sM1V8YRq86EdJkfY4EwGXm0muFmjaFEecOF5sNF99xjATM
	 M6c5cXhjw0FvsDRpmWBiV0aPEvKPgJa7kx7PmaM+C6p31NbY4i8bxrvv7QjyJ25xcC
	 yajA9N2nF6+j+uhT99UPDEHvc32bJzZAzrwEP5q6PSfV13sL6mae4KdddI7HaD5vFj
	 BAd2l/OWBAa9Q==
Message-ID: <sashiko-outbox-210860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akhilesh Patil" <akhilesh.patil@linux.dev>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:18:37 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
>=20
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112091641.GA36=
43677@u5ce4748bae3b54.ant.amazon.com?part=3D1

