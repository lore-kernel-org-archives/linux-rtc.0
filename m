Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789203;
	b=rKIK56hP7y9vD3T/ASOSbm5gK0Eh8HcqH/AFuejy8WreVDgySyr2IG6OXGqfoZE68yEj
	 jMiMH2ZUYinDShNb+EYT3XYtVr+U9gkViqhpDKxPJrWfluZPt2wx0xoQ0WE92VWcarDCl
	 aYdWdKrGvtT8owy5tgPRnpdN8Y1ca+1NnOXDJqUWvR1bp3vFcEAbTnTQNm4kgsaDoDF6P
	 i2gbzpDsJaDx8OByRV8Z96QW3+I2co5kepEFTS4MIfPEfcl/RVgC5XhKyWIDLcaphAp3i
	 lNClbCCjP2EwK87XXtk5O7zDd43PZRPCd9kakm+Tp3SDFe8AU1EVc+cVI0e5yf1aB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yvls3cQGJ0rNiloD4L3E28UaT4vRvwBa3UcfZljAsqM=;
	b=oyNcRBuA4n5MNKl76+SinENz2/E2IuPKvS1t3g9saK2PWxFVfOn4Y7JFSo6ux95kdBq5
	 0hkevdJd6gN3uTjRKmRZQwDH2AkyxNIEZZ9MLknw7gwf8WV34NnMUWjE2EWo5twMpuK6Q
	 kbIya5l8FyfrBafxXVWInqPE9P8V3XW+/o5zG5GCvd0mxcXHXBzVPJA5R66fUazhppqlU
	 B6Qf1OubREiQy0j5hcvSYRgY25p09tkRv81cRniGyqIE8Dhabd4c8mV0hwCST+kF/awWG
	 BhuKi7fhyU5SAP6Kt6L1DzW55OzZ9fgVL6+AdKMCpntfU3ifiqssJvHP1RzV0PE+X4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE9euRZO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD3606A32C
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE9euRZO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD89F1F000C4;
	Mon, 16 Nov 2026 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789203;
	bh=yvls3cQGJ0rNiloD4L3E28UaT4vRvwBa3UcfZljAsqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aE9euRZO2VRzDgNCamHbIAdLsC3aqr8wmGTM3BsbKK/mf7Gu3PCovIUO9xbhnKLrm
	 atmnyNMWVi2WeA0corbm4XCRbL7gB7bvtZhuNU6yq6OBRSL2IaPmh3MqvN5iF9nWTn
	 ltjE9FlnDzXE0Rj758g7sshVlnhRFXXLozWk7UgU+V3RiTzT45SABGfmSqWClU+lkJ
	 WWFjyi+eg528vncJgniQ8Fk9e+Cz94KFtJUgzI7Nqp+MMRiwHB2gujMByLkbevhoHz
	 DP0MInAXiB3G3GZ0xMSYxiuD7/Ksv8ag7CIwhCku9jZvqGU70n/E9BRl7dsjalg4uf
	 EFREwPMYryI4w==
Message-ID: <sashiko-outbox-215950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] alarmtimer: Keep an RTC per suspend state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-5-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-5-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:33:22 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> alarmtimer takes the first RTC that has an alarm and a wakeup capable
> parent and programs it whatever the suspend state. Which RTC wakes the
> system can depend on the state: on ODROID-HC4, meson-vrtc is a register
> the firmware reads when the application processors suspend, with no
> interrupt in Linux, so it wakes the board from deep sleep only, while the
> pcf8563 wakes it from s2idle.
>=20
> Keep an RTC per suspend state instead. An RTC takes the states from which
> its alarm wakes the system, minus those an earlier RTC took, and is
> refused when none is left. For now every RTC is taken to wake the system
> from all states, so the first RTC takes all of them, as before.
>=20
> Link the platform device to each RTC taken, so it suspends before all of
> them. alarmtimer_suspend() programs the RTC of the target state; once an
> RTC can be limited to some states, it rejects the suspend when an alarm
> is pending and no RTC wakes the system from that state.
> alarmtimer_resume() cancels the timer on the RTC it was started on, so
> alarmtimer_suspend() no longer cancels it before starting it.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D5

