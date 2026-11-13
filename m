Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609553;
	b=uzrnb+arlZKUAv1ugfy6Ycd7H0JYpmzyQNTkQiOENsDgtWpwFlgtMr+2Jdi1Fnn39gec
	 ia62s+ANaT7lVbMPu82btgj4H50kU7UyTl2GD7fi+/Hx6y+hsVnD0ry312tEt8SsaqvB+
	 4htVtq6YPU/0sPs/yJxqm0C5YTXesQh0R6ReWDrq0l3No+G0XtYCrnUtuqtTPLpRzo+H2
	 14Ny30w+YSWec5GpfQqPzkGOwDsdq5Eq7iuBQjX/+Ugjwk2Ax0k/4GaXBRYpaLELu0fLw
	 w4lwzn3cfdO4TqGqUdZtWmy+VXEtvRMx9BqunusPXXXjttzyZmcJ3wZCh5+4azBLDUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y1MYkoEgy+aG5djEoERDahuR9lOVXQZQgbkeQB+Agvg=;
	b=3D+vjEjC7oMrNbRfECq0lKZ1G97wnWRgCJ7DkyS3QtQWIt4/JSNAc75rOyTozuYclHRO
	 57xv1dg1JX18dqZrmFwAIwO2e7OHSYacJ2X+YTpiN0glI0L70bPMa0sVj0d570rck5bGe
	 lL9h2vxqIhe/BRHggE9WPTPob3VuKCEMjKEeCoGcDQsgBbsbzyHsLJn37kY4cOkD02wNz
	 0mtInOQFh3C+EO6E2SaN7M1ng9T/Xec6VpMVMXOnqREeEH9QUSokQgKSZwhc5C1+fGhPK
	 V2XqxbgzZG4XBR1lKSItuTpU5NtJ6HmVsBaYmh6X///r3FvPQ3ld8d8WRxYJscQIh7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyNsc5wY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD40606A545
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyNsc5wY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665051F000C4;
	Fri, 13 Nov 2026 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609553;
	bh=Y1MYkoEgy+aG5djEoERDahuR9lOVXQZQgbkeQB+Agvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyNsc5wYGwXAMvSuVRBuWj170Ua9hGbmZLlRqYE8RPb729xw/3PmNL9IGH7exQ6Uv
	 0HFtZvFmfSmf9SsQ6CQVWJ5QjAZ44NJy138wrAprmlIOYZqpX44IJqqazzCx6GyiIt
	 PVAXFBtC8Yh1Rc7lj9Gvpz1ya0TEjD63xkfLADXibthMdkfZwdNZUdY7US61N+1l9X
	 Hw8i1wksX2Bo++8OZSdbq7twnIJQv6J3oWOia0a5XTkTG+JJFigco3yQyqYTUQcXCc
	 KiYTTKjjlJNYv6MQx1IqiFe8ucxBmdoTXj2vPKDCkY+8+yFUsjYYw88o86VaVbLA+t
	 YoOelLGVhMiQA==
Message-ID: <sashiko-outbox-213828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/19] dt-bindings: clock: sunxi-ng: document the
 Allwinner V861 CCUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-5-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-5-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:39:12 +0000
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
> The V861 has a main CCU and a PRCM CCU. Add the binding and the clock
> and reset indices for both.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D5

