Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173569;
	b=HwC/OGFLD7BMWgFNwdBs3UUcvYXkAYUwPFTfMUDMsqOAMeG7QOQC6CNmgPKMiT4jJOz/
	 0K+FI2aNHit4RH72eTZU/YW7WTSjqf8mzk/igyMR4xCbykNk7RVN/hsiEVJrmptZU44Ur
	 bA/uMLFfzjeHA+j3Od0vGIxjHh5Jd51EPI87bFSM8dPKJp8usC+f2u6NfOIv5+B9ycRhA
	 FUpOjHoxHpygtizWBOr2gEDUNji/JyBlMhCf1u5E2GtY7dYxbc7rtDeDd4twWddizbTeo
	 P/sR3AqPPQ5uhqBUDGJ5G3PaGaUzbMW0IvFTH+e+E029IPOIW1l8BwF3BABOFJRC9pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qFpT2RReSmjwT6+TuQY1CWZnxC6wu7opCHsOJr8omLE=;
	b=oYfcf7uSOD0HCu0bEvXdRoAcDXf8/hKFpXYAIoo94qot+ffrjjigVsSin3dLlvZEa5Dv
	 MM4OV/EW3EA97HJOghwI4ouXkd1/mjj6zbVN2QZiJ+1VNWuC6wzUWLXlaLqqakfCmivi1
	 MDnBUfRv/zszkch/5j6r9PhN7OUYnPF4R7RTVhwjunA4yYmFBIxZHHY+T+5i9q5wJYKuh
	 79Agsrl3W6XojYv/XlauQNKzQuP3CFBvf+muMkJd374X5BjyTOdUZiFSv6j4ulWwSvwKe
	 UOpKUck6ibhkQgrPqZEhuBN10GfCQ6NBtDVG64VBgNMV6b6xMfU7ndrcjDI66U6DocQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GTLQI/Xa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF8606A320
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTLQI/Xa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2511F0089F;
	Sun,  8 Nov 2026 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173568;
	bh=qFpT2RReSmjwT6+TuQY1CWZnxC6wu7opCHsOJr8omLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GTLQI/XaYD3A5LTljwdSW+CQ/7AN95FMnFOH/0TQ0hGX1miLtrLAUAVSy/eM/62nx
	 xMj6cebTjKt65U+m6XSn2L3ff09roY0DCailHoVeKP+FAEvZhnelyUwS8LnDZD0EZk
	 +9B1fUWZZ71GQ5bxCpP3hNOK7PyMhh83veAWUO8Vx++t7H1NMLg9YgrLgRek6LgaKO
	 8N0BuPS91AnKLu9JdWf4nSQeqKR35+4NJ2rBnhL+Jh6DueBRd5OWeTNXfz7MRQJOwU
	 JNUb5vGOdLy7tKol3zgAAgcuNgJaknUtQ7YLzjhkJbMnJ2ga75T5ej0NwC267f8V2B
	 IKCUF+wJv4xZw==
Message-ID: <sashiko-outbox-204081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: jh7110: Add the RTC node
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261108212826.15890-5-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
 <20261108212826.15890-5-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:32:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108212826.1589=
0-1-oo.hehir@gmail.com?part=3D4

