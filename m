Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9087399368;
	Sun, 19 Jul 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470719; cv=none; b=nz+0GTduRTlXJHch+eqR0eAX/9bn8SdDCbJG53RgZ+vQzb0v7QUJjSokBR3lwfwrqC2DwgGiaoUC2DO3Q23iCGxUrrZBpmCBb/FfLF4fKWZf/fkbjhdlrUF0YZHqbr2S3kLMElM0usWbDy2Q7h8YBI4+134MH6sIqAkn73V9uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470719; c=relaxed/simple;
	bh=jqrjBAtkaO9kl0oMGRU8UOktpIPfIYTB5jJnuVdkIa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Eaj20Noe+HSV63H+OJml5QIun8iiLn7b1R5ECtlaFKzp4R6dWfOUvWO7ON6Eh7MKNciRIf6I+is5Kz2gAton2V6H+xc5ibWHMD/GQvmxHm/MjgJzhlI97mxH4wwI/u57v7bU6JrxxOnlEKVfe7IRhe0rYh1H/Tcbx2n8l2YYU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzAohL84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzAohL84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D2B1F00A3A;
	Sun, 19 Jul 2026 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784470709;
	bh=jqrjBAtkaO9kl0oMGRU8UOktpIPfIYTB5jJnuVdkIa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzAohL84irG0gUaUPLnbEgEXJGi06yDtNtiu2USLXv8ueRSrmcAKc4BGr3rvubJYE
	 n/U0iBCDNROeEI7EQLYRFUnIMU6uCcrzSnOIUjCBe7ClbxupkEc2kBuQj7EPmhCI4u
	 dNeXo4SJzG0XbL/arD9BrMIebgqwwb/0ZCJl/TtXW2c+000+oee0AhzyjC+RfaBKrj
	 WGkP3VRFHh6ErJF0SLkflUj1wtyiW7Rl0BDPGVbd6PlgjIjPw0YCk31ZkEq0pkNAEH
	 Xyb/jYHS3FBEjl6S3VSjkEiiErgs9/SwcoopEOLpXsCI5gE8mxPokjyP/Q5b8SdNlh
	 CD9RdD0YrolKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260719141008.3562347-2-egbostina@gmail.com>
References: <20260719141008.3562347-1-egbostina@gmail.com>
 <20260719141008.3562347-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 14:18:28 +0000
Message-Id: <20260719141828.D1D2B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Convert the Texas Instruments Palmas RTC controller bindings
> to DT schema.
>=20
> As part of the conversion, declare 'wakeup-source: true'.
> This documents the Palmas PMIC's capability to wake the system.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719141008.3562=
347-1-egbostina@gmail.com?part=3D1

