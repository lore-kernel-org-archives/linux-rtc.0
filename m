Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86C337BBD
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336263; cv=none; b=XJ0xEHT7Qood5j/5ylViU/qP0P3ZEEr028H6I/FRAn0ylQ5OBDh5XmRw6aua4WKDVk9afGrfIsXPAiY1lfyb7lHBZqSll14TJ9axZjoLR21kr8ILa04hrYXhgSJ+aeIOIRH5rw7l1iLW1HCEbhiwoOPWtsXASsQgxlQLxSk8xOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336263; c=relaxed/simple;
	bh=xRbrP2eD9E7EByFwpgV/lYFTol0PMFEEMAgvqN4yRm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plyPki9y8YKsC1RnVRMF7RsYUtcafli5mbTc61c2pK6W/XDubgPFnjXCaR9ilDw/s1mZdyGWcn1O87lf/Y/OZZV1Eejo/P2NhFJ4EkivVZ+vIwVGkRgh6pZNZy/3NTHm/+nnBwt54D0S/THPqgIphpRtmJSQdIYb0oeAPVQ4g/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwGEeVcQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwGEeVcQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so803837f8f.1
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336259; x=1792941059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=KwGEeVcQwepLVz3SC1MSELvXhg55cvyt/OlWfSXbAhnqNFOQsc4sPepRgPJpcdl8Bl
         eYRc9++22lrwal+QHo7TY6Nj2FXwgDW9HcILNba7lHIQ3mNPxonXxb4D2ugQIiR8M9iP
         bpGNNm7AIrHoebI84ac3ZTUS0X3UsP/wCuAVcjpcSE0nx6Gmn0b32/x9UvcCTa1rDmBs
         Z0kQxnKOJeRdEcfxH/pSE7mItoSYhiSTzyfTYZ4X+QwcrPj+UuLIc+2ZnupV67DNZgpN
         cvUv0npyU7x44zsaEk7NxrpNpbg78JnDqU1Sqz94F5mzv/gr7rtXCp4GZSDqORihab0Z
         tJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336259; x=1792941059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaMWXGY4wl0wzFsEiSc/F+H9DwdFVduiP9XS0WHG/PE=;
        b=z0GnAYmtriLXxEIf0S67twyV+BiismGkjv9Km8LCOnbgy77UMzA3sLGmpArWbVzW4b
         7G3zUE5DXMoyxNC09QWr7A3n3fcxg9YhlDhl0pwoNUEiL4obZK6kABWDJDk699R0dJxS
         bbSB659oNIv0jL8rxlKAC33gzPZcgZQ/03fbDPiN/vN87N/kpIfr4krxbA6KFxqrUFII
         CCf95j3DOy6sm0mXGX9mJYteFx5ein7PmMidFd9igE3fwhcjXo7tFaflr7dg1Wr/Nhpv
         2TAyAdJjR0EQxtU1LhGMUqQrTj4R3hFawrd3GnMuMcrR+ch7rXx+4Fl/b3srqrXAd18t
         jozA==
X-Forwarded-Encrypted: i=1; AKwUvBzGf6PGeJHLpQLJaIS1PsXSTTvv5WJtLK/SDJwKTrFnEe1nT1Ts1tigx3VmIyXjRPsgwitVRqob39w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4qCMDXr1rEY07VdJIP8a/G6IUEc5e7uoiA8Q6RSg+O2krMzUq
	lDKB50L1+Pm1NbemthK46m/U+A/m0ENf0YXgSsWAaIL7AKCYzb2iuUsX
X-Gm-Gg: AYBFou3OYjM60NIAq9yjbsDyhXQX7+TD5Pi2fNCCOA6RMtfCWKavVWMoijQGthSe2IH
	0qQCYcfQBttwVy7SYVqq0qRqMwLK+eYXYAmHTfor9istYctZC+LBxBm6WvRTGCIHtA4nRrj2BFc
	bc4tjeAGu9jbak6HDqXxnmz3rD1x3N7KPeFclI0DPS8uTDU4HxPQRK1iSnXeHQkyu+LYAmw8Chj
	DJ99pluwT1lnLgH/Vbcu/5zJn8sPFMBA/E2656Bkyvg8TBv1xi0jJ7FCpdg/ss+Pp77SSxJCk2w
	Y9AcDEJs/6+2gv7CPqwx9ZRsxSLfzjQZhhhbCJiv6Z2GfdrYOddeI9YuI5gBd2PyRChWKOxJP6b
	ULmu0EF/jo0ULyEE4jpPawy9Q2qfLBwQJOn5ccUwcY9nxVXsBdTD9jhx51ms2yh3XkOgs+MHu2i
	D4P2SEufTpgMSE7exf3EsOE5X1RHfm5Dy83lA4bYxsKw6jNkmaTSx+GVHhAfW/mV+517rOF1yVb
	0ujnL4pk2b8KG7m26892/aSEK/XYRfMo9kqjAH0WiTKpw==
X-Received: by 2002:a05:6000:4b1d:b0:48e:eb:56d8 with SMTP id ffacd0b85a97d-48e07bb307emr8915118f8f.12.1792336258666;
        Sun, 18 Oct 2026 08:10:58 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a0dsm17743957f8f.47.2026.10.18.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:10:58 -0700 (PDT)
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
Subject: [PATCH v14 0/3] Raspberry Pi 5 RTC driver
Date: Sun, 18 Oct 2026 17:10:53 +0200
Message-ID: <20261018151056.1051330-1-sander.speetjens@gmail.com>
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

