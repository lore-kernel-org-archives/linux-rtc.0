Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14534CCE
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335634; cv=none; b=NGfP8EMA35/eFFRa0xVxT1gYyDgL1MrXQWCJBMv1x44D+DJsqbqIar6p01Zavtk4XlZ8+keXfjPYT6lsh/P2qhxOn9f2um3nZZNTWvkiM2KNEkJzTxsDRCPLwMtkcHKb67iAOSWIhygkTZ/++McZ5/3UoKsae1c8FuSQMF7nZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335634; c=relaxed/simple;
	bh=xRbrP2eD9E7EByFwpgV/lYFTol0PMFEEMAgvqN4yRm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9tLTHjfVdyUnRTuWtvkuiAfahdvrwpdQC7OVrsEMeC4mqKdTzzU+ZmVluuifRuo1B2QhHPQgRPhPRVyJu6/Yp0o66hvCsL11rB207o40U1VQmp6oocEwqpqfREtOpk6iAa1qo7NiShV8bYKXZmNp1kV3qhwu7AGXxR2jyRoQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAbOKMWr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAbOKMWr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso752856f8f.0
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335631; x=1792940431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=JAbOKMWrojlBhoiJxEKOC/G4S3wJv9zZy+Wb0ivUempI8yBF7fvn/FkTxBzyUCLctH
         Xxh1C+xIaMDGro5zd4lhBLI3JFz09R6hrhUGK8yzgH4UVtg7UjxGxLsv9AVZDAqsoaJg
         T7HR827kyxphZwwAjs/fLcmLEATU21exfV0TzkzwBb4sNoralEWR3zmtxuD5YRReRIOg
         0kZYq3H4EdXx77OuPViCjQkm7YCXtu4wRU36rBtgTRnRVdP/Po3Q+DLo31vRKejHf1st
         O+DiZX27+ec7P10iNbX/LpyVNZdw1wT1GBnl8+ktE4Ec7K0A3/TAu/k66IgwKh2mdxUu
         dV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335631; x=1792940431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=ZxACiluH3XhzxRneoEdUobQLT5+8qWNMWhBmP1gbTCBtRDEL69XcRnuzkXP/zYNEeQ
         D/EoWis+KZV7O3Uz0GxXk5M4KRcml5H/gL9safV7dokYdvh6wrycL+toifTPEOaTTjri
         DFxQCkdkg9oN0fi40VSO1t6OiGjJZHl/twAI3aZ2BDtR0v2IE2EupQjSa9DGYiwf9Kb+
         m/TpflXBmmvbqLnPHHDKYGcZzDGAHPGBeOVjnSk1rnV1eHbYYheKvq9H/8Y334ZvhA9z
         1UWa4kRR/u4LoICDz9aM8208qKeAjDDhgl07eR+de7r5d15mBmCDAt0aXPsvbbv4KFOU
         idVA==
X-Forwarded-Encrypted: i=1; AKwUvByvnFmgWrgusbOEJIgR9YOqRdPJudGgNYeOdsE+aQ7ncr5w/ppnUfNPBKs5wjjAkzoO3jnfxapEeig=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPbrXUbxNaIi2WLy5jtVneJpwA7huweunaN9+qADBBpWlURiJB
	ueZXzzMizFCG0WbJx3fpAU52iJpDKK9IxmCLtqb6x70hH8Td9Wgx2KOE
X-Gm-Gg: AYBFou2NENGv9ZCthMdzvuwtKqe/pJghPyD7DizpVlJvVO/mapdn+O5rv/OkNeJp4Eg
	oilunSGcphXuQ+VAvoqi3E9/GYbOtecGuPil7IfFneJ7K5CSBhCx4QOOOrJKLm3QvPw8UFNEEsm
	sXD3CeaSipfn+SIopeLqkMDshHdA9z/ELFvN8jty1ZlBat7tiqstZaRY1M1JInmrjjJ8WgQs2Z9
	qKQ1IXIoeenFN7l01YK3tQJrqtYt5bRehJPx2FLJoTjdF2R/GdTqMne/Pu5Nnh+GjghQmYS6wvL
	6guCi1HkB3YGt2P+PF0GAwIQGvRzViDDmzdOgwXO+bv5o4nhl64UI4vfFe5wx2fCXG3zkyI80Uk
	M2qMo4lIkM3eTJrMlp063ujttTD++M3SP2/s5Lnj5MPPT7m8HQ4mUk4nTVhAicqh/6BWU7p1Jr2
	ERsDwYNU1PsAridUoKaSeyXEY92m0ZRMNrZQmbYzOcqhRNb11BnUQwIBUOU26SGsBqAT3sq470i
	vW1bTPlHacVChCUw7dNvweOspB9XlZIAwJXm1tMOHK/IQ==
X-Received: by 2002:a05:600c:c170:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a1d76060a7mr97201485e9.20.1792335630619;
        Sun, 18 Oct 2026 08:00:30 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm212868925e9.3.2026.10.18.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:00:30 -0700 (PDT)
From: Sander Speetjens <sander.speetjens@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sander.speetjens@gmail.com,
	pbrobinson@gmail.com
Subject: [PATCH v13 0/3] Raspberry Pi 5 RTC driver
Date: Sun, 18 Oct 2026 17:00:25 +0200
Message-ID: <20261018150028.1047172-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 has a battery-backed RTC located
on the DA9091 PMIC accessed via the I2C bus[1].
Access to the RTC is provided exclusively through the VideoCore firmware
mailbox interface (not via a direct I2C register interface).

As stated by jamesh on the Rasperry Pi forum [2],
"There are no plans to release a public datasheet for the DA9091."
So we are stuck with the firmware interface for now.
PhilE also states that "The firmware needs full control of the DA9091,
sometimes with extremely low latency,
otherwise there's a risk the supply could just cut the power."

This series adds:
  - a DT property for the charging voltage of the RTC battery
  - the RTC driver that talks to the firmware

The driver and binding are based on (and largely taken from) the
downstream Raspberry Pi kernel. The main changes for upstream are
the addition of a dt binding property for setting the charging voltage and
binding the driver from the raspberrypi-firmware driver instead of from
the DT.

The driver supports time read/write, alarm, and optional trickle
charging voltage configuration via the device-tree.

Testing
- Hardware: Raspberry Pi 5 Model B revC
- Kernel: v7.2
- dt_binding_check: passed
- Basic RTC operations (read/write time, alarm) verified

[1] https://www.raspberrypi.com/news/introducing-raspberry-pi-5/
[2] https://forums.raspberrypi.com/viewtopic.php?t=359073

Sander Speetjens (3):
  dt-bindings: rtc: Add missing type to trickle-voltage-millivolt
  dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
  rtc: Add Raspberry Pi 5 RTC driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   6 +
 .../devicetree/bindings/rtc/rtc.yaml          |   1 +
 drivers/firmware/raspberrypi.c                |  24 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 278 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h    |   2 +
 7 files changed, 324 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0

