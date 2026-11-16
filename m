Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789238;
	b=PZ0c+VKG7SqbiOkqYJTV0MwHwaWj2DQObX3TNjPyvUwLrDYYlxOjXCRaWkzB/9f6vm9/
	 +w4ApFFBOBatLAtdI/eSDDq+iwVmhHCz5cXsnjfR7TjK48GBMeNKLC2PR40HpbFrkDfy9
	 xF74s1NbLNDaUi8QgHbX4QTFMHQhPC0othK+zsy9QTwFxlQabMMAYpIwhRkFJyihTJg/u
	 ojswCb2SSPfbieOfrV4mK0nVSGqC8Ep72UlcMIsRFsaLaGUiu7saTv7/jcrDF+Elw4B/V
	 uUPLFiO4Ao1B+JaISpNkrhRexiHVXMoIFyfRXTr0uZZg4g8pP1k8sXrXLGBo5iK0B2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789238;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8OInlRLrCfRyBrzN/BlKrpAxnQDqI18k19LE5+hMFmc=;
	b=tAPsolmiQKrnhbSm96J/qGNrBk+eS7AAdUbeoynB33BM46XhKOop+avRZsQGbuAF0Ni8
	 TYLSlw3GGlgDwsxnPFDOSwRZiTllZg896fOZJgFLutbYKjfNL2cLlN0KVLzOte3dneh4P
	 zV/kQ0XGbCqxRtqm90ipXHDO84podVtv4ZYWWrwchBnymzLT8xcFjR8joHO3S2/fDEVcx
	 uG1uaWd/SZd7s4xwUpAPatk5RMeQfjHwZlmA5zrkAEmbcOXWQXASvLHXRvmib13aW5w6m
	 EoNbGSqynZR81xzbZOM3VVBaJy/wdQsvxX0Sc9AWSew9ha29k02W2oOCIXUDhDTg5EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLwGccIx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFC606A323
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLwGccIx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E821F000C7;
	Mon, 16 Nov 2026 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794789237;
	bh=8OInlRLrCfRyBrzN/BlKrpAxnQDqI18k19LE5+hMFmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLwGccIx+tK3ZqvFssB5wAHsVBHeETiofSURptUuacrSnxOEI8oVXLAIq34t6DZsi
	 fI9cTb9+Kqi6eFxULiNbxxaENgcc4ABX5VsITs5uPcxeDX6onblnoKmYPs1RxyXVXm
	 lSIcmfEOxhu//pxBD5nG+qquUFbSbkYo9+Z705aAwX41ben41EEsNGsaZ1n5de+39k
	 YkiBJutP1uH2eFo1AwzhpzvBfLWoDF5t0U9R4ihmSfeBWNHoGZnD49qfAyvS2vRTjN
	 ZUS1KWoZgTFSDN+dElpKTV5RBci3tr+nIvtIrH8zq+xHARBfSwlzAnLuO3nsbxRPqs
	 AGtmYOOospzkg==
Message-ID: <sashiko-outbox-215954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] alarmtimer: Read the wakeup states of an RTC
 from linux,wakeup-states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-7-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-7-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:33:56 +0000
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
> Every RTC is taken to wake the system from all suspend states, so the
> first RTC with an alarm and a wakeup capable parent takes all of them.
>=20
> Take the suspend states listed in the linux,wakeup-states property of the
> RTC's parent instead, all of them without the property. An RTC with
> "none" is not used.
>=20
> On ODROID-HC4 this lets the pcf8563 wake the board from s2idle and
> meson-vrtc from deep sleep.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D7

