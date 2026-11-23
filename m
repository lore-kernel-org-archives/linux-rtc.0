Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471216;
	b=PdXcDi/RRwv/vgUiJNTunNM0rYlyNswFwxCwQZyTq/A0G/zOKpxi6K9L5m4uCGamcYeg
	 TCn1QHM+KlnEoS1Nu4BWziOQMkugGNc6fmdt1PSAEbjV9unfisKrDQ49MSyQ9GyufXmeN
	 ueqAeE32LtNO86wDjHz5nfoIX2pbLyPvB5T+AthTf2Vjq7wZXE6eVQm/CGY9bjRegVypX
	 nVYB7tR3wu+r/BZ4DqdM16Q5E29GpNuglUiXp54e4HtbKMdcyHgJPE6HE0s7qonsVMRig
	 /y57sqJsvHzG/dGjEIBiWh/IepR6RU9yvQWUGWg7XGomaXN16yZ6vV8pcK5Ehxgh7bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471216;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=z8eScH+II4m5GORBY8XJimZQdDZpF3Q3Ois0eTzg3Bg=;
	b=t1H9G+2AmKqZ71C1rnQwM6LRpNVlJSOD/W5a8kGQu4xZ8NuZybPEpL5gITkT4VVAaGPS
	 XDzeELewHiUZvz27Kdg2QngV7eCjnDwBSs3VqUFQa9jqZTOr9NO8/1HaWyUSM93dOgdZ+
	 nWvA0dykp+cyeG1wDxzk3iF5na+DdtZtjcUKovpQ+xfaXLktVF9EdJv5tl24rfyUAxaZf
	 GxAnhEcQMh0oU1hY14y2NdwbvilYJeMFtbi9+w+Z3vk3o5iSv2XT1gs/Mt0zN0FvA8mGM
	 1VRTwwI81zSJm7Hr6gmZkWKoVdTS/dnvmmDM3gxMewpe5+dL9iZBEKH4hfdkO3DJpEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiOpFyrG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F810606A335;
	Mon, 23 Nov 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiOpFyrG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795471216;
	b=liznJ65Zqw+05k7NZoLqLtofV4UtEQt3F9b1vg91/Eh2P5pYbSqCtY7oZKaZS6QM6UKZ
	 bXm2T2DBYcJ2UXj2P6GwwiBbAAZ8EGif6gtfm/ElwBiaZDV27VZUj5hLUo1qPxpfuF6Vh
	 VYu0oIaMm+HwUcDcv5Duvf1i+gwhLob8v6sKvm+OLVbaJw6nQhOA+LGSrlSIcieTtvcvP
	 XqRzJjexCHXxz+xc71QJv5HJBXTKl8lBBPJgK225tT6iSTJ6a2VhQiG6iKWl9aUWYxPfH
	 jKlvYKgcHEWKL6cJLc08w64tfJky6pNjU9XCsXFGAWV7Sf74CeyC/goWrbDxeBDLdeA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795471216;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=z8eScH+II4m5GORBY8XJimZQdDZpF3Q3Ois0eTzg3Bg=;
	b=Se8q0tJsbGybxzC0XeVcucDGmUA/Fy+xLuWe6VHArXMvgDekZGYPVazkj92UvWOpO85r
	 ZE+1+UOncNdAV2J7oZwixZstc160FCgTzAXidXUT/cLlbv7CHriK7BrX84eamVr04TgyX
	 2HsZKCKjEIllgbtcegZnqSfqLtcHzT1yBkIq0QmD0N1FMBPceY2lHSOSDLVMuYaB9y9T9
	 05rViqvrRjt3oJiphNsLKUSMtw0Zz8uoaV/6kMdeKsamBeTNn44+fv8YJ1w82vJ88d7Es
	 tip+M98AN/WwJOlgtldnV9Kl5p3BLvW1I18SyDhqWabbCfbe6QuWkHMEhq10Snzn90A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F90E1F000C6;
	Mon, 23 Nov 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471216;
	bh=z8eScH+II4m5GORBY8XJimZQdDZpF3Q3Ois0eTzg3Bg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=oiOpFyrGG3MLBcS6dkFISGA5mqu8LLOIjQf63YBWWNUDKYXM5aNr1AqaSIE/3ECrg
	 hyis/UhSeYfFoA5MOEM74A7ja+VzqSrPr7B2QS4K+o9h1uRe7abQqP73IdIJpwrHMA
	 b63UM34V1ppah14fj0BBl8j1JRwf2IuAL6lF9Qt91ShS5H5Id++v5P6tnswejhidD7
	 ma8TXDqkSdM6YZpnoZy2cgmchBR42C355h9v4ZD1tNwW3bU2prMkviFW8M6Mr/hUky
	 DHhvoKBGaSSU0AwJy4LpFbUaFJH+H/vWe7mYq/gCi6wibAHkU6PsCFc9Dke1ImsrOB
	 SSQ1eVjry2HHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C3A724C793;
	Mon, 23 Nov 2026 22:00:13 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Date: Tue, 24 Nov 2026 01:00:12 +0300
Message-Id: <20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBAFf4X0bE13C5R48j+Mh7K0UCNiWmw0h
 H+3xYsXPU7yZt7CgvHOBHYoFuZNdMFNtwRyVzAa9K033HWJGQqsAVDytuQUVFUi9zNxKxpoOqV
 sp5El5+6Ndc+tdzp/ODzai6E5R/JicGGe/Gs7jJB3v9oRuOA1VVLVYK0W8tiP2l33NI0styP+t
 THZEnRbSotEjfm213V9AwyMikr6AAAA
X-Change-ID: 20261123-b4-cs7542-rtc-f0818d77fda2
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795471212; l=3972;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Sj4YCV8Y8oxQ28BgyN0TnodyFRFNZWfHAe8RuVb9Ha4=;
 b=hZkqQdDvSTSzOy3Ge48RCYLbklX0Q+STk6tS8El0cDwtXsqEWg+iqPMEOPLLS1pR5hv3aluNT
 jmL/ASdhuXHBNWARdJ/JIYyEuoQz+FDXdRc6XbntLAVpNvmR0rjrTpT
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

Decode the four-digit BCD year, bound retries across second changes and
retain RTCEN after programming. Leave a disabled or reset RTC alone at
probe and report its time as invalid until a known time is set. The RTC
core validates the decoded calendar and handles absent alarm callbacks.

The vendor-generated BCDYEAR register definition assigns all bits 15:0
to year data and reserves bits 31:16. With the century and leap transitions
below verified, advertise the representable 1970-9999 range. Alarm
interrupts and suspend wake are not implemented; an earlier alarm
prototype did not produce the expected IRQ and is not included.

The three patches are the binding, driver/Kconfig/Makefile and a
MAINTAINERS entry, based on v7.4-rc4 without the pending CS75xx platform
or clock/pinctrl series.

Validation:
- strict source checkpatch: no errors, warnings or checks
- complete minimal ARM vmlinux and modules builds, RTC built in and
  modular, GCC 14.2, W=1, COMPILE_TEST=n, without the platform
- actual read/set/probe functions with mocked MMIO and UBSAN: all 256
  control-byte patterns, disabled/reset rejection, no probe MMIO writes,
  known-time enable, 8030 BCD-year round trips from 1970 through 9999,
  future boundary values, core calendar validation and retry/error paths

On Almond+, an exact driver RAM integration run on Linux 7.4-rc4 first
verified no control changes on reprobe, EINVAL with RTCEN clear or CLKRST
set, then setting known current UTC, enable/reset handling and counting.
A second RAM fixture used the same operations with a widened range and
raw calendar tracing to check these ten cases:
- 1970 first-second tick; 2000 leap day; 2038 boundary tick
- 2099 to 2100; 2100 February 28 to March 1
- 2199 to 2200; 2200 February 28 to March 1
- 2399 to 2400; 2400 February 28 to February 29
- 9999 December 31, 23:59:58 to 23:59:59
All passed. This is hardware evidence for those cases, not a hardware
sweep of every encoded year. Each run restored current UTC before its
watchdog return to installed OpenWrt; a fresh host UTC restoration was
verified again afterwards. Firmware was not flashed. Earlier v1/v2
RAM evidence is not counted as these v3 review and range tests.

---
Changes in v3:
- Preserve RTC enable/reset state at probe; report disabled/reset time
  as invalid and initialise it only when setting a known time.
- Let the core validate calendar fields and remove redundant ALARM
  feature clearing and the two noisy probe messages.
- Advertise 1970-9999 after checking the 16-bit BCD field, critical century
  carries, Gregorian century leap rules and the 9999 endpoint on hardware.
- Link to v2: https://patch.msgid.link/20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com

Changes in v2:
- Place RTC_DRV_CS75XX in the on-CPU RTC section, outside the HID section.
- Keep the Makefile entry alphabetical. Driver C code is unchanged.
- Link to v1: https://patch.msgid.link/20261123-b4-cs7542-rtc-v1-0-6c53761ffa03@gmail.com

---
Fil Dunsky (3):
      dt-bindings: rtc: Add Cortina Systems CS7542 RTC
      rtc: Add Cortina Systems CS7542 RTC driver
      MAINTAINERS: Add Cortina Systems CS7542 RTC support

 .../bindings/rtc/cortina,cs7542-rtc.yaml           |  48 +++++++
 MAINTAINERS                                        |   7 +
 drivers/rtc/Kconfig                                |   9 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cs75xx.c                           | 159 +++++++++++++++++++++
 5 files changed, 224 insertions(+)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-b4-cs7542-rtc-f0818d77fda2

Best regards,
--  
Fil Dunsky <filipp.dunsky@gmail.com>


