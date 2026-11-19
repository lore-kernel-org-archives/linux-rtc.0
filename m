Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071879;
	b=LpTOupc2WyovyE2PLYoLPH1KEadJoASyBwm5CeCAEI5q4yN7BrRIbIQvfMSzjcyJwKrX
	 xU9YEBjkBlr2l8otnFr897oJn7LinLdsks3BF194XSxII8Gnl0HFbyCKByDkyzC5VUdLS
	 uIHsf5PuNMk/+wwA7O6OhgTQRLo410FQKB3YiXlXR/uGlKWBrJRIoEDy0IxOwDihjWALY
	 hyKjbbixOpsMOIcXtHzfkgn8jext8owgwUFq70Fn5VqySPy4TboAlLrKtwAKry5hfadve
	 /e6XHbQ2g+fX8lAKdmKozsvW1LKMeQAC2dGomFcmevzHi73EXPyS0TgHn+xzTek8z5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JmavEqAwX4Gj5Dp1Igd/DO6Mn5mesaDi/vADnq0AExg=;
	b=hHPVWVXasv6LUs05zAFRMMlcuAmswxCOYY+BGSCnLBU7tJzNKHCKv7WQkDCd3l0yEob9
	 zY1njyzVjdBxnsfHtaBs9gR9iA2zJ564P7qtYTyq+/vw27sE94EQKM+aL+f1uhsqx6ZLk
	 42eg5lj+FA7wYj6lYWkcOfDrzkRmCVWtxItbuwyZzTbyVZpGLQpgvBaVxtaDrcqJ0cJe9
	 BBaLPba2qSw4O9wLSfSfqQ5QZ+eUqt1HEePmjwVawCthjyR7K0ZToW9YFWveiXRnXESfa
	 IlMQWxq8y3hT1bGx2ZO6CA4vjLIvWbaGJnE6oqL0yWQDD8BzBhHkUhSs5AHdgYUKbPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogn7euhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16C606A320
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogn7euhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B521F000C4;
	Thu, 19 Nov 2026 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071878;
	bh=JmavEqAwX4Gj5Dp1Igd/DO6Mn5mesaDi/vADnq0AExg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogn7euhBwGAmtT15XDt1V6IUWDdmJBzAofnpPXbKcStRXLvQr2860qpFc/IWUoBfH
	 bPjwz4M1XJULLDQpVqzxZsGnZhCwU1q3Dpks7kFHgZQ0swoxuvS6rfy3pRsfn2OWTL
	 HKfoAyeb8MENTH6tZDlzdvBTO0lliYv4yZ41YKXYdwQMBfJ9rw1FteZBUCn98k9i6b
	 P8r7L85Fz+yJ5hErIRwCTC4LTgjVskXmHoQksA0zlv0nPYrxuXoFXFeXJKiuvp9Khb
	 FAIoz1/4El4UUAOSjVi2jWqpzCbs8gf2fmkCV6AO7eY/nIBvLGnzSyUKoLSHkQjGsJ
	 FUweCG8kA01/g==
Message-ID: <sashiko-outbox-222540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] rtc: Add Qualcomm GIO RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261118-gio-framework-rtc-driver-2026-10-12-v3-3-52d78a8f43ee@oss.qualcomm.com>
References: <20261118-gio-framework-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com>
 <20261118-gio-framework-rtc-driver-2026-10-12-v3-3-52d78a8f43ee@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 07:04:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> On the Glymur platform, the GIO (General I/O) interface communicates
> with the SoCCP battery-management firmware and provides a set of TAD
> (Time-Alarm-Device) registers for reading and writing RTC time. The
> platform also includes registers for configuring an alarm timer and
> initiating device boot-up into different power stages, such as:
> charging only or fully powered-on system, based on the applied power
> source (AC/DC). However, repurposing this alarm timer has very limited
> value for an RTC driver because it does not expose an interrupt when
> the timer expires.
>=20
> Add an auxiliary RTC driver that corresponds to the auxiliary device
> created by the GIO driver, "pmic_gio.rtc", which manages the RTC timer
> by accessing to the TAD real-time register block through the regmap
> interface exposed by the GIO device.
>=20
> Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # Zenbook A16
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-gio-framew=
ork-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com?part=3D3

