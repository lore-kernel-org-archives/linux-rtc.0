Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74113CB551;
	Thu, 27 Aug 2026 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869651; cv=none; b=LxPQj3N0a+NXGvyMnwzYPiJbeskrA9XLbUv2DEtdjUr/2hdUl6EGPOGx1I36ANFSZ1/N7FIZd62rNb2Q0bgVzbQimDsOeCzVjica8i+u4KGOL+i80IRIRQR39sLcPa3fLSkhg2kPiNNijt06MV9zTGxw28OsG31cQz6EXOLYmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869651; c=relaxed/simple;
	bh=gtlRShEerTmXLVaNSdAoVPjPTYg+EfMoVtC2sJsIRyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WHm/+8epoS9YQIYoJMyLElBGiHsZEZ5oLZ9JR+fmCZGnRrhQMVf0KcooWAb7oEqK4qwUeddbK4ebelGzOozqOL7MQqlSPn0ad0vcoWbqaMc9KCpv4R8KQuqjXygWzbruewKwrZqmYrhpvIavls5UsDR5VLwzHcxMOGDs5mzDQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mw9BkywE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mw9BkywE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B390C1A1888;
	Thu, 27 Aug 2026 22:27:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 610DF5FFF4;
	Thu, 27 Aug 2026 22:27:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1933811C7801A;
	Fri, 28 Aug 2026 00:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787869633; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=XppBOrI9ALRujrEJWF1HE2DUDoS/W8T8anKZvDrtxJY=;
	b=Mw9BkywE9YkZmBDBnTxoNAFB/nZkakGJvgcw+c1OSkblB+WkjCeixZUFJRQZ0ethvK0aHS
	TRn+gGE3xJTl9e6Iv0NYFrORl0bt3hhlP23gYB0SOdcguR1Bk7vx/s72X2YPJrcKUkKOfK
	rZSx4QPGzO8kOV9SHwDYI6RfFX3jWbJ/WRiARVHVQsz0K7oSJI+lAUxSvbCP0GOgJJiJHj
	zs3Jtid3hePVihSJ972xcLBqmhJR0kTMkblJ4LSpr6C6xcjuWhyhQHQoDt9j50hyHrLUAQ
	/7jIASj2krD08EqOLvSxva1Kiaw+0zG9zL/HnP0Kb1DGJd3AyNXFAhX8sH/hIA==
Date: Fri, 28 Aug 2026 00:27:12 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 7.3
Message-ID: <202608272227121fa40dbe@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello Linus,

Here is the RTC subsystem pull request for 7.3. The RZN1 driver got a
fairly comprehensive cleanup. More DT binding are converted to DT
schema, leaving only 5 remaining files to convert.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.3

for you to fetch changes up to afce9701d6423a63194a349d2f1e34c50ce76482:

  MAINTAINERS: update rtc subsystem patchwork location (2026-08-27 23:35:24 +0200)

----------------------------------------------------------------
RTC for 7.3

Subsystem:
 - patchwork project is moving to kernel.org
 - fully initialize clk_init_data
 - add missing MODULE_DEVICE_TABLE()
 - DT bindings conversions to DT schema

Drivers:
 - ds1307: fix WADA bit for alarms on RX8130
 - rzn1: add support for RZ/T2H and RZ/N2H, many fixes

----------------------------------------------------------------
Alexandre Belloni (3):
      rtc: mv: fix potential race condition
      rtc: mv: remove mv_rtc_remove
      MAINTAINERS: update rtc subsystem patchwork location

Bhargav Joshi (1):
      dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

Cosmo Chou (1):
      rtc: pcf85363: Add error checking to regmap calls in probe()

Daniel Palmer (1):
      rtc: msc313: Select by default on MSTARV7

Eduard Bostina (1):
      dt-bindings: rtc: Convert TI Palmas RTC to DT schema

Geert Uytterhoeven (5):
      rtc: hym8563: Make sure clk_init_data is fully initialized
      rtc: m41t80: Make sure clk_init_data is fully initialized
      rtc: nct3018y: Make sure clk_init_data is fully initialized
      rtc: philips: Make sure clk_init_data is fully initialized
      rtc: microcrystal: Make sure clk_init_data is fully initialized

Jack Lee (1):
      rtc: ds1343: replace symbolic permissions with octal

Lad Prabhakar (17):
      dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H and RZ/N2H support
      rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
      rtc: rzn1: Fix weekday underflow when alarm crosses month boundary
      rtc: rzn1: Handle unset alarm weekday in rzn1_rtc_read_alarm
      rtc: rzn1: Fix alarm range check truncation on 32-bit systems
      rtc: rzn1: Disable alarm interrupt before reprogramming alarm registers
      rtc: rzn1: Fix malformed MODULE_AUTHOR string
      rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
      rtc: rzn1: Use pm_runtime_put_sync()
      rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
      rtc: rzn1: Dynamically calculate synchronization delay based on clock rate
      rtc: rzn1: Use temporary variable for struct device
      rtc: rzn1: Consistently use dev_err_probe()
      rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
      rtc: rzn1: Add OF match data to gate SUBU register access
      rtc: rzn1: Drop trailing comma from OF match table sentinel
      rtc: rzn1: Add support for Renesas RZ/T2H and RZ/N2H SoCs

Linkai Gong (1):
      rtc: gamecube: check return value of devm_rtc_register_device()

Pengpeng Hou (4):
      rtc: zynqmp: Return optional clock lookup errors
      rtc: s32g: add missing MODULE_DEVICE_TABLE()
      rtc: brcmstb-waketimer: add missing MODULE_DEVICE_TABLE()
      rtc: ab-eoz9: add missing MODULE_DEVICE_TABLE()

Robert Leussler (1):
      rtc: ds1307: fix RX8130 wakeup alarm WADA bit for day-of-month mode

Rosen Penev (1):
      rtc: st-lpc: get IRQ via platform_get_irq()

Sang-Heon Jeon (1):
      rtc: pcf2127: remove conditional return with no effect

Surendra Singh Chouhan (1):
      rtc: spacemit: handle regmap_test_bits() error return

Teja Sai Charan Bellamkonda (1):
      dt-bindings: rtc: Convert rtc-cmos binding to YAML

Udaya Kiran Challa (1):
      dt-bindings: rtc: microchip,pic32mzda-rtc: Convert to DT schema

Yi Ding (1):
      rtc: pcf8563: fix clock provider leak on unbind

 .../bindings/rtc/microchip,pic32-rtc.txt           |  21 ---
 .../bindings/rtc/microchip,pic32mzda-rtc.yaml      |  50 ++++++
 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml  |  35 +++-
 Documentation/devicetree/bindings/rtc/rtc-cmos.txt |  27 ---
 .../devicetree/bindings/rtc/rtc-cmos.yaml          |  63 +++++++
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 ------
 .../devicetree/bindings/rtc/rtc-palmas.txt         |  32 ----
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 140 +++++++++++++++
 .../devicetree/bindings/rtc/ti,palmas-rtc.yaml     |  57 ++++++
 MAINTAINERS                                        |   2 +-
 drivers/rtc/Kconfig                                |   8 +-
 drivers/rtc/rtc-ab-eoz9.c                          |   1 +
 drivers/rtc/rtc-brcmstb-waketimer.c                |   1 +
 drivers/rtc/rtc-ds1307.c                           |   2 +-
 drivers/rtc/rtc-ds1343.c                           |   4 +-
 drivers/rtc/rtc-gamecube.c                         |   4 +-
 drivers/rtc/rtc-hym8563.c                          |   2 +-
 drivers/rtc/rtc-m41t80.c                           |   2 +-
 drivers/rtc/rtc-mv.c                               |  41 +----
 drivers/rtc/rtc-nct3018y.c                         |   2 +-
 drivers/rtc/rtc-pcf2127.c                          |   7 +-
 drivers/rtc/rtc-pcf85063.c                         |   2 +-
 drivers/rtc/rtc-pcf85363.c                         |  17 +-
 drivers/rtc/rtc-pcf8563.c                          |   6 +-
 drivers/rtc/rtc-rv3028.c                           |   2 +-
 drivers/rtc/rtc-rv3032.c                           |   2 +-
 drivers/rtc/rtc-rzn1.c                             | 197 ++++++++++++---------
 drivers/rtc/rtc-s32g.c                             |   1 +
 drivers/rtc/rtc-spacemit-p1.c                      |   5 +-
 drivers/rtc/rtc-st-lpc.c                           |   9 +-
 drivers/rtc/rtc-zynqmp.c                           |   7 +-
 31 files changed, 507 insertions(+), 295 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,pic32mzda-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-cmos.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-cmos.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-omap.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
