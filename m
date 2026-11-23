Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474209;
	b=12YCfzCENJe/WKzaoA/6zcLLXLpS/yi64JPrn2LbYcG8K5IIlrK97lMK3b3kKEBkls+N
	 5fcdB8zl/Yrb/YZ3CoK+lwiOetIfTzxG7iQzLwqE1Rd8JrChw4ksHAmx1vE+2c1RJxs0M
	 KjYxR0FnSEe+c0Ag9Qtvo2KKfJj3xraXKgorGsau6hxLiFxKDk0J/vadQoBiignIN5d89
	 qAUq/wzTDctlYs8HXwy4aWVx36Bkni5cxkdVe56nKBwwdYsfTiW932GTYMOZFKZMvCCzZ
	 kgImEqf1aMrLZYh9QJwVEkqN1O8WDp2Zwaf+Wgp2Vj3AZLkgIKz/MRd+ACgkeqmadwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474209;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Ca4tTScCjuYy0lBJT/xmrIGYvwTpsOx7x01yna43BCk=;
	b=cko9+5XNhqAGpnjfBPMUuoZ9L5gZRNmeRSk7rsk3WtnxB5rXr/FpWUydZNGH0eJ55zIA
	 CiIYkTakQHXNns/9tkid/2pxo3tsuiZ7zh36e2e+FDIyvD5thgz3cbaG7Hj/X1L1IteWN
	 EuVWlaEwW8GRyQAEBnoQqrlXEsPCiCm7rogrUfpik+FeBzYqx3RU9/1oO0yXDd2TxXQ4w
	 gkGaYYlFAfd9Nf2k+JMVKSJut2d9G9H0NYoG2Eljyww+g0o9puGu19K7bzU+A37oEYG7W
	 xj4KvManaxHfBL35JdAxzqkbr/SaWsBckgjWakNgAhy6hLiyyM7lucyneXAeFTN5g0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9uVTNs5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D29606A32A;
	Mon, 23 Nov 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9uVTNs5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795474209;
	b=Nhfpx0dmakuT5/qWQLyNJsoxzEce0QxSr5UC/NS2reV7LhUR2V/SshYkkT5t2xUNKU63
	 ebza08LtqUOQ+DK1i2dHpkzSTOuhBBk8UVv38YvU2vutjR+tMbqFKj+SIqGUaFDg3EsJH
	 xFdv3OtMT0/aCx3Up1y45BX5DgXGbABS8Kfb+MJ+/XdrT79SK80BfbmcqXIw4CD5iYkCV
	 qXhWSN7btKzf0pqkWJco33qOK17yVYoYxaQHGAwS+FBZNQzN9y8k3q79lcZQOOWz6lmhu
	 G/ABsY0KmQyDIrEeSGNXzd3gt6kmwci6J1B+wmDv7awRg/q8K20yuvLbl5ZYiybgleg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474209;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Ca4tTScCjuYy0lBJT/xmrIGYvwTpsOx7x01yna43BCk=;
	b=swi+2RqG+28xlj58/o7pKyMZsNc7QMT805cWZYRdfCfxBd/zKOQVP2AH3HjlDjCdiCLk
	 StUOjYkr+1G0AvthEr0nHF6ikArCmIokq1IC//15fHocb9ZlHrEICoagX+Y2vMthHvCWt
	 nUoJSRliYuwKvz7PwroDFhV6duvLEf7Ejx6aQnOdsk24LBZQ3cdXJmwVRuXJfONb+vjWE
	 2SG1+5QSvAOVEIgT/hqXkGUvcuWpqRVL+rTbxgT5jymTxiBlwUMeITRk9H6r0xqAGhdv6
	 9PhB7sAPlv+sfjQ7M9rX/3/qXl4RWqRZgtY5XqJ1GL++7XGFS63SMl4sGb3ZR3UQX5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E12B41F000C6;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474209;
	bh=Ca4tTScCjuYy0lBJT/xmrIGYvwTpsOx7x01yna43BCk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=d9uVTNs5Aa+/NVMSLEYhIvy5C2RcoxF553SWIXhXEqjh/r74sxcCncvbsL6PMXNf4
	 HyMjM9C9G4Ms5CS/v/j6KT06b9F7GbeFXgX0OkpyyJopjCwvIqZ/nsw1d5PsDHcE2y
	 nRiZAHUCmoVFa/d3xI99O3fufLraAVlHObf53CuswpRT1qClVbpNeNplZd0/aCIcNX
	 CijdyXvzoOla4MQXqDGBILBTj214Q3cuKAWAIA13FztoWG0cJ8i0pxEA+JWA4xcSxC
	 wU0ZJ++2hl5Ya1ZkPWJVKuq1dIRmbGGRW2gtqSdZzZhWD75ngtyZzOT8lbEDt0di1m
	 fRRQ6ZVoVNuiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43EC54C7B1;
	Mon, 23 Nov 2026 22:50:01 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Subject: [PATCH v4 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Date: Tue, 24 Nov 2026 01:50:00 +0300
Message-Id: <20261124-b4-cs7542-rtc-v4-0-bceefd844074@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBCF4asY1mJgoKW68h7GBVBoMbY1UImm6
 d2FutEmunzJfP9MKBjvTECHzYS8iS64oU+DbzdIt7JvDHZ12ggIlJQCw4pjHUTBAftRY0sqWtV
 C2FoCSubmjXWPpXc6v3e4q4vRY47ki9aFcfDP5WGk+e5XO1JMcKkLJkpqrSTs2HTSXXd66FBuR
 /irIWlGpeLMgtaVWWv2qflas6QLtiegrDJEful5nl9aBTsAOAEAAA==
X-Change-ID: 20261123-b4-cs7542-rtc-f0818d77fda2
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795474200; l=4972;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=VhVJSYB9z2on++tWgQG/oLKkQMYVIodUrNY/c6ejsUM=;
 b=UgqFz5j9dCKQcMU6Mp72l5OtxPODMl0u/rDrvgg3MdUedYWWKhjK7/vzQZ0EVy6q463KLWjDw
 viPub9HjbI9B1k6ki+4UeXcilKX6Qe7W+0DtvB3Q098EfQp0ALf3rlG
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

Describe the hardware's 0000-9999 calendar with RTC_TIMESTAMP_BEGIN_0000
and RTC_TIMESTAMP_END_9999. BCDYEAR assigns bits 15:0 to year data and
reserves bits 31:16. The range metadata models physical encoding and is
used by the core's offset handling. Ordinary core validation still
rejects dates before 1970; no public calendar-validation bypass is added.
Alarm interrupts and suspend wake are not implemented.

The three patches are the binding, driver/Kconfig/Makefile and a
MAINTAINERS entry, based on v7.4-rc4 without the pending CS75xx platform
or clock/pinctrl series.

Validation:
- strict source checkpatch: no errors, warnings or checks
- complete minimal ARM vmlinux and modules builds, RTC built in and
  modular, GCC 14.2, W=1, COMPILE_TEST=n, without the platform
- actual read/set/probe functions and core calendar validation helpers
  with mocked MMIO and UBSAN: 10000 BCD-year round trips from 0000 through
  9999, all 256 control-byte patterns, disabled/reset rejection, probe
  side effects, known-time enable, future boundaries and error paths;
  pre-1970 core rejection is checked separately from callback decoding

On Almond+, an additional Linux 7.4-rc4 RAM-only fixture called the actual
RTC callbacks under ops_lock to check the physical lower range. It
bypassed core calendar validation only inside the separate test module.
These six transitions passed, with raw BCDYEAR and decoded callback
fields recorded:
- 0000-01-01, 00:00:00 to 00:00:01, with raw year 0
- 0000-02-28 to February 29
- 0099-12-31 to 0100-01-01
- 0100-02-28 to March 1
- 0400-02-28 to February 29
- 1969-12-31 to 1970-01-01
The module recorded 219 checks, no failures, and verified current-UTC
restoration. The outer RAM supervisor independently verified restoration
before watchdog return, followed by fresh host-UTC restoration in
installed OpenWrt. Firmware was not flashed. Direct pre-1970 callback
reads succeeded while the unchanged core validator returned EINVAL;
the transition into 1970 became core-valid.

The v3 review run had already checked disabled/reset reprobe, invalid
reads, known-current-time set/enable and counting. Its separate range
fixture passed 1970 and 2038 ticks, year 2000 leap day, century carries into
2100/2200/2400, non-leap 2100/2200, leap 2400, and 9999-12-31 at 23:59:58 to
23:59:59. These are targeted hardware cases. The 10000-year round trips
above are software encoding checks, not a hardware sweep of every year.

---
Changes in v4:
- Describe the hardware's 0000-9999 range using RTC_TIMESTAMP_BEGIN_0000;
  keep the core's ordinary pre-1970 calendar validation unchanged.
- Check year 0000, early-century carry/leap transitions and 1969 to 1970
  through direct callbacks in a guarded RAM-only fixture.
- State the hardware calendar range explicitly in Kconfig help.
- Link to v3: https://patch.msgid.link/20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.com

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


