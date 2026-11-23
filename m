Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465637;
	b=TlTZQe3pp2PgLP608rBFqYhExaH3NIVKDE0cl1uyNPgT8rnKjy+JRn2j5k4mKgRNUp2A
	 btXB4RbWe1ZkR8o8lbENZgAGCa78hiEqIEFXe4sWKuNnwHXi5ceZ4ufjmuyI8Pwyj891V
	 Jq8ld8ajV8Q8NMfSfoHUBZPSJm7DEv+tTB8tlnJC/XpZOxjr18WxiczpU3p8BTTkjD5jM
	 7Lz0hRkAlIqsIz06hlegm1Rh8LtPcmTyHmaVKg0zvh95CoC8IlJQBzQDP4X/PsFktXxd8
	 pEt7ynsAban3HUXpdtJ5GGo2HQ5wVX/XqK8M8xaWs6f6dSk11gWNwuq5ByIdD1sR0KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465637;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=rtTQPkEL0XREdskq3jLhFleowecJro76Wk0Qnwyca/o=;
	b=isRYUfukyer0YEty6Ir9LcJtUQTc+0TTMuD2uhv5m6aOiAYQltOvHOQ4c7Ubuj9nLmYe
	 lwSp1P9z8Iw1QLjbOjiKEHgvrqxJNVs7h15foxtlG90C/q2s9M2FIXeXFpfQKFvCWyBoo
	 X5wp0/iHwhdLxTm6AEqrI+FAbDZkWPH9fbJoEdWzX+F+9clLqrIMUny02tZyGb9605nrE
	 tYyhEY9JtpaK54J4z949fdicSHkYco90wa9tZ8pg6pvImRtNPsFe+9nqn83ji8vSXe3UC
	 duVuPX++EdS0cjunfWBt9IO96+NSgBN8IkCQQLVl81HvRCntQxspRLv8jRvNP5lg0eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpMXJ5Vj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC777606A330;
	Mon, 23 Nov 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EpMXJ5Vj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465637;
	b=25jkPVLlPskMDyo72k67+ODSYeVRtEx4jzCmZNzPiRSgiz4NAx9ncca0jXwkB43w3H+r
	 ol/peoR9ft+STHzNt335rN3etop3D0UDO/CMv84/qeCVMQPAWsoPOZiLGBfrXjRbmqOOl
	 Ui5bCaPGdJ7GsG0w/qmMpaf/abciiJ5LdxH2Rz7Hk72UVRoorSd2AyHrf7q9ZKjvQfpgW
	 sujQrAxc7OFqGQowMPUjVYeynxV6/3dDwBonoA/zxU4LU0K9VsM6KmEuBf/tiBGAh4vdD
	 crfSmihZGOQr8rV01hD3AStz0D+iiFHIaU786DVeLvrTwU4Mi6/3Dd1YyK03jea4ASw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465637;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=rtTQPkEL0XREdskq3jLhFleowecJro76Wk0Qnwyca/o=;
	b=hXOYKvKXByv+XgPSi7q0XZ0E/6y10v0VZhaEaXFVBPjQJ1j0XgmkfDFzVJyky6UkXErE
	 9s/o8LoJnuMP+pgbpDY9TndFIrX3o9wIBqdqlp9CQDWFGmTUr6m3g+qheAobB5ThnQITj
	 L95GjXak+uQGpIBWXrSrE/aOjfOJnPLAKDmuSrvUMmyCTf8AcAs3RqgnygsgiG7dugmvf
	 PuTOMRJy6BQOQLm92octuL5j/GzGweuQrjV4wM3tpzESfrPR5GiqRKhNsKcQrtci07cnd
	 yhEZgIp4xGjxEEbhUQpG+IgToHSLKqAphSfiUNPH33IUeGywD/9X1aUgE/DwJjexGFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64F831F000E6;
	Mon, 23 Nov 2026 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465637;
	bh=rtTQPkEL0XREdskq3jLhFleowecJro76Wk0Qnwyca/o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=EpMXJ5Vjx29wuBVhYCIeIuosGvgeN82f8leYmIBzFfm9x47y3X+5pPcpcQyYfGscN
	 FOXiHVNB/QDRD+Vx3lyfUCO/jTlQGUJ7b8OPmNzxjvFIGYAUy/kOxJjE4G0bYo17dU
	 6h9cedUSliiaCh6kF5YiXpsMD5MlxZVlAX2BrACTguvNElwXDQbGMpYQpLFIfWFTcK
	 1BwbGual7xBZSZJVJFNFgmViPBUMt7NgZHAQKaznF1mbS/ksXgKVixMCIr8nHFrxEf
	 f5WDFJMwgltB7MX+TjtASNSqTdL7QxjOvST3tAw5rLynfYe0SJSEJ+nvlLWrab15V6
	 3jlvlswXmxPkQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC34C4C6E1;
	Mon, 23 Nov 2026 20:27:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Date: Mon, 23 Nov 2026 23:27:00 +0300
Message-Id: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFteZS48j8Mi1JaGCPUtEg0p
 P9ui2uXJzn33B2C8WQCXIodvNkokFsSiFMBelLLaJCGxCCYaDgXJfYV6iDrSqBfNVrW8naQ0g5
 KQNo8vbH0Pnq37sfh1d+NXnMkGxOF1fnPcbjx7P1rbxwZNrouZcOtVay8jrOix1m7GboY4xd1s
 cxLvAAAAA==
X-Change-ID: 20261123-b4-cs7542-rtc-f0818d77fda2
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465620; l=3354;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=a/wF/4Ko9QK5xjn99mr5dhgpXbagDzvGTbxdN83EbHE=;
 b=eVgG7vvgPOYVRQRbCsR6+fGr8b55K7cZH1A8wAc2e3YBgRxv4yVem/vYZdfXAGS5buIBucuoD
 oip0g87xUHrDuwDAUj4LMx+hw3ugDmLUOo5c5zay35MTosk7tqnzXuq
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

Add the memory-mapped calendar clock of the CS7542, based on the GPL
vendor and OpenWrt implementation. Use an independent OF/HAS_IOMEM
Kconfig option so the driver can be reviewed without the pending
platform series.

The initial driver supports calendar reads and setting the clock in
the 2000-2099 range. It decodes the four-digit BCD year, bounds retries
across second changes and retains RTCEN after programming. The alarm
and suspend-wakeup features are deliberately not advertised.

An alarm prototype was investigated on the board, but the expected
alarm IRQ did not arrive. Time-of-day and calendar comparisons and
interrupt-mode experiments have not yet established the missing
hardware behaviour. Those experiments are retained locally and are not
included as working functionality in this series. This is a calendar
support submission, not a claim that alarms have been fixed.

The three patches are the binding, the driver/Kconfig/Makefile and a
MAINTAINERS entry. They apply to Linux v7.4-rc4 without the pending
CS75xx platform or clock/pinctrl series. 

Validation:
- binding schema, example compilation and style checks passed
- strict source checkpatch with --no-signoff: no errors/warnings/checks
- complete minimal ARM vmlinux and modules builds with both new
  drivers built in and modular, COMPILE_TEST=n, without the platform
- actual driver functions tested with mocked MMIO/regmap and UBSAN
- exact sources booted in a Linux 7.4-rc4 RAM integration kernel on
  Almond+, with platform v9, clock/pinctrl and the accepted watchdog

RTC opened, read a valid date, advanced over two seconds, accepted
setting the current time and kept counting afterwards. The alarm ioctl
was rejected, matching the advertised support scope.
The final combined RAM test recorded 16 checks with no failures and
returned to installed OpenWrt 6.18.64 through the watchdog. Both CPUs
were online. The firmware was not flashed. Earlier incomplete or
experimental alarm runs are not counted as this successful test.

---
Changes in v2:
- Place RTC_DRV_CS75XX in the on-CPU RTC section, outside the HID section.
- Keep the Makefile entry alphabetical. Driver C code is unchanged.
- Link to v1: https://patch.msgid.link/20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com

To: Fil Dunsky <filipp.dunsky@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Fil Dunsky (3):
      dt-bindings: rtc: Add Cortina Systems CS7542 RTC
      rtc: Add Cortina Systems CS7542 RTC driver
      MAINTAINERS: Add Cortina Systems CS7542 RTC support

 .../bindings/rtc/cortina,cs7542-rtc.yaml           |  48 ++++++
 MAINTAINERS                                        |   7 +
 drivers/rtc/Kconfig                                |   9 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cs75xx.c                           | 174 +++++++++++++++++++++
 5 files changed, 239 insertions(+)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-cs7542-rtc-f0818d77fda2

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


