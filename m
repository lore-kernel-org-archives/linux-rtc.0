Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9404734F7
	for <linux-rtc@vger.kernel.org>; Fri,  2 Oct 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936670; cv=none; b=KeRilN1FsKKzh8ndaGfx7hcLL1os8y0QLGtvE//TWjI9il5EJakDgGtIM7eHAQgQGMJvbPKsTbLLq64UP9HaOIYyOgcH4Gfh/eF1/oxuiFR3gXiM1aZPNU3LDL9iDr6gNuokd7Yl2GElMI+nWjNXmDRKsUKGwxC5zPXf4X8F2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936670; c=relaxed/simple;
	bh=HeEXUdktO9KuRaUQsVoZqQb0BoOKr1S1BCYes0d8csc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cM+ttCE9cbOj/UE49dZekiYEpN4J+wptT255DoC4UcEzQBMcUSjdYyMI6GgZ/Z3+rGH6ZhNQujbwSSqiV3/vlGaqYn0YMHbmiR7GpTzqDizMt4bpVeKSGW7c6lBCPDnAoU8mwzsEU3k7cI4NNKC6m4s8aSbDF+3/C2Lii7CezN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKwMZdgI; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKwMZdgI"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so2561379f8f.1
        for <linux-rtc@vger.kernel.org>; Fri, 02 Oct 2026 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936666; x=1791541466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yi+ts+54+GxWxgSe/WCnTwbV91QjI4mJzfhTrvNy+Cg=;
        b=UKwMZdgIsN/lRpJbW/OcL9e2hkPcfvl+tMPrCC6YFj1AI6M9Rn6CFIirTISlou3a0g
         FtdFrmPmu6bYOeZdoCFHRftM5/HxR9u4g4uGY55eQGvDX0uUUwfgt21YRe4XnKD8hMYx
         2AXulJtumSKByfocPlF18I/y9hx/7Rk8ZkTiu56ksLf8+Xwb4XM126TefeSRhRPMDvcK
         0HH+isTk5dqKa/SZ9KiQPqBS6zzTkiXNxgdvmvrpq3nhTypBK15rZohcdnha4QLxZAOI
         PKEMDWR1zs+74RPNrhlImaWl/c5CyI75KxRNj0Ii2kxaDA9gMOctHviIMhd1Hsld5Zkd
         xcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936666; x=1791541466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yi+ts+54+GxWxgSe/WCnTwbV91QjI4mJzfhTrvNy+Cg=;
        b=EWJxb2Ru1NRXMfZAsMQT31hNwql1tnAkZeXQx6pe2DV2wvBT6l3k0DHGolvhrw+U2q
         u8J7mWQmSJPq4Z6oaHF1SDbAHm3LYK/xhAnmcjc5g6VrZ5TGesCpVKpIQYBlMyIDvw0M
         qdmzlRcf2+sXON3gKF2Uel1cE8xG8NgrnVVY0fYe0t24CLMCCDzNYblJbvmJE7bzQ8uM
         5+M0mgkkrc9aPXPmDl+3CVhY+z+J5RHWwNy8ZtKw+uqZGPQdUVSRrbxyNUhRbEuLLEMU
         CUe7+O5fguKiJJ53jnDLdQAxt7RuKOZwJwYnb9XsjIe0Gq34qh52aaXcS6YQQkjcPuK/
         q0Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzWR0tr3+4xC+7EY+hvU5xqGR2TQk5q6j3uyoibjI/ZxUHDIa3GK6iQQK1S9953I4sd5l40LUZ6cvE=@vger.kernel.org
X-Gm-Message-State: AFuF++n5oxjSJEaLs4HVci1sfecZ6PtadiDdvWkw4HG8clyb2Nz1lFFc
	GRHhNk71oEiTBBCCXEjm+HdItu+UzRyWH518Y0PNrlS+/00xtZ1Clqvq
X-Gm-Gg: AYBFou0uUkHiSKvCxc32v5iXFjxjtzTLpjJFjyXIzKyJKEMj1QiqQuXL0/AhP3/LiJF
	/vR7IimiE0DAUmMVZ1j4muuvvmHdKLpY8qCzGyA8B179idJhvHt6dEmacIdattjtiQaBYurnCfx
	oKJh4zEBrUAs4o3h0kX3iXT3fOR8ccvxPSt4zz0K8GDa7cHU8xmA+855OgK/mNDPgKD7P9gYJEZ
	dRj2wQPlHqzGSih3TtxxA23GYlZtz6sN8k4SDAZxq2AgKw0unlkJCBmeIoAmCypUhgIwCCPO0qk
	cB/ZLFj3lx1/INdAHO6lvlkd85WZeK84r68ebZGnNne1+Kz3NbAaqIh8DrqCVAI6Gs0n+t8lUE2
	hfVyw1Nl7nZhCjaq5xnhilgrO2ViNbNZcqD3wgwQ2FaOWbKFZdSHXkZRMLFXGeTVJF2UYYUdpcx
	IW3mRixMlgbEOFUKIz5vcw0KHvfg7xV3mN9FgAp1gIKSZuGMofr8HO4cbTNyA9pB+EFeW0s1mFN
	VYBD6G8RvEmGVPGJU3Le6wwOHq80aX/Jj2OkVSG3NtAZQ==
X-Received: by 2002:a05:600c:c102:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-4a027534963mr34224645e9.4.1790936666286;
        Fri, 02 Oct 2026 03:24:26 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm99557875e9.11.2026.10.02.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:24:26 -0700 (PDT)
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
Subject: [PATCH v10 0/3] Raspberry Pi 5 RTC driver
Date: Fri,  2 Oct 2026 12:24:16 +0200
Message-ID: <20261002102419.830595-1-sander.speetjens@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 drivers/rtc/rtc-raspberrypi.c                 | 276 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h    |   2 +
 7 files changed, 322 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.55.0

