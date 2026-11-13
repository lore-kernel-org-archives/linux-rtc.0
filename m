Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609566;
	b=Rcg9WIZYLejBDJJ+aq8dF3un6wMX2gIhLFzkuB+WdswiRzlH8HLC4xv+3MJQLgWLnR+l
	 CCT/86BRDM9AZdCRQ+oJB5WfPCO+F/qcB4Lj3xj+kkRLbxUM7HuA5Mc8pDK9IvTRM1tmR
	 CbkNX1BPu6OK51E7mSivgaDwj8lyTmTF+Tl9d3PgJm0O2yLj9PDR17vMbNu2wdShHIA3w
	 OlLFo+LKsOxMc2lZB3RWdNDdizSm0cToWV+TAWOtzPBwxBgthWmQ+YCqH+2VsfozPROkR
	 tWayuQzKHx2qybUp0MIOgHPCkWS/9mSWli5K7nGVZY6oYYVQYpW42PhfEDxLaT+FRpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S9HRiCgHHgLcu+czpEQJgnNtU5PC55v8GzkDmb/IHq0=;
	b=AQLjyHyBNdx6dXccmP+9nDDpGm6b3Nr5gpY9NLTpyV3eAuihIhY1com9md17NREgvGvK
	 75r3VuUTLSBr61PUQXmrYj2mu3f0176gKbiu7Ms0WGsHELYwS8pIFI5XPUFvUF/btvGoB
	 PptPctfsRKql7YOtcw0eDFlLi4uQdyEsj5QkOhWW745jcLH8ZPQmkupeFZpYc1iSfgDhm
	 TlqJBx9HupjldTgpPUpUeydlXI+ebCQ5MpACAof1ji+q4MtnKCeqtTHeOZKU+xuoTW5UF
	 xd/nH3EV5MSTuPr47hVHbJZHTrtPAQOsGodGDIvUQos2LM0/4R9sYIjaTzfZzaXbGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm7UN0Yu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADC606A549
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lm7UN0Yu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4AE1F000C4;
	Fri, 13 Nov 2026 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609566;
	bh=S9HRiCgHHgLcu+czpEQJgnNtU5PC55v8GzkDmb/IHq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lm7UN0YujlCoWDZAs8hPm7VKvLwgXhD6OMA5OedNkozosRPYbk4c79DrGqBM7xMst
	 XTmkBUTi1DlE9CVOCdjJb/E/kKwcwI951K5VpsqL5j6F9qPNGoJzgomRmDhOTDg2TZ
	 lWhPedy9lULAhKayI3DV/R8XUsjTO7XJuxdmMw3qs/JOFhfLhjhinahvJzRwBEqkIP
	 ShmDjbH/MfnxIbQkFD8panQrpM7l5XsAKfcqXYzyCcqwStP7HMUUAlqVaTLq055lHi
	 8cfbxlOxpQWMNOIg7r6337ntn6H0rBQLALhfwXb6DhrfpLFpvp4vP8juHlaq8cmm2f
	 /UEgG1wQPmL0w==
Message-ID: <sashiko-outbox-213832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/19] pinctrl: sunxi: add support for the Allwinner
 V861 R-PIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-15-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-15-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:25 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the V861 always-on pin controller driver, using the DT based
> function tables. The manual calls it RTC_GPIO.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D15

