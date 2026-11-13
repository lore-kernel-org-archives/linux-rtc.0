Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609555;
	b=zjtgDamRiOigYw8tCTMh7jNP7kxksQ+9Xh0YReIXp53MMFe6yzZiAQKuQG4Gh8T27ZfL
	 W4SRHVPb9vEw4OQ4oliN+sNquUeStH8eXla1dT147PhIoEa0k2QW5g1ibGcD2ft8aXjQq
	 RzN+pi7h+3Pvi+BRc7d4VXrfedyL8B3ooSXp2xe5eNkZaGcSed+DV8WLOb8ZcbXc66wKA
	 mASx/ar0mUXY+Q89ZNzjAeUHWxoVpevDwyP4CbmDdjhnYg98aHU4j+irhoe+3doNOlSTL
	 QpsHmF/4np6YWbsT301++je7K327jTrq+2lDdQ8cHir+MRyutIM+IQvd3fCmdrf6tjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xswzpb4iPtEu49O5BbFLS+BZ65eN4z6jRtVUQ8rE5pU=;
	b=0rBTPHUefZfrsPGgJjt/vylvaVQIeIwYwsVKrx/omOvV95jkS55KqCjrErVec0I5wpp3
	 DcmdMhlBd25ADqzEt0I69Unq/ef1ODDmZYqouhAGrSstcpZByTuBEPcHGpHvgKmmXnr2+
	 ZmzMQS9CeMybIwykCYvVaPt+KaZ80K1Kq+IUd9I06xyKgRJrisfltHEAu4YyywixpZhaA
	 OQmDFmGFVeoQW5S85jC6n4GZA+jGaVLd9Gd9xu7NtV4v0nK5EPwT1LH9szMXlj2WqxDuC
	 ti5OKalaEhjpgKjVUIe7ilQAKzYgs7Fb4M1BJVChOw9PaW9GQw4JBl4t6tzl0lMGtHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtPOIvdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67147606A541
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtPOIvdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD2B1F000C4;
	Fri, 13 Nov 2026 22:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609555;
	bh=xswzpb4iPtEu49O5BbFLS+BZ65eN4z6jRtVUQ8rE5pU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtPOIvdLsXBrv9dG1iJvXHNFUEiKYh8bTX8zHX2gGe2ilvKtQGN4a7AnNWunGlxS9
	 At7YbKv+Aj344NqfVcOhIY98sOdc0t/0HYxEfksVuubL2wnRE1Kmhcb6cL/fPDM8f4
	 CsKzSOBT8G9BYa83JnQOB07kfvBW8/Af6ZpeckTp3LrMHBXQHK7XOarXm2qX5WnBC6
	 BmmGMVAYIrNo8a+y1Oq0w21FwXOpEXPJAhP9wBEz3HNlauq9Vq2LNFvPBxYVGMdsoV
	 02Yj1mK5Ix0ioYffia40QBw03bSmWl++aFtNwQgGVdrIBu/Sj06U5AJUDCD52X3l1l
	 iiTTYsO3NQ3PA==
Message-ID: <sashiko-outbox-213830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/19] pinctrl: sunxi: allow a per-controller IRQ
 register base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-13-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-13-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:14 +0000
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
> The V861 always-on pin controller has its interrupt registers at 0x40
> instead of 0x200. Let the descriptor override the base.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D13

