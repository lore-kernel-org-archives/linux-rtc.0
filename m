Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794788999;
	b=1sOA0cLXaZ8mBQrkPB0jZ+y0IKZjgdeKiUR3epYYkeeD+CcsUBiJVzjwGhsFpJ7xq/qb
	 Jf4x7cwKpkD3o1W2Uhn+qajcVMcd6JMlzlguR7F5q2LLMZj6ekvq7JucHLHXKj1RahaGn
	 GvNGv/AAdi50EsqsE3OokylYl+iJr+YaRXQEKTV8jVpTI0QWaks54WqPac/9Zgp+P4rG7
	 ich+i+v/gsdHuE4hmREq/wBmLtmwKDqnXGi5W20n1O5mAi3M/49ZAqwgm+Z1NI68pGpma
	 TiE+BhWBCoKdV7HcPMCnCum35JnWO8RMxMVzY2o4VO8yi0vHj444xriC9WeEeBLnlFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TvMGuDpAHSl2pdxQO0DUvOzw1cNM4UwbJwLvNIMBav8=;
	b=tk5xepTJWkiZReD4OhcXRT3b4fx1dmOXRBZkwa9B8Y9NUAXJ5Y2xyj848yH2VcBl9eYJ
	 z6Tg2SICAUCZRwBqN58A7Gdxns6doBBPOMJ0IoCjHH6Y91I+AXT60jp5IJHbdOF5fZZcq
	 2Wg0L34N/To0RrNDTHxrMoHmEfogb4P/a+oVrd3KeHFwCb9yTT7x0V5KF1mD6+c+33crv
	 V0kePFUCWRHt4ujnrlm4ss09TGRhXHGNckXGSkL+Hq/N/QC6UAnlMAHfIq1WxRoAMcQiz
	 BXnSrrsTST2jc5JzD0w2OIMowPbkPJUD/44AkNExTszJ7UOZR6xg1r4sR1IYCw6nlug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az2L78G5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F43606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 16 Nov 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az2L78G5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0755B1F000C4;
	Mon, 16 Nov 2026 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788999;
	bh=TvMGuDpAHSl2pdxQO0DUvOzw1cNM4UwbJwLvNIMBav8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Az2L78G5qHBoEoMElSt3kLlcPRByap1kOkTNqZ8dIljxbuBVuGWD/xnmn0px/s9Em
	 F21kLsXPm9u3VKkhmaGeSALp+FldIvWMG4yNdsp8+W13Bilmg8NmrdlH3PXjMsAjsn
	 W1YiZjNkwQ7jYwzoj+LieoT7JlHhNuwkVPXiUUB+EqSg/OGusgIeN+EJWk67QERs2J
	 RuXNpj9NNf9BdoAo8ZTcVvrehclFrprwNJiLbZSRrjp0vmwFh7LAyIEGlaRaYrffA1
	 DZ/wW5kxtLOT77UuGxk6OXqa46G1oIqhLUBDufZtxFrafRaqVR1mUok9RkPkQVyvlh
	 /KIHOsny4Qszw==
Message-ID: <sashiko-outbox-215947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] alarmtimer: Replace alarmtimer_get_rtcdev() with
 alarmtimer_has_rtcdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-b4-alarmtimer-rtc-priority-v2-1-b2c69721e489@iav.lv>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-1-b2c69721e489@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:29:58 +0000
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
> alarmtimer_get_rtcdev() returns the wakeup RTC without taking a reference.
> Apart from alarmtimer_suspend() and alarmtimer_resume(), its callers only
> test the result for NULL: the alarm clock functions to tell whether alarm
> clocks are supported, and charger-manager to decide whether to set up its
> alarm.
>=20
> A later patch lets a different RTC wake the system from each suspend
> state, so there is no single RTC to return.
>=20
> Provide alarmtimer_has_rtcdev() for these tests and read rtcdev directly
> in alarmtimer_suspend() and alarmtimer_resume().
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-b4-alarmti=
mer-rtc-priority-v2-0-b2c69721e489@iav.lv?part=3D1

