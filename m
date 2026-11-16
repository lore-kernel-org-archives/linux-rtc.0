Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789226;
	b=D3NyTywCAnVW56yKG1j5t2FNAAWHoLYxYrvnIAXiJX3/uB97bh/EqRb0cSGbtJIOvPu4
	 4aLml9BDkF7rqIApxW1MKaNWcTbdBGPW5P4lO1WIZWR+9orxkmCsDme6VN4YjptHxq0DS
	 z1HBJflKkOWfq3TfRgWXYA40sPNNMBgVPTM2/sTttT5SOzRqy3g87E627fu56iKaQmte5
	 EvKYcpFpbGCNszXboAIRuDrLAj84nrnsn2UiH7dYJ4GYPsHa2OGh1OQtMja1cwkcy9oFA
	 qGT3O+I4mebS/i5RkQvSt/JfWph6DSFAYjW72aSqke4+Xy9sxz3vl4x53rP1+xNUbUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=grhguZaGXnCNzha6wKBfk2JyST6Im+rdfY0i39of9Ms=;
	b=do+NaYuEoUn8f6t+6kG9VU4KmQ0Pzp7QS2ahgdHUP/bTPtnBSoN/bCxaLhecsFJ96Eh6
	 KFGk6/gspTKv6QbmuOInYc4cMl1OuzATbgLq7paWRkaWyMVz/WEwJqOlAaJeE3iQicvBF
	 vaVe/JRv+XWpNjgohmk0T6JkAaQo+Um7HwYa/yiXL+6Z4cY4zaS4TwNQX8iJyo82OMikt
	 b3wMokm8ofRSiHowd0Fn4wVGrsorZq+rY7XBNcLzvC4gmzY79zhWlgQMmKW0yVlM7AE/N
	 l3mejV0CXymK9XwnUwORR4eRLo1l7F4QMNh5RLN9uc5hiOH0Ye4dssd49iCayRFq4aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=botdWQDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE07606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=botdWQDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD53D1F000C4;
	Mon, 16 Nov 2026 00:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789225;
	bh=grhguZaGXnCNzha6wKBfk2JyST6Im+rdfY0i39of9Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=botdWQDqct04JDKMYkDgM9fKH6SfmdulAZK1ETPr7pzS+gOMPr7XZFEe/UvppXoZK
	 Xq/Kjqe8ehPiEEU/hcKsGmdNAVboWd0LYuR+oFpMXYXc7rxEbR3N+2+vmQlx5dIGmt
	 kKGVgHBCqVSYt8vjPc9GehZij9TBQdFfaHZc/UUp8jGB9rAzoQDQWreTumYcLgLHbE
	 KTrqW4wPPfEnsBBJXBofEv03Xp+lrEI/XpbZTN+5hn5h44umhceTnD5l4q4cgFLv23
	 HlyJd0HGKRBaeiu7fPgj12G0hW4Za43q0i6X5aGeC2MdIM9xx0xmbot9oFi3w2vPNs
	 nVF58BgYbFHTA==
Message-ID: <sashiko-outbox-215952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] alarmtimer: Register the platform device without
 a parent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-4-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-4-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:33:45 +0000
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
> alarmtimer registers its platform device as a child of the wakeup RTC, so
> the driver core suspends it before the RTC and alarmtimer_suspend() can
> program the RTC. A device with one parent cannot be ordered against a
> second RTC.
>=20
> Register the device without a parent once the RTC is taken and add a
> device link to the RTC, which keeps the device after the RTC in dpm_list
> also when the RTC is moved there later, so it still suspends first.
>=20
> Add links named after the suspend states, which point to the RTC that
> wakes the system from that state. The names are those of
> /sys/power/mem_sleep: in /sys/power/state "mem" stands for whichever
> state mem_sleep selects, which can be s2idle.
>=20
> The device moves from under the RTC to /sys/devices/platform, its name
> stays alarmtimer.N.auto.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D4

