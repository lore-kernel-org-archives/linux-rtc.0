Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503709;
	b=wiL7vSQAT1XygFT301L6twMXushT1stCle+yHts4sSBzaqoS+oyVcyxp4RErkUWXGS8u
	 sl8n4mf+62MgjDajKGHEYmJr0lGAZoLY6Z6iJ2WM9v5D4i2s2uOeTOwlOe3pUdxeksHmY
	 bPdWDiX4tZ5Gnx0sFlQ2q+xiTOYPIjQxeadR4EgVn2iRlMVcJRB05ajSq0C/XwZtQCLs6
	 cVhqDn+dF7PTaEE0aAJ/Xd9pEeIfLHjQ/Kk4nJGdNF5vStym1VB0asdkAhhW+/ctGOw2v
	 4c23sHfy49QTH2l6B0TPpGv58nn4c0bd+HJzK00FlyibN5yUoPql92Arlyqz7YyHurQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503709;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Last-TLS-Session-Version;
	bh=9LYQxUSQh6HCH5hqVznJTc/H8uXNcqWVdSWMPGvX4uo=;
	b=bySnYGKilhsD0BmDuC1E7sPgCuC4QVCXp2blYUlIdgpcVPbhm3rRDz2aJ1lMtq6+AYjX
	 sGOOKUuKQwpnkyYwKeWjKbFYZz/MgjxU8IZQ37gzrS5voBUmmyu1VeIMBqhpvlRKcCQf9
	 Mtk+lvr5M+f+JKkGuiKcXU6lOGTl4QVrqlxvsakeYIKmM32j28F9gaCL6GaK9dSTOBuRw
	 3us0NS5eucchhkFlTeb6xHZmL51TBhyHpbvnNFPb4bz5F2LP2oQaBaeYRP33hOr7aGY3q
	 0i0qGbiiZOt2jChGWe726WZr1BnEj16cy20z4YtRFWhW8rdUCkWWnWycGtv81mZkg3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nUthlsXP;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119C606A325;
	Sun,  1 Nov 2026 03:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0119C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nUthlsXP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5E0541A13E5;
	Sun,  1 Nov 2026 03:28:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EFAC60750;
	Sun,  1 Nov 2026 03:28:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACB0410328678;
	Sun,  1 Nov 2026 04:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793503697; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=9LYQxUSQh6HCH5hqVznJTc/H8uXNcqWVdSWMPGvX4uo=;
	b=nUthlsXPesmt3Sn7y/zk7kOQbDtCCud4yOc8R3xXOsPTL78d9kVGG4iu7WJdX7O0toJlz3
	/weGD/7a03sGr2tMtOLqmUVGK2aFbI+zuDTLeNgmwGTJIHPEbZZUb07JwrJ5ymFCQaitdG
	zjHFaUnzeXx4pdTmwgCVPLmQdNyiaNEdIYBqN9yNa0kmaKrUFO+clnZEWZD371pVPj9H5Z
	prLJ9NtyUXqcftvX5qT12a+lnprARBdeyHA8O+VnfaIJI71CjrGF4IcGIG7Wvge9MaCXb9
	mwtAjZxHpWcZKvga/zrRGmAmJkrEa+6gsZYvO3jSbQiF3/4KSkVQsvRYOuEjwg==
Date: Sun, 1 Nov 2026 04:28:15 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 7.4
Message-ID: <202611010328159ca7e972@mail.local>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello Linus,

Here is the RTC subsystem pull request for 7.4. A way to lift the
hctosys limit for 32-bit system is introduced to ensure systems relying
on it can pass Y2038. A driver for the Raspberry Pi 5 RTC is added and
support for the Abracon abx81x, Ricoh R2223x, Renesas R-Car X5H and
Allwinner B288 RTCs is added in existing drivers.

I still need to review multiple sets of LLM generated fixes that have
been sent, I will probably send in a fixes PR after -rc1.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.4

for you to fetch changes up to 7485659ecb81d5fce3a3edf2cae9fcb29c17b1cd:

  rtc: rs5c372: use sysfs_emit() instead of sprintf() (2026-10-30 23:23:31 +0100)

----------------------------------------------------------------
RTC for 7.4

Subsystem:
 - the hctosys limit for 32bit platforms is now configurable
 - introduce lock guard for for rtc_device.ops_lock
 - use sysfs_emit() instead of sprintf() were possible
 - selftest fixes

New driver:
 - Raspberry Pi 5 RTC

Drivers:
 - abx80x: add support for ABX81X
 - bd70528: properly enable wakeup
 - cmos: Fix ACPI RTC alarm handling
 - ds1685: power-off fixes
 - mt6397: add nvmem support
 - pcf85063: add HW UIE support
 - rs5c372: Ricoh R2223x support
 - rzn1: add R-Car X5H support
 - s35390a: allow use of output pin for interrupt signal 1 for wakealarm to
   support synology devices
 - sun6i: add Allwinner B288 support

----------------------------------------------------------------
Akshat Rawat (1):
      rtc: rv3028: use sysfs_emit() instead of sprintf()

Alexander Sverdlin (4):
      rtc: pcf85063: use devm_of_clk_add_hw_provider() for clkout
      rtc: pcf85063: do not clear AIE in the interrupt handler
      rtc: pcf85063: preserve the alarm flag in clkout register updates
      rtc: pcf85063: add 1 Hz update interrupt (UIE) support

Alexandre Belloni (33):
      rtc: omap: remove unused argument
      rtc: ftrtc010: fix cast
      rtc: nvidia-vrs10: remove locking in IRQ handler
      rtc: introduce rtc_device.ops_lock guard()
      rtc: ac100: use guard
      rtc: asm9260: use guard
      rtc: atcrtc100: use guard
      rtc: ds1305: use guard
      rtc: ds1307: use guard
      rtc: ds1343: use guard
      rtc: ds1685: use guard
      rtc: ds3232: use guard
      rtc: hym8563: use guard
      rtc: m41t80: use guard
      rtc: mcp795: use guard
      rtc: nct6694: use guard
      rtc: pcf2123: use guard
      rtc: rv3029c2: use guard
      rtc: rx8010: use guard
      rtc: rx8025: use guard
      rtc: stm32: use guard
      rtc: abx80x: simplify locking
      rtc: rv3029: use sysfs_emit() instead of sprintf()
      rtc: pcf2127: use sysfs_emit() instead of sprintf()
      rtc: ep93xx: use sysfs_emit() instead of sprintf()
      rtc: bq32k: use sysfs_emit() instead of sprintf()
      rtc: x1205: use sysfs_emit() instead of sprintf()
      rtc: rx8025: use sysfs_emit() instead of sprintf()
      rtc: ds1343: use sysfs_emit() instead of sprintf()
      rtc: ds1685: use sysfs_emit() instead of sprintf()
      rtc: isl1208: use sysfs_emit() instead of sprintf()
      rtc: ds1307: use sysfs_emit() instead of sprintf()
      rtc: rs5c372: use sysfs_emit() instead of sprintf()

Andreas Kemnade (1):
      rtc: bd70528: properly enable wakeup

Antoni Pokusinski (9):
      dt-bindings: rtc: abx80x: document ABX81X RTCs
      rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
      rtc: abx80x: add mutex protection for register writes
      rtc: abx80x: properly handle shared IRQs
      rtc: abx80x: add irq to struct abx80x_priv
      rtc: abx80x: use regmap instead of I2C specific API
      rtc: abx80x: replace read-modify-write pattern with regmap helpers
      rtc: abx80x: create abx80x_i2c_probe()
      rtc: abx80x: add support for ABX81X

Baek Kyu, Kim (1):
      rtc: mpfs: Fix alarm register word order

Eric Liu (1):
      rtc: nct3018y: report chassis intrusion through hwmon

Gregory Price (2):
      rtc: cmos: Disable ACPI RTC event before handling it
      rtc: cmos: Honor explicit use_acpi_alarm parameter value

Guoming Chen (1):
      rtc: ds1307: drop redundant dev_set_drvdata() in probe

Heiko Schocher (3):
      dt-bindings: rtc: add ricoh,r2223x binding
      rtc: rs5c372: add support for Ricoh R2223x
      rtc: rs5c372: support eco mode on R2223x

Igor Velkov (1):
      rtc: pcf8563: pass the driver data to the alarm interrupt handler

Imre Kaloz (3):
      rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      rtc: ds1685: do not sleep in the power-off handler
      rtc: ds1685: keep setting PAB until power is removed

Karl Mehltretter (1):
      rtc: class: Make the time32 hctosys limit configurable

Liu Dalin (3):
      rtc: ftrtc010: fix clock resource leak on probe failure
      rtc: ftrtc010: use devm clock APIs to fix use-after-disable in remove
      rtc: ftrtc010: fix integer overflow in time calculation

Ma Ke (1):
      platform/x86/amd/pmc: Fix RTC reference leak in amd_pmc_verify_czn_rtc()

Markus Probst (6):
      dt-bindings: rtc: Add pinctrl for S35390A
      rtc: s35390a: Add missing newline to dev_err
      rtc: s35390a: Fix alarm not disabling
      rtc: s35390a: Read 24-hour mode on access
      rtc: s35390a: Add pinctrl
      rtc: s35390a: Add synology quirk

Michael Walle (1):
      rtc: pcf8563: add SMBus support

Pablo Mazzini (3):
      rtc: sun6i: fix error handling in sun6i_rtc_clk_init()
      dt-bindings: rtc: sun6i-a31: add Allwinner B288
      rtc: sun6i: add Allwinner B288 compatible

Ryan Brue (2):
      dt-bindings: mfd: mediatek: mt6397: describe the RTC's nvmem layout
      rtc: mt6397: expose the spare bytes of the alarm registers as nvmem

Sander Speetjens (3):
      dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
      dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
      rtc: Add Raspberry Pi 5 RTC driver

Wake Liu (1):
      selftests: rtc: fix flaky date_read_loop test

Wolfram Sang (8):
      dt-bindings: rtc: rzn1: drop unneeded 'start-year' from example
      dt-bindings: rtc: rzn1: add SoC names next to their IDs
      dt-bindings: rtc: rzn1: add R-Car X5H support
      rtc: rzn1: add R-Car X5H support
      dt-bindings: rtc: rzn1: add resets property
      selftest: rtc: rtctest: don't mention skipping twice
      selftest: rtc: rtctest: make missing UIEs really skip
      selftest: rtc: rtctest: skip properly if setting alarm fails

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   6 +
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   |   9 +
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  18 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      |   3 +
 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml  |  37 +-
 .../devicetree/bindings/rtc/ricoh,r2223x.yaml      |  58 ++
 Documentation/devicetree/bindings/rtc/rtc.yaml     |   1 +
 .../devicetree/bindings/rtc/sii,s35390a.yaml       | 118 +++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 -
 drivers/firmware/raspberrypi.c                     |  24 +
 drivers/platform/x86/amd/pmc/pmc.c                 |   5 +-
 drivers/rtc/Kconfig                                |  60 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/class.c                                |   8 +-
 drivers/rtc/rtc-abx80x.c                           | 821 +++++++++++++--------
 drivers/rtc/rtc-ac100.c                            |  10 +-
 drivers/rtc/rtc-asm9260.c                          |   4 +-
 drivers/rtc/rtc-atcrtc100.c                        |   3 +-
 drivers/rtc/rtc-bd70528.c                          |   5 +
 drivers/rtc/rtc-bq32k.c                            |   2 +-
 drivers/rtc/rtc-cmos.c                             |  32 +-
 drivers/rtc/rtc-ds1305.c                           |   4 +-
 drivers/rtc/rtc-ds1307.c                           |  16 +-
 drivers/rtc/rtc-ds1343.c                           |  12 +-
 drivers/rtc/rtc-ds1685.c                           |  53 +-
 drivers/rtc/rtc-ds3232.c                           |  50 +-
 drivers/rtc/rtc-ep93xx.c                           |   4 +-
 drivers/rtc/rtc-ftrtc010.c                         |  73 +-
 drivers/rtc/rtc-hym8563.c                          |   6 +-
 drivers/rtc/rtc-isl1208.c                          |  10 +-
 drivers/rtc/rtc-m41t80.c                           |  12 +-
 drivers/rtc/rtc-mcp795.c                           |   3 +-
 drivers/rtc/rtc-mpfs.c                             |   4 +-
 drivers/rtc/rtc-mt6397.c                           |  91 ++-
 drivers/rtc/rtc-nct3018y.c                         |  94 +++
 drivers/rtc/rtc-nct6694.c                          |   8 +-
 drivers/rtc/rtc-nvidia-vrs10.c                     |   5 +-
 drivers/rtc/rtc-omap.c                             |   5 +-
 drivers/rtc/rtc-pcf2123.c                          |   5 +-
 drivers/rtc/rtc-pcf2127.c                          |   2 +-
 drivers/rtc/rtc-pcf85063.c                         | 141 +++-
 drivers/rtc/rtc-pcf8563.c                          |   5 +-
 drivers/rtc/rtc-raspberrypi.c                      | 278 +++++++
 drivers/rtc/rtc-rs5c372.c                          |  56 +-
 drivers/rtc/rtc-rv3028.c                           |   6 +-
 drivers/rtc/rtc-rv3029c2.c                         |   9 +-
 drivers/rtc/rtc-rx8010.c                           |   4 +-
 drivers/rtc/rtc-rx8025.c                           |  12 +-
 drivers/rtc/rtc-rzn1.c                             |  52 +-
 drivers/rtc/rtc-s35390a.c                          | 483 +++++++++---
 drivers/rtc/rtc-stm32.c                            |   4 +-
 drivers/rtc/rtc-sun6i.c                            |  23 +-
 drivers/rtc/rtc-x1205.c                            |   4 +-
 drivers/soc/ti/pm33xx.c                            |   2 +-
 include/linux/mfd/mt6397/rtc.h                     |   7 +
 include/linux/rtc.h                                |   5 +
 include/linux/rtc/rtc-omap.h                       |   2 +-
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 tools/testing/selftests/rtc/rtctest.c              |  60 +-
 59 files changed, 2100 insertions(+), 739 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/ricoh,r2223x.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/sii,s35390a.yaml
 create mode 100644 drivers/rtc/rtc-raspberrypi.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
