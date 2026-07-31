Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B57384CC6
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485189; cv=none; b=OqdOKhBVRbAgdZuSDG+YjfiK+RgXOFh07umSZFgfulFdy7DV6JzbySec5KPkIwtb7vEWrJ7j5QOYF/v/qQOd0AzJ8+saReJDqiU8qyIEe+guHAh2LHtErxouiRKGtS4PQ/ibpO+sJLAV1f/R/2uubHM7xGEgQs07wAS8aYECCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485189; c=relaxed/simple;
	bh=spAPCs+hkr0d1ECkAe7i74YrZvjml6JFM/fmjxBQ0dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBa8CwgsZ+AciWOpAXQO1orAPep5n4JlcnXj+dZtCHgoL7LrrjXdGi7bcPCsxbwukgK1c4nkTAWUje0RKsPmKUh8NVi6LShHcUcqDbIOhfzdqSjBoK05Fb2iRKerI0YJq6pPAMnBhTKfE9zgvw3TDPgUoEtdFFolCOGZTmdg7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8LtR6Gz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8LtR6Gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A3B1F00A3A;
	Fri, 31 Jul 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785485188;
	bh=spAPCs+hkr0d1ECkAe7i74YrZvjml6JFM/fmjxBQ0dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8LtR6GzZXwaQW1yGv9OFw+sOF+uSxsHUPdwU50cXkvbSZdDKp8/yRE3SExwHJ4eW
	 j0wolEtRVRnYijpa9AtXCXY+wIYnynJgEuGfUVnR27arz+jd/NBdh6bekGDo/ua4LS
	 tKxk/D5ckH8+Lj6TGraV5IRVXrhFcCvqPSibe5P+U4UeSO2CqTnPY4h5mk+FLc5idv
	 DnP8RF06+pIVimOB2vHe1V0OyddAvSRBgaRdiuK+nSbKTm+THo5bOB5MEKuVhXTogn
	 OaoD3REq5wUAtXRysCBfXhni60OHbYfn4/+1anvn7z31uwSXDL41mKzHTScP5lSbPo
	 iP4JU5isk8Ofw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: gamecube: check return value of
 devm_rtc_register_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260731080255.387419-1-gonglinkai@kylinos.cn>
References: <20260731080255.387419-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:06:27 +0000
Message-Id: <20260731080627.E9A3B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> gamecube_rtc_probe() ignored the return value of
> devm_rtc_register_device() and always returned success. Propagate the
> error so probe fails when RTC registration fails.
>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731080255.3874=
19-1-gonglinkai@kylinos.cn?part=3D1

