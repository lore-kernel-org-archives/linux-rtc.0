Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479173;
	b=gWlByv7276jE4fbb3wEbBJlwoiZPpuUO9LOkyUi7zml4ku4Gf1vY+H//aya6ZGV8uqiR
	 xQg5Vo8n+T0uXNrlON3p9ElzAq0iaKIzn5RT8NGSk2wNDALyUzgw3vTnnRAJA1Xd5o7pD
	 Hojs3sNal9SMfP6h3AFypQW1ITky7Q3l/BCPp4xLQjp9s1nh9liTrftxfWIICmv66Vftu
	 qi2f+gHld0+e3yVwWEEZwBy1Rekv+Inmn06d2SxN2o4xccJUN/uWSj/g2Pemz17iSd1Rl
	 1J9jjG8kM407ypd/A/5p5pajGXYNKBF7jsKwEM2lklTBJVCRhKIx5f3bEQCuAc0sX9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=jrsn/Px9lGsC8Eed1cY/Fr6R1aGVP1fP5cAXfFK6IWA=;
	b=ZRFHhP2lu1t4qWhlqKPjnTjgESY9H8tU+0Im8U1JamqcFm/4lBlbnvX9PJBfFrvtj8CF
	 t8wNL797oAgElgMDV7oAw5ocwxPkjFF3R8HyHf9WulYHHXgIBaOausDmSGp2QBvLuSuKF
	 vYx7Tlypr9/J1JKJDAMVCWNfjN6AN1Rq0whK6QDS/iETnlwppY//ObzXMbFbpWg5HC8dm
	 ziyV/GaV4WHz9rZNJUnJs8Z6JOiBkJklg48QKTRx97oXoh15uClDPgghA0dEFz9iFd8Tg
	 mXHrO4SFgO62vrhsTWkGhgfmhEb3NYigFU85mNc4okf2+AMR/luEAnsxPxjnuPR15Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLepS0hr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53391606A321;
	Thu, 12 Nov 2026 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLepS0hr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C131F00A05;
	Thu, 12 Nov 2026 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479172;
	bh=jrsn/Px9lGsC8Eed1cY/Fr6R1aGVP1fP5cAXfFK6IWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CLepS0hrcr5HCmxavHbh93S+IYBwrHV7A2D0Mu/zPVe/88mTxLHfgxtqyZG9Vp8p6
	 H3koPlgsTVMp6EZxukeKNd0imL0av/Azweye5C75tr6vvpXddeUqDRHya9QMdw8L2L
	 ebnPgMesY2xYHFr2R3VK/xx/NR7uf/Pth3H8asUozDIlVs9IPfFCgRkO/zjrYfVDYl
	 vejHJHA02OiWFVw9f6W+WC/OtMF0QmDDbcbbSZZa0FohfE06x2vDnSHYoDxwdKAMq2
	 BZ3QlBB8aUO8uyOXz/UnJjK/H9rGF69T7ID0WBqF+LbyUvIFPP1YElZJ0+6t6npl4s
	 3PRmJmudQ0boA==
From: Thomas Gleixner <tglx@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: John Stultz <jstultz@google.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar
 <mlichvar@redhat.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 2/3] alarmtimer: Choose the wakeup RTC by sleep
 state and priority
In-Reply-To: <20261111-re-tglx-alarmtimer-rfc2@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
 <87qzgsth2g.ffs@fw13> <20261111-re-tglx-alarmtimer-rfc2@iav.lv>
Date: Thu, 12 Nov 2026 11:26:09 +0100
Message-ID: <878q2ytkfy.ffs@fw13>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 11 2026 at 01:50, Igor Velkov wrote:
> On Wed, Nov 11 2026 at 00:14, Thomas Gleixner wrote:
>> So this gets _ONE_ suspend() and _ONE_ resume() call and nothing more
>> and everything falls in place and is comprehensible, no?
>
> Thanks, that is much simpler. v2 will first replace the freezer_delta
> handling as you sketched, then add the per-state wakeup_ctl with one
> pseudo device and no priority, and reject suspend into a state without
> an RTC while an alarm is armed. It will be based on tip timers/core and
> follow the tip style. I'll also check whether user space looks up the
> alarmtimer device.

You want to structure this nicely into $N patches:

    1) Provide and use alarmtimer_has_rtcdev()

       Just check !!READ_ONCE(rtcdev)

       Convert the one lonely user outside of the core code and the core
       code itself. Replace the few users which actually need the
       pointer and do the read directly there.

    2) Move the static variables into struct wakeup_ctl

    3) Replace the freezer delta handling

    4) Switch to the pseudo platform device

    5) Convert the rtcdev storage to an array and implement a stub
       parser which returns STATES_ALL.

    6) Add the actual device tree parser logic, which enables the whole
       thing.

That makes it easy to review and bisect.

For #4 you might think about doing the following:

	for (int state = 0; i < ARRAY_SIZE(state_names); state++) {
        	if (!state_names[state])
                	continue;
         	sysfs_create_link(&wakeup_ctl->pdev->dev.kobj,
                                  &dev->kobj, state_names[state];
        }

which creates symlinks in

/sys/devices/platform/alarmtimer.0.auto/

        freeze -> ../../pci0000:00/0000:00:1f.0/PNP0B00:00/rtc/rtc0
        mem -> ../../pci0000:00/0000:00:1f.0/PNP0B00:00/rtc/rtc0
        standby -> ../../pci0000:00/0000:00:1f.0/PNP0B00:00/rtc/rtc0

and in #5 this becomes:

	for_each_set_bit(state, &states, PM_SUSPEND_MAX) {
		wakeup_ctl.rtcs[state] = dev;
         	sysfs_create_link(&wakeup_ctl->pdev->dev.kobj,
                                  &dev->kobj, state_names[state];
        }

so the symlinks point to the device which is assigned to a state. That
gives at least some insight into the actual assignments on systmes which
need more than one RTC to wake up.

Thanks,

        tglx



