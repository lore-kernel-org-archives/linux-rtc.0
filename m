Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236A5275B8
	for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169227; cv=none; b=D8AX87Mlgi1iY8kWlS7lJNU56PkejY8T3Xa5TQSBuQpY8zcsG87rZAe9Sv7x/tB+aX7OdVNAAoP2nNCalWAY+/7moGNhGQgltqk+NnMw9bbkoWR98jsfKKEAAGe+BZ7aFplMcW68UPunKiI4iVgY6CpwdbEvec01X9y/W71S01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169227; c=relaxed/simple;
	bh=jFZ9QklyccwNP+P0t/i751eWiOibowSv0+P2kl/6mtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhKDid92oFAEgYGLmqWiad0Pl8ugFj0kmrRnTQjTnKtVqszhY9WBgfEnlEokaKs9QtuyrfDoig6TVRHsRA3xZHW9MAc/gmjFCmkdwBHRNvGCF2+Jgzo3TY1L2uU22Bjk8TYo//Hik2aBuYHFaAZXevxEiXkPjTIGs5sukusNgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4wodJ10; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4wodJ10"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d8239so6621395e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169224; x=1790774024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEL/ziy119TiL5y3r1fCl+gEEEgKmW5ZTGC1Lv1U1dM=;
        b=A4wodJ10OKE3BhoVP/wokdnaPptKp8twxnn0f9r9V2pHgjHsZa6qDrQLlrPMiDnKFG
         ItfkJ7mbDNWkvYYhBerg4a5HNn/AR290A4UcrY8527WGmZi0a20x0Y84Hd0E8GVW0NYg
         uefwfieHHsrdWQ8MJvNW8f0D0ZbyGJqbxz7Su8pSH3jfDnH3TNSBlYrmbVBxWn7dVlgV
         N8mI/KfBEy7z+7iOXCDWE6MuQyQh4bg328s1R2qVmblmvHse7JYzEecXpOz/XdrECw4j
         qsAtPkPxfAJhNrkW+Ct+zxgJiPJGOp95v1hzywh+L1YmUi/jffFWIqxWG4jJ2BuC9uEP
         yklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169224; x=1790774024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEL/ziy119TiL5y3r1fCl+gEEEgKmW5ZTGC1Lv1U1dM=;
        b=HI0RTO5F1U/b2ZdwrlnqMIO+rYR+qNXWgK3NkGstjc9uJ/2x/uDxAvJqosAGwVp8OE
         gafoMZ4pMqpjS+Z3VYC75sLay8KkCABTCJcgekfUum8+bYI4TkkS5sxJ7Hhf2J7W6BWc
         GWHWKRnVvjKIWp4mEyDVkUN/8iBVPIU3t/PN/7z6jSnBR5yYRJ34VFQxwam7kF0E/Dpe
         xygTTR0Bqvf/IX94Av4TQexZgEwi5qnuTmQBTijibkRJIWHjYvDZfrx6/7WeHUhZwxud
         tC29LTC4BMOUBwn8Qm4TMfzupSEMCNv3pOEkA7/QlHQRT/bArVt+hjCdIFUW2dFFCbx8
         9WSg==
X-Forwarded-Encrypted: i=1; AKwUvBzCxAHRJxZAFbq5BsEowkmALfpx8rCBSSRYJXP+iC98w7TpaopgsTZ++DF1BzRyj9mym7tPK1fVDM0=@vger.kernel.org
X-Gm-Message-State: AFuF++majHPjGXmSd6Wq6Bf4Qgc4QenYpoYZEBEyVfUF/13/hjtEgZ0K
	1NOS8POHikDckM1W1mRIH8FXJDoIHJSTD3RJwLUNLBmuvm1Lnr6GwUP8
X-Gm-Gg: AYBFou3GokBqy2gH6y+kyebF9RJIbnIUEqF07NFAcQKS57cFL8TIJRCFzzZpCD7RztJ
	PjC4XacLf6AwfjVyMgNW9EkIzFlIH5BS53WmHBIb6K7yNVPSXMSRQtanOe3tBATxkOWr2uvCO17
	9T/ZKcWLxnwttwlpbriqNyuKkrzUy8KEHBf9suE5zc2bM2xJwY5diEYIyyUYlEY/gmhQjvIVDGn
	JjS8V4k/IovLh/nHsrR5Qt1lIsh7SeXBPi38KySqziDLRX5MCm7c3BxN5MHDB//LxqmjWj8knVP
	KLyl4J1AYFLykYiYb8O8A1Met2VvjfCm9XgViGq2jZGcQy05i8vVjL9US9Z6/pTZRl7Bf36AMbO
	bdtvmS3VotW30WAXD0/eO+yvmG+jcLzMxFThqK506CZnMKc7udUfc1Y4d6rw4W9nwnjdZkIQmsB
	dCO/oLyVWxBQvy+8kj3usIWprd3olhXcif2y5McHYgY+EcRaM0d1MHMxuh7QNnFDu//krKy/imD
	r6+EMyoNHhzVA9qU6hDUSaJq/qAhnDHUVv/x40FPRXfXw==
X-Received: by 2002:a05:600c:1d14:b0:49f:ce73:4a with SMTP id 5b1f17b1804b1-49fdf34f0e0mr36303145e9.34.1790169223305;
        Wed, 23 Sep 2026 06:13:43 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm57230235e9.2.2026.09.23.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:13:42 -0700 (PDT)
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
	sander.speetjens@gmail.com
Subject: [PATCH v4 0/2] Raspberry Pi 5 RTC driver
Date: Wed, 23 Sep 2026 15:13:21 +0200
Message-ID: <20260923131323.1099979-1-sander.speetjens@gmail.com>
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

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |   8 +
 drivers/firmware/raspberrypi.c                |  25 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 242 ++++++++++++++++++
 5 files changed, 288 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

