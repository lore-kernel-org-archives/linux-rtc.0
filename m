Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239336;
	b=V/XAJbBmy6Sc0/Rgk1v8zPafFIaj2KAgOUkTi9Tk/v/b8JmwBXiELCq57ZZsEjfvQ5iU
	 YJ4WB2bIECVqEUvk+FES8iBLsk+rc3fwfG9L6x0Ga/NdcjkIjNIV54iK4kpguh3H7RHtK
	 UGo0E3fc+eziNaceso+1kAe9YtvqsNygNpbaVN0arW6Jzr7QuFvDYQox3nzrlU02tf949
	 r4kN1eWTKtrWb4Gu3ij8ObiJSPbC6nQUQmYL3LidcL4dAsVxl9xNDjCTU5BP6Akxfi5NE
	 pFX9vg1VxKtwvv3JeTFT/FPvECZPwB2hatAobGXE/0LbjBfsL9JdEYJz54oU1RltVqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VFESuAfZcN+x2V4nHjaEMRfGeIcpw/CPHA2B5iCQ9tM=;
	b=NWUA+2l7pLm+UXdEeskfI7cxE2X/5oOulC6UJAFfbMuS+Q9M8miUETh3KWuwXAcQ3Cmu
	 l8R+k3nFgbXUXdHqefyvu9cKtnVQ49YV5+NbmtYHwnH6cs4/l3DolfiQBLSEuEVH9Qgnb
	 3PjN9srDHnpF1JmPpUPPqGQufXzVrohXbxSqNnFEuEgTvxBSeAJAVgof2Q2fbU2OZngDj
	 nf4AjkSHJGZOdu7RxkmnpFA1/CyA5JLtl+VjZltSUJHloD5TZWrIOlxlTBHNit/JoVkdA
	 ImEMEeH7mgE20EIJ2R1aPHnBAvA+FnEfUSGgHqTjReVmPbVahVz1AVFPSsYrcvmda0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPF5GfwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF61606A325
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPF5GfwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF431F0089F;
	Mon,  9 Nov 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239336;
	bh=VFESuAfZcN+x2V4nHjaEMRfGeIcpw/CPHA2B5iCQ9tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPF5GfwUmySud1ft0WAwaLOcHnvZgveQRhDuph99Up01/SAMoQleetpN/NbLZlYx4
	 z5+gbRb+tRok6LX5cLdgFQ/HIQaDQzEam4rGMsdcj5hmZzoNvkI31A0hePTrcmNEGu
	 u5pyhRTQBV5VChvDHCNTFaoommrGdkkgGH+BdA/KJzteBST/P+laTFdXGcMcp8Ygoq
	 1adYWIuTm+FOh82dK4f5T/L1ySK1uL43vMZ2UU42wZqS4KnnRooPKvJ5ASSvEkj5Zn
	 FZnQf4J9MFLshSdCzExga30p18ZrMDYe4O/HjYOSju7xWx0jeklJO0aMVgH3vA8IDU
	 /LEi47AVKAbnw==
Message-ID: <sashiko-outbox-205184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] riscv: dts: starfive: jh7110: Add the RTC node
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109154501.63762-5-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
 <20261109154501.63762-5-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:48:55 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Tested on a VisionFive 2 v1.3B.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109154501.6376=
2-1-oo.hehir@gmail.com?part=3D4

