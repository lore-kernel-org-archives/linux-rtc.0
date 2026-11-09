Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221284;
	b=L4gWiC7ExYPHF/r5tSSxxZvUWb9I/A0XZmN1VMdaXwk9bDjfVh2tQao+0bifkXVI6LW8
	 cXDvu86qHX3ZU8QeYZe2bk7nZJxVfhq2rwQCoqjPGdV40R8eU5T1wA4Yv/j5F2l/jvvSD
	 dsptER049QBSSQGSTf9edhN2z2fNW7dWez8Y6RiLSVw97I/jDEIVBDsLMX0BdBb6H0RY/
	 tcNS9E1Sqej5k6YAVCiwknLfTjF5q4I0ZMqpGmvXteciv0RhTRpKduEM1o79c8Ct5cFvX
	 4efifTOT1TEehIdFFvu0imM2fEgzxVCyoPeCo1tL5kRUrsc0JRPJ0v43/36xP9bkbOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2w9NpOHLiSYxRP1FPDHEsiXuUfQmZWzg6xMGSp86SU=;
	b=sJinyqvJ/bEcYlxnjVzV6d3XRQ1pHClXgaplY9rM8eeJqv5a6mk7ofRZmVlGYV8/3tsV
	 TJayR9y8HCY4jaJhjyb00jVrd47wHWk2z1/k5Jdwe+2mpWCa5Qec8Rpm2fDoiD8UhPbUw
	 PlL3hqJWPFqh+Fp7ofHtKhBdpJh060XuYreJOepXCyM80pTh7TsNiXioVApfbsab8eV71
	 +wM0N84Cok+r1nTQG/0om3FQORQInFLKW1odoLqaWoAbRXPweMCZBAKnZ+sh4i7X5asNY
	 ILtOpy9jIYSb9cFQQqmplB00QSAJFvsE3bAKC0KIY4n8+4GwXgNOcWH3YkqQEGZMOLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1jamDor;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEF606A321;
	Mon,  9 Nov 2026 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1jamDor
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0501F0089F;
	Mon,  9 Nov 2026 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221284;
	bh=K2w9NpOHLiSYxRP1FPDHEsiXuUfQmZWzg6xMGSp86SU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1jamDor127KQXxUbxl3NV49w6cSCIpcrdOb5JXfo5NK8AE6/e6NV98KXenZrcNl1
	 qhPfNJVaqqKMDzS8b9hZw7noe/CzI0DybVsXd3cXBegglnHi/RU1ZobIDQI1+roPJx
	 QAqLCAO/fPVgcgbtxXWr6rk2TSp6pManiIrAS75a1gE9Jsd22TlTeAj96R2yw0Q0fW
	 +6Ej4Tz6UQNoBNdSGXRk5n7LtIr4HT7R34ub5FtxCCy+UztPJ+rfmGjwod8XE05ZCE
	 aoLE6KW68+Vco00xEHvtcw5zpsYy6asMarVcctZOkDscEyEd9rzqFHEuYqElZdm7lC
	 iLPGmH4UDX6Xw==
Message-ID: <sashiko-outbox-204850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akhilesh Patil" <akhilesh.patil@linux.dev>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
References: <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:48:03 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mailmap: new entry for Akhilesh Patil is not dictionary sorted
--

commit 764f73a610f916591aa8eda10671882c375e0355
Author: Akhilesh Patil <akhilesh.patil@linux.dev>

MAINTAINERS: Update Akhilesh Patil Email address

This commit updates Akhilesh Patil's email address to akhilesh.patil@linux.=
dev
in .mailmap, MAINTAINERS, device tree bindings, and the adp810 driver.

> diff --git a/.mailmap b/.mailmap
> index 0d05be949eff9..6b93a15c9419d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1024,3 +1024,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.c=
om>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
>  Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
>  Zijun Hu <zijun_hu@htc.com>
> +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>

[Severity: Low]
Should this .mailmap entry be placed in dictionary order between Akhil P
Oommen and Alan Cox instead of at the end of the file?  The header comment
notes that .mailmap is kept dictionary sorted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109104443.GA53=
1570@u5ce4748bae3b54.ant.amazon.com?part=3D1
