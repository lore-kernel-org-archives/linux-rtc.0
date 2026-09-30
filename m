Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE12DC791
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761931; cv=none; b=VGbeFaMu1lEU2QpRvHv4M/Mq57nU4gF3I8F0d+WuxZkTYbxyqO/ZDm2ahkiBz3+UOZVgYzLDZPVuMWgm8CJsKPcSLBUGFOpOeSqDZn2Hc439Yn7LCB3vpkFfJ2K5VhnJev6OOZpEfzs1FHfPEgF0pP5uT17qsn/31lMEQvAW+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761931; c=relaxed/simple;
	bh=e5J8Isd+ivv6vNFvneGjdbqRHB4zDbqy1EFTktYGCI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKTTzGfuNkrLXexeX4X2Q2FF8fH5Tea1PaWczL0YTLtEZYSpdwm9Xf1NuO4E/W4aot6b8xb5GBgOr9RzMEIl2y0Iz8RA4kzdmEbsx+1frm7iXkUX8Cb1s3+Oao0eAuXy0tDhnCO/MXHwPMZS9NbR8GSO9M9PFS58WsQ0zoTaMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy6YFADd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy6YFADd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so38419165e9.1
        for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761925; x=1791366725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGyaJVivWNa7+BTJdqSgJRNH8LjXxwlOXt4JHsGvrnY=;
        b=Uy6YFADd0JKxz0dGEkyyovRgqRssT3ntYJuwI1MuBx31GcLdtMf2RRIhMhWTyF+AjN
         nNDF7/E0WXBEwG3gcIbYA48zIGeT2iYEadJ+55Xzcef8osrZYIgZW61il2KXSnuHPVy3
         OZv6eZslKENOrljToVod452s/13/GksyPJkRbaQbMqO5xpRc5OjnNate5SkfvYmtEzD/
         CCINQCbM/iOHlD3CRVbwXItvQeyNKcCpRgiTt9Dp1TIM3wJF6j8ef2+ZOJhCU70bgWVm
         TYHTHNALJZF6wQpVcFl8aDts6SKxzwWlQWlEuwAihLiT0r/w8KeMccXKlQY6dWhQ+b8a
         djlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761925; x=1791366725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGyaJVivWNa7+BTJdqSgJRNH8LjXxwlOXt4JHsGvrnY=;
        b=xBKeWKUe1bgHo34TDR5in8qnitxbLVrK0USHve6SulfW3pF7/Il9AjpGT3V0OQ/uiu
         opPlJnFhsK0Ty3BQezBqSxbb2YenWtx72C02eBVmJHE2dTZ7iJE+gxfz8GHDCezUwJ24
         Wprh5EXbVaCO2FHtiz1SqfBnAQyz8bjmcOOrYTpwQ+Z+29c5uG0MpgVtbMi8JyUAND0P
         embOc/GOyoAPD0qzVMDxMJcVGRIXjyZvpt4wYUI5fgArF/WnKCHSU4r059SVGAKzaa6O
         xGyTa7N+R2VWPx3wCSuPvhABh0zyO4Q+kPlO9pqndXaFrYwPis0iOlLRgp/oQZzLQdBO
         xQCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgWYYa3lD6c6q1SqfQ9rs0n4W70EipvcB7ZPifhRZJBXr65uN7n5y7X9eyiOSiiIW8Og28axwmJoc=@vger.kernel.org
X-Gm-Message-State: AFuF++llkGVw9wlWIpEL+WCB5fs4wwMiuVYMpyuOsa5G9rEUzIsBa+w5
	QyJYyeaVuGfr7lEfl2up6RvGrfi07QXtPa8AWICu05vh3jvJqInM5+VN
X-Gm-Gg: AYBFou0EyMC6/JCHg/WlqKWFN8tLiMN9dumQvFztGCm7XC+3ZolFmLEVFqEQ4uhxwTR
	q8GtCgVMumsn11ojIPQROWG/gex9zFTy+AFJni8qfKdy1jbG/5Mm+/YKGDWLujBhIObqjQqCb2d
	Fq/2QC0kylvkyELDvdCMhsOq4+o2bx9bmtEMD6RSHc3JfhtjSKHz+dn3Ce6FV1yZJISN2k+oFF+
	cwHX/xchcK7gFNdn+L8XURROCFLuHxgZYnYs0OFKDN/d/klyNh3eVZ1jZ+OjB2CE4AUUCRFDHRJ
	I3rKBtO49rZ92COrXa4Vacj4kp0MJD4h/eQle8QwcMuYn8TRWfbO7Lppl1a97GHS1rune5aReB/
	etcNqEta/ABk2E12UGpvTilcUtViYQoHUag+mM2Lc3dBd0vTqb87/2UhTZAq/+OAdRX4QBf3QYP
	lDbE40XHRipqMv03vMxF7woWKOq39qywlh/CCOcBHBtg23dcShzLiDk5jkk+GS7gSpzkcaWONYz
	xEC15iqtKdvspvBfFxjMebIdi8FIXKYtMa8iOhEREvPISk=
X-Received: by 2002:a05:600c:8b21:b0:4a0:1b8d:3e58 with SMTP id 5b1f17b1804b1-4a01b8d4099mr9189045e9.14.1790761925200;
        Wed, 30 Sep 2026 02:52:05 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015abd9ffsm43859655e9.2.2026.09.30.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:52:04 -0700 (PDT)
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
Subject: [PATCH v8 0/2] Raspberry Pi 5 RTC driver
Date: Wed, 30 Sep 2026 11:52:01 +0200
Message-ID: <20260930095203.492949-1-sander.speetjens@gmail.com>
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

Sander Speetjens (2):
  dt-bindings: rtc: Add property for Raspberry Pi 5 RTC
  rtc: Add Raspberry Pi 5 RTC driver

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   6 +
 drivers/firmware/raspberrypi.c                |  23 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 279 ++++++++++++++++++
 5 files changed, 321 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

