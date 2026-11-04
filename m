Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793771683;
	b=kPW3Be97OVFXkOALhC1SaQylor/+iQ64PSGfVGHas9anWooGiZ0j2KVjRDw4CLoWZ8wN
	 w58aoDnADc74/Tlb1pJbdoGauzpsK5OHypo+pPOs4M8p2yxkkz/t0NrSgGoKb83XG5Aon
	 lZe6Jbha4YREoPY2cY3/jMY40ec1AYB9TLpkmhbywqneNU8MBR5+Xtx9IJWrgMTxWaFrx
	 smZZkRy2L7L278UTQHR+dKjYiJ0gR45aNP+ewAF7hUdbrqAnpyXKKCW4v/Uipiqoe4gu1
	 O5YMqgzXWBY6oAep3LP6UXSk8Vi8674bkNeyXuZ0q9EXy60ndtEgOnnh7Opwmi51BXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771683;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=l6QTWAiT2pnjRja/ALYbiKuIFt7Nll81q03ZWRJukTo=;
	b=QcUaziRq4zmWUBUFyae845JAlG0wiFAF/I71gK3XekxdtXyBR9CHZhPz+Vumy7IUKxpy
	 83lkpXjFV9fJ5JiziLxceQQ0q7wF3CTZB5Zi+UPANq7h0fZpecUmGB+Ifr9SlkyQKuwxh
	 lFOdSi4CkCzQ/809WTyYSSKTypPiMFlLzaqJ1as7o7a1eAjLyQrxEGTvV7wjsqw3HibW7
	 3Yyv6UrK+6Pl2qcVhKSwYFWuLybuZKzxrHb7jF8nGKs6LjOgCTg68bCvQtutnaG+I11u5
	 I0jOSdPgZi67w8mxSnTC62tb5Tbaiff3HtQnPiRhpYDunXkcoIgzISsMaJgTkuhUG1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oODXvuwQ;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD9606A31B;
	Wed,  4 Nov 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oODXvuwQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793771681;
	b=wPCgumpn0G5a+Pma8pYUHdPtGBCkuKVe8XuxVMo/0J3GdR/YKK3rmkyolfxAjc5L5zrR
	 StZLNkrg8zhzkstD+nwpMm0TjjemjSF4S0NQ4g2jH/DKpGz+HQIZVDxW7S+NW7yQ0dh68
	 1BGi9D5kINqyBkWtoOSlRBzvjsL5IXYJ4Yx3KV0ZokaicZ5ju7hR7Nitock1ieFhril1+
	 k2FvjS3QWLZbgBvaXe5NjRs/qfcOYqkpzsZO30kOs+TUPM5ZVyDDJRbwUXmhYUx1gbaMw
	 YFmqGiSxmz+3hZ7EvQ2zbJwmLNDnmlrCz5vZhI5e66orNRHkacxyfcSeopf2BeKcr7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793771681;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=l6QTWAiT2pnjRja/ALYbiKuIFt7Nll81q03ZWRJukTo=;
	b=lgQyO0BV7yZb612/NPJ8FKJeOBW65eyseFUK7ODe3pe7Jcp76YVZnGN+kYWnWea+2hNn
	 KdUjQLtoZjDcXewBi50S4FQ0w48TyYjbnsHv3Ym1oZ3IAXek+GnBJS+tTq8vM/Z6y0qnF
	 MvBDMp2PI3j3hUWX5DEJMkBC6kUONdiVjON/HKkTuwqzF5gOHdoA95AOWsrNc1MzA6NR+
	 Wiiz0kpRzmCLwBc/zErbvpya82S04ezXrsLyZeGajVz7okZUhYL+GYMKtWghHYSFUi1gD
	 GHx5P1toR5u5TQ0VlZd9bIz0BxlaInh6oqQC0V4v2qMlfRz7ebU+144TynkiVuwOIpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 314551F000C1;
	Wed,  4 Nov 2026 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771681;
	bh=l6QTWAiT2pnjRja/ALYbiKuIFt7Nll81q03ZWRJukTo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=oODXvuwQ2dcUNulurxLj5q3EWvbva2U4hPPiYuHRVOnkA3UBC8o+MbJ2gQVAXI9DZ
	 AqWbn9ZSXqnO5B/zYZes9LNsGq37KR/lWK3YOHqjphOAG+Ui+ho9WseeR+uyzxzs8O
	 lfo9r/vkf9QZPHKTLu34nYyMZj7Jv2kWEZ+hTsmSOpxfMeooNqxHzA/ylmJNhSZEYq
	 lH3x0OLPd5RM582nTQMbruoA/xjwIBVxD4XHEOBHc0duukhT+YQTjHVw3h7b5FQyHt
	 osRqjg5Y/6kHopCmBgz6a8NdDy27Yz8X86c/bN0WMQBss0i0hpp7SibsBF8QZKKjeb
	 nG53P9UfvSNAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B1C5E46C9F;
	Wed,  4 Nov 2026 05:54:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH RFC 0/3] alarmtimer: Choose the wakeup RTC per sleep state
 from the device tree
Date: Wed, 04 Nov 2026 05:54:36 +0000
Message-Id: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3I6moC/x3MSwrCQAwA0KuUrA00cWyxW6EHcCsuxmnaBvojM
 4hSencHl2/zdohiKhGaYgeTt0Zdlww6FRBGvwyC2mUDl1wRlQ5fDv3kbU46i6GlgJvpapq+yMI
 XOpPnK9WQg82k188/f8C9vcHzOH4P0Y9gcQAAAA==
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=0IYwb1SInrt3b80xHHEOcsUK/4uBWyP8cJUA4xS+Tyw=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmvTswTXs/q8/O4/BzBn62T5ojfu5TIqLR8j/mNjgvVB
 3iaZ5Sxd5SyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJ5FoxMlzdxL/urq5/yVIF
 OQEZ9kwdBc9Ufb4Tx/9Y+k/JunPsTSQjQ5tPQuWGiZ7ze80Tuu7nVl/167vQfeIwa0bkj0A3ZeF
 wVgA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

alarmtimer binds to the first registered RTC that has an alarm and a
wakeup-capable parent and programs it on every suspend. On ODROID-HC4
that RTC is amlogic,meson-vrtc: a register the SoC firmware reads when
the application processors suspend. It wakes the board from deep sleep
only, and only when the firmware handles the alarm; it raises no
interrupt in Linux, so it never wakes the board from s2idle. The board's
pcf8563, whose interrupt line goes to a GPIO, registers later and is
never used.

Which RTC wakes the system depends on the sleep state and on the board's
firmware, so the series lets the board device tree say it per RTC:

- linux,wakeup-states: the sleep states an alarm of this RTC wakes the
  system from ("s2idle", "shallow", "deep" as in /sys/power/mem_sleep,
  plus "hibernate" and "off"), or "none".
- linux,alarmtimer-priority: a weight to pick among several RTCs that
  wake the system from the same state.

alarmtimer keeps each RTC that has an alarm and a wakeup-capable parent,
unless an RTC registered before it, with at least the same priority,
already wakes from every state it lists; each kept RTC gets its own
"alarmtimer" platform device under the RTC. alarmtimer_suspend() picks,
by pm_suspend_target_state, the RTC with the highest priority among
those listing that state, the first registered among equals, and
programs the alarm from that RTC's platform device only. The driver core
suspends a device before its ancestors (dpm_suspend() takes
dpm_prepared_list from the tail, in reverse registration order), so the
chosen RTC and its parent, which drives the hardware, are still awake
when the alarm is programmed.
Without the properties only the first RTC gets a platform device and
alarmtimer programs it on every suspend.

An RTC without linux,wakeup-states is taken to wake the system from
every state, so that adding the property to one RTC, e.g. from an
overlay, does not change how the others are used; a priority on the new
one settles which wins.

Hibernation wakeups (.freeze/.poweroff callbacks) are not part of this
series.

Patch 3 sets linux,wakeup-states on ODROID-HC4: "s2idle" for the
pcf8563 and "deep" for meson-vrtc, so that alarmtimer programs the
pcf8563 for s2idle and meson-vrtc for deep sleep. The patch applies to
the current tree, but the s2idle wakeup also needs the pcf8563
interrupt (GPIOX_5), which a patch under review adds [1].

Tested on ODROID-HC4 with v7.3.1, [1] and a BL301 that handles the vrtc
alarm, waking by a CLOCK_BOOTTIME_ALARM timer, once per state: s2idle
woke on the pcf8563 interrupt, deep sleep on meson-vrtc with the pcf8563
alarm left unset. Without the series the alarm went to meson-vrtc and
the board did not wake from s2idle.

Questions:

- Are "linux,wakeup-states" and "linux,alarmtimer-priority" acceptable
  names, or should they be generic (no linux, prefix), given that the
  states describe the hardware and the firmware rather than Linux?
- Is the device tree the right place for a capability that depends on
  the firmware the board runs? On HC4, meson-vrtc wakes from deep sleep
  only with a BL301 that handles its alarm.

The alarm limit of meson-vrtc also depends on the firmware, and the
kernel cannot learn it. Some API is needed to pass this information to
the kernel.

[1] https://lore.kernel.org/r/20261020-hc4-rtc-alarm-irq-v1-1-b2b8c68d54f5@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (3):
      dt-bindings: rtc: Add linux,wakeup-states and linux,alarmtimer-priority
      alarmtimer: Choose the wakeup RTC by sleep state and priority
      arm64: dts: amlogic: meson-sm1-odroid-hc4: Describe which RTC wakes the board

 .../bindings/rtc/amlogic,meson-vrtc.yaml           |   3 +
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml       |   3 +
 Documentation/devicetree/bindings/rtc/rtc.yaml     |  29 ++++
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts      |   5 +
 kernel/time/alarmtimer.c                           | 157 ++++++++++++++++++---
 5 files changed, 180 insertions(+), 17 deletions(-)
---
base-commit: 348f54c435bf3177baa78201952810b255d44b30
change-id: 20261104-b4-alarmtimer-rtc-priority-2e25131a2917

Best regards,
-- 
Igor Velkov <iav@iav.lv>


