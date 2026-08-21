Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFB352008;
	Fri, 21 Aug 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347350; cv=none; b=DvnuBapbBXCP/bEE2Z9GwGmtPgg+MpFSerMd2ZCti+t8Pa8qeMVBcWd7UaGk2gS4G18wUV87x0V9KesaFnq6694zq6jUFDTWEFIZbT8x69uRXP9PkM7NKG5/ADvfVSOr67wMd8FYofe3HGj8zO2UUiz/lHvXybkBDz3LMm+L3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347350; c=relaxed/simple;
	bh=NlP7Mv9d9BHe8IU9g1TB7Ezni5NUuvNpP+BIEo/vRMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNpdO8Me+wurkQMjGMNQ9kGlrSb8uQ9kZE9I37FtUwqwJh/IeH/T3BW57fjar8DqC38hG7A1bTgw7vNXD/tatTIH47Zqa4n1JHTBc7MJ2LykiTZjbGbegWbMljeVCMcDuHkZA9FyGA8nPZvfyKxUolwkXHd5e/HmfJXE+DSxv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX5w2w+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX5w2w+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B81F000E9;
	Fri, 21 Aug 2026 21:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347349;
	bh=NlP7Mv9d9BHe8IU9g1TB7Ezni5NUuvNpP+BIEo/vRMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iX5w2w+FGm/e3BHISFHffT2RBRaDLUXv7kKY11fzUscKNSazXyNJUvaly6yiK+5Cr
	 Z8I0w7PhpOGYHd30LqRcbwI0oomYBCv1SNdy6Ig6g7H7g2iXyXuBhO1jZwSPqdCo4L
	 ZnyTjEfpUJd1Mm7zWV4yXWAw+KAWID0P2HeAmGPxDrAthgq+fveBo3/s8k5hVpaE+u
	 9sCmXOdyranVQrxE/0qqN+j6eog0JwLI3FAjbrwrGL1qNSxwwN6jcRKBAF1P5httax
	 7FacIV7fVUsrmQ460nw3wqCRMR776buyNI7bG2TAoCYVtn7xitAtcs15Ex6vwAFy/e
	 UEFw12NBb59Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/17] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821211032.13554-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:22:28 +0000
Message-Id: <20260821212229.2C9B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
>=20
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D5

