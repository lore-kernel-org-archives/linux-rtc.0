Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE63542CF;
	Mon,  7 Sep 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813696; cv=none; b=f1RqfYJcBFPUDpm0eqaYkSOVUNTSqgrTaRF6NMkrHrTNz1bOkq7MgpqeRqp0QBVumfgMqoZZPf8h8ubQqpo03nkMMgyV5juposc2GBJm0RWHvvnPWJIEoK/mlgWZfajRhhL3ZzPvv5kHM8SWxcg49zrbqLiLPuQZJil+5nsuLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813696; c=relaxed/simple;
	bh=IB5XdxBKT/0JIdEhOeggVauClC7AWr/LkF/S48FwJrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0XZrH4aWEAbl+gnT9xm3qakoKEar99NQOrw9nnd+YBKXL37pWd6K52/xShAIrPjkPwr9ASkjkRyErPvAtsIyjDf5p4GUkILgUTZxxBY373vn9yJd2+IRUBSoC2r1I9ReNL9hw0YXNXaZ5Awh4dpgQQynqdJInQpYv68FTRLugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYpZYy3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYpZYy3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D351F00A3A;
	Mon,  7 Sep 2026 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813694;
	bh=IB5XdxBKT/0JIdEhOeggVauClC7AWr/LkF/S48FwJrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VYpZYy3dzLcHVJ5IXf7nrmQlEDdG3/CGi/ouWlqqsOpt7fTeaKFdOecYnNS/D9I2r
	 2mXS9rTln6CrB2q8iMbUOxNDbUul8QFsr0soE0M1ImUYTyS1w1X5SvAL1sLjQrIlHq
	 fxgpzrsx60vDnJyo9GMaOZLGRVjZj/+qb8q/2JfV07ITWxUYAz9QANld8a2H8/Lsyu
	 Q+Zo+UUKeO+r79uAiv/jtLqg5xjjaQKev6sFF+LpVs3JNWlF9JLv6iJAwZyuW1Y0wU
	 p72b2scZdSDazMyalC4DuhB8vvchmAVklmkSECfWa+81gFZsFs+d/f188T7xl3AboO
	 2pcFAK2NsnbYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260907203216.53192-2-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:41:33 +0000
Message-Id: <20260907204133.F1D351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D1

