Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AA4A2A76
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966635; cv=none; b=onkivquvEdUScfMoEeSSkKblMH+Ycwk10IZ5wdI0+p71izXZYehbcYyoIy3FpwgF6h/Nqsyo74BMKyhwq86WYv8cWJ0bqwn5f5OQUjdaeLPpn7XE9MvY1JiqGN3Wrj+Kg3kCKtx2xISwxBSk+tTwzLyjBWHXzlQK94y/w7uaZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966635; c=relaxed/simple;
	bh=R4rmzB0tpot0BkFidDBKSzcVNityaJcRd26Z65Qgp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ne5X42icmAyOMOXC++Cgs6CUQsqHpZQekit5m7hTqWT38XXlonhdeh3IwcuQs4J48+9zcZC+EeJJTd7+NQqxMrqXvdggiJpx5GmSbZEd0WcHePZEyE8KCK6ssSq8ShSkMLEFgSDJIOFWFlAVbwH5q60+oEP+x08YuRn2zFMJ9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCskCYYp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCskCYYp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so5973245e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791966631; x=1792571431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cQrhVOMwNqoVIytixPfhP0MphHNQ9fMhJFoWlxHFbYI=;
        b=RCskCYYpuPbtAPIA5AKz4DKFvNu5RgTeCvoHJ+tWs1cxmZ0ydv1K2B4JA+UV2jmP9N
         9uYxouI/CMVFrA+DeXT6YcBey1gcwZ5njYqjRdLkA/De8J5sw2iyvV+xYhenZ19Wxybp
         I0/5f8FY/OHhFGIsyY4IBRv/fjAOMu/W9CtXB6MAt2oxjG5Dc2ITPKaTddQkfMiziO9j
         ipvEKE2hR9w594VxmgGuVk51sUaVko6SKp1bHs1I11egIwZMXm9fj8FPbXH8nQQNxr1I
         2xlR+YVO+SthZdCWPf5uGHwcPYHS3K8KFhe+YOpFlHbAiO2kTWYzRH0EFAcB0XB2/r7O
         X5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966631; x=1792571431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQrhVOMwNqoVIytixPfhP0MphHNQ9fMhJFoWlxHFbYI=;
        b=jXt6YZqfNB6xcLLCc8BIZcDwVfjZVSEkfgi6gV5x1J1TZ3pPFm7WU+p6H1hqjRwW3U
         yp4kz3CJrjTsFNCZsZI33VwJkGSWOGCqtyV7TR8xcKEZ4YeEdw7H3Xpl/9NXg17c2ujD
         FsZOS6fmGPR3efecXe0Hxd7FImzvSMD4uUa8Qume76MG6a7CxXU76TvvdQilvx0MMVbw
         EiRA8VSmshRPi2/nk9WBv8sP8nV61tG7RQZwQlUhqeuGXUvC4oDCrVv31quEq3J3P3xt
         WYzjSdicIgWFBvyId1EymTHYQU7pEnLdy+vilXEG1hGt4PW2SUEbIjeQP5F5jtgvgQQE
         5BrA==
X-Forwarded-Encrypted: i=1; AKwUvBxBvGjk/O5T4TrrDVyZ8H5fVr9nognxZgRH2aRFZygBBKrgcyI6yYKeUWbwy0F/5SlidfwlRtu/QYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQgulcD+yBTQus2gXQsvdj6QVDyUh9JdeS7MT+FvU6VwAmk2h0
	tXok/eRfXEUCCkLBoqeEw4kxtIOklXPiI+fS24tEMpkwGN1nG91IL8WJ
X-Gm-Gg: AYBFou0/wacNVNOTfW/Xo6dyTnpS6dOYEkGvbTIoKDEgGbuEhUm8ORoZ50tATy7TI68
	JF4n0/ga+l2/YFXodW3pAEOrwiZjJBLCtiW48OLyVjijry0pq/9xMYcvdIsUpQHDP5ytXD1mlzq
	lGAIDz4ADQGBBgCGZz5BPkzMLKuVRCfTWrDExevFTpcBlJ3JkhEohwYbZsvYiXYjQqFc79ktAfI
	RK0eQl2SW3Q0DNqyRzr0QH4gwIG/oZSVarHXncyeZug5mLYDHgUUEguKwOmrOsNgdRn8wIDFkBM
	3OtrPXcceNCrEJ3Ws/S15fMHo4dqLQUQIi/b6+tguH8P8sUEOsQR6h8pCT0N8orsY5wJOIyw8Fs
	kM004Iovfe3XJaDCDc3BiE6AnVexgqqHBTRVLRQ6IlACKQ8uVMX71ubiDNN3NZk07yeho+T9w3f
	I1pfAEgjSWshohyELSb84HC3pRFraPEIL+fVoNuDX04u+B51uFhoq6AtZw0iVGE1DBtIifVujrz
	3z0Tjo/ng19aL5LKQUvxK2/sqYmkJp8vYOnal/K6GzdhnRJJbMjTtIb
X-Received: by 2002:a05:600c:5251:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a18e4d5a01mr295506985e9.32.1791966631257;
        Wed, 14 Oct 2026 01:30:31 -0700 (PDT)
Received: from zeus.localdomain (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c198134sm431809745e9.15.2026.10.14.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:30:26 -0700 (PDT)
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
Subject: [PATCH v11 0/3] Raspberry Pi 5 RTC driver
Date: Wed, 14 Oct 2026 10:30:13 +0200
Message-ID: <20261014083016.332338-1-sander.speetjens@gmail.com>
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
 drivers/firmware/raspberrypi.c                |  25 ++
 drivers/rtc/Kconfig                           |  12 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-raspberrypi.c                 | 275 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h    |   2 +
 7 files changed, 322 insertions(+)
 create mode 100644 drivers/rtc/rtc-raspberrypi.c


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.56.0

