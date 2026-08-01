Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411601F12FB;
	Sat,  1 Aug 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610530; cv=none; b=iU/D9LTEwZ1hRdLZ4mIxq+M7eSiDTlH2NNTKgglRSnC1Dp9IoABUcpuV2SXIQQQYGyD7GsfaJHjTrdhBGfgqOCpOaU/e0Qu0AyaxCnrPqRibXdIwHEbr2VdbsDkfFZV2iJiq0uZ078wgPTgnXuKj2G1StJlXbq04w+G93MPjnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610530; c=relaxed/simple;
	bh=ur1Ya7lmihI/wgn0Dl5F1ryheIv8I5pwttb0PydXDDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e0G2pCh9k1DSVdKmD66sJVn9cyd6fa1QnKaabUaZvyb6TpReqxBDYhyrb7qiGFHzkeLbWULo+qLphD0YcMgXUVaxbGfXQvRhYkF5OJgHNUxypJXOsDROMuXvmC6vWdhslwM0vCagECAxs422L86kd6U7xhww58YVl2aqLwsX+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOVYKvFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOVYKvFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C01F00AC4;
	Sat,  1 Aug 2026 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610529;
	bh=t+ti7q+2YeYBKyxwLztK7o8T4E17Pua4BwEj85YdDHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOVYKvFczm7tDGlQo/lcAgbmlVOew3E6d0s/dx5CQIzQWhSQuUCVxDCRH7oJMgPh5
	 alP8kDE+QnQ9nTrnXwi87SbHTE2GBcdS1M0YBD8sDg9uwd/iNB7aqmkhTDq14ZhrLq
	 QZ/13ynwuPUVCsRey8rDTVHzIDQSwu/bg+LUCHEUgYkjDJRUBrnGJ/F9Zlepaev7wN
	 OI15Ltv0tu+44fC1XSZcFBQFawvzIhjV8eB4d/P8P/eLlZBPTSQkLmQQ21B3c0ZK2v
	 rfXsvZMyIYuVRfmMcyW3416UYX3NbBVson6592fdaZ01c52Afd8eTP1qpK6tL/q5Z8
	 xKOWJ2ekTRr8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260801-rtc_s35390a_int1-v2-3-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-3-f10c99ad1d6c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:55:28 +0000
Message-Id: <20260801185528.998C01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized stack memory usage in `s35390a_rtc_alarm_irq_enable`=
 corrupts the RTC hardware state and cached alarm time.
--

--- Patch [3]: [PATCH v2 3/5] rtc: s35390a: Fix alarm not disabling ---
commit 14759f80e44e19699052dca75586c20731eb4d5d
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Fix alarm not disabling

This commit implements the alarm_irq_enable callback to disable the alarm if
requested. It also restores the last used alarm time when the alarm is
re-enabled.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 4cfe7034c5165..fbf5471eb3d0b 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c

[ ... ]

> @@ -379,6 +383,19 @@ static int s35390a_rtc_read_alarm(struct device *dev=
, struct rtc_wkalrm *alm)
>  	return 0;
>  }
> =20
> +static int s35390a_rtc_alarm_irq_enable(struct device *dev, unsigned int=
 enabled)
> +{
> +	struct s35390a *s35390a =3D dev_get_drvdata(dev);
> +	struct rtc_wkalrm alm;
> +
> +	alm.enabled =3D enabled;
> +
> +	if (enabled)
> +		alm.time =3D s35390a->tm_alarm;
> +
> +	return s35390a_rtc_set_alarm(dev, &alm);
> +}

[Severity: High]
When s35390a_rtc_alarm_irq_enable() is called with enabled =3D=3D 0, the al=
m.time
field remains uninitialized on the stack.

Since alm is passed to s35390a_rtc_set_alarm(), won't the uninitialized
alm.time be read by the dev_dbg() call at the start of that function?

Additionally, does this uninitialized memory overwrite the cached alarm tim=
e?
Looking at the earlier changes to s35390a_rtc_set_alarm():

s35390a_rtc_set_alarm()
    ...
    if (!err)
        s35390a->tm_alarm =3D alm->time;

It appears the uninitialized stack memory can be assigned to s35390a->tm_al=
arm,
which would permanently corrupt the cache. When the alarm is subsequently
re-enabled, this corrupted time would then be restored and written to the
hardware.

Could this be resolved by zero-initializing the alm structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801-rtc_s35390=
a_int1-v2-0-f10c99ad1d6c@posteo.de?part=3D3
