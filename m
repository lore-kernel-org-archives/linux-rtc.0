Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609718;
	b=qpgm5+boNM2vlTwEE8WGI7fs8AUzaKwfYmlhski6f04SplOvDaa5EGgyLOjUEUuLwa0A
	 itHRo+CKqsjRMMl86HiaaNpRHFPYjTcU1TZK/xiqTgx6v5m8xrKUNAzOvT/HpdFl3d0NW
	 Sz67hNWWTB30a9zm8hCrXAb/JM36R8gOV2Mi9LmyvyoE/CJswBbEOisEeQ2bkzEP7XIfk
	 MAmKMaVwDddFnE3URsvrl//S0h4GbNH3vWsP+2sDScDvwVYCCmGqH7WZ2mJw/E3mkjlI2
	 B73AE+7H0mIPy7FKZwNWPmNvkWQ1FRzr/xs2sUT+TyguGw2efMwuAFz5VTdkcWgOerQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a6VlVvQekKxe4XBngX2zbvnlolL/NOWY11a4MIqgV2Q=;
	b=hBr9zp2i1iRdWDDeNEn8HDPIjHTnTyvKTP+PtHEmqvucEU6FOgagfh4EN9WI459BBhR5
	 Wx/HYd0QEuc8SllLUDrAYqkBMbl7fd2w65Xz8ywmq27kKDJE7yJkrxhvElKd8REbZ6tLi
	 Aucnpf6y07sFpmhMDGCkdYQD+v3WJM5wZo4mew+D7krYbXQGooQDsH49eoUst//mj3SLx
	 lxc+UuUPrTv43549iIhCwL/jYQaakWMzvDM7dcrdRneZ0pwIpoi7/XC20T0EVSInegwMD
	 o8VC9Hc1GRC+upL715nl7YpKDjJ2uRUnsQGh6c8+Lwb2qE2eey32+2pgrCbCUjgkTug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq+dtKqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7287606A546
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kq+dtKqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE31F000C4;
	Fri, 13 Nov 2026 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609718;
	bh=a6VlVvQekKxe4XBngX2zbvnlolL/NOWY11a4MIqgV2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kq+dtKqy4ma9qaje4sqFcikUqUmYOYNjfHzKifAo6O1A0scNypRCwnX018B8CzSdc
	 nYtEiJ/vJghSHcLS/WLgYvOl5r0JkW0BkaorNrz0X7kkzK1wf3vfLyIafAYKL3co3P
	 WUO9rzKNMI/amlbng782cfY5Z/4Z5MqNXfnchzkssp6XjIFy8Q7LuLBLvUo3qoOZvT
	 JZjkqkpVPOmdq77wAWMVtKt9EQY1aUmhqkz51GI7z4OohvLAF2B0s360o8+GSE93nf
	 xThp5mK8ImVvopZkjoZQOWyWdAETep9ZHO16z8XOHmU1V2symQsBPPpmX6cI/yXvz9
	 DSxLFcc21ve0Q==
Message-ID: <sashiko-outbox-213836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/19] dt-bindings: pinctrl: add the Allwinner V861 pin
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-12-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-12-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:41:57 +0000
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
> The V861 main and always-on pin controllers follow the A523 binding.
> The always-on one has a single interrupt bank, so also allow a single
> debounce value.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D12

