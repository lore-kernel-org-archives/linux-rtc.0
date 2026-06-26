Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB093C3443;
	Fri, 26 Jun 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511354; cv=none; b=RsJdKJbsutdLNZGoLiaQeKsKUERlyD1YV0pgQ6Y66OwuwVpzhGXNMv6///TBbVz61Rd8jGYygqVmyOSAHDM+7K4OgSBRaFYJd/tsp0HMjY5YR71Z5fzdLUYo32cZynL3a9a0d7Kvl+FSm3PT9Lz7eS5fK5/nqdtVmW7W8NR5LP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511354; c=relaxed/simple;
	bh=dDJfYgE35jdkIBqLA3gv2siOUx5QHaJwoG+/QkxwgWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GuezGuoEjo6ChnPGFI7tbDESBYjbIHdplLzAfDzxobujZbe8GWLH6Kx49w1pXFZ0mX1crrvz1puqu4jwIWmH8HVtPq1Ia02piJJDZwz71tMvGx8SZJ4Cj58O7DLdNTZrJSjzAKylpLVSJC1j6E+mJ5NtvlYROJy8lq8TAtH8fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=peE07De6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="peE07De6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7582C4E40979;
	Fri, 26 Jun 2026 22:02:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2857D60232;
	Fri, 26 Jun 2026 22:02:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE13D106F1124;
	Sat, 27 Jun 2026 00:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782511347; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bjL0fER4T+IcW+0u2A4DJ4JHP0FMNPWHt40mOPjxjpk=;
	b=peE07De6mwkmBCuhB1kU94gjojg79+gVHzliTS9E6a4pfOS90BppTv1FTZnSAFt1UP5gav
	4WjH98d+y79wdNqJU5WKjKGJ+9MWUGT3eBaWMcuYpNDb18bSWnbTiP8pWeZ/fnMmxp2CFu
	N4z9NGxu4w2BVibHh7D73xvlFSrLocsxUELeg82AJf0rxcAlEZATY/M9gGlwb/gbJvSXzI
	rVteVjU/uq0/PUO5ZNf5RAUjVKzCt6Uh3nTtx/dq6WMy6bweyCCWN1GGBJHOSFxn8K0XCw
	P2Lk3CSixznV+HGU987cTquTOHL1DyshjDxzwNa6kviR4tkE2uipUbL5GNBObw==
Date: Sat, 27 Jun 2026 00:02:26 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 7.2
Message-ID: <20260626220226c3609b27@mail.local>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Linus,

Here is the RTC subsystem pull request for 7.2. Most of the work and
improvements are for features of the m41t93. The ds1307 also gets
support for OSF for new variants. The pcap driver is being removed as
the Motorola EZX support was removed a while ago.

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-7.2

for you to fetch changes up to 3c8f28578a0d68bc7fb91d881b832d55f734270c:

  rtc: ds1307: update reference to removed CONFIG_RTC_DRV_DS1307_HWMON (2026-06-25 14:44:39 +0200)

----------------------------------------------------------------
RTC for 7.2

Subsystem:
 - add rtc_read_next_alarm() to read next expiring timer

Drivers:
 - ds1307: handle OSF for ds1337/ds1339/ds3231, add clock provider for ds1307,
   fix wday for rx8130
 - m41t93: DT support, alarm, clock provider, watchdog support
 - mv: add suspend/resume support for wakeup
 - pcap: remove driver
 - renesas-rtca3: many fixes

----------------------------------------------------------------
Adriana Stancu (1):
      rtc: bq32000: add delay between RTC reads

Akhilesh Patil (7):
      rtc: ds1307: add support for clock provider in ds1307
      dt-bindings: rtc: Add ST m41t93
      rtc: m41t93: add device tree support
      rtc: m41t93: migrate to regmap api for register access
      rtc: m41t93: Add alarm support
      rtc: m41t93: Add square wave clock provider support
      rtc: m41t93: Add watchdog support

Alexandre Belloni (1):
      rtc: s35390a: fix typo in comment

Antoni Pokusinski (1):
      rtc: abx80x: fix the RTC_VL_CLR clearing all status flags

Arnd Bergmann (1):
      rtc: remove unused pcap driver

Conor Dooley (1):
      rtc: mpfs: fix counter upload completion condition

Ethan Nelson-Moore (1):
      rtc: ds1307: update reference to removed CONFIG_RTC_DRV_DS1307_HWMON

Fredrik M Olsson (2):
      dt-bindings: rtc: ds1307: Add epson,rx8901
      rtc: ds1307: Fix off-by-one issue with wday for rx8130

Haoxiang Li (1):
      rtc: cmos: unregister HPET IRQ handler on probe failure

John Madieu (1):
      rtc: isl1208: Balance enable_irq_wake() with disable_irq_wake() on cleanup

Lad Prabhakar (5):
      rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path
      rtc: renesas-rtca3: Check RADJ poll result during initial setup
      rtc: renesas-rtca3: Fix incorrect error message for reset assert
      rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
      rtc: renesas-rtca3: Factor out year decoding helper

Mario Limonciello (2):
      rtc: interface: Add rtc_read_next_alarm() to read next expiring timer
      platform/x86: amd-pmc: Fix S0i3 wakeup with alarmtimer

Maxwell Doose (1):
      rtc: ab8500: replace sprintf() with sysfs_emit()

Ronan Dalton (1):
      rtc: ds1307: handle oscillator stop flag for ds1337/ds1339/ds3231

Stepan Ionichev (1):
      rtc: msc313: fix NULL deref in shared IRQ handler at probe

Tommy Huang (2):
      dt-bindings: rtc: add ASPEED AST2700 compatible
      rtc: aspeed: add AST2700 compatible

Udaya Kiran Challa (1):
      dt-bindings: rtc: epson,rx6110: Convert to DT Schema

Uwe Kleine-König (The Capable Hub) (4):
      rtc: Use named initializers for arrays of i2c_device_data
      rtc: Drop unused assignment of platform_device_id driver data
      rtc: ab8500: Simplify driver_data handling
      rtc: Use named initializers for platform_device_id arrays

Xue Lei (1):
      rtc: mv: add suspend/resume support for wakeup

Yahya Saqban (1):
      rtc: interface: fix typos in rtc_handle_legacy_irq() documentation

 .../devicetree/bindings/rtc/epson,rx6110.txt       |  39 --
 .../devicetree/bindings/rtc/epson,rx6110.yaml      |  68 +++
 .../devicetree/bindings/rtc/rtc-ds1307.yaml        |   1 +
 .../devicetree/bindings/rtc/st,m41t93.yaml         |  50 +++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |   2 +
 drivers/platform/x86/amd/pmc/pmc.c                 |   9 +-
 drivers/rtc/Kconfig                                |   7 -
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/interface.c                            |  44 +-
 drivers/rtc/rtc-88pm886.c                          |   2 +-
 drivers/rtc/rtc-ab-b5ze-s3.c                       |   2 +-
 drivers/rtc/rtc-ab-eoz9.c                          |   2 +-
 drivers/rtc/rtc-ab8500.c                           |   8 +-
 drivers/rtc/rtc-abx80x.c                           |  23 +-
 drivers/rtc/rtc-aspeed.c                           |   1 +
 drivers/rtc/rtc-bd70528.c                          |   8 +-
 drivers/rtc/rtc-bq32k.c                            |  11 +-
 drivers/rtc/rtc-cmos.c                             |   6 +
 drivers/rtc/rtc-cros-ec.c                          |   4 +-
 drivers/rtc/rtc-ds1307.c                           | 207 +++++++--
 drivers/rtc/rtc-ds1374.c                           |   2 +-
 drivers/rtc/rtc-ds1672.c                           |   2 +-
 drivers/rtc/rtc-ds3232.c                           |   2 +-
 drivers/rtc/rtc-em3027.c                           |   2 +-
 drivers/rtc/rtc-fm3130.c                           |   2 +-
 drivers/rtc/rtc-hym8563.c                          |   4 +-
 drivers/rtc/rtc-isl12022.c                         |   2 +-
 drivers/rtc/rtc-isl12026.c                         |   4 +-
 drivers/rtc/rtc-isl1208.c                          |  25 +-
 drivers/rtc/rtc-m41t80.c                           |  22 +-
 drivers/rtc/rtc-m41t93.c                           | 488 ++++++++++++++++++---
 drivers/rtc/rtc-max31335.c                         |   4 +-
 drivers/rtc/rtc-max6900.c                          |   2 +-
 drivers/rtc/rtc-max77686.c                         |  10 +-
 drivers/rtc/rtc-max8997.c                          |   4 +-
 drivers/rtc/rtc-max8998.c                          |   4 +-
 drivers/rtc/rtc-mpfs.c                             |   2 +-
 drivers/rtc/rtc-msc313.c                           |   4 +-
 drivers/rtc/rtc-mv.c                               |  23 +
 drivers/rtc/rtc-nct3018y.c                         |   2 +-
 drivers/rtc/rtc-pcap.c                             | 179 --------
 drivers/rtc/rtc-pcf2127.c                          |   8 +-
 drivers/rtc/rtc-pcf85063.c                         |  12 +-
 drivers/rtc/rtc-pcf8523.c                          |   2 +-
 drivers/rtc/rtc-pcf8563.c                          |   6 +-
 drivers/rtc/rtc-pcf8583.c                          |   2 +-
 drivers/rtc/rtc-renesas-rtca3.c                    |  26 +-
 drivers/rtc/rtc-rs5c372.c                          |  12 +-
 drivers/rtc/rtc-rv3029c2.c                         |   4 +-
 drivers/rtc/rtc-rv8803.c                           |   8 +-
 drivers/rtc/rtc-rx6110.c                           |   2 +-
 drivers/rtc/rtc-rx8010.c                           |   2 +-
 drivers/rtc/rtc-rx8025.c                           |   4 +-
 drivers/rtc/rtc-rx8581.c                           |   2 +-
 drivers/rtc/rtc-s35390a.c                          |   4 +-
 drivers/rtc/rtc-s5m.c                              |  12 +-
 drivers/rtc/rtc-sd2405al.c                         |   2 +-
 drivers/rtc/rtc-sd3078.c                           |   2 +-
 drivers/rtc/rtc-tps6594.c                          |   4 +-
 drivers/rtc/rtc-x1205.c                            |   2 +-
 include/linux/rtc.h                                |   2 +
 61 files changed, 961 insertions(+), 441 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/st,m41t93.yaml
 delete mode 100644 drivers/rtc/rtc-pcap.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
