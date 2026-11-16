Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789254;
	b=oHaFbYOEdTX0gTNqmufGCEGcYPSJIM73Bfo67IJaE6TdYWq0glMIC+8WYgbjo6oW+IFj
	 Fw5lK2z6kn67LLJRsFGUz8ExS61cx5Lm+p2diL4Q65032TVRFpfSV5LZ3D3ICVtC456yS
	 aXJ6tA3b9thEECnnnAOtwCXFXTHqPoUWs9EHiWcXBb/Nx4DoU6alTWcF+ZUqMT/QeygQo
	 oRsoTuGc98h6mLWMPuP+HlSHfIYGjGViaEYBs2jx1PNqfUZTuw7FEFvyfUa0TLUuEC2w9
	 qxiTdvrafKC4PxKsgVOq98Yc0qFdNVBxufYEBvldtq2Q6JvGoo+B5IoUoR7qniCjwqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789254;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rtXER+VvTgs/puXuf7Ep5BfUZWM8LiVfH+5X7vOthnE=;
	b=1Y3KUaLsSCkahf8QV9VBb9u82nWWyGubqKfMTbwCeEINWTg5ZD9T5XjfVFkj4vpbyBA2
	 gUB4K6DSv9dhL94X8H5I0zvUDpX+ZKXqMfF0EsSliJaADcxQcG2FK1PyrfdX8usV8y5LR
	 j+N8JJM7ZEB14wVVpc2Q5KId0sW9lFjHbeycqWi5fdonvO2+qlgmkJ6KOpgOCf08y13R3
	 Wrzqz96yxvkl60gpMVop8SpiLizLJ4Xka3oHxBfeD+2ffCeMMvJneE7ShrsV+17uHEHO5
	 VpE65dyM2GVVey+Ii5/aKWLr+Qrxe+gzSwsVSE8Y1BPok5CYf+ymVzGrEVmWEWwKDdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKhA1HGF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C15606A323
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKhA1HGF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439D1F000C4;
	Mon, 16 Nov 2026 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789253;
	bh=rtXER+VvTgs/puXuf7Ep5BfUZWM8LiVfH+5X7vOthnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKhA1HGFUBjboD66MpbX6/xL1n8ZXwPpF2emy/89l5548vDXgE66MH+wH3qtxf0I0
	 /eW4rlRAJUrDgFpr3ryVMOQD2GaTwEUHmkstpJHaA6CsSZPj23BZ+jxji37FJsznQ2
	 W9R159R5duMewRNRc5z11Yc8/WPcL7XS6jhzTmwAH2TBdbW1Dn4tLHNTgHPqN/UdeL
	 QjDAym9wWaPdqCK8PnrLAkcpANlbl0gixoYb0VcZbwxAG48QfbZNeiza+YhcTX8TD6
	 9UapA8bTp1T/og1rvYtU8wPb6oYkOmHFDq6JD9HVVXa5Ffb2s9LKz/y80PMl/XJ301
	 zNJtSxG+RedjA==
Message-ID: <sashiko-outbox-215955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] alarmtimer: Replace the freezer delta with per
 type expiry times
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-3-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-3-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:34:13 +0000
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
> When the freezer interrupts an alarm clock_nanosleep(),
> alarmtimer_freezerset() records the remaining time, the expiry and the
> alarm type and keeps the call with the least remaining time.
> alarmtimer_suspend() starts its scan with that.
>=20
> The remaining time is computed when the task is frozen, so it is stale
> when the system suspends, and a clock_settime() in between is not taken
> into account for REALTIME. A remaining time of exactly 0 counts as no
> timer.
>=20
> Record the earliest expiry per alarm type instead, KTIME_MAX for none, and
> compare it with the queue head of its base in alarmtimer_suspend(), so the
> remaining time is computed when it is used. The scan also takes KTIME_MAX
> instead of 0 as no timer.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D3

